package com.streamfit.controller

import com.streamfit.service.DiagnosticService
import com.streamfit.service.UserService
import com.streamfit.service.AsyncResultProcessor
import com.streamfit.UserSession
import grails.converters.JSON

class ResultController {

    DiagnosticService diagnosticService
    UserService userService
    AsyncResultProcessor asyncResultProcessor
    
    /**
     * Main diagnostic tests page
     * GET /diagnostic
     */
    def index() {
        def examTests = diagnosticService.getAvailableTests('EXAM')
        def careerTests = diagnosticService.getAvailableTests('CAREER')
        
        [examTests: examTests, careerTests: careerTests]
    }
    
    /**
     * Get all available diagnostic tests
     * GET /api/diagnostic/tests
     */
    def tests() {
        try {
            def testType = params.type // 'EXAM' or 'CAREER' or null for all
            def tests = diagnosticService.getAvailableTests(testType)
            
            response.status = 200
            render(tests.collect { test ->
                [
                    testId: test.testId,
                    testName: test.testName,
                    testType: test.testType,
                    description: test.description,
                    questionCount: test.questionCount,
                    estimatedMinutes: test.estimatedMinutes
                ]
            } as JSON)
        } catch (Exception e) {
            log.error "Error fetching diagnostic tests: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch tests'] as JSON)
        }
    }
    
    /**
     * Get a specific test details
     * GET /api/diagnostic/test/:testId
     */
    def test() {
        try {
            def testId = params.testId
            def test = diagnosticService.getTest(testId)
            
            if (!test) {
                response.status = 404
                render([success: false, error: 'Test not found'] as JSON)
                return
            }
            
            response.status = 200
            render([
                testId: test.testId,
                testName: test.testName,
                testType: test.testType,
                description: test.description,
                questionCount: test.questionCount,
                estimatedMinutes: test.estimatedMinutes
            ] as JSON)
        } catch (Exception e) {
            log.error "Error fetching test details: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch test details'] as JSON)
        }
    }
    
    /**
     * Get questions for a specific test
     * GET /api/diagnostic/questions/:testId
     */
    def questions() {
        try {
            def testId = params.testId
            def questions = diagnosticService.getTestQuestions(testId)
            
            if (!questions) {
                response.status = 404
                render([success: false, error: 'Test not found'] as JSON)
                return
            }
            
            response.status = 200
            render(questions as JSON)
        } catch (Exception e) {
            log.error "Error fetching test questions: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch questions'] as JSON)
        }
    }
    
    /**
     * Start a new test session
     * POST /api/diagnostic/start
     * Body: { testId: "SPIRIT_ANIMAL" }
     */
    def start() {
        try {
            def requestData = request.JSON
            def testId = requestData.testId
            
            if (!testId) {
                response.status = 400
                render([success: false, error: 'testId is required'] as JSON)
                return
            }

            // Get or create session user
                        def user
        if (session.userId) {
            user = userService.getUserById(session.userId)
        }
        if (!user) {
            user = userService.createAnonymousUser()
            session.userId = user.userId
        }

            def result = diagnosticService.startTestSession(user, testId)
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 400
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error starting test session: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to start test session'] as JSON)
        }
    }
    
    /**
     * Submit a response to a question
     * POST /api/diagnostic/response
     * Body: { sessionId: "...", questionId: "...", answerValue: "...", confidenceLevel: 2, timeSpent: 30 }
     */
    def submitResponse() {
        try {
            def requestData = request.JSON
            def sessionId = requestData.sessionId
            def questionId = requestData.questionId
            def answerValue = requestData.answerValue
            def confidenceLevel = requestData.confidenceLevel
            def timeSpent = requestData.timeSpent
            
            if (!sessionId || !questionId || !answerValue) {
                response.status = 400
                render([success: false, error: 'sessionId, questionId, and answerValue are required'] as JSON)
                return
            }
            
            def result = diagnosticService.submitResponse(sessionId, questionId, answerValue, confidenceLevel, timeSpent)
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 400
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error submitting response: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to submit response'] as JSON)
        }
    }
    
    /**
     * Submit all answers and get results - HIGH PERFORMANCE ASYNC VERSION
     * POST /api/result/submit
     * REDUCED: 1-3 seconds → 50-100ms response time
     */
    def submit() {
        log.info "CONTROLLER_DEBUG: ResultController.submit() called"
        
        try {
            def requestData = request.JSON
            def sessionId = requestData.sessionId
            def answers = requestData.answers
            
            log.info "CONTROLLER_DEBUG: Request data - sessionId: ${sessionId}, answers count: ${answers?.size()}"
            answers?.each { answer ->
                log.info "CONTROLLER_DEBUG: Answer - QuestionId: ${answer.questionId}, AnswerValue: ${answer.answerValue}"
            }
            
            if (!sessionId || !answers) {
                log.error "CONTROLLER_DEBUG: Missing sessionId or answers"
                response.status = 400
                render([success: false, error: 'sessionId and answers are required'] as JSON)
                return
            }
            
            def result
            
            // Try async processor first (high performance)
            try {
                if (asyncResultProcessor) {
                    log.info "CONTROLLER_DEBUG: Calling asyncResultProcessor.submitTestAsync"
                    result = asyncResultProcessor.submitTestAsync(sessionId, answers)
                    log.info "CONTROLLER_DEBUG: Async result: ${result}"
                } else {
                    log.warn "AsyncResultProcessor not available, falling back to sync processing"
                    throw new Exception("Fallback to sync")
                }
            } catch (Exception e) {
                log.warn "Async processing failed, falling back to sync: ${e.message}"
                // Fallback to legacy sync method
                result = diagnosticService.submitTest(sessionId, answers)
            }
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 400
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error submitting test: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to submit test'] as JSON)
        }
    }
    
    /**
     * Check result processing status
     * GET /api/result/status/:sessionId
     */
    def status() {
        try {
            def sessionId = params.sessionId
            def status
            
            // Try async processor first
            try {
                if (asyncResultProcessor) {
                    status = asyncResultProcessor.getResultStatus(sessionId)
                } else {
                    // Fallback: check session directly using new system
                    def session = UserSession.findBySessionId(sessionId)
                    if (!session) {
                        status = [found: false]
                    } else {
                        status = [
                            found: true,
                            status: session.status,
                            completed: session.status == 'COMPLETED',
                            processing: session.status == 'PROCESSING',
                            failed: session.status == 'FAILED'
                        ]
                    }
                }
            } catch (Exception e) {
                log.warn "Async status check failed, falling back to sync: ${e.message}"
                // Fallback: check session directly using new system
                def session = UserSession.findBySessionId(sessionId)
                if (!session) {
                    status = [found: false]
                } else {
                    status = [
                        found: true,
                        status: session.status,
                        completed: session.status == 'COMPLETED',
                        processing: session.status == 'PROCESSING',
                        failed: session.status == 'FAILED'
                    ]
                }
            }
            
            response.status = 200
            render(status as JSON)
        } catch (Exception e) {
            log.error "Error checking result status: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to check status'] as JSON)
        }
    }
    
    /**
     * Get test results
     * GET /api/diagnostic/result/:sessionId
     */
    def result() {
        try {
            def sessionId = params.sessionId
            
            if (!sessionId) {
                response.status = 400
                render([success: false, error: 'sessionId is required'] as JSON)
                return
            }
            
            def result = diagnosticService.getResults(sessionId)
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 404
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error fetching results: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch results'] as JSON)
        }
    }
    
    /**
     * Get user's test history
     * GET /api/diagnostic/history
     */
    def history() {
        try {
                        def user
        if (session.userId) {
            user = userService.getUserById(session.userId)
        }
        if (!user) {
            user = userService.createAnonymousUser()
            session.userId = user.userId
        }

            def history = diagnosticService.getUserTestHistory(user)
            
            response.status = 200
            render(history as JSON)
        } catch (Exception e) {
            log.error "Error fetching test history: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch test history'] as JSON)
        }
    }
    
    /**
     * Test start page
     * GET /result/test/:testId
     */
    def testPage() {
        def testId = params.testId
        def test = diagnosticService.getTest(testId)
        
        if (!test) {
            response.status = 404
            render(view: '/error/404')
            return
        }
        
        [test: test]
    }
    
    /**
     * Result page
     * GET /result/:sessionId
     */
    def resultPage() {
        def sessionId = params.sessionId
        def result = diagnosticService.getResults(sessionId)

        if (!result.success) {
            response.status = 404
            render(view: '/error/404')
            return
        }

        // Check if user is authenticated
        def isAnonymous = true // Always anonymous since we removed auth

        [result: result, isAnonymous: isAnonymous]
    }
}

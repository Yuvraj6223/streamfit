package com.streamfit.controller

import com.streamfit.service.DiagnosticService
import com.streamfit.service.UserService
import com.streamfit.service.AuthService
import grails.converters.JSON

class DiagnosticController {

    DiagnosticService diagnosticService
    UserService userService
    AuthService authService
    
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
            def user = authService.getOrCreateSessionUser()

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
     * Submit all answers and get results
     * POST /api/diagnostic/submit
     * Body: { sessionId: "...", answers: [{questionId: "...", answerValue: "...", confidenceLevel: 2, timeSpent: 30}] }
     */
    def submit() {
        try {
            def requestData = request.JSON
            def sessionId = requestData.sessionId
            def answers = requestData.answers
            
            if (!sessionId || !answers) {
                response.status = 400
                render([success: false, error: 'sessionId and answers are required'] as JSON)
                return
            }
            
            def result = diagnosticService.submitTest(sessionId, answers)
            
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
            def user = authService.getOrCreateSessionUser()

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
     * GET /diagnostic/test/:testId
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
     * GET /diagnostic/result/:sessionId
     */
    def resultPage() {
        def sessionId = params.sessionId
        def result = diagnosticService.getResults(sessionId)
        
        if (!result.success) {
            response.status = 404
            render(view: '/error/404')
            return
        }
        
        [result: result]
    }
}


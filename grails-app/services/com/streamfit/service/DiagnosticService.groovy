package com.streamfit.service

import com.streamfit.diagnostic.*
import com.streamfit.user.User
import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

@Transactional
class DiagnosticService {

    // Inject specific test services
    SpiritAnimalService spiritAnimalService
    CognitiveRadarService cognitiveRadarService
    FocusStaminaService focusStaminaService
    GuessworkQuotientService guessworkQuotientService
    CuriosityCompassService curiosityCompassService
    ModalityMapService modalityMapService
    ChallengeDriverService challengeDriverService
    WorkModeService workModeService
    PatternSnapshotService patternSnapshotService
    RewardService rewardService

    /**
     * Get all available diagnostic tests
     */
    def getAvailableTests(String testType = null) {
        def criteria = DiagnosticTest.createCriteria()
        return criteria.list {
            eq('isActive', true)
            if (testType) {
                eq('testType', testType)
            }
            order('testId', 'asc')
        }
    }

    /**
     * Get a specific diagnostic test by ID
     */
    def getTest(String testId) {
        return DiagnosticTest.findByTestId(testId)
    }

    /**
     * Get all questions for a diagnostic test
     */
    def getTestQuestions(String testId) {
        def test = DiagnosticTest.findByTestId(testId)
        if (!test) {
            return null
        }

        def questions = DiagnosticQuestion.findAllByTest(test, [sort: 'questionNumber', order: 'asc'])

        return questions.collect { question ->
            def options = DiagnosticQuestionOption.findAllByQuestion(question, [sort: 'displayOrder'])

            [
                questionId: question.questionId,
                questionNumber: question.questionNumber,
                questionText: question.questionText,
                questionType: question.questionType,
                timeLimit: question.timeLimit,
                scoringDimension: question.scoringDimension,
                options: options.collect { opt ->
                    [
                        optionText: opt.optionText,
                        optionValue: opt.optionValue,
                        scoreValue: opt.scoreValue
                    ]
                }
            ]
        }
    }

    /**
     * Start a new diagnostic test session
     */
    def startTestSession(User user, String testId) {
        def test = DiagnosticTest.findByTestId(testId)
        if (!test) {
            return [success: false, error: 'Test not found']
        }

        def session = new DiagnosticTestSession(
            user: user,
            test: test,
            sessionId: UUID.randomUUID().toString(),
            status: 'STARTED',
            startedAt: new Date()
        )

        if (!session.save(flush: true)) {
            log.error "Failed to create diagnostic test session: ${session.errors}"
            return [success: false, error: 'Failed to create test session']
        }

        return [
            success: true,
            sessionId: session.sessionId,
            testId: test.testId,
            testName: test.testName,
            questionCount: test.questionCount,
            estimatedMinutes: test.estimatedMinutes
        ]
    }

    /**
     * Submit a response to a question
     */
    def submitResponse(String sessionId, String questionId, def answerValue, Integer confidenceLevel = null, Integer timeSpent = null) {
        def session = DiagnosticTestSession.findBySessionId(sessionId)
        if (!session) {
            return [success: false, error: 'Session not found']
        }

        def question = DiagnosticQuestion.findByQuestionId(questionId)

        // Convert answerValue to String if it's not already
        String answerValueStr = answerValue?.toString()

        def selectedOption = DiagnosticQuestionOption.findByQuestionAndOptionValue(question, answerValueStr)

        def response = new DiagnosticResponse(
            session: session,
            question: question,
            selectedOption: selectedOption,
            answerValue: answerValueStr,
            confidenceLevel: confidenceLevel,
            timeSpent: timeSpent,
            answeredAt: new Date()
        )

        // Check if answer is correct (for questions with correct answers)
        if (selectedOption?.isCorrect != null) {
            response.isCorrect = selectedOption.isCorrect
        }

        if (!response.save(flush: true)) {
            log.error "Failed to save diagnostic response: ${response.errors}"
            return [success: false, error: 'Failed to save response']
        }

        // Update session status
        if (session.status == 'STARTED') {
            session.status = 'IN_PROGRESS'
            session.save(flush: true)
        }

        return [success: true, responseId: response.id]
    }

    /**
     * Submit all answers and calculate results
     */
    def submitTest(String sessionId, List answers) {
        def session = DiagnosticTestSession.findBySessionId(sessionId)
        if (!session) {
            return [success: false, error: 'Session not found']
        }

        // Save all responses
        answers.each { answer ->
            submitResponse(
                sessionId,
                answer.questionId,
                answer.answerValue,
                answer.confidenceLevel,
                answer.timeSpent
            )
        }

        // Calculate results based on test type
        def results = calculateResults(session)

        // Update session with results
        session.status = 'COMPLETED'
        session.completedAt = new Date()
        session.resultType = results.resultType
        session.resultTitle = results.resultTitle
        session.resultSummary = results.resultSummary
        // Convert scoreBreakdown Map to JSON string
        session.scoreBreakdown = results.scoreBreakdown ? (results.scoreBreakdown as grails.converters.JSON).toString() : null
        session.save(flush: true)

        // Process rewards for test completion
        def rewards = rewardService.processTestCompletionRewards(session.user, session)

        return [
            success: true,
            sessionId: session.sessionId,
            results: results,
            rewards: rewards
        ]
    }

    /**
     * Calculate results based on test type and responses
     */
    private def calculateResults(DiagnosticTestSession session) {
        def testId = session.test.testId
        
        switch (testId) {
            case 'SPIRIT_ANIMAL':
                return calculateSpiritAnimalResults(session)
            case 'COGNITIVE_RADAR':
                return calculateCognitiveRadarResults(session)
            case 'FOCUS_STAMINA':
                return calculateFocusStaminaResults(session)
            case 'GUESSWORK_QUOTIENT':
                return calculateGuessworkQuotientResults(session)
            case 'CURIOSITY_COMPASS':
                return calculateCuriosityCompassResults(session)
            case 'MODALITY_MAP':
                return calculateModalityMapResults(session)
            case 'CHALLENGE_DRIVER':
                return calculateChallengeDriverResults(session)
            case 'WORK_MODE':
                return calculateWorkModeResults(session)
            case 'PATTERN_SNAPSHOT':
                return calculatePatternSnapshotResults(session)
            default:
                return [resultType: 'UNKNOWN', resultTitle: 'Unknown', resultSummary: 'Unable to calculate results']
        }
    }

    /**
     * Get test results for a session
     */
    def getResults(String sessionId) {
        def session = DiagnosticTestSession.findBySessionId(sessionId)
        if (!session) {
            return [success: false, error: 'Session not found']
        }

        if (session.status != 'COMPLETED') {
            return [success: false, error: 'Test not completed']
        }

        def result = DiagnosticResult.findByTestAndResultId(session.test, session.resultType)

        // Parse scoreBreakdown JSON string back to Map
        def scoreBreakdownMap = null
        if (session.scoreBreakdown) {
            try {
                scoreBreakdownMap = grails.converters.JSON.parse(session.scoreBreakdown)
            } catch (Exception e) {
                log.error "Failed to parse scoreBreakdown JSON: ${e.message}"
            }
        }

        return [
            success: true,
            sessionId: session.sessionId,
            testId: session.test.testId,
            testName: session.test.testName,
            resultType: session.resultType,
            resultTitle: session.resultTitle,
            resultSummary: session.resultSummary,
            scoreBreakdown: scoreBreakdownMap,
            completedAt: session.completedAt,
            profile: result?.profile,
            strengths: result?.strengths,
            traps: result?.traps,
            aiRoadmap: result?.aiRoadmap,
            bestMatches: result?.bestMatches,
            emoji: result?.emoji
        ]
    }

    /**
     * Get user's test history
     */
    def getUserTestHistory(User user) {
        def sessions = DiagnosticTestSession.findAllByUser(user, [sort: 'dateCreated', order: 'desc'])

        return sessions.collect { session ->
            [
                sessionId: session.sessionId,
                testId: session.test.testId,
                testName: session.test.testName,
                testType: session.test.testType,
                status: session.status,
                resultType: session.resultType,
                resultTitle: session.resultTitle,
                startedAt: session.startedAt,
                completedAt: session.completedAt
            ]
        }
    }

    // Calculation methods delegate to specific service classes
    private def calculateSpiritAnimalResults(DiagnosticTestSession session) {
        return spiritAnimalService.calculateResults(session)
    }

    private def calculateCognitiveRadarResults(DiagnosticTestSession session) {
        return cognitiveRadarService.calculateResults(session)
    }

    private def calculateFocusStaminaResults(DiagnosticTestSession session) {
        return focusStaminaService.calculateResults(session)
    }

    private def calculateGuessworkQuotientResults(DiagnosticTestSession session) {
        return guessworkQuotientService.calculateResults(session)
    }

    private def calculateCuriosityCompassResults(DiagnosticTestSession session) {
        return curiosityCompassService.calculateResults(session)
    }

    private def calculateModalityMapResults(DiagnosticTestSession session) {
        return modalityMapService.calculateResults(session)
    }

    private def calculateChallengeDriverResults(DiagnosticTestSession session) {
        return challengeDriverService.calculateResults(session)
    }

    private def calculateWorkModeResults(DiagnosticTestSession session) {
        return workModeService.calculateResults(session)
    }

    private def calculatePatternSnapshotResults(DiagnosticTestSession session) {
        return patternSnapshotService.calculateResults(session)
    }
}


package com.streamfit.service

import com.streamfit.diagnostic.*
import com.streamfit.user.User
import com.streamfit.service.UnifiedPersonaService
import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

@Transactional
class DiagnosticService {

    // Use the unified persona service instead of individual services
    UnifiedPersonaService unifiedPersonaService

    /**
     * Get all available diagnostic tests (using new unified system)
     */
    def getAvailableTests(String testType = null) {
        try {
            // Return available game types from the new system
            def gameTypes = [
                [testId: 'COGNITIVE_RADAR', testName: 'Brain Power Game', testType: 'EXAM', questionCount: 6, estimatedMinutes: 10],
                [testId: 'CURIOSITY_COMPASS', testName: 'Curiosity Game', testType: 'CAREER', questionCount: 6, estimatedMinutes: 3],
                [testId: 'FOCUS_STAMINA', testName: 'Focus Power Game', testType: 'EXAM', questionCount: 2, estimatedMinutes: 5],
                [testId: 'GUESSWORK_QUOTIENT', testName: 'Smart Guess Game', testType: 'EXAM', questionCount: 10, estimatedMinutes: 8],
                [testId: 'MODALITY_MAP', testName: 'Learning Style Game', testType: 'CAREER', questionCount: 6, estimatedMinutes: 3],
                [testId: 'PATTERN_SNAPSHOT', testName: 'Pattern Rush Game', testType: 'CAREER', questionCount: 6, estimatedMinutes: 3],
                [testId: 'SPIRIT_ANIMAL', testName: 'Spirit Animal Game', testType: 'EXAM', questionCount: 12, estimatedMinutes: 5],
                [testId: 'WORK_MODE', testName: 'Work Style Game', testType: 'CAREER', questionCount: 5, estimatedMinutes: 2],
                [testId: 'PERSONALITY', testName: 'Personality Game', testType: 'CAREER', questionCount: 5, estimatedMinutes: 3]
            ]
            
            if (testType) {
                return gameTypes.findAll { it.testType == testType }
            }
            
            return gameTypes
        } catch (Exception e) {
            log.warn "Could not fetch available tests: ${e.message}"
            return []
        }
    }

    /**
     * Get a specific diagnostic test by ID (using new unified system)
     */
    def getTest(String testId) {
        def gameTypes = getAvailableTests()
        return gameTypes.find { it.testId == testId }
    }

    /**
     * Get all questions for a diagnostic test (using new unified system)
     */
    def getTestQuestions(String testId) {
        try {
            def questions = com.streamfit.GameQuestion.findAllByGameType(testId, [sort: 'questionNumber', order: 'asc'])

            return questions.collect { question ->
                def options = com.streamfit.GameOption.findAllByQuestion(question, [sort: 'displayOrder'])

                [
                    questionId: question.questionId,
                    questionNumber: question.questionNumber,
                    questionText: question.questionText,
                    questionType: question.questionType,
                    timeLimit: question.timeLimit,
                    scoringDimension: question.scoringDimension,
                    options: options.collect { opt ->
                        [
                            optionId: opt.id,
                            optionText: opt.optionText,
                            optionValue: opt.optionValue,
                            isCorrect: opt.isCorrect
                        ]
                    }
                ]
            }
        } catch (Exception e) {
            log.error "Could not fetch test questions for ${testId}: ${e.message}"
            return null
        }
    }

    /**
     * Start a new diagnostic test session (using new unified system)
     */
    def startTestSession(User user, String testId) {
        def test = getTest(testId)
        if (!test) {
            return [success: false, error: 'Test not found']
        }

        def session = new com.streamfit.UserSession(
            user: user,
            sessionId: UUID.randomUUID().toString(),
            status: 'ACTIVE',
            startTime: new Date()
        )

        if (!session.save(flush: true)) {
            log.error "Failed to create user session: ${session.errors}"
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
     * Submit a response to a question (using new unified system)
     */
    def submitResponse(String sessionId, String questionId, def answerValue, Integer confidenceLevel = null, Integer timeSpent = null) {
        def session = com.streamfit.UserSession.findBySessionId(sessionId)
        if (!session) {
            return [success: false, error: 'Session not found']
        }

        def question = com.streamfit.GameQuestion.findByQuestionId(questionId)
        if (!question) {
            return [success: false, error: 'Question not found']
        }

        // Convert answerValue to String if it's not already
        String answerValueStr = answerValue?.toString()

        def selectedOption = com.streamfit.GameOption.findByQuestionAndOptionValue(question, answerValueStr)

        if (selectedOption) {
            // Create engagement data entry
            def engageData = new com.streamfit.EngageData(
                sessionId: sessionId,
                gameType: question.gameType,
                questionId: questionId,
                optionId: selectedOption.id.toString(),
                timestamp: new Date(),
                timeSpent: timeSpent,
                confidenceLevel: confidenceLevel,
                isCorrect: selectedOption.isCorrect
            )

            if (!engageData.save(flush: true)) {
                log.error "Failed to save engagement data: ${engageData.errors}"
                return [success: false, error: 'Failed to save response']
            }
        } else {
            log.warn "Invalid option '${answerValueStr}' for question '${questionId}'. Response not saved."
        }

        return [success: true]
    }

    /**
     * Submit all answers and calculate results (using new unified system)
     */
    def submitTest(String sessionId, List answers) {
        def session = com.streamfit.UserSession.findBySessionId(sessionId)
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

        // Calculate results using the unified persona service
        def results = unifiedPersonaService.calculateFinalPersona(sessionId)

        // Update session with results
        session.endTime = new Date()
        session.status = 'COMPLETED'
        if (results && results.gameResults) {
            session.gameResults = new groovy.json.JsonBuilder(results.gameResults).toString()
        }
        session.save(flush: true)

        // Skip rewards since reward system is disabled
        def rewards = [message: "Reward system is currently disabled"]

        return [
            success: true,
            sessionId: session.sessionId,
            results: results,
            rewards: rewards
        ]
    }

    /**
     * Get test results for a session (using new unified system)
     */
    def getResults(String sessionId) {
        def session = com.streamfit.UserSession.findBySessionId(sessionId)
        if (!session) {
            return [success: false, error: 'Session not found']
        }

        if (session.status != 'COMPLETED') {
            return [success: false, error: 'Test not completed']
        }

        // Parse game results JSON
        def results = null
        if (session.gameResults) {
            try {
                results = new groovy.json.JsonSlurper().parseText(session.gameResults)
            } catch (Exception e) {
                log.error "Failed to parse game results JSON: ${e.message}"
            }
        }

        return [
            success: true,
            sessionId: session.sessionId,
            results: results,
            completedAt: session.endTime
        ]
    }

    /**
     * Get user's test history (using new unified system)
     */
    def getUserTestHistory(User user) {
        try {
            def sessions = com.streamfit.UserSession.findAllByUser(user, [sort: 'startTime', order: 'desc'])

            return sessions.collect { session ->
                [
                    sessionId: session.sessionId,
                    status: session.status,
                    startTime: session.startTime,
                    endTime: session.endTime,
                    gameResults: session.gameResults ? new groovy.json.JsonSlurper().parseText(session.gameResults) : null
                ]
            }
        } catch (Exception e) {
            log.warn "Could not fetch test history for user ${user.userId}: ${e.message}"
            return []
        }
    }
}


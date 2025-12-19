package com.streamfit.service

import com.streamfit.test.*
import com.streamfit.user.User
import grails.gorm.transactions.Transactional

@Transactional
class TestService {

    def analyticsService
    
    def getAllTests() {
        return TestDefinition.where {
            isActive == true
        }.list(sort: 'category', order: 'asc')
    }

    def getCoreTests() {
        return TestDefinition.where {
            category == 'CORE' && isActive == true
        }.list(sort: 'testCode', order: 'asc')
    }

    def getStreamFitTests() {
        return TestDefinition.where {
            category == 'STREAMFIT' && isActive == true
        }.list(sort: 'testCode', order: 'asc')
    }
    
    def getTestByCode(String testCode) {
        return TestDefinition.findByTestCode(testCode)
    }
    
    def startTest(User user, String testCode) {
        TestDefinition test = getTestByCode(testCode)
        
        if (!test) {
            log.error "Test not found: ${testCode}"
            return null
        }
        
        // Check if there's an existing incomplete session
        UserTestSession existingSession = UserTestSession.findByUserAndTestDefinitionAndStatusInList(
            user, 
            test, 
            ['STARTED', 'IN_PROGRESS']
        )
        
        if (existingSession) {
            log.info "Resuming existing session: ${existingSession.sessionId}"
            return existingSession
        }
        
        // Create new session
        def session = new UserTestSession(
            user: user,
            testDefinition: test,
            sessionId: UUID.randomUUID().toString(),
            status: 'STARTED',
            startedAt: new Date(),
            currentQuestionNumber: 1
        )
        
        if (!session.save(flush: true)) {
            log.error "Failed to create test session: ${session.errors}"
            return null
        }
        
        // Track analytics
        analyticsService?.trackEvent(user, 'TEST_STARTED', [
            testCode: testCode,
            sessionId: session.sessionId
        ])
        
        log.info "Started test session: ${session.sessionId} for user: ${user.userId}"
        return session
    }
    
    def getQuestion(UserTestSession session, Integer questionNumber) {
        return TestQuestion.findByTestDefinitionAndQuestionNumber(
            session.testDefinition, 
            questionNumber
        )
    }
    
    def getCurrentQuestion(UserTestSession session) {
        return getQuestion(session, session.currentQuestionNumber)
    }
    
    def getQuestionOptions(TestQuestion question) {
        return QuestionOption.findAllByQuestion(question, [sort: 'displayOrder'])
    }
    
    def submitAnswer(UserTestSession session, Integer questionNumber, Long optionId, Integer timeTaken = null) {
        TestQuestion question = getQuestion(session, questionNumber)
        QuestionOption option = QuestionOption.get(optionId)
        
        if (!question || !option) {
            log.error "Invalid question or option"
            return [success: false, error: 'Invalid question or option']
        }
        
        // Save response
        def response = new UserResponse(
            session: session,
            question: question,
            selectedOption: option,
            responseValue: option.optionValue,
            timeTaken: timeTaken,
            isCorrect: option.isCorrect,
            answeredAt: new Date()
        )
        
        if (!response.save(flush: true)) {
            log.error "Failed to save response: ${response.errors}"
            return [success: false, error: 'Failed to save response']
        }
        
        // Update session
        session.status = 'IN_PROGRESS'
        
        // Check if this was the last question
        if (questionNumber >= session.testDefinition.totalQuestions) {
            session.status = 'COMPLETED'
            session.completedAt = new Date()
            session.currentQuestionNumber = session.testDefinition.totalQuestions
        } else {
            session.currentQuestionNumber = questionNumber + 1
        }
        
        session.save(flush: true)
        
        // Track analytics
        analyticsService?.trackEvent(session.user, 'QUESTION_ANSWERED', [
            testCode: session.testDefinition.testCode,
            sessionId: session.sessionId,
            questionNumber: questionNumber,
            timeTaken: timeTaken
        ])
        
        return [
            success: true, 
            isCompleted: session.status == 'COMPLETED',
            nextQuestionNumber: session.currentQuestionNumber
        ]
    }
    
    def getSessionProgress(UserTestSession session) {
        int answeredQuestions = UserResponse.countBySession(session)
        int totalQuestions = session.testDefinition.totalQuestions
        
        return [
            current: answeredQuestions,
            total: totalQuestions,
            percentage: (answeredQuestions / totalQuestions) * 100,
            isCompleted: session.status == 'COMPLETED'
        ]
    }
    
    def getUserTestHistory(User user) {
        return UserTestSession.findAllByUser(user, [sort: 'dateCreated', order: 'desc'])
    }
    
    def getCompletedTests(User user) {
        return UserTestSession.findAllByUserAndStatus(user, 'COMPLETED', [sort: 'completedAt', order: 'desc'])
    }
    
    def hasCompletedTest(User user, String testCode) {
        TestDefinition test = getTestByCode(testCode)
        if (!test) return false
        
        return UserTestSession.countByUserAndTestDefinitionAndStatus(user, test, 'COMPLETED') > 0
    }
}


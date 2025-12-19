package com.streamfit.controller

import com.streamfit.service.UserService
import com.streamfit.service.TestService
import com.streamfit.service.ScoringService
import com.streamfit.service.AnalyticsService
import grails.converters.JSON

class TestController {

    UserService userService
    TestService testService
    ScoringService scoringService
    AnalyticsService analyticsService
    
    def index() {
        def coreTests = testService.getCoreTests()
        def streamFitTests = testService.getStreamFitTests()
        
        [
            coreTests: coreTests,
            streamFitTests: streamFitTests
        ]
    }
    
    def start(String testCode) {
        def userId = session.userId
        
        if (!userId) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def testSession = testService.startTest(user, testCode)
        
        if (!testSession) {
            flash.error = "Failed to start test"
            redirect action: 'index'
            return
        }
        
        session.currentSessionId = testSession.sessionId
        
        redirect action: 'question', params: [sessionId: testSession.sessionId]
    }
    
    def question(String sessionId) {
        def userId = session.userId
        
        if (!userId) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def user = userService.getUserById(userId)
        def testSession = com.streamfit.test.UserTestSession.findBySessionId(sessionId)
        
        if (!testSession || testSession.user.id != user.id) {
            flash.error = "Invalid test session"
            redirect action: 'index'
            return
        }
        
        if (testSession.status == 'COMPLETED') {
            redirect action: 'result', params: [sessionId: sessionId]
            return
        }
        
        def question = testService.getCurrentQuestion(testSession)
        def options = testService.getQuestionOptions(question)
        def progress = testService.getSessionProgress(testSession)
        
        [
            session: testSession,
            question: question,
            options: options,
            progress: progress,
            testDefinition: testSession.testDefinition
        ]
    }
    
    def submitAnswer() {
        def params = request.JSON ?: params
        def sessionId = params.sessionId
        def questionNumber = params.questionNumber as Integer
        def optionId = params.optionId as Long
        def timeTaken = params.timeTaken as Integer
        
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def testSession = com.streamfit.test.UserTestSession.findBySessionId(sessionId)
        
        if (!testSession) {
            response.status = 404
            render([success: false, message: 'Test session not found'] as JSON)
            return
        }
        
        def result = testService.submitAnswer(testSession, questionNumber, optionId, timeTaken)
        
        if (result.success && result.isCompleted) {
            // Calculate test results
            def testResults = scoringService.calculateTestResults(testSession)
            
            // Track completion
            analyticsService.trackTestCompleted(
                testSession.user, 
                testSession.testDefinition.testCode, 
                sessionId, 
                testSession.totalTimeSpent
            )
            
            result.testResults = testResults
            result.redirectUrl = createLink(action: 'result', params: [sessionId: sessionId], absolute: true)
        }
        
        render(result as JSON)
    }
    
    def result(String sessionId) {
        def userId = session.userId
        
        if (!userId) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def user = userService.getUserById(userId)
        def testSession = com.streamfit.test.UserTestSession.findBySessionId(sessionId)
        
        if (!testSession || testSession.user.id != user.id) {
            flash.error = "Invalid test session"
            redirect action: 'index'
            return
        }
        
        if (testSession.status != 'COMPLETED') {
            redirect action: 'question', params: [sessionId: sessionId]
            return
        }
        
        def results = com.streamfit.test.TestResult.findAllBySession(testSession)
        
        [
            session: testSession,
            testDefinition: testSession.testDefinition,
            results: results,
            user: user
        ]
    }
    
    def history() {
        def userId = session.userId
        
        if (!userId) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def user = userService.getUserById(userId)
        def testHistory = testService.getUserTestHistory(user)
        
        [
            user: user,
            testHistory: testHistory
        ]
    }
    
    def abandon(String sessionId) {
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def testSession = com.streamfit.test.UserTestSession.findBySessionId(sessionId)
        
        if (!testSession) {
            response.status = 404
            render([success: false, message: 'Test session not found'] as JSON)
            return
        }
        
        testSession.status = 'ABANDONED'
        testSession.save(flush: true)
        
        analyticsService.trackTestAbandoned(
            testSession.user,
            testSession.testDefinition.testCode,
            sessionId,
            testSession.currentQuestionNumber
        )
        
        render([success: true, message: 'Test abandoned'] as JSON)
    }
}


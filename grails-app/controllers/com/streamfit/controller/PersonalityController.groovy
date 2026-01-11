package com.streamfit.controller

import com.streamfit.service.UserService
import com.streamfit.service.UnifiedPersonaService
import grails.converters.JSON
import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Value
import java.util.concurrent.TimeUnit

class PersonalityController {

    UnifiedPersonaService unifiedPersonaService
    UserService userService
    RedisTemplate<String, Object> redisTemplate
    
    private static final String CACHE_VERSION = "v1"
    
    @Value('${cache.ttl.personality-questions:86400}')
    private long personalityQuestionsTTL
    
    private String getCacheKey(String baseKey) {
        return "${CACHE_VERSION}:${baseKey}"
    }
    
    /**
     * Main personality test page - Free for all users
     */
    def index() {
        // No login required - show test introduction
        [:]
    }
    
    /**
     * API endpoint: Get all personality test questions
     * GET /api/personality/questions
     * CACHED: 24 hours - questions rarely change
     */
    def questions() {
        String cacheKey = getCacheKey("personality:questions")
        
        try {
            // Try cache first - HIGH IMPACT: This endpoint is hit on every test start
            def cached = redisTemplate?.opsForValue()?.get(cacheKey)
            if (cached) {
                log.debug "Cache HIT: ${cacheKey}"
                def cachedResponse = new JsonSlurper().parseText(cached.toString())
                render(cachedResponse as JSON)
                return
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
        log.debug "Cache MISS: ${cacheKey}"
        
        try {
            // Get personality questions from the new unified system
            def questions = com.streamfit.GameQuestion.findAllByGameType('PERSONALITY', [sort: 'questionNumber', order: 'asc'])
            
            def responseData = questions.collect { question ->
                def options = com.streamfit.GameOption.findAllByQuestion(question, [sort: 'displayOrder'])
                [
                    id: question.questionId,
                    text: question.questionText,
                    number: question.questionNumber,
                    options: options.collect { opt ->
                        [
                            value: opt.optionValue,
                            text: opt.optionText
                        ]
                    }
                ]
            }
            
            // Cache the result for 24 hours
            try {
                redisTemplate?.opsForValue()?.set(cacheKey, JsonOutput.toJson(responseData), personalityQuestionsTTL, TimeUnit.SECONDS)
            } catch (Exception e) {
                log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
            }
            
            render(responseData as JSON)
        } catch (Exception e) {
            log.error "Error fetching personality questions: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch questions'] as JSON)
        }
    }
    
    /**
     * API endpoint: Submit personality test answers
     * POST /api/personality/submit
     * 
     * Request body:
     * {
     *   "answers": [
     *     {"id": "base64_encoded_question", "value": -3 to 3},
     *     ...
     *   ],
     *   "gender": "Male" | "Female" | "Other"
     * }
     */
    def submit() {
        try {
            def params = request.JSON ?: params
            def answers = params.answers
            def gender = params.gender
            
            // Validate input
            if (!answers || answers.isEmpty()) {
                response.status = 400
                render([success: false, error: 'Answers are required'] as JSON)
                return
            }
            
            // Prevent DoS with overly large payloads
            if (answers.size() > 100) {
                response.status = 400
                render([success: false, error: 'Too many answers provided'] as JSON)
                return
            }
            
            // Validate each answer
            for (answer in answers) {
                // Validate answer has required fields
                if (!answer.id) {
                    response.status = 400
                    render([success: false, error: 'Each answer must have an id'] as JSON)
                    return
                }
                
                // Validate answer value is in range (-3 to 3)
                def value = answer.value
                if (value == null || !(value instanceof Number) || value < -3 || value > 3) {
                    response.status = 400
                    render([success: false, error: 'Answer values must be between -3 and 3'] as JSON)
                    return
                }
            }
            
            // Validate gender if provided
            if (gender && !(gender in ['Male', 'Female', 'Other'])) {
                response.status = 400
                render([success: false, error: 'Invalid gender value'] as JSON)
                return
            }
            
            def user = userService.getOrCreateAnonymousUser(session)
            
            // Create session and submit answers using new unified system
            def session = new com.streamfit.UserSession(
                user: user,
                sessionId: UUID.randomUUID().toString(),
                status: 'ACTIVE',
                startTime: new Date()
            )
            session.save(flush: true)
            
            // Save all responses
            answers.each { answer ->
                def engageData = new com.streamfit.EngageData(
                    sessionId: session.sessionId,
                    gameType: 'PERSONALITY',
                    questionId: answer.id,
                    optionId: answer.value?.toString(),
                    timestamp: new Date()
                )
                engageData.save(flush: true)
            }
            
            // Calculate results using unified persona service
            def result = unifiedPersonaService.calculateFinalPersona(session.sessionId)

            // Save FULL result (including gameDominantPersonas) to session
            session.status = 'COMPLETED'
            session.endTime = new Date()
            session.gameResults = new groovy.json.JsonBuilder(result).toString()  // ✅ Save full result including gameDominantPersonas
            session.save(flush: true)
            
            render([success: true, sessionId: session.sessionId, result: result] as JSON)
        } catch (Exception e) {
            log.error "Error submitting personality test: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to submit test'] as JSON)
        }
    }
    
    /**
     * View personality test result - Free for all users
     */
    def result(String sessionId) {
        // Allow anonymous users to view results
        def testSession = com.streamfit.UserSession.findBySessionId(sessionId)

        if (!testSession) {
            flash.error = "Invalid test session"
            redirect action: 'index'
            return
        }

        if (testSession.status != 'COMPLETED') {
            flash.error = "Test not completed"
            redirect action: 'index'
            return
        }

        // Parse game results
        def results = null
        if (testSession.gameResults) {
            try {
                results = new groovy.json.JsonSlurper().parseText(testSession.gameResults)
            } catch (Exception e) {
                log.error "Failed to parse game results JSON: ${e.message}"
            }
        }

        // Check if user is logged in for premium features
        def userId = session.userId
        def user = userId ? userService.getUserById(userId) : null
        def isAnonymous = !user || user.userId.startsWith('anon_')

        [
            session: testSession,
            results: results,
            user: user,
            isAnonymous: isAnonymous
        ]
    }
    
    /**
     * Start personality test (web interface) - Free for all users
     */
    def start() {
        // No login required - anyone can take the test
        [:]
    }
    
    /**
     * API endpoint: Get personality test result by session ID
     * GET /api/personality/result/:sessionId
     */
    def getResult(String sessionId) {
        try {
            def testSession = com.streamfit.UserSession.findBySessionId(sessionId)

            if (!testSession) {
                response.status = 404
                render([success: false, error: 'Session not found'] as JSON)
                return
            }

            if (testSession.status != 'COMPLETED') {
                response.status = 400
                render([success: false, error: 'Test not completed'] as JSON)
                return
            }

            // Parse game results
            def results = null
            if (testSession.gameResults) {
                try {
                    results = new groovy.json.JsonSlurper().parseText(testSession.gameResults)
                } catch (Exception e) {
                    log.error "Failed to parse game results JSON: ${e.message}"
                }
            }

            def result = [
                success: true,
                sessionId: testSession.sessionId,
                results: results,
                completedAt: testSession.endTime
            ]

            render(result as JSON)
        } catch (Exception e) {
            log.error "Error fetching personality result: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch result'] as JSON)
        }
    }

    /**
     * Personality types overview page
     */
    def types() {
        [:]
    }
}


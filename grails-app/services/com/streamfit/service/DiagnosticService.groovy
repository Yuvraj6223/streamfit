package com.streamfit.service

import com.streamfit.diagnostic.*
import com.streamfit.user.User
import com.streamfit.service.UnifiedPersonaService
import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper
import groovy.json.JsonOutput
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Value
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicLong

@Transactional
class DiagnosticService {

    // Use the unified persona service instead of individual services
    UnifiedPersonaService unifiedPersonaService
    
    RedisTemplate<String, Object> redisTemplate
    
    private static final String CACHE_VERSION = "v1"
    
    // Circuit breaker state for Redis failures
    private static final AtomicInteger failureCount = new AtomicInteger(0)
    private static final AtomicLong lastFailureTime = new AtomicLong(0)
    
    @Value('${cache.circuit-breaker.failure-threshold:5}')
    private int failureThreshold
    
    @Value('${cache.circuit-breaker.recovery-timeout:30000}')
    private long recoveryTimeout
    
    @Value('${cache.ttl.test-metadata:86400}')
    private long testMetadataTTL
    
    @Value('${cache.ttl.test-questions:86400}')
    private long testQuestionsTTL
    
    @Value('${cache.ttl.user-history:7200}')
    private long userHistoryTTL
    
    @Value('${cache.ttl.session-progress:1800}')
    private long sessionProgressTTL
    
    @Value('${cache.ttl.default:3600}')
    private long defaultTTL
    
    /**
     * Helper method to generate versioned cache keys
     */
    private String getCacheKey(String baseKey) {
        return "${CACHE_VERSION}:${baseKey}"
    }
    
    /**
     * Check if circuit breaker is open (Redis should be bypassed)
     */
    private boolean isCircuitOpen() {
        if (failureCount.get() >= failureThreshold) {
            long timeSinceLastFailure = System.currentTimeMillis() - lastFailureTime.get()
            if (timeSinceLastFailure < recoveryTimeout) {
                return true // Circuit is open, bypass Redis
            } else {
                // Recovery timeout passed, try to reset
                failureCount.set(0)
                return false
            }
        }
        return false
    }
    
    /**
     * Record a Redis failure for circuit breaker
     */
    private void recordRedisFailure() {
        failureCount.incrementAndGet()
        lastFailureTime.set(System.currentTimeMillis())
    }
    
    /**
     * Reset circuit breaker on successful Redis operation
     */
    private void recordRedisSuccess() {
        failureCount.set(0)
    }
    
    /**
     * Get TTL based on cache type
     */
    private long getCacheTTL(String cacheType) {
        switch(cacheType) {
            case 'test-metadata': return testMetadataTTL
            case 'test-questions': return testQuestionsTTL
            case 'user-history': return userHistoryTTL
            case 'session-progress': return sessionProgressTTL
            default: return defaultTTL
        }
    }

    /**
     * Get all available diagnostic tests (using new unified system)
     */
    def getAvailableTests(String testType = null) {
        String cacheKey = getCacheKey("game:all")
        
        try {
            // Try cache first
            def cached = redisTemplate.opsForValue().get(cacheKey)
            if (cached) {
                def gameTypes = new JsonSlurper().parseText(cached.toString())
                return testType ? gameTypes.findAll { it.testType == testType } : gameTypes
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
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
            
            // Cache the result
            try {
                redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(gameTypes), getCacheTTL('test-metadata'), TimeUnit.SECONDS)
            } catch (Exception e) {
                log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
            }
            
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
        String cacheKey = getCacheKey("game:${testId}")
        
        try {
            // Try cache first
            def cached = redisTemplate.opsForValue().get(cacheKey)
            if (cached) {
                log.debug "Cache HIT: ${cacheKey}"
                return new JsonSlurper().parseText(cached.toString())
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
        log.debug "Cache MISS: ${cacheKey}"
        def gameTypes = getAvailableTests()
        def test = gameTypes.find { it.testId == testId }
        
        // Cache the result
        if (test) {
            try {
                redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(test), getCacheTTL('test-metadata'), TimeUnit.SECONDS)
            } catch (Exception e) {
                log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
            }
        }
        
        return test
    }

    /**
     * Get all questions for a diagnostic test (using new unified system)
     */
    def getTestQuestions(String testId) {
        log.info "🔍 getTestQuestions called for testId: '${testId}'"
        
        String cacheKey = getCacheKey("game:${testId}:questions")
        
        try {
            // Try cache first
            def cached = redisTemplate.opsForValue().get(cacheKey)
            if (cached) {
                return new JsonSlurper().parseText(cached.toString())
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
        try {
            def questions = com.streamfit.GameQuestion.findAllByGameType(testId, [sort: 'questionNumber', order: 'asc'])
            
            if (!questions || questions.isEmpty()) {
                return []
            }

            def result = questions.collect { question ->
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
            
            log.info "✅ Successfully prepared ${result.size()} questions for ${testId}"
            
            // Cache the result
            try {
                redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(result), getCacheTTL('test-questions'), TimeUnit.SECONDS)
            } catch (Exception e) {
                log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
            }
            
            return result
        } catch (Exception e) {
            log.error "Could not fetch test questions for ${testId}: ${e.message}", e
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
                user: session.user,
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
            
            // Update session progress cache
            updateSessionProgressCache(sessionId)
        } else {
            log.warn "Invalid option '${answerValueStr}' for question '${questionId}'. Response not saved."
        }

        return [success: true]
    }
    
    /**
     * Update session progress in cache
     */
    private void updateSessionProgressCache(String sessionId) {
        String cacheKey = getCacheKey("session:${sessionId}")
        
        try {
            def engageData = com.streamfit.EngageData.findAllBySessionId(sessionId)
            def progress = [
                sessionId: sessionId,
                responsesCount: engageData.size(),
                lastUpdated: new Date(),
                gameTypes: engageData.collect { it.gameType }.unique()
            ]
            
            redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(progress), getCacheTTL('session-progress'), TimeUnit.SECONDS)
        } catch (Exception e) {
            log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
        }
    }

    /**
     * Submit all answers and calculate results (using new unified system)
     */
    @Transactional
    def submitTest(String sessionId, List answers) {
        def session = com.streamfit.UserSession.findBySessionId(sessionId)
        if (!session) {
            return [success: false, error: 'Session not found']
        }

        try {
            // Save all responses within transaction
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
            
            // Cache invalidation happens AFTER successful transaction commit
            invalidateTestCaches(sessionId, session.user.userId)
            
            // Skip rewards since reward system is disabled
            def rewards = [message: "Reward system is currently disabled"]

            return [
                success: true,
                sessionId: session.sessionId,
                results: results,
                rewards: rewards
            ]
        } catch (Exception e) {
            log.error "Error submitting test ${sessionId}: ${e.message}", e
            // Cache is NOT updated on error - transaction rolls back
            throw e
        }
    }

    /**
     * Get test results for a session (using new unified system)
     */
    def getResults(String sessionId) {
        String cacheKey = getCacheKey("result:${sessionId}")
        
        try {
            // Try cache first
            def cached = redisTemplate.opsForValue().get(cacheKey)
            if (cached) {
                def cachedResult = new JsonSlurper().parseText(cached.toString())
                return cachedResult
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
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
        
        def result = [
            success: true,
            sessionId: session.sessionId,
            results: results,
            completedAt: session.endTime
        ]
        
        // Cache the result
        try {
            redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(result), getCacheTTL('test-results'), TimeUnit.SECONDS)
        } catch (Exception e) {
            log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
        }

        return result
    }

    /**
     * Get user's test history (using new unified system)
     */
    def getUserTestHistory(User user) {
        String cacheKey = getCacheKey("user:${user.userId}:history")
        
        try {
            // Try cache first
            def cached = redisTemplate.opsForValue().get(cacheKey)
            if (cached) {
                log.debug "Cache HIT: ${cacheKey}"
                return new JsonSlurper().parseText(cached.toString())
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
        log.debug "Cache MISS: ${cacheKey}"
        
        try {
            def sessions = com.streamfit.UserSession.findAllByUser(user, [sort: 'startTime', order: 'desc'])

            def result = sessions.collect { session ->
                [
                    sessionId: session.sessionId,
                    status: session.status,
                    startTime: session.startTime,
                    endTime: session.endTime,
                    gameResults: session.gameResults ? new groovy.json.JsonSlurper().parseText(session.gameResults) : null
                ]
            }
            
            // Cache the result
            try {
                redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(result), getCacheTTL('user-history'), TimeUnit.SECONDS)
            } catch (Exception e) {
                log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
            }
            
            return result
        } catch (Exception e) {
            log.warn "Could not fetch test history for user ${user.userId}: ${e.message}"
            return []
        }
    }
    
    /**
     * Invalidate all related caches when test data changes
     */
    def invalidateTestCaches(String sessionId, String userId = null) {
        try {
            // Invalidate session results cache
            redisTemplate.delete(getCacheKey("result:${sessionId}"))
            
            // Invalidate session progress cache
            redisTemplate.delete(getCacheKey("session:${sessionId}"))
            
            // Invalidate persona profiles cache (since results changed)
            redisTemplate.delete(getCacheKey("persona:all"))
            
            // Invalidate user test history cache if userId provided
            if (userId) {
                redisTemplate.delete(getCacheKey("user:${userId}:history"))
            }
            
        } catch (Exception e) {
            log.warn "Failed to invalidate test caches: ${e.message}"
        }
    }
    
    /**
     * Invalidate user test history cache - kept for backward compatibility
     */
    def invalidateUserTestHistoryCache(User user) {
        String cacheKey = getCacheKey("user:${user.userId}:history")
        
        try {
            redisTemplate.delete(cacheKey)
        } catch (Exception e) {
            log.warn "Redis cache invalidation failed for ${cacheKey}: ${e.message}"
        }
    }
}


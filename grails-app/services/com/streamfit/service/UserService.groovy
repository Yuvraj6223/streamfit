package com.streamfit.service

import com.streamfit.UserSession
import com.streamfit.user.User
import grails.gorm.transactions.Transactional
import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Value
import java.util.concurrent.TimeUnit
import java.util.Random

@Transactional
class UserService {

    DiagnosticService diagnosticService
    RedisTemplate<String, Object> redisTemplate
    
    private static final String CACHE_VERSION = "v1"
    
    @Value('${cache.ttl.user-profile:3600}')
    private long userProfileTTL
    
    @Value('${cache.ttl.user-stats:1800}')
    private long userStatsTTL
    
    /**
     * Helper method to generate versioned cache keys
     */
    private String getCacheKey(String baseKey) {
        return "${CACHE_VERSION}:${baseKey}"
    }
    
    /**
     * Invalidate user cache when user data changes
     */
    private void invalidateUserCache(String userId) {
        try {
            redisTemplate.delete(getCacheKey("user:${userId}"))
            redisTemplate.delete(getCacheKey("user:${userId}:stats"))
        } catch (Exception e) {
            log.warn "Failed to invalidate user cache: ${e.message}"
        }
    }

    def createOrGetUser(Map params) {
        String userId = params.userId ?: UUID.randomUUID().toString()

        User user = User.findByUserId(userId)

        if (!user) {
            user = new User(
                userId: userId,
                name: params.name,
                email: params.email,
                phoneNumber: params.phoneNumber,
                age: params.age as Integer,
                gender: params.gender,
                educationLevel: params.educationLevel,
                currentStream: params.currentStream,
                ipAddress: params.ipAddress,
                userAgent: params.userAgent,
                referralSource: params.referralSource,
                agreedToTerms: params.agreedToTerms as Boolean ?: false,
                optInForUpdates: params.optInForUpdates as Boolean ?: false
            )

            if (!user.save(flush: true)) {
                log.error "Failed to create user: ${user.errors}"
                return null
            }


            log.info "Created new user: ${user.userId}"
        } else {
            // Update user info if provided
            if (params.name) user.name = params.name
            if (params.email) user.email = params.email
            if (params.phoneNumber) user.phoneNumber = params.phoneNumber
            if (params.age) user.age = params.age as Integer

            user.save(flush: true)
        }

        return user
    }

    @Transactional
    def registerUser(Map params) {
        def email = params.email

        if (!email) {
            return [success: false, message: "Email is required", user: null]
        }

        if (User.findByEmail(email)) {
            return [success: false, message: "Email already registered. Please login instead.", user: null]
        }

        def userId = generateUniqueUserId()

        def user = new User(
            userId: userId,
            name: params.name,
            email: params.email,
            age: params.age as Integer,
            ipAddress: params.ipAddress,
            userAgent: params.userAgent,
            agreedToTerms: true
        )

        if (user.save(flush: true)) {
            log.info "User created successfully: ${user.userId} - ${user.name}"
            return [success: true, message: "Account created successfully!", user: user]
        } else {
            log.error "User save failed for email ${email}: ${user.errors.allErrors}"
            def errorMessage = user.errors.allErrors.first()?.defaultMessage ?: "Failed to create account. Please try again."
            return [success: false, message: errorMessage, user: null]
        }
    }

    private String generateUniqueUserId() {
        def userId
        def exists = true

        while (exists) {
            userId = "USR" + System.currentTimeMillis() + String.format("%04d", new Random().nextInt(10000))
            exists = User.findByUserId(userId) != null
        }

        return userId
    }


    def getUserById(String userId) {
        if (!userId) return null
        
        String cacheKey = getCacheKey("user:${userId}")
        
        try {
            // Try cache first
            def cached = redisTemplate.opsForValue().get(cacheKey)
            if (cached) {
                log.debug "Cache HIT: ${cacheKey}"
                def userData = new JsonSlurper().parseText(cached.toString())
                return User.findByUserId(userData.userId) // Return actual domain object
            }
        } catch (Exception e) {
            log.warn "Redis cache read failed for ${cacheKey}: ${e.message}"
        }
        
        log.debug "Cache MISS: ${cacheKey}"
        
        def user = User.findByUserId(userId)
        
        // Cache the result
        if (user) {
            try {
                def userData = [userId: user.userId, name: user.name, email: user.email]
                redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(userData), userProfileTTL, TimeUnit.SECONDS)
            } catch (Exception e) {
                log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
            }
        }
        
        return user
    }
    
    def updateUserPreferences(User user, Map preferences) {
        if (preferences.containsKey('optInForUpdates')) {
            user.optInForUpdates = preferences.optInForUpdates as Boolean
        }
        if (preferences.containsKey('prebookedStreamMap')) {
            user.prebookedStreamMap = preferences.prebookedStreamMap as Boolean
        }
        
        return user.save(flush: true)
    }
    
    def getUserStats(User user) {
        if (!user) return getDefaultStats()
        
        String cacheKey = getCacheKey("user:${user.userId}:stats")
        
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
        
        // Calculate stats (currently returns defaults since LearningDNA was dropped)
        def stats = getDefaultStats()
        
        // Cache the result
        try {
            redisTemplate.opsForValue().set(cacheKey, JsonOutput.toJson(stats), userStatsTTL, TimeUnit.SECONDS)
        } catch (Exception e) {
            log.warn "Redis cache write failed for ${cacheKey}: ${e.message}"
        }
        
        return stats
    }
    
    private Map getDefaultStats() {
        return [
            totalTestsCompleted: 0,
            coreTestsCompleted: 0,
            streamFitTestsCompleted: 0,
            isDashboardUnlocked: false,
            completionPercentage: 0.0
        ]
    }

    /**
     * Create an anonymous user for personality test
     */
    def createAnonymousUser() {
        String userId = "anon_" + UUID.randomUUID().toString()

        User user = new User(
            userId: userId,
            name: "Anonymous User",
            agreedToTerms: true,
            optInForUpdates: false
        )

        if (!user.save(flush: true)) {
            log.error "Failed to create anonymous user: ${user.errors}"
            return null
        }

        log.info "Created anonymous user: ${user.userId}"
        return user
    }

    /**
     * Get or create an anonymous user for diagnostic tests
     * Reuses existing anonymous user from session if available
     */
    def getOrCreateAnonymousUser(session = null) {
        // Try to reuse existing anonymous user from session
        if (session?.userId?.startsWith('anon_')) {
            def existingUser = User.findByUserId(session.userId)
            if (existingUser) {
                return existingUser
            }
        }

        // Create new anonymous user only if needed
        def newUser = createAnonymousUser()
        if (session != null && newUser) {
            session.userId = newUser.userId
        }
        return newUser
    }

    /**
     * Get the current authenticated user
     * Returns null if no user is authenticated
     * Note: This will be delegated to AuthService in controllers
     */
    def getCurrentUser() {
        // This method is kept for backward compatibility
        // Controllers should use AuthService.getCurrentUser() or AuthService.getOrCreateSessionUser()
        return null
    }

    @Transactional
    def migrateUserSession(String anonymousUserId, User authenticatedUser) {
        if (!anonymousUserId || !authenticatedUser) {
            return
        }

        def anonymousUser = User.findByUserId(anonymousUserId, [lock: true])
        if (anonymousUser) {
            try {
                def userSessions = UserSession.findAllByUser(anonymousUser)
                userSessions.each { session ->
                    session.user = authenticatedUser
                    session.save(flush: true)
                }

                // Invalidate caches for both users before deleting the anonymous one
                diagnosticService.invalidateUserTestHistoryCache(anonymousUser)
                diagnosticService.invalidateUserTestHistoryCache(authenticatedUser)

                anonymousUser.delete(flush: true)
                
            } catch (Exception e) {
                log.warn "Failed to migrate user session or invalidate cache for ${anonymousUserId}: ${e.message}"
            }
        }
    }
}


package com.streamfit.interceptor

import groovy.util.logging.Slf4j
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Autowired
import java.util.concurrent.TimeUnit
import java.util.concurrent.ConcurrentHashMap

/**
 * Rate Limiting Interceptor - Protects API endpoints from abuse
 * 
 * Uses Redis for distributed rate limiting with fallback to in-memory
 * when Redis is unavailable.
 * 
 * Rate Limits:
 * - Login/Signup: 5 requests per minute per IP
 * - Test submissions: 10 requests per minute per IP
 * - General API: 100 requests per minute per IP
 */
@Slf4j
class RateLimitingInterceptor {

    @Autowired(required = false)
    RedisTemplate<String, Object> redisTemplate
    
    // Fallback in-memory rate limiter when Redis unavailable
    private static final ConcurrentHashMap<String, RateLimitEntry> localRateLimits = new ConcurrentHashMap<>()
    
    int order = HIGHEST_PRECEDENCE + 5 // Run before SecurityInterceptor
    
    // Rate limit configurations
    private static final int AUTH_LIMIT = 5          // requests per minute for auth endpoints
    private static final int SUBMIT_LIMIT = 10       // requests per minute for submission endpoints
    private static final int GENERAL_LIMIT = 100     // requests per minute for general endpoints
    private static final int WINDOW_SECONDS = 60     // 1 minute window
    
    RateLimitingInterceptor() {
        match(controller: 'auth', action: ~/(processLogin|processSignup|doLogin|doSignup)/)
        match(controller: 'personality', action: 'submit')
        match(controller: 'result', action: ~/(submit|submitResponse|start)/)
    }

    boolean before() {
        def clientIp = getClientIp()
        def endpoint = "${controllerName}:${actionName}"
        def limit = getRateLimit(controllerName, actionName)
        
        if (!isRateLimitAllowed(clientIp, endpoint, limit)) {
            log.warn "Rate limit exceeded for IP: ${clientIp} on endpoint: ${endpoint}"
            response.status = 429
            response.setContentType('application/json')
            response.setHeader('Retry-After', WINDOW_SECONDS.toString())
            response.writer.write('{"success": false, "error": "Too many requests. Please try again later.", "retryAfter": ' + WINDOW_SECONDS + '}')
            return false
        }
        
        return true
    }

    boolean after() { true }

    void afterView() {
        // Cleanup old entries from local cache periodically
        cleanupLocalCache()
    }
    
    /**
     * Get the rate limit for a specific controller/action
     */
    private int getRateLimit(String controller, String action) {
        if (controller == 'auth') {
            return AUTH_LIMIT
        }
        if (action in ['submit', 'submitResponse']) {
            return SUBMIT_LIMIT
        }
        return GENERAL_LIMIT
    }
    
    /**
     * Check if the request is within rate limits
     */
    private boolean isRateLimitAllowed(String clientIp, String endpoint, int limit) {
        String key = "ratelimit:${endpoint}:${clientIp}"
        
        try {
            if (redisTemplate) {
                return checkRedisRateLimit(key, limit)
            }
        } catch (Exception e) {
            log.warn "Redis rate limit check failed, falling back to local: ${e.message}"
        }
        
        // Fallback to local rate limiting
        return checkLocalRateLimit(key, limit)
    }
    
    /**
     * Check rate limit using Redis (distributed)
     */
    private boolean checkRedisRateLimit(String key, int limit) {
        def currentCount = redisTemplate.opsForValue().get(key)
        
        if (currentCount == null) {
            // First request - set counter with TTL
            redisTemplate.opsForValue().set(key, 1, WINDOW_SECONDS, TimeUnit.SECONDS)
            return true
        }
        
        int count = currentCount as Integer
        if (count >= limit) {
            return false
        }
        
        // Increment counter
        redisTemplate.opsForValue().increment(key)
        return true
    }
    
    /**
     * Check rate limit using local in-memory cache (fallback)
     */
    private boolean checkLocalRateLimit(String key, int limit) {
        long now = System.currentTimeMillis()
        long windowStart = now - (WINDOW_SECONDS * 1000)
        
        RateLimitEntry entry = localRateLimits.compute(key) { k, existing ->
            if (existing == null || existing.windowStart < windowStart) {
                // New window
                return new RateLimitEntry(windowStart: now, count: 1)
            }
            existing.count++
            return existing
        }
        
        return entry.count <= limit
    }
    
    /**
     * Cleanup old entries from local cache
     */
    private void cleanupLocalCache() {
        // Run cleanup roughly every 100 requests
        if (Math.random() < 0.01) {
            long windowStart = System.currentTimeMillis() - (WINDOW_SECONDS * 1000 * 2)
            localRateLimits.entrySet().removeIf { it.value.windowStart < windowStart }
        }
    }
    
    /**
     * Get the real client IP, handling proxies
     */
    private String getClientIp() {
        // Check for proxy headers
        String ip = request.getHeader('X-Forwarded-For')
        if (ip && ip != 'unknown') {
            // X-Forwarded-For can contain multiple IPs, take the first one
            return ip.split(',')[0].trim()
        }
        
        ip = request.getHeader('X-Real-IP')
        if (ip && ip != 'unknown') {
            return ip
        }
        
        return request.remoteAddr ?: '0.0.0.0'
    }
    
    /**
     * Simple rate limit entry for in-memory tracking
     */
    private static class RateLimitEntry {
        long windowStart
        int count
    }
}

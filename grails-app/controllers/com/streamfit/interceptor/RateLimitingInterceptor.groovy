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
    
    // Trusted proxy IPs - configure based on your infrastructure
    // Add your load balancer/reverse proxy IPs here
    private static final Set<String> TRUSTED_PROXY_IPS = [
        '127.0.0.1',
        '::1',
        // Add your production proxy IPs, e.g.:
        // '10.0.0.0/8' prefix check done below
    ].toSet()
    
    /**
     * Get the real client IP, handling proxies securely
     * Only trusts X-Forwarded-For when request originates from a known trusted proxy
     */
    private String getClientIp() {
        String remoteAddr = request.remoteAddr ?: '0.0.0.0'
        
        // Only trust proxy headers if the direct connection is from a trusted proxy
        if (isTrustedProxy(remoteAddr)) {
            // Check X-Forwarded-For header
            String xff = request.getHeader('X-Forwarded-For')
            if (xff && xff != 'unknown') {
                // X-Forwarded-For can contain multiple IPs, take the first (original client)
                String clientIp = xff.split(',')[0].trim()
                // Validate it looks like an IP address
                if (isValidIpFormat(clientIp)) {
                    return clientIp
                }
            }
            
            // Check X-Real-IP header
            String realIp = request.getHeader('X-Real-IP')
            if (realIp && realIp != 'unknown' && isValidIpFormat(realIp)) {
                return realIp
            }
        }
        
        return remoteAddr
    }
    
    /**
     * Check if the given IP is a trusted proxy
     */
    private boolean isTrustedProxy(String ip) {
        if (!ip) return false
        
        // Check exact matches
        if (TRUSTED_PROXY_IPS.contains(ip)) return true
        
        // Check common private network ranges (typically where proxies reside)
        // Only enable these if your proxy is on a private network
        if (ip.startsWith('10.') || 
            ip.startsWith('172.16.') || ip.startsWith('172.17.') || ip.startsWith('172.18.') ||
            ip.startsWith('172.19.') || ip.startsWith('172.20.') || ip.startsWith('172.21.') ||
            ip.startsWith('172.22.') || ip.startsWith('172.23.') || ip.startsWith('172.24.') ||
            ip.startsWith('172.25.') || ip.startsWith('172.26.') || ip.startsWith('172.27.') ||
            ip.startsWith('172.28.') || ip.startsWith('172.29.') || ip.startsWith('172.30.') ||
            ip.startsWith('172.31.') ||
            ip.startsWith('192.168.')) {
            return true
        }
        
        return false
    }
    
    /**
     * Basic IP format validation to prevent injection
     */
    private boolean isValidIpFormat(String ip) {
        if (!ip || ip.length() > 45) return false  // Max length for IPv6
        // Allow IPv4 and IPv6 characters only
        return ip.matches('^[0-9a-fA-F.:]+$')
    }
    
    /**
     * Simple rate limit entry for in-memory tracking
     */
    private static class RateLimitEntry {
        long windowStart
        int count
    }
}

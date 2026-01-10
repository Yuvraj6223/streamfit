package com.streamfit.controller

import grails.converters.JSON
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Autowired
import java.text.SimpleDateFormat

/**
 * Health Check Controller for load balancer probes and monitoring
 */
class HealthController {

    @Autowired(required = false)
    RedisTemplate<String, Object> redisTemplate
    
    private static final SimpleDateFormat ISO_FORMAT = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ")

    /**
     * Basic health check endpoint
     * GET /health
     * Returns 200 if application is healthy, 503 if degraded
     */
    def check() {
        def health = [
            status: 'UP',
            timestamp: ISO_FORMAT.format(new Date()),
            checks: [:]
        ]
        
        boolean isHealthy = true
        
        // Check database connectivity
        try {
            def dbCheck = com.streamfit.user.User.count() >= 0
            health.checks.database = [status: 'UP']
        } catch (Exception e) {
            health.checks.database = [status: 'DOWN', error: e.message]
            isHealthy = false
        }
        
        // Check Redis connectivity (optional - don't fail health if Redis is down)
        try {
            if (redisTemplate) {
                redisTemplate.opsForValue().get("health:ping")
                health.checks.redis = [status: 'UP']
            } else {
                health.checks.redis = [status: 'NOT_CONFIGURED']
            }
        } catch (Exception e) {
            health.checks.redis = [status: 'DOWN', error: e.message]
            // Don't fail overall health for Redis - it has fallback
        }
        
        if (isHealthy) {
            response.status = 200
        } else {
            response.status = 503
            health.status = 'DOWN'
        }
        
        render(health as JSON)
    }
    
    /**
     * Liveness probe - just confirms app is running
     * GET /health/live
     */
    def live() {
        response.status = 200
        render([status: 'UP', timestamp: ISO_FORMAT.format(new Date())] as JSON)
    }
    
    /**
     * Readiness probe - confirms app is ready to serve traffic
     * GET /health/ready
     */
    def ready() {
        try {
            // Quick database check
            com.streamfit.user.User.count()
            response.status = 200
            render([status: 'READY', timestamp: ISO_FORMAT.format(new Date())] as JSON)
        } catch (Exception e) {
            response.status = 503
            render([status: 'NOT_READY', error: e.message] as JSON)
        }
    }
}

package com.streamfit.interceptor

import groovy.util.logging.Slf4j

/**
 * Security Interceptor - Adds security headers and validates session ownership
 * 
 * Security Headers Added:
 * - X-Content-Type-Options: nosniff
 * - X-Frame-Options: DENY
 * - X-XSS-Protection: 1; mode=block
 * - Content-Security-Policy: default-src 'self'
 * - Referrer-Policy: strict-origin-when-cross-origin
 * - Permissions-Policy: geolocation=(), microphone=(), camera=()
 */
@Slf4j
class SecurityInterceptor {

    int order = HIGHEST_PRECEDENCE + 10
    
    SecurityInterceptor() {
        matchAll()
    }

    boolean before() {
        // Add security headers to all responses
        addSecurityHeaders()
        
        // Check session ownership for sensitive result endpoints
        if (isResultEndpoint()) {
            return validateSessionOwnership()
        }
        
        return true
    }

    boolean after() { true }

    void afterView() { }
    
    /**
     * Add security headers to prevent common attacks
     */
    private void addSecurityHeaders() {
        response.setHeader('X-Content-Type-Options', 'nosniff')
        response.setHeader('X-Frame-Options', 'DENY')
        response.setHeader('X-XSS-Protection', '1; mode=block')
        response.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin')
        response.setHeader('Permissions-Policy', 'geolocation=(), microphone=(), camera=()')
        
        // Content-Security-Policy - adjust as needed for your app
        response.setHeader('Content-Security-Policy', 
            "default-src 'self'; " +
            "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://www.googletagmanager.com https://www.google-analytics.com; " +
            "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdn.jsdelivr.net; " +
            "font-src 'self' https://fonts.gstatic.com; " +
            "img-src 'self' data: https:; " +
            "connect-src 'self' https://www.google-analytics.com;")
        
        // Strict-Transport-Security - only add in production with HTTPS
        if (grails.util.Environment.current == grails.util.Environment.PRODUCTION) {
            response.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains')
        }
    }
    
    /**
     * Check if this is a result endpoint that requires ownership validation
     */
    private boolean isResultEndpoint() {
        def uri = request.requestURI
        return uri.matches('/api/personality/result/.*') ||
               uri.matches('/api/result/[a-f0-9-]+') ||
               uri.matches('/result/[a-f0-9-]+')
    }
    
    /**
     * Validate that the current user owns the session being accessed
     */
    private boolean validateSessionOwnership() {
        def sessionId = extractSessionIdFromUri()
        if (!sessionId) {
            return true // No session ID to validate
        }
        
        // Get the current user's session ID
        def currentUserId = session.userId
        
        // Allow access if user is not logged in (anonymous access allowed for their own sessions)
        // But verify the session belongs to the current session user
        try {
            def userSession = com.streamfit.UserSession.findBySessionId(sessionId)
            
            if (!userSession) {
                // Session not found - let the controller handle 404
                return true
            }
            
            // If user is logged in, verify ownership
            if (currentUserId) {
                def sessionOwner = userSession.user?.userId
                
                // Allow if the session belongs to the current user
                if (sessionOwner && sessionOwner != currentUserId) {
                    // Check if current user started as anonymous and is the same session
                    if (!sessionOwner.startsWith('anon_') || !currentUserId.startsWith('anon_')) {
                        log.warn "Unauthorized access attempt: User ${currentUserId} tried to access session owned by ${sessionOwner}"
                        response.status = 403
                        response.setContentType('application/json')
                        response.writer.write('{"success": false, "error": "Access denied"}')
                        return false
                    }
                }
            }
        } catch (Exception e) {
            log.error "Error validating session ownership: ${e.message}"
            // Allow request to continue on error - fail open for availability
        }
        
        return true
    }
    
    /**
     * Extract session ID from the request URI
     */
    private String extractSessionIdFromUri() {
        def uri = request.requestURI
        def matcher = uri =~ /\/(?:api\/(?:personality\/)?result|result)\/([a-f0-9-]+)/
        return matcher.find() ? matcher.group(1) : null
    }
}

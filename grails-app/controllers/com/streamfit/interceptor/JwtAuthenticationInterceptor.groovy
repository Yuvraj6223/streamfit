package com.streamfit.interceptor

import com.streamfit.service.JwtTokenService
import io.jsonwebtoken.Claims

class JwtAuthenticationInterceptor {

    JwtTokenService jwtTokenService

    /**
     * Paths that require JWT authentication
     */
    private static final List<String> PROTECTED_PATHS = [
        '/dashboard',
        '/api/user',
        '/api/persona',
        '/api/session',
        '/api/me',
        '/api/token/refresh',
        '/profile'
    ]

    /**
     * Paths that are public (no auth required)
     */
    private static final List<String> PUBLIC_PATHS = [
        '/',
        '/home',
        '/about',
        '/faq',
        '/login',
        '/signup',
        '/api/login',
        '/api/signup',
        '/personality',
        '/personality/start',
        '/result',
        '/api/result/tests',
        '/api/result/questions',
        '/api/result/start',
        '/api/result/response',
        '/api/result/submit',
        '/api/personality/questions',
        '/api/personality/submit',
        '/analytics',
        '/analytics/track'
    ]

    boolean before() {
        String requestPath = request.forwardURI

        // Check if path is in public list
        if (isPublicPath(requestPath)) {
            log.debug("Public path accessed: ${requestPath}")
            return true
        }

        // Extract JWT from Authorization header
        String authHeader = request.getHeader('Authorization')
        String token = null

        if (authHeader?.startsWith('Bearer ')) {
            token = authHeader.substring(7)
        }

        if (!token) {
            log.warn("No JWT provided for protected path: ${requestPath}")
            response.status = 401
            render(contentType: 'application/json') {
                [success: false, error: 'Unauthorized: Missing JWT token']
            }
            return false
        }

        // Validate JWT
        Claims claims = jwtTokenService.validateToken(token)

        if (!claims) {
            log.warn("Invalid JWT for protected path: ${requestPath}")
            response.status = 401
            render(contentType: 'application/json') {
                [success: false, error: 'Unauthorized: Invalid token']
            }
            return false
        }

        // Store claims in request for use in controllers
        request.setAttribute('jwtClaims', claims)
        request.setAttribute('userId', claims.get('uid', String.class))
        request.setAttribute('sessionId', claims.get('sid', String.class))
        request.setAttribute('userRole', claims.get('role', String.class) ?: 'guest')

        log.debug("JWT validated for user=${claims.get('uid', String.class)}, role=${claims.get('role', String.class)}")

        return true
    }

    boolean after() {
        return true
    }

    void afterView() {
        // No-op
    }

    /**
     * Check if request path is in public paths list
     */
    private boolean isPublicPath(String path) {
        return PUBLIC_PATHS.any { publicPath ->
            path.startsWith(publicPath)
        }
    }
}


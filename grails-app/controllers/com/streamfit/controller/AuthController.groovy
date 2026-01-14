package com.streamfit.controller

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import com.streamfit.user.User
import com.streamfit.UserSession
import com.streamfit.service.JwtTokenService
import com.streamfit.service.RefreshTokenService
import java.util.regex.Pattern


class AuthController {

    static namespace = null
    def userService
    JwtTokenService jwtTokenService
    RefreshTokenService refreshTokenService

    // Email validation pattern (RFC 5322 simplified)
    private static final Pattern EMAIL_PATTERN = ~/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/
    
    // Maximum input lengths to prevent DoS
    private static final int MAX_EMAIL_LENGTH = 254
    private static final int MAX_NAME_LENGTH = 100

    def login() {
        render(view: "login")
    }

    def signup() {
        render(view: "signup")
    }

    /**
     * API endpoint: POST /api/login
     * Login existing user and issue JWT tokens
     *
     * Request body:
     * {
     *   "email": "user@example.com",
     *   "sessionId": "optional-session-uuid"  // Current guest session to link
     * }
     *
     * Response:
     * {
     *   "success": true,
     *   "accessToken": "eyJhbGc...",
     *   "refreshToken": "eyJhbGc...",
     *   "expiresIn": 3600,
     *   "tokenType": "Bearer",
     *   "user": { "userId", "name", "email" }
     * }
     */
    @Transactional
    def processLogin() {
        def jsonData = request.JSON
        def email = jsonData?.email?.toString()?.trim()
        def guestSessionId = jsonData?.sessionId?.toString()?.trim()

        // Input validation
        if (!email) {
            response.status = 400
            render([success: false, error: "Email is required"] as JSON)
            return
        }
        
        // Validate email length
        if (email.length() > MAX_EMAIL_LENGTH) {
            response.status = 400
            render([success: false, error: "Email is too long"] as JSON)
            return
        }
        
        // Validate email format
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            response.status = 400
            render([success: false, error: "Invalid email format"] as JSON)
            return
        }

        // Find user by email
        def user = User.findByEmail(email)

        if (!user) {
            log.warn("Login attempt for non-existent user: ${email}")
            response.status = 401
            render([success: false, error: "Invalid email or password"] as JSON)
            return
        }

        try {
            // Update login tracking
            user.lastLoginAt = new Date()
            user.lastLoginIp = request.getRemoteAddr()
            user.failedLoginAttempts = 0
            user.save(flush: true)

            // Update session user ID to match logged in user
            session.userId = user.userId

            // Link guest session to user if provided
            if (guestSessionId) {
                def guestSession = UserSession.findBySessionId(guestSessionId)
                if (guestSession && !guestSession.user) {
                    guestSession.user = user
                    guestSession.save(flush: true)
                    log.info("Guest session ${guestSessionId} linked to user ${user.userId}")
                }
            }

            // Generate JWT tokens
            def tokenPair = jwtTokenService.generateTokenPair(user.userId, guestSessionId ?: UUID.randomUUID().toString(), 'user')

            // Save refresh token
            def refreshTokenId = UUID.randomUUID().toString()
            def expiresAt = new Date(System.currentTimeMillis() + (7 * 24 * 60 * 60 * 1000))  // 7 days
            refreshTokenService.saveRefreshToken(
                refreshTokenId,
                user,
                tokenPair.refreshToken,
                expiresAt,
                request.getRemoteAddr(),
                request.getHeader('User-Agent')
            )

            // Invalidate user cache
            refreshTokenService.invalidateUserCache(user.userId)


            log.info("User logged in successfully: ${user.userId}")

            response.status = 200
            render([
                success: true,
                accessToken: tokenPair.accessToken,
                refreshToken: tokenPair.refreshToken,
                expiresIn: tokenPair.expiresIn,
                tokenType: tokenPair.tokenType,
                user: [
                    userId: user.userId,
                    name: user.name,
                    email: user.email,
                    role: 'user'
                ]
            ] as JSON)
        } catch (Exception e) {
            log.error("Error during login: ${e.message}", e)
            response.status = 500
            render([success: false, error: 'Login failed'] as JSON)
        }
    }

    /**
     * API endpoint: POST /api/signup
     * Register new user and issue JWT tokens
     *
     * Request body:
     * {
     *   "email": "user@example.com",
     *   "name": "John Doe",
     *   "age": 25,
     *   "sessionId": "optional-guest-session-uuid"
     * }
     *
     * Response: same as login
     */
    @Transactional
    def processSignup() {
        def jsonData = request.JSON
        def name = jsonData?.name?.toString()?.trim()
        def email = jsonData?.email?.toString()?.trim()
        def age = jsonData?.age as Integer
        def guestSessionId = jsonData?.sessionId?.toString()?.trim()

        // Input validation
        if (!email) {
            response.status = 400
            render([success: false, error: "Email is required"] as JSON)
            return
        }
        
        // Validate email length
        if (email.length() > MAX_EMAIL_LENGTH) {
            response.status = 400
            render([success: false, error: "Email is too long"] as JSON)
            return
        }
        
        // Validate email format
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            response.status = 400
            render([success: false, error: "Invalid email format"] as JSON)
            return
        }
        
        // Validate name length if provided
        if (name && name.length() > MAX_NAME_LENGTH) {
            response.status = 400
            render([success: false, error: "Name is too long"] as JSON)
            return
        }
        
        // Validate age if provided
        if (age != null && (age < 1 || age > 120)) {
            response.status = 400
            render([success: false, error: "Invalid age"] as JSON)
            return
        }

        def ipAddress = request.getRemoteAddr()
        def userAgent = request.getHeader('User-Agent')

        def result = userService.registerUser([
            name: name,
            email: email,
            age: age,
            ipAddress: ipAddress,
            userAgent: userAgent
        ])

        if (!result.success) {
            response.status = 409
            render([success: false, error: result.message] as JSON)
            return
        }

        try {
            def user = result.user

            // Update session user ID to match signed up user
            def anonymousUserId = session.userId
            if (anonymousUserId?.startsWith("anon_")) {
                userService.migrateUserSession(anonymousUserId, user)
            }

            // SECURITY: Regenerate session ID to prevent session fixation attacks
            request.changeSessionId()

            session.user = user
            session.userId = user.userId

            // Link guest session to user
            if (guestSessionId) {
                def guestSession = UserSession.findBySessionId(guestSessionId)
                if (guestSession && !guestSession.user) {
                    guestSession.user = user
                    guestSession.save(flush: true)
                    log.info("Guest session ${guestSessionId} linked to user ${user.userId}")
                }
            }

            // Update login tracking
            user.lastLoginAt = new Date()
            user.lastLoginIp = ipAddress
            user.save(flush: true)

            // Generate JWT tokens
            def tokenPair = jwtTokenService.generateTokenPair(user.userId, guestSessionId ?: UUID.randomUUID().toString(), 'user')

            // Save refresh token
            def refreshTokenId = UUID.randomUUID().toString()
            def expiresAt = new Date(System.currentTimeMillis() + (7 * 24 * 60 * 60 * 1000))  // 7 days
            refreshTokenService.saveRefreshToken(
                refreshTokenId,
                user,
                tokenPair.refreshToken,
                expiresAt,
                ipAddress,
                userAgent
            )

            // Invalidate user cache
            refreshTokenService.invalidateUserCache(user.userId)


            log.info("User registered and logged in: ${user.userId}")

            response.status = 201
            render([
                success: true,
                accessToken: tokenPair.accessToken,
                refreshToken: tokenPair.refreshToken,
                expiresIn: tokenPair.expiresIn,
                tokenType: tokenPair.tokenType,
                user: [
                    userId: user.userId,
                    name: user.name,
                    email: user.email,
                    role: 'user'
                ]
            ] as JSON)
        } catch (Exception e) {
            log.error("Error during signup: ${e.message}", e)
            response.status = 500
            render([success: false, error: 'Signup failed'] as JSON)
        }
    }

    /**
     * API endpoint: POST /api/token/refresh
     * Refresh access token using refresh token
     *
     * Request headers:
     * Authorization: Bearer {refreshToken}
     *
     * OR request body:
     * {
     *   "refreshToken": "eyJhbGc..."
     * }
     *
     * Response:
     * {
     *   "success": true,
     *   "accessToken": "eyJhbGc...",
     *   "refreshToken": "eyJhbGc...",  // Rotated
     *   "expiresIn": 3600,
     *   "tokenType": "Bearer"
     * }
     */
    @Transactional
    def refreshToken() {
        try {
            // Get refresh token from header or body
            def authHeader = request.getHeader('Authorization')
            def refreshToken = null

            if (authHeader?.startsWith('Bearer ')) {
                refreshToken = authHeader.substring(7)
            } else {
                def jsonData = request.JSON
                refreshToken = jsonData?.refreshToken?.toString()
            }

            if (!refreshToken) {
                response.status = 400
                render([success: false, error: "Refresh token is required"] as JSON)
                return
            }

            // Validate refresh token
            def claims = jwtTokenService.validateToken(refreshToken)
            if (!claims) {
                response.status = 401
                render([success: false, error: "Invalid refresh token"] as JSON)
                return
            }

            def userId = claims.get('uid', String.class)
            def sessionId = claims.get('sid', String.class)
            def role = claims.get('role', String.class) ?: 'guest'

            if (!userId) {
                response.status = 401
                render([success: false, error: "Invalid token payload"] as JSON)
                return
            }

            // Generate new access token
            def newAccessToken = jwtTokenService.generateAccessToken(userId, sessionId, role)

            // Rotate refresh token
            def newRefreshTokenValue = jwtTokenService.generateRefreshToken(userId, sessionId, role)
            def newRefreshTokenId = UUID.randomUUID().toString()
            def newExpiresAt = new Date(System.currentTimeMillis() + (7 * 24 * 60 * 60 * 1000))

            // Note: Finding the old token would require decoding, so we'll just create new one
            // In production, you might want to find and rotate the actual token
            def user = com.streamfit.user.User.findByUserId(userId)
            if (!user) {
                response.status = 401
                render([success: false, error: "User not found"] as JSON)
                return
            }

            refreshTokenService.saveRefreshToken(
                newRefreshTokenId,
                user,
                newRefreshTokenValue,
                newExpiresAt,
                request.getRemoteAddr(),
                request.getHeader('User-Agent')
            )

            log.info("Token refreshed for user: ${userId}")

            response.status = 200
            render([
                success: true,
                accessToken: newAccessToken,
                refreshToken: newRefreshTokenValue,
                expiresIn: 3600,
                tokenType: 'Bearer'
            ] as JSON)
        } catch (Exception e) {
            log.error("Error refreshing token: ${e.message}", e)
            response.status = 500
            render([success: false, error: 'Token refresh failed'] as JSON)
        }
    }

    /**
     * API endpoint: POST /api/logout
     * Logout user and revoke all refresh tokens
     *
     * Request headers:
     * Authorization: Bearer {accessToken}
     */
    @Transactional
    def logout() {
        try {
            def userId = request.getAttribute('userId') as String

            if (!userId) {
                response.status = 400
                render([success: false, error: "Not authenticated"] as JSON)
                return
            }

            def user = com.streamfit.user.User.findByUserId(userId)
            if (user) {
                user.lastLogoutAt = new Date()
                user.save(flush: true)

                // Revoke all refresh tokens for user
                int revokedCount = refreshTokenService.revokeAllTokensForUser(userId)
                log.info("User logged out: ${userId}, revoked ${revokedCount} tokens")
            }

            // Invalidate server session to prevent data leakage to next user
            session.invalidate()

            response.status = 200
            render([success: true, message: "Logged out successfully"] as JSON)
        } catch (Exception e) {
            log.error("Error during logout: ${e.message}", e)
            response.status = 500
            render([success: false, error: 'Logout failed'] as JSON)
        }
    }

    /**
     * API endpoint: GET /api/me
     * Get current user info from JWT
     *
     * Request headers:
     * Authorization: Bearer {accessToken}
     */
    def me() {
        try {
            def userId = request.getAttribute('userId') as String
            def sessionId = request.getAttribute('sessionId') as String
            def userRole = request.getAttribute('userRole') as String

            if (!userId) {
                // Guest user
                response.status = 200
                render([
                    success: true,
                    user: [
                        userId: null,
                        sessionId: sessionId,
                        role: 'guest'
                    ]
                ] as JSON)
                return
            }

            def user = com.streamfit.user.User.findByUserId(userId)

            response.status = 200
            render([
                success: true,
                user: [
                    userId: user?.userId,
                    name: user?.name,
                    email: user?.email,
                    age: user?.age,
                    sessionId: sessionId,
                    role: userRole ?: 'user',
                    lastLoginAt: user?.lastLoginAt
                ]
            ] as JSON)
        } catch (Exception e) {
            log.error("Error fetching current user: ${e.message}", e)
            response.status = 500
            render([success: false, error: 'Failed to fetch user info'] as JSON)
        }
    }
}

package com.streamfit.controller

import com.streamfit.service.AuthService
import grails.converters.JSON

class AuthController {

    AuthService authService
    
    /**
     * Login page
     * GET /login
     */
    def login() {
        // If already authenticated, redirect to dashboard
        if (authService.isAuthenticated()) {
            redirect(uri: '/dashboard')
            return
        }
        
        render(view: 'login')
    }
    
    /**
     * Signup page
     * GET /signup
     */
    def signup() {
        // If already authenticated, redirect to dashboard
        if (authService.isAuthenticated()) {
            redirect(uri: '/dashboard')
            return
        }
        
        render(view: 'signup')
    }
    
    /**
     * Process login
     * POST /api/auth/login
     */
    def doLogin() {
        try {
            def requestData = request.JSON
            def email = requestData.email
            def name = requestData.name
            
            if (!email) {
                response.status = 400
                render([success: false, error: 'Email is required'] as JSON)
                return
            }
            
            def result = authService.login(email, name)
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 400
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error during login: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Login failed'] as JSON)
        }
    }
    
    /**
     * Process signup
     * POST /api/auth/signup
     */
    def doSignup() {
        try {
            def requestData = request.JSON
            
            def result = authService.register(requestData)
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 400
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error during signup: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Signup failed'] as JSON)
        }
    }
    
    /**
     * Logout
     * POST /api/auth/logout
     */
    def logout() {
        try {
            authService.logout()
            
            response.status = 200
            render([success: true] as JSON)
        } catch (Exception e) {
            log.error "Error during logout: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Logout failed'] as JSON)
        }
    }
    
    /**
     * Get current user
     * GET /api/auth/me
     */
    def me() {
        try {
            def user = authService.getCurrentUser()
            
            if (user) {
                response.status = 200
                render([
                    success: true,
                    user: [
                        userId: user.userId,
                        email: user.email,
                        name: user.name
                    ]
                ] as JSON)
            } else {
                response.status = 401
                render([success: false, error: 'Not authenticated'] as JSON)
            }
        } catch (Exception e) {
            log.error "Error fetching current user: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch user'] as JSON)
        }
    }
}


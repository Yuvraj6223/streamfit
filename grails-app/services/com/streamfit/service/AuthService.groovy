package com.streamfit.service

import com.streamfit.user.User
import grails.gorm.transactions.Transactional
import org.springframework.web.context.request.RequestContextHolder

@Transactional
class AuthService {

    UserService userService
    
    /**
     * Login user with email
     */
    def login(String email, String name = null) {
        if (!email) {
            return [success: false, error: 'Email is required']
        }
        
        // Find or create user by email
        def user = User.findByEmail(email)
        
        if (!user) {
            // Create new user
            user = new User(
                userId: UUID.randomUUID().toString(),
                email: email,
                name: name ?: email.split('@')[0],
                agreedToTerms: true
            ).save(flush: true)
            
            // Create Learning DNA
            userService.createLearningDNA(user)
        } else if (name && !user.name) {
            // Update name if provided and not set
            user.name = name
            user.save(flush: true)
        }
        
        // Store user in session
        setCurrentUser(user)
        
        return [
            success: true,
            user: [
                userId: user.userId,
                email: user.email,
                name: user.name
            ]
        ]
    }
    
    /**
     * Register new user
     */
    def register(Map params) {
        if (!params.email) {
            return [success: false, error: 'Email is required']
        }
        
        // Check if user already exists
        if (User.findByEmail(params.email)) {
            return [success: false, error: 'User with this email already exists']
        }
        
        // Create user
        def user = userService.createOrGetUser(params)
        
        if (!user) {
            return [success: false, error: 'Failed to create user']
        }
        
        // Store user in session
        setCurrentUser(user)
        
        return [
            success: true,
            user: [
                userId: user.userId,
                email: user.email,
                name: user.name
            ]
        ]
    }
    
    /**
     * Logout current user
     */
    def logout() {
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        session.removeAttribute('currentUser')
        session.invalidate()
        
        return [success: true]
    }
    
    /**
     * Get current authenticated user
     */
    def getCurrentUser() {
        def session = RequestContextHolder.currentRequestAttributes().getSession(false)
        if (!session) {
            return null
        }
        
        def userId = session.getAttribute('currentUser')
        if (!userId) {
            return null
        }
        
        return User.findByUserId(userId)
    }
    
    /**
     * Set current user in session
     */
    def setCurrentUser(User user) {
        def session = RequestContextHolder.currentRequestAttributes().getSession()
        session.setAttribute('currentUser', user.userId)
    }
    
    /**
     * Check if user is authenticated
     */
    def isAuthenticated() {
        return getCurrentUser() != null
    }
    
    /**
     * Get or create session user (for anonymous access)
     */
    def getOrCreateSessionUser() {
        def user = getCurrentUser()
        
        if (!user) {
            // Check if we have a session user ID
            def session = RequestContextHolder.currentRequestAttributes().getSession()
            def sessionUserId = session.getAttribute('sessionUser')
            
            if (sessionUserId) {
                user = User.findByUserId(sessionUserId)
            }
            
            if (!user) {
                // Create anonymous user
                user = userService.createAnonymousUser()
                session.setAttribute('sessionUser', user.userId)
            }
        }
        
        return user
    }
}


package com.streamfit.controller

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import com.streamfit.user.User
import java.util.regex.Pattern


class AuthController {

    static namespace = null
    def userService


    def login() {
        render(view: "login")
    }

    def signup() {
        render(view: "signup")
    }

    // Email validation pattern (RFC 5322 simplified)
    private static final Pattern EMAIL_PATTERN = ~/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/
    
    // Maximum input lengths to prevent DoS
    private static final int MAX_EMAIL_LENGTH = 254
    private static final int MAX_NAME_LENGTH = 100

    @Transactional
    def processLogin() {
        def jsonData = request.JSON
        def email = jsonData?.email?.toString()?.trim()
        def name = jsonData?.name?.toString()?.trim()

        // Input validation
        if (!email) {
            render([success: false, message: "Email is required"] as JSON)
            return
        }
        
        // Validate email length
        if (email.length() > MAX_EMAIL_LENGTH) {
            render([success: false, message: "Email is too long"] as JSON)
            return
        }
        
        // Validate email format
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            render([success: false, message: "Invalid email format"] as JSON)
            return
        }

        // Find user by email
        def user = User.findByEmail(email)

        if (user) {
            // Prevent session fixation: regenerate session ID after successful login
            def oldUserId = session.userId
            if (oldUserId?.startsWith("anon_")) {
                userService.migrateUserSession(oldUserId, user)
            }
            
            // Regenerate session to prevent session fixation attacks
            request.changeSessionId()
            
            session.user = user
            session.userId = user.userId

            render([
                    success: true,
                    message: "Login successful",
                    user: [
                            userId: user.userId,
                            name: user.name,
                            email: user.email
                    ]
            ] as JSON)
        } else {
            render([success: false, message: "User not found. Please sign up first."] as JSON)
        }
    }

    @Transactional
    def processSignup() {
        def jsonData = request.JSON
        def name = jsonData?.name?.toString()?.trim()
        def email = jsonData?.email?.toString()?.trim()
        def age = jsonData?.age as Integer

        // Input validation
        if (!email) {
            render([success: false, message: "Email is required"] as JSON)
            return
        }
        
        // Validate email length
        if (email.length() > MAX_EMAIL_LENGTH) {
            render([success: false, message: "Email is too long"] as JSON)
            return
        }
        
        // Validate email format
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            render([success: false, message: "Invalid email format"] as JSON)
            return
        }
        
        // Validate name length if provided
        if (name && name.length() > MAX_NAME_LENGTH) {
            render([success: false, message: "Name is too long"] as JSON)
            return
        }
        
        // Validate age if provided
        if (age != null && (age < 1 || age > 120)) {
            render([success: false, message: "Invalid age"] as JSON)
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

        if (result.success) {
            def user = result.user
            def anonymousUserId = session.userId
            if (anonymousUserId?.startsWith("anon_")) {
                userService.migrateUserSession(anonymousUserId, user)
            }
            session.user = user
            session.userId = user.userId

            render([
                    success: true,
                    message: result.message,
                    user: [
                            userId: user.userId,
                            name: user.name,
                            email: user.email,
                            age: user.age
                    ]
            ] as JSON)
        } else {
            render([success: false, message: result.message] as JSON)
        }
    }

    @Transactional
    def logout() {
        session.user = null
        session.userId = null
        session.invalidate()

        render([success: true, message: "Logged out successfully"] as JSON)
    }

    def me() {
        def user = session.user

        if (user) {
            render([
                    success: true,
                    user: [
                            userId: user.userId,
                            name: user.name,
                            email: user.email,
                            age: user.age
                    ]
            ] as JSON)
        } else {
            render([success: false, message: "Not authenticated"] as JSON)
        }
    }
}
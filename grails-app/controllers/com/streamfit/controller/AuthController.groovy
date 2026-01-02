package com.streamfit.controller

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import com.streamfit.user.User


class AuthController {

    static namespace = null

    def login() {
        redirect(uri: "/result")
    }

    def signup() {
        redirect(uri: "/result")
    }

    @Transactional
    def processLogin() {
        def jsonData = request.JSON
        def email = jsonData?.email
        def name = jsonData?.name

        println "Login attempt: email=${email}, name=${name}"

        if (!email) {
            render([success: false, message: "Email is required"] as JSON)
            return
        }

        // Find user by email
        def user = User.findByEmail(email)

        if (user) {
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
        def name = jsonData?.name
        def email = jsonData?.email
        def age = jsonData?.age

        println "Signup attempt: name=${name}, email=${email}, age=${age}"

        // Validate required fields
        if (!email) {
            render([success: false, message: "Email is required"] as JSON)
            return
        }

        // Check if user already exists
        def existingUser = User.findByEmail(email)
        if (existingUser) {
            render([success: false, message: "Email already registered. Please login instead."] as JSON)
            return
        }

        // Generate unique userId
        def userId = generateUniqueUserId()

        // Get request metadata
        def ipAddress = request.getRemoteAddr()
        def userAgent = request.getHeader('User-Agent')

        // Create new user
        def user = new User(
                userId: userId,
                name: name,
                email: email,
                age: age,
                ipAddress: ipAddress,
                userAgent: userAgent,
                agreedToTerms: true
        )

        if (user.save(flush: true)) {
            session.user = user
            session.userId = user.userId

            println "User created successfully: ${user.userId} - ${user.name}"

            render([
                    success: true,
                    message: "Account created successfully!",
                    user: [
                            userId: user.userId,
                            name: user.name,
                            email: user.email,
                            age: user.age
                    ]
            ] as JSON)
        } else {
            println "User save failed: ${user.errors.allErrors}"
            def errorMessage = "Failed to create account. Please try again."

            if (user.errors.hasErrors()) {
                errorMessage = user.errors.allErrors[0].defaultMessage
            }

            render([success: false, message: errorMessage] as JSON)
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
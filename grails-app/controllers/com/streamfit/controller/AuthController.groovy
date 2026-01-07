package com.streamfit.controller

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import com.streamfit.user.User


class AuthController {

    static namespace = null
    def userService


    def login() {
        render(view: "login")
    }

    def signup() {
        render(view: "signup")
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
            def anonymousUserId = session.userId
            if (anonymousUserId?.startsWith("anon_")) {
                userService.migrateUserSession(anonymousUserId, user)
            }
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
        def age = jsonData?.age as Integer

        println "Signup attempt: name=${name}, email=${email}, age=${age}"

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
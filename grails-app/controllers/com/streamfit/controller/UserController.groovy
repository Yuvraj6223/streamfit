package com.streamfit.controller

import com.streamfit.service.UserService
import com.streamfit.service.AnalyticsService
import grails.converters.JSON

class UserController {

    UserService userService
    AnalyticsService analyticsService
    
    def register() {
        if (request.method == 'POST') {
            def params = request.JSON ?: params
            
            def user = userService.createOrGetUser([
                name: params.name,
                email: params.email,
                phoneNumber: params.phoneNumber,
                age: params.age,
                gender: params.gender,
                educationLevel: params.educationLevel,
                currentStream: params.currentStream,
                agreedToTerms: params.agreedToTerms,
                optInForUpdates: params.optInForUpdates,
                ipAddress: request.remoteAddr,
                userAgent: request.getHeader('User-Agent'),
                referralSource: params.referralSource
            ])
            
            if (user) {
                session.userId = user.userId
                
                render([
                    success: true,
                    userId: user.userId,
                    message: 'User registered successfully'
                ] as JSON)
            } else {
                response.status = 400
                render([
                    success: false,
                    message: 'Failed to register user'
                ] as JSON)
            }
        } else {
            render view: 'register'
        }
    }
    
    def profile() {
        def userId = session.userId
        
        if (!userId) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            redirect controller: 'user', action: 'register'
            return
        }
        
        def stats = userService.getUserStats(user)
        
        [
            user: user,
            stats: stats
        ]
    }
    
    def updatePreferences() {
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            response.status = 404
            render([success: false, message: 'User not found'] as JSON)
            return
        }
        
        def params = request.JSON ?: params
        
        userService.updateUserPreferences(user, params)
        
        render([
            success: true,
            message: 'Preferences updated successfully'
        ] as JSON)
    }
    
    def stats() {
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            response.status = 404
            render([success: false, message: 'User not found'] as JSON)
            return
        }
        
        def stats = userService.getUserStats(user)
        def engagement = analyticsService.getUserEngagementMetrics(user)
        
        render([
            success: true,
            stats: stats,
            engagement: engagement
        ] as JSON)
    }
}


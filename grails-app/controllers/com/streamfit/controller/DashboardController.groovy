package com.streamfit.controller

import com.streamfit.service.UserService
import com.streamfit.service.DashboardService
import com.streamfit.service.AnalyticsService
import grails.converters.JSON

class DashboardController {

    UserService userService
    DashboardService dashboardService
    AnalyticsService analyticsService
    
    def index() {
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
        
        def dashboardData = dashboardService.getDashboardData(user)
        
        // Track dashboard view
        if (dashboardData.unlocked) {
            analyticsService.trackDashboardView(user)
        }
        
        [
            user: user,
            dashboard: dashboardData
        ]
    }
    
    def learningDNA() {
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
        
        def dna = dashboardService.getLearningDNA(user)
        
        render([
            success: true,
            learningDNA: dna
        ] as JSON)
    }
    
    def data() {
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
        
        def dashboardData = dashboardService.getDashboardData(user)
        
        render([
            success: true,
            dashboard: dashboardData
        ] as JSON)
    }
}


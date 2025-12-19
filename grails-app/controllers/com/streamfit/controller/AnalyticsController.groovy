package com.streamfit.controller

import com.streamfit.service.UserService
import com.streamfit.service.AnalyticsService
import grails.converters.JSON

class AnalyticsController {

    UserService userService
    AnalyticsService analyticsService
    
    def index() {
        // Admin view for analytics dashboard
        def overallAnalytics = analyticsService.getOverallAnalytics()
        
        [
            analytics: overallAnalytics
        ]
    }
    
    def track() {
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
        def eventType = params.eventType
        def eventData = params.eventData ?: [:]

        // Add userAgent from request headers
        eventData.userAgent = request.getHeader('User-Agent')
        eventData.referrer = request.getHeader('Referer')

        analyticsService.trackEvent(user, eventType, eventData)

        render([success: true] as JSON)
    }
    
    def prebook() {
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
        def leadType = params.leadType ?: 'STREAMMAP_REPORT'
        def contactPreference = params.contactPreference
        
        def lead = analyticsService.createPrebookingLead(user, leadType, contactPreference)
        
        if (lead) {
            render([
                success: true,
                message: 'Thank you for your interest! We will contact you soon.',
                lead: lead
            ] as JSON)
        } else {
            response.status = 400
            render([
                success: false,
                message: 'Failed to create prebooking lead'
            ] as JSON)
        }
    }
    
    def stats() {
        def overallAnalytics = analyticsService.getOverallAnalytics()
        
        render([
            success: true,
            analytics: overallAnalytics
        ] as JSON)
    }
    
    def dropoffRates() {
        def dropoffRates = analyticsService.getTestDropoffRates()
        
        render([
            success: true,
            dropoffRates: dropoffRates
        ] as JSON)
    }
    
    def ctaStats() {
        def ctaStats = analyticsService.getCTAClickThroughRates()
        
        render([
            success: true,
            ctaStats: ctaStats
        ] as JSON)
    }
    
    def prebookingStats() {
        def prebookingStats = analyticsService.getPrebookingStats()
        
        render([
            success: true,
            prebookingStats: prebookingStats
        ] as JSON)
    }
}


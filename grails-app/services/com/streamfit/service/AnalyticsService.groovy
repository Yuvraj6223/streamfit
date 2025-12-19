package com.streamfit.service

import com.streamfit.user.User
import com.streamfit.analytics.UserAnalytics
import com.streamfit.analytics.PrebookingLead
import grails.gorm.transactions.Transactional
import groovy.json.JsonOutput

@Transactional
class AnalyticsService {

    def trackEvent(User user, String eventType, Map eventData = [:]) {
        def analytics = new UserAnalytics(
            user: user,
            eventType: eventType,
            eventData: JsonOutput.toJson(eventData),
            testCode: eventData.testCode,
            sessionId: eventData.sessionId,
            referrer: eventData.referrer,
            deviceType: determineDeviceType(eventData.userAgent),
            browserInfo: eventData.userAgent,
            eventTimestamp: new Date()
        )
        
        if (!analytics.save(flush: true)) {
            log.error "Failed to track event: ${analytics.errors}"
            return false
        }
        
        log.debug "Tracked event: ${eventType} for user: ${user.userId}"
        return true
    }
    
    def trackTestStarted(User user, String testCode, String sessionId) {
        trackEvent(user, 'TEST_STARTED', [
            testCode: testCode,
            sessionId: sessionId
        ])
    }
    
    def trackTestCompleted(User user, String testCode, String sessionId, Integer timeSpent) {
        trackEvent(user, 'TEST_COMPLETED', [
            testCode: testCode,
            sessionId: sessionId,
            timeSpent: timeSpent
        ])
    }
    
    def trackTestAbandoned(User user, String testCode, String sessionId, Integer questionNumber) {
        trackEvent(user, 'TEST_ABANDONED', [
            testCode: testCode,
            sessionId: sessionId,
            abandonedAt: questionNumber
        ])
    }
    
    def trackCTAClick(User user, String ctaType, String ctaLocation) {
        trackEvent(user, 'CTA_CLICKED', [
            ctaType: ctaType,
            location: ctaLocation
        ])
    }
    
    def trackResultShared(User user, String platform, String testCode) {
        trackEvent(user, 'RESULT_SHARED', [
            platform: platform,
            testCode: testCode
        ])
    }
    
    def trackPrebookClick(User user, String leadType) {
        trackEvent(user, 'PREBOOK_CLICKED', [
            leadType: leadType
        ])
    }
    
    def trackDashboardView(User user) {
        trackEvent(user, 'DASHBOARD_VIEWED', [:])
    }
    
    def createPrebookingLead(User user, String leadType, String contactPreference = null) {
        def lead = new PrebookingLead(
            user: user,
            leadType: leadType,
            status: 'PENDING',
            contactPreference: contactPreference,
            prebookedAt: new Date()
        )
        
        if (!lead.save(flush: true)) {
            log.error "Failed to create prebooking lead: ${lead.errors}"
            return null
        }
        
        // Update user preference
        user.prebookedStreamMap = true
        user.save(flush: true)
        
        // Track the event
        trackPrebookClick(user, leadType)
        
        log.info "Created prebooking lead: ${leadType} for user: ${user.userId}"
        return lead
    }
    
    def getTestDropoffRates() {
        def sql = """
            SELECT 
                test_code,
                COUNT(CASE WHEN status = 'STARTED' OR status = 'IN_PROGRESS' THEN 1 END) as abandoned,
                COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END) as completed,
                COUNT(*) as total
            FROM user_test_session
            GROUP BY test_code
        """
        
        // This would use actual SQL execution in production
        // For now, returning mock structure
        return [
            testCode: 'EXAM_SPIRIT_ANIMAL',
            abandonedCount: 0,
            completedCount: 0,
            totalStarted: 0,
            dropoffRate: 0.0
        ]
    }
    
    def getCTAClickThroughRates() {
        def ctaClicks = UserAnalytics.findAllByEventType('CTA_CLICKED')
        def totalUsers = User.count()
        
        def ctaStats = [:]
        ctaClicks.each { click ->
            def data = parseEventData(click.eventData)
            String ctaType = data.ctaType
            ctaStats[ctaType] = (ctaStats[ctaType] ?: 0) + 1
        }
        
        return ctaStats.collectEntries { ctaType, count ->
            [ctaType, [
                clicks: count,
                clickThroughRate: totalUsers > 0 ? (count / totalUsers) * 100 : 0
            ]]
        }
    }
    
    def getPrebookingStats() {
        def totalLeads = PrebookingLead.count()
        def pendingLeads = PrebookingLead.countByStatus('PENDING')
        def convertedLeads = PrebookingLead.countByStatus('CONVERTED')
        
        return [
            total: totalLeads,
            pending: pendingLeads,
            converted: convertedLeads,
            conversionRate: totalLeads > 0 ? (convertedLeads / totalLeads) * 100 : 0
        ]
    }
    
    def getStreamFitMatches() {
        // Aggregate most common stream matches
        def sql = """
            SELECT result_value, COUNT(*) as count
            FROM test_result
            WHERE result_type = 'STREAM_FIT'
            GROUP BY result_value
            ORDER BY count DESC
        """
        
        // Mock return for now
        return [
            'SCIENCE': 0,
            'COMMERCE': 0,
            'ENGINEERING': 0,
            'ARTS': 0,
            'MEDICAL': 0
        ]
    }
    
    def getUserEngagementMetrics(User user) {
        def events = UserAnalytics.findAllByUser(user, [sort: 'eventTimestamp', order: 'asc'])
        
        if (!events) {
            return [
                totalEvents: 0,
                firstVisit: null,
                lastVisit: null,
                testsStarted: 0,
                testsCompleted: 0,
                ctaClicks: 0,
                sharesCount: 0
            ]
        }
        
        return [
            totalEvents: events.size(),
            firstVisit: events.first().eventTimestamp,
            lastVisit: events.last().eventTimestamp,
            testsStarted: events.count { it.eventType == 'TEST_STARTED' },
            testsCompleted: events.count { it.eventType == 'TEST_COMPLETED' },
            ctaClicks: events.count { it.eventType == 'CTA_CLICKED' },
            sharesCount: events.count { it.eventType == 'RESULT_SHARED' }
        ]
    }
    
    def getOverallAnalytics() {
        def totalUsers = User.count()
        def totalSessions = UserAnalytics.countByEventType('TEST_STARTED')
        def completedTests = UserAnalytics.countByEventType('TEST_COMPLETED')
        def totalShares = UserAnalytics.countByEventType('RESULT_SHARED')
        def totalPrebooks = PrebookingLead.count()
        
        return [
            users: [
                total: totalUsers,
                withCompletedTests: User.executeQuery(
                    "SELECT COUNT(DISTINCT u) FROM User u JOIN u.testSessions s WHERE s.status = 'COMPLETED'"
                )[0] ?: 0
            ],
            tests: [
                totalStarted: totalSessions,
                totalCompleted: completedTests,
                completionRate: totalSessions > 0 ? (completedTests / totalSessions) * 100 : 0
            ],
            engagement: [
                totalShares: totalShares,
                totalPrebooks: totalPrebooks,
                shareRate: totalUsers > 0 ? (totalShares / totalUsers) * 100 : 0,
                prebookRate: totalUsers > 0 ? (totalPrebooks / totalUsers) * 100 : 0
            ],
            topTests: getTopTests(),
            streamMatches: getStreamFitMatches()
        ]
    }
    
    private List getTopTests() {
        def testCounts = UserAnalytics.executeQuery("""
            SELECT ua.testCode, COUNT(ua)
            FROM UserAnalytics ua
            WHERE ua.eventType = 'TEST_COMPLETED'
            GROUP BY ua.testCode
            ORDER BY COUNT(ua) DESC
        """)
        
        return testCounts.collect { [testCode: it[0], completions: it[1]] }
    }
    
    private String determineDeviceType(String userAgent) {
        if (!userAgent) return 'UNKNOWN'
        
        userAgent = userAgent.toLowerCase()
        
        if (userAgent.contains('mobile') || userAgent.contains('android') || userAgent.contains('iphone')) {
            return 'MOBILE'
        } else if (userAgent.contains('tablet') || userAgent.contains('ipad')) {
            return 'TABLET'
        } else {
            return 'DESKTOP'
        }
    }
    
    private Map parseEventData(String eventDataJson) {
        if (!eventDataJson) return [:]
        
        try {
            return new groovy.json.JsonSlurper().parseText(eventDataJson)
        } catch (Exception e) {
            log.error "Failed to parse event data: ${e.message}"
            return [:]
        }
    }
}


package com.streamfit.analytics

import com.streamfit.user.User

class UserAnalytics {
    
    User user
    String eventType // TEST_STARTED, TEST_COMPLETED, TEST_ABANDONED, CTA_CLICKED, RESULT_SHARED, PREBOOK_CLICKED
    String eventData
    String testCode
    String sessionId
    String referrer
    String deviceType
    String browserInfo
    
    Date eventTimestamp
    Date dateCreated
    
    static belongsTo = [user: User]
    
    static constraints = {
        eventType blank: false, inList: [
            'PAGE_VIEW',
            'TEST_STARTED',
            'TEST_COMPLETED',
            'TEST_ABANDONED',
            'CTA_CLICKED',
            'RESULT_SHARED',
            'PREBOOK_CLICKED',
            'DASHBOARD_VIEWED',
            'QUESTION_ANSWERED'
        ]
        eventData nullable: true, maxSize: 2000
        testCode nullable: true, maxSize: 50
        sessionId nullable: true
        referrer nullable: true, maxSize: 500
        deviceType nullable: true, inList: ['MOBILE', 'TABLET', 'DESKTOP', 'UNKNOWN']
        browserInfo nullable: true, maxSize: 200
        eventTimestamp nullable: false
    }
    
    static mapping = {
        table 'user_analytics'
        version false
        eventData type: 'text'
    }
    
    String toString() {
        return "${eventType} - ${user} - ${eventTimestamp}"
    }
}


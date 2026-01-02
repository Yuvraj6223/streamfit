package com.streamfit

class EngageData {
    String sessionId // Reference to UserSession but no direct foreign key
    String gameType
    String questionId
    String optionId
    Date timestamp
    Integer timeSpent // Time spent on this question in seconds
    Integer confidenceLevel // 1-3 scale for confidence
    Boolean isCorrect // For questions with right/wrong answers
    String userAgent
    String ipAddress
    
    static constraints = {
        sessionId blank: false
        gameType blank: false
        questionId blank: false
        optionId blank: false
        timestamp nullable: false
        timeSpent nullable: true
        confidenceLevel nullable: true, range: 1..3
        isCorrect nullable: true
        userAgent nullable: true, maxSize: 500
        ipAddress nullable: true, maxSize: 45
    }
    
    static mapping = {
        table 'engage_data'
        version false
        timestamp default: "now()"
    }
}

package com.streamfit.reward

import com.streamfit.user.User

/**
 * Represents a special achievement or milestone
 */
class Achievement {
    
    User user
    String achievementType // "FIRST_TEST", "ALL_EXAM_TESTS", "ALL_CAREER_TESTS", "PERFECT_SCORE", etc.
    String achievementTitle
    String achievementDescription
    String emoji
    Integer pointsAwarded
    
    Date achievedAt
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [user: User]
    
    static constraints = {
        achievementType blank: false, maxSize: 100
        achievementTitle blank: false, maxSize: 200
        achievementDescription nullable: true, maxSize: 1000
        emoji nullable: true, maxSize: 10
        pointsAwarded min: 0
        achievedAt nullable: false
    }
    
    static mapping = {
        table 'achievement'
        version false
        achievementDescription sqlType: 'text'
    }
    
    String toString() {
        return "${emoji} ${achievementTitle}"
    }
}


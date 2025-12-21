package com.streamfit.reward

/**
 * Represents a badge that can be earned by users
 */
class Badge {
    
    String badgeId // Unique identifier
    String badgeName
    String badgeDescription
    String emoji // Visual representation
    String category // "EXAM", "CAREER", "MILESTONE", "STREAK"
    String rarity // "COMMON", "RARE", "EPIC", "LEGENDARY"
    Integer pointsValue
    
    // Unlock criteria
    String unlockCondition // Description of how to unlock
    String requiredTestId // If badge is for completing a specific test
    Integer requiredTestCount // Number of tests to complete
    Integer requiredStreak // Consecutive days required
    
    Boolean isActive = true
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        badgeId blank: false, unique: true, maxSize: 100
        badgeName blank: false, maxSize: 200
        badgeDescription nullable: true, maxSize: 1000
        emoji nullable: true, maxSize: 10
        category inList: ['EXAM', 'CAREER', 'MILESTONE', 'STREAK', 'SPECIAL']
        rarity inList: ['COMMON', 'RARE', 'EPIC', 'LEGENDARY']
        pointsValue min: 0
        unlockCondition nullable: true, maxSize: 500
        requiredTestId nullable: true, maxSize: 100
        requiredTestCount nullable: true, min: 1
        requiredStreak nullable: true, min: 1
    }
    
    static mapping = {
        table 'badge'
        version false
        badgeDescription sqlType: 'text'
        unlockCondition sqlType: 'text'
    }
    
    String toString() {
        return "${emoji} ${badgeName}"
    }
}


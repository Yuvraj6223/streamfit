package com.streamfit.reward

import com.streamfit.user.User

/**
 * Tracks user's points and level
 */
class UserPoints {
    
    User user
    Integer totalPoints = 0
    Integer currentLevel = 1
    Integer currentStreak = 0
    Integer longestStreak = 0
    Date lastActivityDate
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [user: User]
    
    static constraints = {
        totalPoints min: 0
        currentLevel min: 1
        currentStreak min: 0
        longestStreak min: 0
        lastActivityDate nullable: true
    }
    
    static mapping = {
        table 'user_points'
        version false
    }
    
    /**
     * Calculate level based on points
     * Level 1: 0-99 points
     * Level 2: 100-299 points
     * Level 3: 300-599 points
     * etc.
     */
    def calculateLevel() {
        if (totalPoints < 100) return 1
        if (totalPoints < 300) return 2
        if (totalPoints < 600) return 3
        if (totalPoints < 1000) return 4
        if (totalPoints < 1500) return 5
        if (totalPoints < 2100) return 6
        if (totalPoints < 2800) return 7
        if (totalPoints < 3600) return 8
        if (totalPoints < 4500) return 9
        return 10
    }
    
    /**
     * Get points needed for next level
     */
    def getPointsToNextLevel() {
        def nextLevelThresholds = [100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500, 5500]
        def currentLevelIndex = currentLevel - 1
        
        if (currentLevelIndex >= nextLevelThresholds.size()) {
            return 0 // Max level reached
        }
        
        return nextLevelThresholds[currentLevelIndex] - totalPoints
    }
    
    String toString() {
        return "${user.name} - Level ${currentLevel} (${totalPoints} points)"
    }
}


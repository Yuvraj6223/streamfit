package com.streamfit.reward

import com.streamfit.user.User

/**
 * Represents a badge earned by a user
 */
class UserBadge {
    
    User user
    Badge badge
    Date earnedAt
    Boolean isNew = true // For showing "NEW!" indicator
    Boolean isFavorite = false
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [user: User, badge: Badge]
    
    static constraints = {
        earnedAt nullable: false
    }
    
    static mapping = {
        table 'user_badge'
        version false
    }
    
    String toString() {
        return "${user.name} earned ${badge.badgeName}"
    }
}


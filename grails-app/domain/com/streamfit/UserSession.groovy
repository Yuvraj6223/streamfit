package com.streamfit

import com.streamfit.user.User

class UserSession {
    String sessionId
    User user
    Date startTime
    Date endTime
    String status // 'ACTIVE', 'COMPLETED', 'ABANDONED'
    
    // Game results data
    String gameResults // JSON string storing all game results
    
    static constraints = {
        sessionId unique: true, blank: false
        user nullable: true  // Allow guest sessions without user
        startTime nullable: false
        endTime nullable: true
        status inList: ['ACTIVE', 'COMPLETED', 'ABANDONED']
        gameResults nullable: true, maxSize: 5000
    }
    
    static mapping = {
        table 'user_session'
        version false
        gameResults type: 'text'
        user index: 'idx_user_session_user'  // Index for faster user history queries
    }
}

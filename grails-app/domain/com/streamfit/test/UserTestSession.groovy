package com.streamfit.test

import com.streamfit.user.User

class UserTestSession {
    
    User user
    TestDefinition testDefinition
    String sessionId
    String status // STARTED, IN_PROGRESS, COMPLETED, ABANDONED
    Date startedAt
    Date completedAt
    Integer currentQuestionNumber = 1
    Integer totalTimeSpent // in seconds
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [user: User, testDefinition: TestDefinition]
    static hasMany = [responses: UserResponse, results: TestResult]
    
    static constraints = {
        sessionId unique: true, blank: false
        status inList: ['STARTED', 'IN_PROGRESS', 'COMPLETED', 'ABANDONED']
        startedAt nullable: false
        completedAt nullable: true
        currentQuestionNumber min: 1
        totalTimeSpent nullable: true, min: 0
    }
    
    static mapping = {
        table 'user_test_session'
        version false
        responses cascade: 'all-delete-orphan'
        results cascade: 'all-delete-orphan'
    }
    
    String toString() {
        return "${user} - ${testDefinition} - ${status}"
    }
}


package com.streamfit.personality

import com.streamfit.user.User

class PersonalityTestSession {
    
    User user
    String sessionId
    String gender // Male, Female, Other
    String status // STARTED, IN_PROGRESS, COMPLETED
    
    // Results
    String personality // e.g., "ISTP"
    String variant // e.g., "A" or "T"
    String niceName // e.g., "Virtuoso"
    String role
    String strategy
    String avatarSrc
    String avatarAlt
    String avatarSrcStatic
    String profileUrl
    
    Date startedAt
    Date completedAt
    Date dateCreated
    Date lastUpdated
    
    static hasMany = [responses: PersonalityResponse, traits: PersonalityTrait]
    
    static constraints = {
        sessionId blank: false, unique: true
        gender inList: ['Male', 'Female', 'Other']
        status inList: ['STARTED', 'IN_PROGRESS', 'COMPLETED']
        personality nullable: true, maxSize: 10
        variant nullable: true, maxSize: 5
        niceName nullable: true, maxSize: 100
        role nullable: true, maxSize: 100
        strategy nullable: true, maxSize: 100
        avatarSrc nullable: true, url: true
        avatarAlt nullable: true, maxSize: 200
        avatarSrcStatic nullable: true, url: true
        profileUrl nullable: true, url: true
        completedAt nullable: true
    }
    
    static mapping = {
        table 'personality_test_session'
        version false
        responses cascade: 'all-delete-orphan'
        traits cascade: 'all-delete-orphan'
    }
    
    String toString() {
        return "Session ${sessionId} - ${personality ?: 'In Progress'}"
    }
}


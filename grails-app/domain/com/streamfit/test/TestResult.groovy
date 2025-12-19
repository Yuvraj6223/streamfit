package com.streamfit.test

class TestResult {
    
    UserTestSession session
    TestArchetype archetype
    String resultType // ARCHETYPE, COGNITIVE_SCORE, WORK_STYLE, etc.
    String resultKey
    String resultValue
    Double scorePercentage
    String scoreLabel
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [session: UserTestSession]
    
    static constraints = {
        archetype nullable: true
        resultType blank: false, maxSize: 50
        resultKey blank: false, maxSize: 100
        resultValue nullable: true, maxSize: 1000
        scorePercentage nullable: true, min: 0.0d, max: 100.0d
        scoreLabel nullable: true, maxSize: 100
    }
    
    static mapping = {
        table 'test_result'
        version false
        resultValue type: 'text'
    }
    
    String toString() {
        return "${resultType}: ${resultKey}"
    }
}


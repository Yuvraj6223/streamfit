package com.streamfit.test

class TestDefinition {
    
    String testCode
    String testName
    String description
    String category // CORE or STREAMFIT
    Integer estimatedMinutes
    Integer totalQuestions
    Boolean isActive = true
    Boolean isTimed = false
    
    Date dateCreated
    Date lastUpdated
    
    static hasMany = [
        questions: TestQuestion,
        archetypes: TestArchetype
    ]
    
    static constraints = {
        testCode unique: true, blank: false, maxSize: 50
        testName blank: false, maxSize: 100
        description nullable: true, maxSize: 500
        category inList: ['CORE', 'STREAMFIT']
        estimatedMinutes min: 1
        totalQuestions min: 1
    }
    
    static mapping = {
        table 'test_definition'
        version false
        questions cascade: 'all-delete-orphan'
        archetypes cascade: 'all-delete-orphan'
    }
    
    String toString() {
        return testName
    }
}


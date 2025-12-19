package com.streamfit.test

class TestQuestion {
    
    TestDefinition testDefinition
    Integer questionNumber
    String questionText
    String questionType // SINGLE_CHOICE, MULTIPLE_CHOICE, TIMED_GAME
    String imageUrl
    String cognitiveArea // For Cognitive Radar: LOGIC, VERBAL, SPATIAL, SPEED
    Integer timeLimit // in seconds, for timed questions
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [testDefinition: TestDefinition]
    static hasMany = [options: QuestionOption]
    
    static constraints = {
        questionNumber min: 1
        questionText blank: false, maxSize: 1000
        questionType inList: ['SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'TIMED_GAME']
        imageUrl nullable: true, url: true
        cognitiveArea nullable: true, inList: ['LOGIC', 'VERBAL', 'SPATIAL', 'SPEED']
        timeLimit nullable: true, min: 1
    }
    
    static mapping = {
        table 'test_question'
        version false
        options cascade: 'all-delete-orphan'
        questionText sqlType: 'text'
    }
    
    String toString() {
        return "Q${questionNumber}: ${questionText?.take(50)}"
    }
}


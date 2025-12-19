package com.streamfit.test

class QuestionOption {
    
    TestQuestion question
    String optionText
    String optionValue // For scoring/mapping
    String imageUrl
    Integer displayOrder
    Boolean isCorrect = false // For aptitude tests
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [question: TestQuestion]
    
    static constraints = {
        optionText blank: false, maxSize: 500
        optionValue blank: false, maxSize: 100
        imageUrl nullable: true, url: true
        displayOrder min: 1
    }
    
    static mapping = {
        table 'question_option'
        version false
    }
    
    String toString() {
        return optionText
    }
}


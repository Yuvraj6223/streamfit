package com.streamfit.personality

class PersonalityQuestion {
    
    String questionId // Base64 encoded question text
    String questionText
    Integer questionNumber
    
    Date dateCreated
    Date lastUpdated
    
    static hasMany = [options: PersonalityQuestionOption]
    
    static constraints = {
        questionId blank: false, unique: true
        questionText blank: false, maxSize: 1000
        questionNumber min: 1
    }
    
    static mapping = {
        table 'personality_question'
        version false
        options cascade: 'all-delete-orphan'
        questionText sqlType: 'text'
    }
    
    String toString() {
        return "Q${questionNumber}: ${questionText?.take(50)}"
    }
}


package com.streamfit.personality

class PersonalityQuestionOption {
    
    PersonalityQuestion question
    String optionText
    Integer optionValue // -3 to 3
    Integer displayOrder
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [question: PersonalityQuestion]
    
    static constraints = {
        optionText blank: false, maxSize: 200
        optionValue min: -3, max: 3
        displayOrder min: 1
    }
    
    static mapping = {
        table 'personality_question_option'
        version false
    }
    
    String toString() {
        return "${optionText} (${optionValue})"
    }
}


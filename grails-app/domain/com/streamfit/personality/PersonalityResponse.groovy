package com.streamfit.personality

class PersonalityResponse {
    
    PersonalityTestSession session
    String questionId
    String questionText
    Integer answerValue
    
    Date answeredAt
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [session: PersonalityTestSession]
    
    static constraints = {
        questionId blank: false
        questionText blank: false, maxSize: 1000
        answerValue min: -3, max: 3
    }
    
    static mapping = {
        table 'personality_response'
        version false
        questionText sqlType: 'text'
    }
    
    String toString() {
        return "${questionId}: ${answerValue}"
    }
}


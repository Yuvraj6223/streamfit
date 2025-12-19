package com.streamfit.test

class UserResponse {
    
    UserTestSession session
    TestQuestion question
    QuestionOption selectedOption
    String responseValue
    Integer timeTaken // in seconds
    Boolean isCorrect
    Date answeredAt
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [session: UserTestSession]
    
    static constraints = {
        question nullable: false
        selectedOption nullable: true
        responseValue nullable: true, maxSize: 500
        timeTaken nullable: true, min: 0
        isCorrect nullable: true
        answeredAt nullable: false
    }
    
    static mapping = {
        table 'user_response'
        version false
    }
    
    String toString() {
        return "Response to ${question}"
    }
}


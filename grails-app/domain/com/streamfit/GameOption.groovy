package com.streamfit

class GameOption {
    GameQuestion question
    String optionText
    String optionValue
    Integer displayOrder
    Boolean isCorrect // for questions with right/wrong answers
    
    static constraints = {
        question nullable: false
        optionText blank: false, maxSize: 500
        optionValue blank: false, maxSize: 100
        displayOrder nullable: false
        isCorrect nullable: true
    }
    
    static mapping = {
        table 'game_options'
        version false
        optionText type: 'text'
    }
    
    static belongsTo = [question: GameQuestion]
}

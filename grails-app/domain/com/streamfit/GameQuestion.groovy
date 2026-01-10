package com.streamfit

class GameQuestion {
    String questionId
    String gameType // 'COGNITIVE_RADAR', 'CURIOSITY_COMPASS', etc.
    Integer questionNumber
    String questionText
    String questionType // 'MULTIPLE_CHOICE', 'BETTING', 'INTERACTIVE', 'TIMED'
    String scoringDimension
    Integer timeLimit // for timed questions
    Boolean isActive = true
    
    static constraints = {
        questionId unique: true, blank: false
        gameType blank: false, inList: [
            'COGNITIVE_RADAR', 'CURIOSITY_COMPASS', 'FOCUS_STAMINA', 
            'GUESSWORK_QUOTIENT', 'MODALITY_MAP', 'PATTERN_SNAPSHOT',
            'SPIRIT_ANIMAL', 'WORK_MODE', 'PERSONALITY'
        ]
        questionNumber nullable: false
        questionText blank: false, maxSize: 1000
        questionType inList: ['MULTIPLE_CHOICE', 'BETTING', 'INTERACTIVE', 'TIMED']
        scoringDimension nullable: true, maxSize: 100
        timeLimit nullable: true
        isActive nullable: false
    }
    
    static mapping = {
        table 'game_questions'
        version false
        questionText type: 'text'
        options batchSize: 25  // Batch fetch options to avoid N+1 queries
    }
    
    static hasMany = [options: GameOption]
}

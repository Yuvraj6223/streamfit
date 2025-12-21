package com.streamfit.diagnostic

/**
 * Represents a question in a diagnostic test
 */
class DiagnosticQuestion {
    
    DiagnosticTest test
    String questionId // Unique identifier
    String questionText
    Integer questionNumber
    String questionType // "MULTIPLE_CHOICE", "TIMED", "INTERACTIVE", "BETTING"
    Integer timeLimit // For timed questions (in seconds)
    String scoringDimension // e.g., "PROCESS_VS_INTUITION", "LOGIC", "VERBAL", etc.
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [test: DiagnosticTest]
    static hasMany = [options: DiagnosticQuestionOption]
    
    static constraints = {
        questionId blank: false, unique: true, maxSize: 100
        questionText blank: false, maxSize: 2000
        questionNumber min: 1
        questionType inList: ['MULTIPLE_CHOICE', 'TIMED', 'INTERACTIVE', 'BETTING']
        timeLimit nullable: true, min: 1
        scoringDimension nullable: true, maxSize: 100
    }
    
    static mapping = {
        table 'diagnostic_question'
        version false
        options cascade: 'all-delete-orphan'
        questionText sqlType: 'text'
    }
    
    String toString() {
        return "Q${questionNumber}: ${questionText?.take(50)}"
    }
}


package com.streamfit.diagnostic

/**
 * Represents an option/answer for a diagnostic question
 */
class DiagnosticQuestionOption {
    
    DiagnosticQuestion question
    String optionText
    String optionValue // The trait/dimension this option maps to (e.g., "PROCESS", "INTUITION", "A", "B", etc.)
    Integer scoreValue // Numeric score if applicable
    Integer displayOrder
    Boolean isCorrect = false // For questions with correct answers
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [question: DiagnosticQuestion]
    
    static constraints = {
        optionText blank: false, maxSize: 500
        optionValue blank: false, maxSize: 50
        scoreValue nullable: true
        displayOrder min: 1
    }
    
    static mapping = {
        table 'diagnostic_question_option'
        version false
    }
    
    String toString() {
        return "${optionText} (${optionValue})"
    }
}


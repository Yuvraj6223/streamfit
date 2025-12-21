package com.streamfit.diagnostic

/**
 * Represents a user's response to a diagnostic question
 */
class DiagnosticResponse {

    DiagnosticTestSession session
    DiagnosticQuestion question
    DiagnosticQuestionOption selectedOption

    String answerValue // The value selected (e.g., "A", "PROCESS", etc.)
    Integer confidenceLevel // For betting-type questions (1-3)
    Integer timeSpent // Time spent on question in seconds
    Boolean isCorrect // For questions with correct answers

    Date answeredAt
    Date dateCreated
    Date lastUpdated

    static belongsTo = [session: DiagnosticTestSession]

    static constraints = {
        answerValue blank: false, maxSize: 100
        confidenceLevel nullable: true, min: 1, max: 3
        timeSpent nullable: true, min: 0
        isCorrect nullable: true
        question nullable: true
        selectedOption nullable: true
    }

    static mapping = {
        table 'diagnostic_response'
        version false
    }
    
    String toString() {
        return "Response to ${question?.questionId ?: 'unknown'}: ${answerValue}"
    }
}


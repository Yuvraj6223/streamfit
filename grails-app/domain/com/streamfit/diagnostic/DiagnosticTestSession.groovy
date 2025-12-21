package com.streamfit.diagnostic

import com.streamfit.user.User

/**
 * Represents a user's session for taking a diagnostic test
 */
class DiagnosticTestSession {

    User user
    DiagnosticTest test
    String sessionId
    String status // "STARTED", "IN_PROGRESS", "COMPLETED"

    // Results - will be populated after completion
    String resultType // e.g., "WISE_OWL", "STRATEGIC_WOLF", "ANALYTICAL_DIAMOND", etc.
    String resultTitle
    String resultSummary

    // Metadata - stored as JSON strings
    String scoreBreakdown // JSON field for detailed scores
    String metadata // Additional session data

    Date startedAt
    Date completedAt
    Date dateCreated
    Date lastUpdated

    static belongsTo = [user: User, test: DiagnosticTest]
    static hasMany = [responses: DiagnosticResponse]

    static constraints = {
        sessionId blank: false, unique: true
        status inList: ['STARTED', 'IN_PROGRESS', 'COMPLETED']
        resultType nullable: true, maxSize: 100
        resultTitle nullable: true, maxSize: 200
        resultSummary nullable: true, maxSize: 5000
        scoreBreakdown nullable: true
        metadata nullable: true
        completedAt nullable: true
    }

    static mapping = {
        table 'diagnostic_test_session'
        version false
        responses cascade: 'all-delete-orphan'
        scoreBreakdown sqlType: 'text'
        metadata sqlType: 'text'
        resultSummary sqlType: 'text'
    }

    String toString() {
        return "Session ${sessionId} - ${test?.testName} - ${resultType ?: 'In Progress'}"
    }
}


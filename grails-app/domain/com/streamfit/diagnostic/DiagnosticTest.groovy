package com.streamfit.diagnostic

/**
 * Represents a diagnostic test (e.g., Spirit Animal, Cognitive Radar, etc.)
 */
class DiagnosticTest {
    
    String testId // Unique identifier (e.g., "SPIRIT_ANIMAL", "COGNITIVE_RADAR")
    String testName // Display name
    String testType // "EXAM" or "CAREER"
    String description
    Integer questionCount
    Integer estimatedMinutes
    Boolean isActive = true
    
    Date dateCreated
    Date lastUpdated
    
    static hasMany = [questions: DiagnosticQuestion]
    
    static constraints = {
        testId blank: false, unique: true, maxSize: 50
        testName blank: false, maxSize: 200
        testType inList: ['EXAM', 'CAREER']
        description nullable: true, maxSize: 1000
        questionCount min: 1
        estimatedMinutes min: 1
    }
    
    static mapping = {
        table 'diagnostic_test'
        version false
        questions cascade: 'all-delete-orphan'
        description sqlType: 'text'
    }
    
    String toString() {
        return "${testName} (${testId})"
    }
}


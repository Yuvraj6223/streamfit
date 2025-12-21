package com.streamfit.diagnostic

/**
 * Represents a diagnostic result profile/archetype
 * (e.g., Wise Owl, Strategic Wolf, Analytical Diamond, etc.)
 */
class DiagnosticResult {
    
    DiagnosticTest test
    String resultId // Unique identifier (e.g., "WISE_OWL", "STRATEGIC_WOLF")
    String resultTitle // Display title
    String emoji // Emoji representation
    String summary // Short summary
    String profile // Detailed profile description
    String strengths // Key strengths
    String traps // Common pitfalls/weaknesses
    String aiRoadmap // AI coaching recommendations
    String bestMatches // Best exam/career matches
    
    // Scoring criteria
    String primaryTrait // e.g., "PROCESS", "INTUITION"
    String secondaryTrait // e.g., "ACCURACY", "SPEED"
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [test: DiagnosticTest]
    
    static constraints = {
        resultId blank: false, unique: true, maxSize: 100
        resultTitle blank: false, maxSize: 200
        emoji nullable: true, maxSize: 10
        summary nullable: true, maxSize: 1000
        profile nullable: true, maxSize: 5000
        strengths nullable: true, maxSize: 2000
        traps nullable: true, maxSize: 2000
        aiRoadmap nullable: true, maxSize: 3000
        bestMatches nullable: true, maxSize: 2000
        primaryTrait nullable: true, maxSize: 50
        secondaryTrait nullable: true, maxSize: 50
    }
    
    static mapping = {
        table 'diagnostic_result'
        version false
        summary sqlType: 'text'
        profile sqlType: 'text'
        strengths sqlType: 'text'
        traps sqlType: 'text'
        aiRoadmap sqlType: 'text'
        bestMatches sqlType: 'text'
    }
    
    String toString() {
        return "${emoji} ${resultTitle} (${resultId})"
    }
}


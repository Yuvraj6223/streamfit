import grails.util.Environment
import com.streamfit.*
import com.streamfit.diagnostic.*
import com.streamfit.personality.*
import com.streamfit.reward.*

// Database reset script
// This script will delete all existing tables and create fresh ones

println "=== DATABASE RESET SCRIPT ==="
println "Environment: ${Environment.current}"
println "WARNING: This will delete all existing data!"
println "Press Ctrl+C to cancel or wait 5 seconds to continue..."
Thread.sleep(5000)

try {
    println "Starting database reset..."
    
    // Delete old diagnostic tables
    println "Deleting old diagnostic tables..."
    DiagnosticResponse.executeUpdate("DELETE FROM DiagnosticResponse")
    DiagnosticResult.executeUpdate("DELETE FROM DiagnosticResult") 
    DiagnosticQuestionOption.executeUpdate("DELETE FROM DiagnosticQuestionOption")
    DiagnosticQuestion.executeUpdate("DELETE FROM DiagnosticQuestion")
    DiagnosticTestSession.executeUpdate("DELETE FROM DiagnosticTestSession")
    DiagnosticTest.executeUpdate("DELETE FROM DiagnosticTest")
    
    // Delete old personality tables
    println "Deleting old personality tables..."
    PersonalityResponse.executeUpdate("DELETE FROM PersonalityResponse")
    PersonalityQuestionOption.executeUpdate("DELETE FROM PersonalityQuestionOption")
    PersonalityQuestion.executeUpdate("DELETE FROM PersonalityQuestion")
    PersonalityTestSession.executeUpdate("DELETE FROM PersonalityTestSession")
    PersonalityTrait.executeUpdate("DELETE FROM PersonalityTrait")
    
    // Delete old reward tables
    println "Deleting old reward tables..."
    UserBadge.executeUpdate("DELETE FROM UserBadge")
    UserPoints.executeUpdate("DELETE FROM UserPoints")
    Badge.executeUpdate("DELETE FROM Badge")
    Achievement.executeUpdate("DELETE FROM Achievement")
    
    // Delete old dashboard tables
    println "Deleting old dashboard tables..."
    LearningDNA.executeUpdate("DELETE FROM LearningDNA")
    
    // Delete new tables if they exist (for clean reset)
    println "Resetting new tables..."
    EngageData.executeUpdate("DELETE FROM EngageData")
    OptionPersonaMapping.executeUpdate("DELETE FROM OptionPersonaMapping")
    GameOption.executeUpdate("DELETE FROM GameOption")
    GameQuestion.executeUpdate("DELETE FROM GameQuestion")
    UserSession.executeUpdate("DELETE FROM UserSession")
    
    // Keep User table but clean sensitive data if needed
    println "Keeping User table intact..."
    
    println "Database reset completed successfully!"
    println "New tables will be created automatically on application startup."
    
} catch (Exception e) {
    println "Error during database reset: ${e.message}"
    e.printStackTrace()
}

println "=== DATABASE RESET COMPLETE ==="

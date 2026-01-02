package com.streamfit

import com.streamfit.service.UnifiedPersonaService
import com.streamfit.service.RewardService

class BootStrap {

    UnifiedPersonaService unifiedPersonaService
    RewardService rewardService

    def init = { servletContext ->
        // Check if this is first run (no game questions exist)
        def isFirstRun = false
        try {
            com.streamfit.GameQuestion.withTransaction { transaction ->
                isFirstRun = com.streamfit.GameQuestion.count() == 0
            }
        } catch (Exception e) {
            log.warn "Could not check GameQuestion count, assuming first run: ${e.message}"
            isFirstRun = true
        }
        
        // Only delete old tables on first run
        if (isFirstRun) {
            deleteOldTables()
        }
        
        // Initialize new unified game system
        initializeUnifiedGameSystem(isFirstRun)

        // Initialize reward system
        initializeRewardSystem()
    }

    def destroy = {
    }
    
    private void deleteOldTables() {
        try {
            log.info "Deleting old database tables..."
            
            // Delete old diagnostic tables
            try {
                com.streamfit.diagnostic.DiagnosticResponse.executeUpdate("DELETE FROM DiagnosticResponse")
                com.streamfit.diagnostic.DiagnosticResult.executeUpdate("DELETE FROM DiagnosticResult") 
                com.streamfit.diagnostic.DiagnosticQuestionOption.executeUpdate("DELETE FROM DiagnosticQuestionOption")
                com.streamfit.diagnostic.DiagnosticQuestion.executeUpdate("DELETE FROM DiagnosticQuestion")
                com.streamfit.diagnostic.DiagnosticTestSession.executeUpdate("DELETE FROM DiagnosticTestSession")
                com.streamfit.diagnostic.DiagnosticTest.executeUpdate("DELETE FROM DiagnosticTest")
                log.info "Old diagnostic tables deleted"
            } catch (Exception e) {
                log.warn "Some diagnostic tables may not exist: ${e.message}"
            }
            
            // Delete old personality tables
            try {
                com.streamfit.personality.PersonalityResponse.executeUpdate("DELETE FROM PersonalityResponse")
                com.streamfit.personality.PersonalityQuestionOption.executeUpdate("DELETE FROM PersonalityQuestionOption")
                com.streamfit.personality.PersonalityQuestion.executeUpdate("DELETE FROM PersonalityQuestion")
                com.streamfit.personality.PersonalityTestSession.executeUpdate("DELETE FROM PersonalityTestSession")
                com.streamfit.personality.PersonalityTrait.executeUpdate("DELETE FROM PersonalityTrait")
                log.info "Old personality tables deleted"
            } catch (Exception e) {
                log.warn "Some personality tables may not exist: ${e.message}"
            }
            
            // Delete old reward tables
            try {
                com.streamfit.reward.UserBadge.executeUpdate("DELETE FROM UserBadge")
                com.streamfit.reward.UserPoints.executeUpdate("DELETE FROM UserPoints")
                com.streamfit.reward.Badge.executeUpdate("DELETE FROM Badge")
                com.streamfit.reward.Achievement.executeUpdate("DELETE FROM Achievement")
                log.info "Old reward tables deleted"
            } catch (Exception e) {
                log.warn "Some reward tables may not exist: ${e.message}"
            }
            
            // Delete old dashboard tables
            try {
                com.streamfit.dashboard.LearningDNA.executeUpdate("DELETE FROM LearningDNA")
                log.info "Old dashboard tables deleted"
            } catch (Exception e) {
                log.warn "Dashboard tables may not exist: ${e.message}"
            }
            
            log.info "Old tables cleanup completed"
            
        } catch (Exception e) {
            log.error "Error deleting old tables: ${e.message}", e
        }
    }

    private void initializeUnifiedGameSystem(boolean isFirstRun) {
        try {
            // Check if game questions already exist
            com.streamfit.GameQuestion.withTransaction { transaction ->
                def questionCount = com.streamfit.GameQuestion.count()

                if (questionCount == 0) {
                    log.info "Initializing unified game system..."
                    
                    // Run the migration to populate new tables
                    def migration = new com.streamfit.GameDataMigration()
                    migration.migrateAllGameData()
                    
                    log.info "Unified game system initialized successfully!"
                } else {
                    log.info "Game questions already exist (${questionCount} questions) - skipping migration"
                }
            }
        } catch (Exception e) {
            log.error "Error initializing unified game system: ${e.message}", e
        }
    }

    private void initializeRewardSystem() {
        try {
            com.streamfit.reward.Badge.withTransaction { transaction ->
                log.info "Initializing reward system..."
                rewardService.initializeDefaultBadges()
                log.info "Reward system initialized!"
            }
        } catch (Exception e) {
            log.error "Error initializing reward system: ${e.message}", e
        }
    }
}


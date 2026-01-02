package com.streamfit

import com.streamfit.service.UnifiedPersonaService
import com.streamfit.service.RewardService

class BootStrap {

    UnifiedPersonaService unifiedPersonaService
    RewardService rewardService

    def init = { servletContext ->
        // Always create essential tables first
        createEssentialTables()
        
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
    
    private void createEssentialTables() {
        try {
            log.info "Creating essential tables..."
            
            // Create user table first (needed by everything else)
            com.streamfit.GameQuestion.withTransaction { tx ->
                com.streamfit.GameQuestion.withSession { session ->
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS streamfit_user (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            user_id VARCHAR(100) NOT NULL UNIQUE,
                            name VARCHAR(200),
                            email VARCHAR(200),
                            phone_number VARCHAR(50),
                            age INT,
                            gender VARCHAR(20),
                            education_level VARCHAR(100),
                            current_stream VARCHAR(100),
                            date_created DATETIME,
                            last_updated DATETIME,
                            ip_address VARCHAR(50),
                            user_agent TEXT,
                            referral_source VARCHAR(200),
                            agreed_to_terms BOOLEAN DEFAULT FALSE,
                            opt_in_for_updates BOOLEAN DEFAULT FALSE,
                            prebooked_stream_map BOOLEAN DEFAULT FALSE,
                            INDEX idx_user_id (user_id),
                            INDEX idx_email (email)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                }
            }
            
            log.info "Essential tables created successfully!"
        } catch (Exception e) {
            log.error "Error creating essential tables: ${e.message}", e
        }
    }
    
    private void deleteOldTables() {
        try {
            log.info "Dropping old database tables..."
            
            // Drop old diagnostic tables
            try {
                com.streamfit.diagnostic.DiagnosticQuestion.withTransaction { tx ->
                    com.streamfit.diagnostic.DiagnosticQuestion.withSession { session ->
                        session.createSQLQuery("DROP TABLE IF EXISTS diagnostic_question_option").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS diagnostic_response").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS diagnostic_result").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS diagnostic_question").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS diagnostic_test_session").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS diagnostic_test").executeUpdate()
                    }
                }
                log.info "Old diagnostic tables dropped"
            } catch (Exception e) {
                log.warn "Some diagnostic tables may not exist: ${e.message}"
            }
            
            // Drop old personality tables
            try {
                com.streamfit.personality.PersonalityQuestion.withTransaction { tx ->
                    com.streamfit.personality.PersonalityQuestion.withSession { session ->
                        session.createSQLQuery("DROP TABLE IF EXISTS personality_question_option").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS personality_response").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS personality_question").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS personality_test_session").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS personality_trait").executeUpdate()
                    }
                }
                log.info "Old personality tables dropped"
            } catch (Exception e) {
                log.warn "Some personality tables may not exist: ${e.message}"
            }
            
            // Drop old reward tables
            try {
                com.streamfit.reward.Badge.withTransaction { tx ->
                    com.streamfit.reward.Badge.withSession { session ->
                        session.createSQLQuery("DROP TABLE IF EXISTS user_badge").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS user_points").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS badge").executeUpdate()
                        session.createSQLQuery("DROP TABLE IF EXISTS achievement").executeUpdate()
                    }
                }
                log.info "Old reward tables dropped"
            } catch (Exception e) {
                log.warn "Some reward tables may not exist: ${e.message}"
            }
            
            // Drop old dashboard tables
            try {
                com.streamfit.dashboard.LearningDNA.withTransaction { tx ->
                    com.streamfit.dashboard.LearningDNA.withSession { session ->
                        session.createSQLQuery("DROP TABLE IF EXISTS learning_dna").executeUpdate()
                    }
                }
                log.info "Old dashboard tables dropped"
            } catch (Exception e) {
                log.warn "Dashboard tables may not exist: ${e.message}"
            }
            
            // NOTE: streamfit_user table is NOT dropped here as it's still needed by the system
            
            log.info "Old tables cleanup completed"
            
        } catch (Exception e) {
            log.error "Error dropping old tables: ${e.message}", e
        }
    }

    private void initializeUnifiedGameSystem(boolean isFirstRun) {
        try {
            // Check if game questions already exist
            com.streamfit.GameQuestion.withTransaction { transaction ->
                def questionCount = com.streamfit.GameQuestion.count()

                if (questionCount == 0) {
                    log.info "Initializing unified game system..."
                    
                    // Create new tables if they don't exist
                    createNewGameTables()
                    
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
    
    private void createNewGameTables() {
        try {
            log.info "Creating new unified game tables..."
            
            // Create tables for the new unified system
            com.streamfit.GameQuestion.withTransaction { tx ->
                com.streamfit.GameQuestion.withSession { session ->
                    // Create user table first (needed by other tables)
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS streamfit_user (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            user_id VARCHAR(100) NOT NULL UNIQUE,
                            name VARCHAR(200),
                            email VARCHAR(200),
                            phone_number VARCHAR(50),
                            age INT,
                            gender VARCHAR(20),
                            education_level VARCHAR(100),
                            current_stream VARCHAR(100),
                            date_created DATETIME,
                            last_updated DATETIME,
                            ip_address VARCHAR(50),
                            user_agent TEXT,
                            referral_source VARCHAR(200),
                            agreed_to_terms BOOLEAN DEFAULT FALSE,
                            opt_in_for_updates BOOLEAN DEFAULT FALSE,
                            prebooked_stream_map BOOLEAN DEFAULT FALSE,
                            INDEX idx_user_id (user_id),
                            INDEX idx_email (email)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                    
                    // Create game_question table
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS game_question (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            question_id VARCHAR(100) NOT NULL UNIQUE,
                            game_type VARCHAR(50) NOT NULL,
                            question_number INT NOT NULL,
                            question_text TEXT NOT NULL,
                            question_type VARCHAR(50) NOT NULL,
                            scoring_dimension VARCHAR(100),
                            time_limit INT,
                            date_created DATETIME,
                            last_updated DATETIME,
                            INDEX idx_question_id (question_id),
                            INDEX idx_game_type (game_type)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                    
                    // Create game_option table
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS game_option (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            question_id BIGINT NOT NULL,
                            option_text TEXT NOT NULL,
                            option_value VARCHAR(100) NOT NULL,
                            display_order INT NOT NULL,
                            is_correct BOOLEAN DEFAULT FALSE,
                            date_created DATETIME,
                            last_updated DATETIME,
                            FOREIGN KEY (question_id) REFERENCES game_question(id) ON DELETE CASCADE,
                            INDEX idx_question_id (question_id)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                    
                    // Create option_persona_mapping table
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS option_persona_mapping (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            game_option_id BIGINT NOT NULL,
                            persona_type VARCHAR(100) NOT NULL,
                            trait_category VARCHAR(50) DEFAULT 'PRIMARY',
                            weight DECIMAL(3,2) DEFAULT 1.0,
                            date_created DATETIME,
                            last_updated DATETIME,
                            FOREIGN KEY (game_option_id) REFERENCES game_option(id) ON DELETE CASCADE,
                            INDEX idx_game_option_id (game_option_id),
                            INDEX idx_persona_type (persona_type)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                    
                    // Create user_session table
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS user_session (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            session_id VARCHAR(100) NOT NULL UNIQUE,
                            user_id VARCHAR(100),
                            game_type VARCHAR(50) NOT NULL,
                            status VARCHAR(20) DEFAULT 'ACTIVE',
                            current_question_number INT DEFAULT 1,
                            total_score INT DEFAULT 0,
                            max_possible_score INT DEFAULT 0,
                            start_time DATETIME,
                            end_time DATETIME,
                            date_created DATETIME,
                            last_updated DATETIME,
                            INDEX idx_session_id (session_id),
                            INDEX idx_user_id (user_id),
                            INDEX idx_game_type (game_type)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                    
                    // Create engage_data table
                    session.createSQLQuery("""
                        CREATE TABLE IF NOT EXISTS engage_data (
                            id BIGINT AUTO_INCREMENT PRIMARY KEY,
                            session_id BIGINT NOT NULL,
                            question_id BIGINT NOT NULL,
                            selected_option_id BIGINT,
                            response_time_ms INT,
                            is_correct BOOLEAN,
                            score_earned INT DEFAULT 0,
                            date_created DATETIME,
                            last_updated DATETIME,
                            FOREIGN KEY (session_id) REFERENCES user_session(id) ON DELETE CASCADE,
                            FOREIGN KEY (question_id) REFERENCES game_question(id),
                            FOREIGN KEY (selected_option_id) REFERENCES game_option(id),
                            INDEX idx_session_id (session_id),
                            INDEX idx_question_id (question_id)
                        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
                    """).executeUpdate()
                }
            }
            
            log.info "New unified game tables created successfully!"
            
        } catch (Exception e) {
            log.error "Error creating new game tables: ${e.message}", e
            throw e
        }
    }

    private void initializeRewardSystem() {
        try {
            // Skip reward system initialization since we're using the unified game system
            log.info "Reward system initialization skipped - using unified game system"
        } catch (Exception e) {
            log.error "Error in reward system: ${e.message}", e
        }
    }
}


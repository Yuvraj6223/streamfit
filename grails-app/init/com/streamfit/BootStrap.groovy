package com.streamfit


import com.streamfit.service.SpiritAnimalService
import com.streamfit.service.CognitiveRadarService
import com.streamfit.service.FocusStaminaService
import com.streamfit.service.GuessworkQuotientService
import com.streamfit.service.CuriosityCompassService
import com.streamfit.service.ModalityMapService
import com.streamfit.service.ChallengeDriverService
import com.streamfit.service.WorkModeService
import com.streamfit.service.PatternSnapshotService
import com.streamfit.service.RewardService
import com.streamfit.service.PersonalityService

class BootStrap {


    SpiritAnimalService spiritAnimalService
    CognitiveRadarService cognitiveRadarService
    FocusStaminaService focusStaminaService
    GuessworkQuotientService guessworkQuotientService
    CuriosityCompassService curiosityCompassService
    ModalityMapService modalityMapService
    ChallengeDriverService challengeDriverService
    WorkModeService workModeService
    PatternSnapshotService patternSnapshotService
    RewardService rewardService
    PersonalityService personalityService

    def init = { servletContext ->
        // Initialize personality test questions
        initializePersonalityTest()

        // Initialize diagnostic tests
        initializeDiagnosticTests()

        // Initialize reward system
        initializeRewardSystem()
    }

    def destroy = {
    }


    private void initializePersonalityTest() {
        try {
            // Check if personality questions already exist
            com.streamfit.personality.PersonalityQuestion.withTransaction {
                def questionCount = com.streamfit.personality.PersonalityQuestion.count()

                if (questionCount == 0) {
                    log.info "Initializing personality test questions..."
                    personalityService.initializeDefaultQuestions()
                    log.info "Personality test questions initialized successfully!"
                } else {
                    log.info "Personality test questions already exist (${questionCount} questions)"
                }
            }
        } catch (Exception e) {
            log.error "Error initializing personality test: ${e.message}", e
        }
    }

    private void initializeDiagnosticTests() {
        try {
            com.streamfit.diagnostic.DiagnosticTest.withTransaction {
                log.info "Initializing diagnostic tests..."

                // Initialize Exam Tests
                initializeExamTests()

                // Initialize Career Tests
                initializeCareerTests()

                log.info "Diagnostic tests initialization completed!"
            }
        } catch (Exception e) {
            log.error "Error initializing diagnostic tests: ${e.message}", e
        }
    }

    private void initializeExamTests() {
        log.info "Initializing exam diagnostic tests..."

        // Spirit Animal Test
        try {
            spiritAnimalService.initializeQuestions()
            spiritAnimalService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Spirit Animal test: ${e.message}", e
        }

        // Cognitive Radar Test
        try {
            cognitiveRadarService.initializeQuestions()
            cognitiveRadarService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Cognitive Radar test: ${e.message}", e
        }

        // Focus Stamina Test
        try {
            focusStaminaService.initializeQuestions()
            focusStaminaService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Focus Stamina test: ${e.message}", e
        }

        // Guesswork Quotient Test
        try {
            guessworkQuotientService.initializeQuestions()
            guessworkQuotientService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Guesswork Quotient test: ${e.message}", e
        }

        log.info "Exam diagnostic tests initialized!"
    }

    private void initializeCareerTests() {
        log.info "Initializing career diagnostic tests..."

        // Curiosity Compass Test
        try {
            curiosityCompassService.initializeQuestions()
            curiosityCompassService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Curiosity Compass test: ${e.message}", e
        }

        // Modality Map Test
        try {
            modalityMapService.initializeQuestions()
            modalityMapService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Modality Map test: ${e.message}", e
        }

        // Challenge Driver Test
        try {
            challengeDriverService.initializeQuestions()
            challengeDriverService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Challenge Driver test: ${e.message}", e
        }

        // Work Mode Test
        try {
            workModeService.initializeQuestions()
            workModeService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Work Mode test: ${e.message}", e
        }

        // Pattern Snapshot Test
        try {
            patternSnapshotService.initializeQuestions()
            patternSnapshotService.initializeResults()
        } catch (Exception e) {
            log.error "Error initializing Pattern Snapshot test: ${e.message}", e
        }

        log.info "Career diagnostic tests initialized!"
    }

    private void initializeRewardSystem() {
        try {
            com.streamfit.reward.Badge.withTransaction {
                log.info "Initializing reward system..."
                rewardService.initializeDefaultBadges()
                log.info "Reward system initialized!"
            }
        } catch (Exception e) {
            log.error "Error initializing reward system: ${e.message}", e
        }
    }
}


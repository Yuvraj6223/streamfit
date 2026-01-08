package com.streamfit.service

import com.streamfit.*
import grails.gorm.transactions.Transactional
import groovy.json.JsonBuilder
import groovy.json.JsonSlurper

@Transactional
class UnifiedPersonaService {

    /**
     * Calculate final persona based on all game responses
     * STRICT: Each game's results are calculated independently from its own options only
     */
    def calculateFinalPersona(String sessionId) {
        def engageData = EngageData.findAllBySessionId(sessionId)
        if (!engageData) {
            return [error: 'No engagement data found for session']
        }
        
        // INFO: Log all engagement data to see what we're working with
        log.info "PATTERN_DEBUG: Total engageData records: ${engageData.size()}"
        engageData.each { data ->
            log.info "PATTERN_DEBUG: Session ${data.sessionId}, GameType: ${data.gameType}, QuestionId: ${data.questionId}, OptionId: ${data.optionId}"
        }
        
        // Group responses by game type - STRICT ISOLATION
        def gameResponses = engageData.groupBy { it.gameType }
        
        log.info "PATTERN_DEBUG: Game groups found: ${gameResponses.keySet()}"
        gameResponses.each { gameType, responses ->
            log.info "PATTERN_DEBUG: Game ${gameType} has ${responses.size()} responses"
        }
        
        def gameResults = [:]
        def dominantPersonas = [:] // Store each game's dominant persona
        
        // Calculate results for each game INDEPENDENTLY
        gameResponses.each { gameType, responses ->
            log.info "PATTERN_DEBUG: Calculating results for gameType: ${gameType} with ${responses.size()} responses"
            
            // STRICT: Only use this game's responses and its own persona mappings
            def gameResult = calculateGameResults(gameType, responses)
            gameResults[gameType] = gameResult
            
            log.info "PATTERN_DEBUG: Game ${gameType} result: ${gameResult.resultType}, personaScores: ${gameResult.personaScores}"
            
            // Store each game's dominant persona separately - NO CROSS-GAME MIXING
            if (gameResult.personaScores) {
                dominantPersonas[gameType] = gameResult.personaScores.max { it.value }?.key
                log.info "PATTERN_DEBUG: Dominant persona for ${gameType}: ${dominantPersonas[gameType]}"
            }
        }
        
        // Determine overall dominant persona from individual game dominants (not aggregated scores)
        def personaFrequency = dominantPersonas.values().countBy { it }
        def dominantPersona = personaFrequency.max { it.value }?.key ?: 'UNKNOWN'
        
        log.info "PATTERN_DEBUG: Final dominant persona: ${dominantPersona}"
        
        // Get comprehensive persona profile
        def personaProfile = getPersonaProfile(dominantPersona, gameResults)
        
        return [
            sessionId: sessionId,
            dominantPersona: dominantPersona,
            personaProfile: personaProfile,
            gameResults: gameResults,
            gameDominantPersonas: dominantPersonas, // Show each game's individual dominant persona
            summary: generatePersonaSummary(dominantPersona, gameResults)
        ]
    }
    
    /**
     * Calculate results for a specific game type
     */
    def calculateGameResults(String gameType, List responses) {
        switch (gameType) {
            case 'COGNITIVE_RADAR':
                return calculateCognitiveRadar(responses)
            case 'CURIOSITY_COMPASS':
                return calculateCuriosityCompass(responses)
            case 'FOCUS_STAMINA':
                return calculateFocusStamina(responses)
            case 'GUESSWORK_QUOTIENT':
                return calculateGuessworkQuotient(responses)
            case 'MODALITY_MAP':
                return calculateModalityMap(responses)
            case 'PATTERN_SNAPSHOT':
                return calculatePatternSnapshot(responses)
            case 'SPIRIT_ANIMAL':
                return calculateSpiritAnimal(responses)
            case 'WORK_MODE':
                return calculateWorkMode(responses)
            case 'PERSONALITY':
                return calculatePersonality(responses)
            default:
                return [error: "Unknown game type: $gameType"]
        }
    }
    
    /**
     * Cognitive Radar calculation - STRICT: Only uses COGNITIVE_RADAR game options
     */
    def calculateCognitiveRadar(List responses) {
        def scores = [LOGIC: 0, VERBAL: 0, SPATIAL: 0, SPEED: 0]
        def personaScores = [:]
        
        // STRICT: Only process responses that belong to COGNITIVE_RADAR game
        def cognitiveRadarResponses = responses.findAll { 
            it.gameType == 'COGNITIVE_RADAR' 
        }
        
        cognitiveRadarResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            def mapping = OptionPersonaMapping.findByGameOption(option)
            
            // STRICT: Only process if this option belongs to COGNITIVE_RADAR game
            if (mapping && option.question.gameType == 'COGNITIVE_RADAR') {
                // Map dimensions to persona types - COGNITIVE_RADAR specific
                def dimensionToPersona = [
                    'LOGIC': 'ANALYTICAL_DIAMOND',
                    'VERBAL': 'COMMUNICATOR_PEARL', 
                    'SPATIAL': 'VISUALIZER_EMERALD',
                    'SPEED': 'PERFORMER_RUBY'
                ]
                
                def personaType = dimensionToPersona[option.question.scoringDimension]
                if (personaType) {
                    personaScores[personaType] = (personaScores[personaType] ?: 0) + mapping.weight
                }
                
                if (response.isCorrect) {
                    scores[mapping.personaType]++
                }
            }
        }
        
        // Determine cognitive profile
        def sortedPillars = scores.sort { -it.value }.collect { it.key }
        def primaryPillar = sortedPillars[0]
        def secondaryPillar = sortedPillars[1]
        
        def resultType = determineCognitiveProfile(primaryPillar, secondaryPillar)
        
        return [
            resultType: resultType,
            scores: scores,
            primaryPillar: primaryPillar,
            secondaryPillar: secondaryPillar,
            personaScores: personaScores
        ]
    }
    
    /**
     * Curiosity Compass calculation - STRICT: Only uses CURIOSITY_COMPASS game options
     */
    def calculateCuriosityCompass(List responses) {
        def scores = [THEORIST: 0, BUILDER: 0, EMPATH: 0, CHALLENGER: 0]
        def personaScores = [:]
        
        // STRICT: Only process responses that belong to CURIOSITY_COMPASS game
        def curiosityCompassResponses = responses.findAll { 
            it.gameType == 'CURIOSITY_COMPASS' 
        }
        
        curiosityCompassResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            def mapping = OptionPersonaMapping.findByGameOption(option)
            
            // STRICT: Only process if this option belongs to CURIOSITY_COMPASS game
            if (mapping && option.question.gameType == 'CURIOSITY_COMPASS') {
                scores[mapping.personaType] = (scores[mapping.personaType] ?: 0) + mapping.weight
                
                // Map to broader persona types
                def personaMapping = [
                    'THEORIST': 'INNOVATOR_SAPPHIRE',
                    'BUILDER': 'BUILDER_AMETHYST',
                    'EMPATH': 'EMPATH_ROSE',
                    'CHALLENGER': 'CHALLENGER_GARNET'
                ]
                
                def personaType = personaMapping[mapping.personaType]
                if (personaType) {
                    personaScores[personaType] = (personaScores[personaType] ?: 0) + mapping.weight
                }
            }
        }
        
        def dominantType = scores.max { it.value }?.key ?: 'THEORIST'
        
        return [
            resultType: dominantType,
            scores: scores,
            dominantType: dominantType,
            personaScores: personaScores
        ]
    }
    
    /**
     * Focus Stamina calculation - STRICT: Only uses FOCUS_STAMINA game options
     */
    def calculateFocusStamina(List responses) {
        // STRICT: Only process responses that belong to FOCUS_STAMINA game
        def focusStaminaResponses = responses.findAll { 
            it.gameType == 'FOCUS_STAMINA' 
        }
        
        def attentionResponses = focusStaminaResponses.findAll { 
            GameOption.findById(it.optionId).question.scoringDimension == 'ATTENTION_SUSTAIN' 
        }
        def stressResponse = focusStaminaResponses.find { 
            GameOption.findById(it.optionId).question.scoringDimension == 'STRESS_RESPONSE' 
        }
        
        def focusDecay = calculateFocusDecay(attentionResponses)
        def gritLevel = calculateGritLevel(stressResponse)
        def resultType = determineWorkStyle(focusDecay < 20, gritLevel > 60)
        
        def personaScores = [
            'MARATHONER': (resultType == 'MARATHONER' ? 10 : 0),
            'SPRINTER': (resultType == 'SPRINTER' ? 10 : 0),
            'SAFE_PLAYER': (resultType == 'SAFE_PLAYER' ? 10 : 0),
            'QUITTER': (resultType == 'QUITTER' ? 10 : 0)
        ]
        
        return [
            resultType: resultType,
            focusDecay: focusDecay,
            gritLevel: gritLevel,
            personaScores: personaScores
        ]
    }
    
    /**
     * Guesswork Quotient calculation - STRICT: Only uses GUESSWORK_QUOTIENT game options
     */
    def calculateGuessworkQuotient(List responses) {
        // STRICT: Only process responses that belong to GUESSWORK_QUOTIENT game
        def guessworkResponses = responses.findAll { 
            it.gameType == 'GUESSWORK_QUOTIENT' 
        }
        
        def totalQuestions = guessworkResponses.size()
        def correctAnswers = guessworkResponses.count { it.isCorrect }
        def accuracy = (correctAnswers / totalQuestions) * 100
        
        def confidenceSum = guessworkResponses.sum { it.confidenceLevel ?: 0 }
        def avgConfidence = (confidenceSum / totalQuestions) * 33.33
        
        def calibration = Math.abs(accuracy - avgConfidence)
        def resultType = determineRiskProfile(accuracy, avgConfidence)
        
        def personaScores = [
            'BALANCED_STRATEGIST': (resultType == 'BALANCED_STRATEGIST' ? 10 : 0),
            'HIGH_ROLLER': (resultType == 'HIGH_ROLLER' ? 10 : 0),
            'UNDER_ESTIMATOR': (resultType == 'UNDER_ESTIMATOR' ? 10 : 0),
            'HESITANT_SEARCHER': (resultType == 'HESITANT_SEARCHER' ? 10 : 0)
        ]
        
        return [
            resultType: resultType,
            accuracy: accuracy,
            avgConfidence: avgConfidence,
            calibration: calibration,
            personaScores: personaScores
        ]
    }
    
    /**
     * Modality Map calculation - STRICT: Only uses MODALITY_MAP game options
     */
    def calculateModalityMap(List responses) {
        def scores = [VISUAL: 0, AUDITORY: 0, KINESTHETIC: 0, CONCEPTUAL: 0]
        def personaScores = [:]
        
        // STRICT: Only process responses that belong to MODALITY_MAP game
        def modalityMapResponses = responses.findAll { 
            it.gameType == 'MODALITY_MAP' 
        }
        
        modalityMapResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            def mapping = OptionPersonaMapping.findByGameOption(option)
            
            // STRICT: Only process if this option belongs to MODALITY_MAP game
            if (mapping && option.question.gameType == 'MODALITY_MAP' && mapping.personaType) {
                scores[mapping.personaType] = (scores[mapping.personaType] ?: 0) + mapping.weight
                
                // Map to persona types - MODALITY_MAP specific
                def personaMapping = [
                    'VISUAL': 'VISUAL',
                    'AUDITORY': 'AUDITORY',
                    'KINESTHETIC': 'KINESTHETIC',
                    'CONCEPTUAL': 'CONCEPTUAL'
                ]
                
                def personaType = personaMapping[mapping.personaType]
                if (personaType) {
                    personaScores[personaType] = (personaScores[personaType] ?: 0) + mapping.weight
                }
            }
        }
        
        def dominantModality = scores.max { it.value }?.key ?: 'UNKNOWN'
        
        return [
            resultType: dominantModality,
            scores: scores,
            dominantModality: dominantModality,
            personaScores: personaScores
        ]
    }
    
    /**
     * Pattern Snapshot calculation - STRICT: Only uses PATTERN_SNAPSHOT game options
     */
    def calculatePatternSnapshot(List responses) {
        log.info "PATTERN_DEBUG: calculatePatternSnapshot called with ${responses.size()} total responses"
        
        def scores = [VISUAL: 0, VERBAL: 0, NUMERIC: 0]
        def personaScores = [:]
        
        // STRICT: Only process responses that belong to PATTERN_SNAPSHOT game
        def patternSnapshotResponses = responses.findAll { 
            it.gameType == 'PATTERN_SNAPSHOT' 
        }
        
        log.info "PATTERN_DEBUG: Pattern Snapshot filtered responses: ${patternSnapshotResponses.size()}"
        patternSnapshotResponses.each { response ->
            log.info "PATTERN_DEBUG: Processing Pattern Snapshot response - GameType: ${response.gameType}, OptionId: ${response.optionId}"
        }
        
        patternSnapshotResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            def mapping = OptionPersonaMapping.findByGameOption(option)
            
            log.info "PATTERN_DEBUG: Option found: ${option?.id}, Question gameType: ${option?.question?.gameType}, Mapping personaType: ${mapping?.personaType}"
            
            // STRICT: Only process if this option belongs to PATTERN_SNAPSHOT game
            if (mapping && option.question.gameType == 'PATTERN_SNAPSHOT') {
                scores[mapping.personaType] = (scores[mapping.personaType] ?: 0) + mapping.weight
                
                // Map to persona types - PATTERN_SNAPSHOT specific
                def personaMapping = [
                    'VISUAL': 'VISUAL',
                    'VERBAL': 'VERBAL',
                    'NUMERIC': 'NUMERIC'
                ]
                
                def personaType = personaMapping[mapping.personaType]
                if (personaType) {
                    personaScores[personaType] = (personaScores[personaType] ?: 0) + mapping.weight
                    log.info "PATTERN_DEBUG: Added persona score for ${personaType}: ${mapping.weight}"
                }
            } else {
                log.warn "PATTERN_DEBUG: SKIPPED response - Option gameType: ${option?.question?.gameType}, expected: PATTERN_SNAPSHOT"
            }
            
            if (response.isCorrect) {
                scores[option.question.scoringDimension]++
            }
        }
        
        def dominantSkew = scores.max { it.value }?.key ?: 'UNKNOWN'
        
        log.info "PATTERN_DEBUG: Pattern Snapshot final scores: ${scores}, personaScores: ${personaScores}, dominantSkew: ${dominantSkew}"
        
        return [
            resultType: dominantSkew,
            scores: scores,
            dominantSkew: dominantSkew,
            personaScores: personaScores
        ]
    }
    
    /**
     * Spirit Animal calculation - STRICT: Only uses SPIRIT_ANIMAL game options
     */
    def calculateSpiritAnimal(List responses) {
        def processCount = 0
        def intuitionCount = 0
        def accuracyCount = 0
        def speedCount = 0
        
        // STRICT: Only process responses that belong to SPIRIT_ANIMAL game
        def spiritAnimalResponses = responses.findAll { 
            it.gameType == 'SPIRIT_ANIMAL' 
        }
        
        spiritAnimalResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            def mapping = OptionPersonaMapping.findByGameOption(option)
            
            // STRICT: Only process if this option belongs to SPIRIT_ANIMAL game
            if (mapping && option.question.gameType == 'SPIRIT_ANIMAL') {
                switch (mapping.personaType) {
                    case 'PROCESS': processCount++; break
                    case 'INTUITION': intuitionCount++; break
                    case 'ACCURACY': accuracyCount++; break
                    case 'SPEED': speedCount++; break
                }
            }
        }
        
        def primaryTrait = processCount > intuitionCount ? 'PROCESS' : 'INTUITION'
        def secondaryTrait = accuracyCount > speedCount ? 'ACCURACY' : 'SPEED'
        
        def resultType = determineSpiritAnimal(primaryTrait, secondaryTrait)
        
        def personaScores = [
            'WISE_OWL': (resultType == 'WISE_OWL' ? 10 : 0),
            'STRATEGIC_WOLF': (resultType == 'STRATEGIC_WOLF' ? 10 : 0),
            'DISCIPLINED_BEE': (resultType == 'DISCIPLINED_BEE' ? 10 : 0),
            'BOLD_TIGER': (resultType == 'BOLD_TIGER' ? 10 : 0)
        ]
        
        return [
            resultType: resultType,
            processCount: processCount,
            intuitionCount: intuitionCount,
            accuracyCount: accuracyCount,
            speedCount: speedCount,
            primaryTrait: primaryTrait,
            secondaryTrait: secondaryTrait,
            personaScores: personaScores
        ]
    }
    
    /**
     * Work Mode calculation - STRICT: Only uses WORK_MODE game options
     */
    def calculateWorkMode(List responses) {
        def soloCount = 0
        def teamCount = 0
        def structuredCount = 0
        def flexibleCount = 0
        
        // STRICT: Only process responses that belong to WORK_MODE game
        def workModeResponses = responses.findAll { 
            it.gameType == 'WORK_MODE' 
        }
        
        workModeResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            def mapping = OptionPersonaMapping.findByGameOption(option)
            
            // STRICT: Only process if this option belongs to WORK_MODE game
            if (mapping && option.question.gameType == 'WORK_MODE') {
                switch (mapping.personaType) {
                    case 'SOLO': soloCount++; break
                    case 'TEAM': teamCount++; break
                    case 'STRUCTURED': structuredCount++; break
                    case 'FLEXIBLE': flexibleCount++; break
                }
            }
        }
        
        def workStyle = determineWorkStyle(soloCount > teamCount, structuredCount > flexibleCount)
        
        def personaScores = [
            'STRUCTURED_SOLOIST': (workStyle == 'STRUCTURED_SOLOIST' ? 10 : 0),
            'STRUCTURED_COLLABORATOR': (workStyle == 'STRUCTURED_COLLABORATOR' ? 10 : 0),
            'FREEFORM_EXPLORER': (workStyle == 'FREEFORM_EXPLORER' ? 10 : 0),
            'CHAOTIC_CREATIVE': (workStyle == 'CHAOTIC_CREATIVE' ? 10 : 0)
        ]
        
        return [
            resultType: workStyle,
            soloCount: soloCount,
            teamCount: teamCount,
            structuredCount: structuredCount,
            flexibleCount: flexibleCount,
            personaScores: personaScores
        ]
    }
    
    /**
     * Personality calculation - STRICT: Only uses PERSONALITY game options
     */
    def calculatePersonality(List responses) {
        def personalityScore = 0
        
        // STRICT: Only process responses that belong to PERSONALITY game
        def personalityResponses = responses.findAll { 
            it.gameType == 'PERSONALITY' 
        }
        
        personalityResponses.each { response ->
            def option = GameOption.findById(response.optionId)
            
            // STRICT: Only process if this option belongs to PERSONALITY game
            if (option.question.gameType == 'PERSONALITY') {
                personalityScore += Integer.parseInt(option.optionValue)
            }
        }
        
        def resultType = personalityScore > 0 ? 'EXTROVERT' : 'INTROVERT'
        
        def personaScores = [
            'PERSONALITY_EXTROVERT': (resultType == 'EXTROVERT' ? Math.abs(personalityScore) : 0),
            'PERSONALITY_INTROVERT': (resultType == 'INTROVERT' ? Math.abs(personalityScore) : 0)
        ]
        
        return [
            resultType: resultType,
            personalityScore: personalityScore,
            personaScores: personaScores
        ]
    }
    
    // Helper methods for determining profiles
    private String determineCognitiveProfile(String primary, String secondary) {
        if ((primary == 'LOGIC' && secondary == 'SPATIAL') || (primary == 'SPATIAL' && secondary == 'LOGIC')) {
            return 'ANALYTICAL_DIAMOND'
        } else if ((primary == 'VERBAL' && secondary == 'SPEED') || (primary == 'SPEED' && secondary == 'VERBAL')) {
            return 'VERBAL_VIRTUOSO'
        } else if ((primary == 'LOGIC' && secondary == 'SPEED') || (primary == 'SPEED' && secondary == 'LOGIC')) {
            return 'PRECISE_PROCESSOR'
        } else if ((primary == 'SPATIAL' && secondary == 'VERBAL') || (primary == 'VERBAL' && secondary == 'SPATIAL')) {
            return 'VISUAL_VISIONARY'
        }
        return "COGNITIVE_${primary}"
    }
    
    private String determineWorkStyle(boolean isSolo, boolean isStructured) {
        if (isSolo && isStructured) return 'STRUCTURED_SOLOIST'
        if (!isSolo && isStructured) return 'STRUCTURED_COLLABORATOR'
        if (!isSolo && !isStructured) return 'FREEFORM_EXPLORER'
        return 'CHAOTIC_CREATIVE'
    }
    
    private String determineRiskProfile(Double accuracy, Double avgConfidence) {
        def calibration = Math.abs(accuracy - avgConfidence)
        
        if (calibration < 15) {
            return 'BALANCED_STRATEGIST'
        } else if (avgConfidence > accuracy + 15) {
            return 'HIGH_ROLLER'
        } else if (accuracy > avgConfidence + 15) {
            return 'UNDER_ESTIMATOR'
        } else if (accuracy < 50) {
            return 'HESITANT_SEARCHER'
        }
        
        return 'BALANCED_STRATEGIST'
    }

    private String determineSpiritAnimal(String primaryTrait, String secondaryTrait) {
        // ✅ RANDOM SELECTION - Returns random animal every time
        def animals = ['WISE_OWL', 'DISCIPLINED_BEE', 'STRATEGIC_WOLF', 'BOLD_TIGER']
        def random = new Random()
        def selectedAnimal = animals[random.nextInt(4)]

        log.info "🎲 Random Spirit Animal: ${selectedAnimal}"

        return selectedAnimal
    }
    
    private Double calculateFocusDecay(List responses) {
        if (!responses) return 0.0
        
        def minute1Responses = responses.findAll { it.timeSpent <= 60 }
        def minute3Responses = responses.findAll { it.timeSpent > 120 }
        
        if (!minute1Responses || !minute3Responses) return 0.0
        
        def minute1Accuracy = minute1Responses.count { it.isCorrect } / minute1Responses.size() * 100
        def minute3Accuracy = minute3Responses.count { it.isCorrect } / minute3Responses.size() * 100
        
        return minute1Accuracy - minute3Accuracy
    }
    
    private Integer calculateGritLevel(def response) {
        if (!response || !response.timeSpent) return 0
        
        def timeSpent = response.timeSpent
        
        if (timeSpent < 30) return 20
        else if (timeSpent < 60) return 50
        else if (timeSpent < 120) return 75
        else return 90
    }
    
    /**
     * Get comprehensive persona profile
     */
    def getPersonaProfile(String dominantPersona, Map gameResults) {
        def profiles = [
            'ANALYTICAL_DIAMOND': [
                title: 'The Analytical Diamond',
                emoji: '💎',
                description: 'You have a "STEM Brain." You see the world in systems and structures.',
                strengths: 'Natural for Math/Physics/Coding. Excellent at systematic problem-solving.',
                challenges: 'May struggle with verbal reasoning and communication-heavy subjects.',
                recommendations: 'Our AI will bypass basic explanations and move straight to "Level 3" complex problem-solving.'
            ],
            'VERBAL_VIRTUOSO': [
                title: 'The Verbal Virtuoso',
                emoji: '✍️',
                description: 'You are a master of communication and rapid processing.',
                strengths: 'Natural for Law/Humanities/Literature. Excellent reading comprehension.',
                challenges: 'Math speed may lag behind reading speed.',
                recommendations: 'The AI tutor will provide you with high-level vocabulary and "Critical Reasoning" challenges.'
            ],
            'WISE_OWL': [
                title: 'The Wise Owl',
                emoji: '🦉',
                description: 'You like to understand everything deeply before moving forward.',
                strengths: 'You understand concepts really well and are super careful with details.',
                challenges: 'You spend too much time on hard questions and don\'t want to skip them.',
                recommendations: 'We\'ll teach you when to skip questions and how to manage your time better.'
            ],
            'BOLD_TIGER': [
                title: 'The Bold Tiger',
                emoji: '🐯',
                description: 'You perform best under pressure and love competition.',
                strengths: 'You can finish exams quickly and often do better in real exams than in practice.',
                challenges: 'You get bored with easy topics and forget things you learned a while ago.',
                recommendations: 'We\'ll make learning fun like a game and send you quick reminders.'
            ]
            // Add more persona profiles as needed
        ]
        
        return profiles[dominantPersona] ?: [
            title: 'Unique Thinker',
            emoji: '🌟',
            description: 'You have a unique combination of traits that makes you special.',
            strengths: 'Adaptive thinking and diverse problem-solving approaches.',
            challenges: 'Finding the right learning environment that matches your style.',
            recommendations: 'Our AI will create a personalized learning path based on your specific traits.'
        ]
    }
    
    /**
     * Generate persona summary
     */
    def generatePersonaSummary(String dominantPersona, Map gameResults) {
        def summary = "Based on your performance across ${gameResults.size()} games, your dominant persona is ${dominantPersona}. "
        
        gameResults.each { gameType, result ->
            summary += "In ${gameType}, you scored as ${result.resultType}. "
        }
        
        return summary
    }

    /**
     * Calculate suggested career streams based on cognitive radar scores
     */
    def calculateSuggestedStreams(cognitiveRadarResult) {
        if (!cognitiveRadarResult?.scoreBreakdown) {
            return []
        }

        def s = cognitiveRadarResult.scoreBreakdown

        // Normalize scores (same logic as was in the GSP)
        // Note: The controller is responsible for passing lowercase keys (logic, verbal, etc.)
        def logic = (s.logic ?: 0) / 2.0 * 100
        def verbal = (s.verbal ?: 0) / 2.0 * 100
        def spatial = (s.spatial ?: 0) * 100
        def speed = (s.speed ?: 0) * 100

        def streamLibrary = [
            [id: 'engineering', title: 'Engineering', icon: '🏗️', w: [logic: 0.5, spatial: 0.5], outcome: 'Build Systems'],
            [id: 'law', title: 'Law', icon: '⚖️', w: [verbal: 0.8, logic: 0.2], outcome: 'Defend Rights'],
            [id: 'cs', title: 'Comp. Science', icon: '💻', w: [logic: 0.6, speed: 0.4], outcome: 'Innovate Tech'],
            [id: 'design', title: 'Design', icon: '🎨', w: [spatial: 0.8, verbal: 0.2], outcome: 'Create Art'],
            [id: 'medicine', title: 'Medicine', icon: '🩺', w: [logic: 0.4, speed: 0.3, verbal: 0.3], outcome: 'Heal Others'],
            [id: 'business', title: 'Business', icon: '💼', w: [verbal: 0.5, logic: 0.3, speed: 0.2], outcome: 'Lead Teams']
        ]

        def calculatedStreams = streamLibrary.collect { item ->
            def score = 0
            if (item.w.logic) score += logic * item.w.logic
            if (item.w.verbal) score += verbal * item.w.verbal
            if (item.w.spatial) score += spatial * item.w.spatial
            if (item.w.speed) score += speed * item.w.speed
            
            def desc = score > 85 ? "Your profile is a strong match." : (score > 70 ? "Good potential with effort." : "A challenging path.")
            [id: item.id, title: item.title, icon: item.icon, match: score.toInteger(), isBest: false, desc: desc, outcome: item.outcome]
        }.sort { -it.match }.take(3)

        if (calculatedStreams) {
            calculatedStreams[0].isBest = true
        }

        return calculatedStreams
    }
}

package com.streamfit.service

import com.streamfit.test.*
import com.streamfit.user.User
import com.streamfit.dashboard.LearningDNA
import grails.gorm.transactions.Transactional

@Transactional
class ScoringService {

    def dashboardService
    
    def calculateTestResults(UserTestSession session) {
        if (session.status != 'COMPLETED') {
            log.warn "Cannot calculate results for incomplete session: ${session.sessionId}"
            return null
        }
        
        String testCode = session.testDefinition.testCode
        
        switch (testCode) {
            case 'EXAM_SPIRIT_ANIMAL':
                return calculateSpiritAnimalResult(session)
            case 'COGNITIVE_RADAR':
                return calculateCognitiveRadarResult(session)
            case 'FOCUS_STAMINA':
                return calculateFocusStaminaResult(session)
            case 'RISK_PROFILE':
                return calculateRiskProfileResult(session)
            case 'CURIOSITY_COMPASS':
            case 'MODALITY_MAP':
            case 'CHALLENGE_DRIVER':
            case 'WORK_MODE':
                return calculateStreamFitResult(session)
            case 'PATTERN_SNAPSHOT':
                return calculatePatternSnapshotResult(session)
            default:
                log.error "Unknown test code: ${testCode}"
                return null
        }
    }
    
    private Map calculateSpiritAnimalResult(UserTestSession session) {
        // Count responses by archetype
        def responses = UserResponse.findAllBySession(session)
        def archetypeCounts = [:]
        
        responses.each { response ->
            String archetypeCode = response.responseValue
            archetypeCounts[archetypeCode] = (archetypeCounts[archetypeCode] ?: 0) + 1
        }
        
        // Find dominant archetype
        def dominantArchetype = archetypeCounts.max { it.value }?.key
        
        if (!dominantArchetype) {
            log.error "No dominant archetype found"
            return null
        }
        
        TestArchetype archetype = TestArchetype.findByTestDefinitionAndArchetypeCode(
            session.testDefinition, 
            dominantArchetype
        )
        
        if (!archetype) {
            log.error "Archetype not found: ${dominantArchetype}"
            return null
        }
        
        // Save result
        def result = new TestResult(
            session: session,
            archetype: archetype,
            resultType: 'LEARNING_STYLE',
            resultKey: 'SPIRIT_ANIMAL',
            resultValue: archetype.archetypeName,
            scorePercentage: (archetypeCounts[dominantArchetype] / responses.size()) * 100,
            scoreLabel: archetype.archetypeName
        )
        
        result.save(flush: true)
        
        // Update Learning DNA
        dashboardService?.updateLearningStylePersona(session.user, archetype)
        
        return [
            archetype: archetype,
            percentage: result.scorePercentage,
            distribution: archetypeCounts
        ]
    }
    
    private Map calculateCognitiveRadarResult(UserTestSession session) {
        def responses = UserResponse.findAllBySession(session)
        
        // Calculate scores for each cognitive area
        def areaScores = [
            LOGIC: [],
            VERBAL: [],
            SPATIAL: [],
            SPEED: []
        ]
        
        responses.each { response ->
            String area = response.question.cognitiveArea
            if (area && areaScores.containsKey(area)) {
                areaScores[area] << (response.isCorrect ? 1 : 0)
            }
        }
        
        // Calculate percentages
        def cognitiveScores = [:]
        areaScores.each { area, scores ->
            if (scores) {
                cognitiveScores[area] = (scores.sum() / scores.size()) * 100
            }
        }
        
        // Determine dominant cognitive strength
        def dominantArea = cognitiveScores.max { it.value }?.key
        
        // Save results
        cognitiveScores.each { area, score ->
            new TestResult(
                session: session,
                resultType: 'COGNITIVE_SCORE',
                resultKey: area,
                resultValue: area,
                scorePercentage: score,
                scoreLabel: "${area} - ${score.round(1)}%"
            ).save(flush: true)
        }
        
        // Update Learning DNA
        dashboardService?.updateCognitiveSkew(session.user, dominantArea, cognitiveScores)
        
        return [
            scores: cognitiveScores,
            dominantArea: dominantArea,
            radarData: cognitiveScores
        ]
    }
    
    private Map calculateFocusStaminaResult(UserTestSession session) {
        def responses = UserResponse.findAllBySession(session)
        
        // Analyze response patterns for work style
        def avgTimeTaken = responses.collect { it.timeTaken ?: 0 }.sum() / responses.size()
        def consistencyScore = calculateConsistency(responses)
        
        String workStyle
        String workStyleEmoji
        
        if (avgTimeTaken < 30 && consistencyScore > 70) {
            workStyle = 'Sprinter'
            workStyleEmoji = '🚀'
        } else if (avgTimeTaken > 60 && consistencyScore > 80) {
            workStyle = 'Marathon Runner'
            workStyleEmoji = '🏃'
        } else if (consistencyScore < 50) {
            workStyle = 'Burst Worker'
            workStyleEmoji = '⚡'
        } else {
            workStyle = 'Steady Pacer'
            workStyleEmoji = '🎯'
        }
        
        def result = new TestResult(
            session: session,
            resultType: 'WORK_STYLE',
            resultKey: 'FOCUS_STAMINA',
            resultValue: workStyle,
            scorePercentage: consistencyScore,
            scoreLabel: "${workStyleEmoji} ${workStyle}"
        )
        
        result.save(flush: true)
        
        // Update Learning DNA
        dashboardService?.updateWorkStyle(session.user, workStyle, workStyleEmoji)
        
        return [
            workStyle: workStyle,
            emoji: workStyleEmoji,
            avgTime: avgTimeTaken,
            consistency: consistencyScore
        ]
    }
    
    private Map calculateRiskProfileResult(UserTestSession session) {
        def responses = UserResponse.findAllBySession(session)
        
        // Calculate accuracy and confidence
        def correctAnswers = responses.findAll { it.isCorrect }.size()
        def accuracy = (correctAnswers / responses.size()) * 100
        
        // Analyze time taken as proxy for confidence
        def avgTimeTaken = responses.collect { it.timeTaken ?: 0 }.sum() / responses.size()
        def confidence = avgTimeTaken < 20 ? 'HIGH' : avgTimeTaken < 40 ? 'MEDIUM' : 'LOW'
        
        String riskProfile
        if (accuracy > 70 && confidence == 'HIGH') {
            riskProfile = 'Confident & Accurate'
        } else if (accuracy > 70 && confidence != 'HIGH') {
            riskProfile = 'Cautious & Accurate'
        } else if (accuracy <= 70 && confidence == 'HIGH') {
            riskProfile = 'Bold Risk-Taker'
        } else {
            riskProfile = 'Careful Guesser'
        }
        
        def result = new TestResult(
            session: session,
            resultType: 'RISK_PROFILE',
            resultKey: 'GUESSING_STYLE',
            resultValue: riskProfile,
            scorePercentage: accuracy,
            scoreLabel: riskProfile
        )
        
        result.save(flush: true)
        
        return [
            profile: riskProfile,
            accuracy: accuracy,
            confidence: confidence
        ]
    }
    
    private Map calculateStreamFitResult(UserTestSession session) {
        def responses = UserResponse.findAllBySession(session)
        
        // Count stream preferences
        def streamCounts = [:]
        responses.each { response ->
            String stream = response.responseValue
            streamCounts[stream] = (streamCounts[stream] ?: 0) + 1
        }
        
        // Get top 3 streams
        def topStreams = streamCounts.sort { -it.value }.take(3)
        
        // Save results
        topStreams.eachWithIndex { entry, index ->
            new TestResult(
                session: session,
                resultType: 'STREAM_FIT',
                resultKey: "STREAM_${index + 1}",
                resultValue: entry.key,
                scorePercentage: (entry.value / responses.size()) * 100,
                scoreLabel: entry.key
            ).save(flush: true)
        }
        
        // Update Learning DNA
        dashboardService?.updateStreamFitSuggestions(session.user, topStreams.keySet().toList())
        
        return [
            topStreams: topStreams,
            distribution: streamCounts
        ]
    }
    
    private Map calculatePatternSnapshotResult(UserTestSession session) {
        def responses = UserResponse.findAllBySession(session)
        
        def correctAnswers = responses.findAll { it.isCorrect }.size()
        def accuracy = (correctAnswers / responses.size()) * 100
        def totalTime = responses.collect { it.timeTaken ?: 0 }.sum()
        
        // Calculate pattern recognition score
        def patternScore = (accuracy * 0.7) + ((1000 - totalTime) / 1000 * 100 * 0.3)
        
        def result = new TestResult(
            session: session,
            resultType: 'PATTERN_RECOGNITION',
            resultKey: 'PATTERN_SCORE',
            resultValue: patternScore.toString(),
            scorePercentage: patternScore,
            scoreLabel: "Pattern Score: ${patternScore.round(1)}"
        )
        
        result.save(flush: true)
        
        return [
            score: patternScore,
            accuracy: accuracy,
            totalTime: totalTime
        ]
    }
    
    private Double calculateConsistency(List<UserResponse> responses) {
        if (responses.size() < 2) return 100.0
        
        def times = responses.collect { it.timeTaken ?: 0 }
        def avg = times.sum() / times.size()
        def variance = times.collect { Math.pow(it - avg, 2) }.sum() / times.size()
        def stdDev = Math.sqrt(variance)
        
        // Lower standard deviation = higher consistency
        def consistencyScore = Math.max(0, 100 - (stdDev / avg * 100))
        
        return consistencyScore
    }
}


package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class FocusStaminaService {

    /**
     * Calculate Focus Stamina results based on interactive challenge performance
     * Maps Focus Decay and Grit levels
     */
    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        // Analyze attention sustain test (Phase A)
        def attentionResponses = responses.findAll { it.question.scoringDimension == 'ATTENTION_SUSTAIN' }
        def focusDecay = calculateFocusDecay(attentionResponses)
        
        // Analyze stress response (Phase B)
        def stressResponse = responses.find { it.question.scoringDimension == 'STRESS_RESPONSE' }
        def gritLevel = calculateGritLevel(stressResponse)
        
        // Determine work style
        def resultType = determineWorkStyle(focusDecay, gritLevel)
        
        // Get result details
        def result = DiagnosticResult.findByTestAndResultId(session.test, resultType)
        
        def scoreBreakdown = [
            focusDecay: focusDecay,
            gritLevel: gritLevel,
            focusType: focusDecay < 20 ? 'STEADY' : 'BURST',
            gritType: gritLevel > 60 ? 'HIGH' : 'LOW'
        ]
        
        return [
            resultType: resultType,
            resultTitle: result?.resultTitle ?: resultType,
            resultSummary: result?.summary ?: '',
            scoreBreakdown: scoreBreakdown,
            emoji: result?.emoji,
            profile: result?.profile,
            strengths: result?.strengths,
            traps: result?.traps,
            aiRoadmap: result?.aiRoadmap
        ]
    }
    
    /**
     * Calculate focus decay percentage (accuracy drop from minute 1 to minute 3)
     */
    private Double calculateFocusDecay(List responses) {
        if (!responses) return 0.0
        
        // Group responses by time period
        def minute1Responses = responses.findAll { it.timeSpent <= 60 }
        def minute3Responses = responses.findAll { it.timeSpent > 120 }
        
        if (!minute1Responses || !minute3Responses) return 0.0
        
        def minute1Accuracy = minute1Responses.count { it.isCorrect } / minute1Responses.size() * 100
        def minute3Accuracy = minute3Responses.count { it.isCorrect } / minute3Responses.size() * 100
        
        return minute1Accuracy - minute3Accuracy
    }
    
    /**
     * Calculate grit level based on time spent on impossible problem
     */
    private Integer calculateGritLevel(DiagnosticResponse response) {
        if (!response || !response.timeSpent) return 0
        
        def timeSpent = response.timeSpent
        
        if (timeSpent < 30) {
            return 20 // Low grit
        } else if (timeSpent < 60) {
            return 50 // Medium grit
        } else if (timeSpent < 120) {
            return 75 // High grit
        } else {
            return 90 // Very high grit (risk of over-fixation)
        }
    }
    
    /**
     * Determine work style based on focus and grit
     */
    private String determineWorkStyle(Double focusDecay, Integer gritLevel) {
        def steadyFocus = focusDecay < 20
        def highGrit = gritLevel > 60
        
        if (steadyFocus && highGrit) {
            return 'MARATHONER'
        } else if (!steadyFocus && highGrit) {
            return 'SPRINTER'
        } else if (steadyFocus && !highGrit) {
            return 'SAFE_PLAYER'
        } else {
            return 'FLASH'
        }
    }
    
    /**
     * Initialize Focus Stamina test (interactive challenges)
     */
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('FOCUS_STAMINA')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'FOCUS_STAMINA',
                testName: 'Focus Power Game',
                testType: 'EXAM',
                description: '',
                questionCount: 2,
                estimatedMinutes: 5,
                isActive: true
            )
            test.save(flush: true)
        }
        
        def existingQuestions = DiagnosticQuestion.findAllByTest(test)
        if (existingQuestions) {
            log.info "Focus Stamina questions already exist"
            return
        }
        
        // Phase A: Attention Sustain Test
        def question1 = new DiagnosticQuestion(
            test: test,
            questionId: 'FOCUS_STAMINA_ATTENTION',
            questionText: 'Your mind keeps getting distracted',
            questionNumber: 1,
            questionType: 'INTERACTIVE',
            scoringDimension: 'ATTENTION_SUSTAIN',
            timeLimit: 180
        )
        question1.save(flush: true)

        // Phase B: Impossible Problem (Stress Response)
        def question2 = new DiagnosticQuestion(
            test: test,
            questionId: 'FOCUS_STAMINA_STRESS',
            questionText: 'This puzzle feels impossible right now',
            questionNumber: 2,
            questionType: 'INTERACTIVE',
            scoringDimension: 'STRESS_RESPONSE'
        )
        question2.save(flush: true)

        // Add options for stress response
        new DiagnosticQuestionOption(
            question: question2,
            optionText: '😵 Give up now',
            optionValue: 'GIVE_UP',
            displayOrder: 1
        ).save(flush: true)

        new DiagnosticQuestionOption(
            question: question2,
            optionText: '💡 Show me hint',
            optionValue: 'SHOW_HINT',
            displayOrder: 2
        ).save(flush: true)

        new DiagnosticQuestionOption(
            question: question2,
            optionText: '🔥 Submit my answer',
            optionValue: 'SUBMIT',
            displayOrder: 3
        ).save(flush: true)
        
        log.info "Focus Stamina questions initialized successfully"
    }
    
    /**
     * Initialize Focus Stamina result profiles
     */
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('FOCUS_STAMINA')
        if (!test) {
            log.error "Focus Stamina test not found"
            return
        }
        
        def existingResults = DiagnosticResult.findAllByTest(test)
        if (existingResults) {
            log.info "Focus Stamina results already exist"
            return
        }
        
        // Marathoner
        createResult(test, 'MARATHONER', '🏃', 'The Marathoner', 'STEADY', 'HIGH_GRIT',
            'You are a rare breed. While others lose focus after 20 minutes, you are just getting started. You don\'t panic when a problem is hard; you get quieter and more determined.',
            'Exceptional sustained focus and determination. Can handle long, complex problems.',
            'Most likely to suffer from Silent Burnout. You don\'t realize you are tired until you are completely exhausted.',
            'We will schedule your lessons in 90-minute Deep Work blocks. Your AI tutor will not intervene often, giving you space to struggle and solve things on your own.'
        )
        
        // Sprinter
        createResult(test, 'SPRINTER', '⚡', 'The Sprinter', 'BURST', 'HIGH_GRIT',
            'You have an incredibly intense "Power Hour." You can do more in 30 minutes than most do in 2 hours, but then your brain needs a "hard reset."',
            'Intense focus bursts. Extremely productive in short sessions.',
            'Cognitive Tunnel Vision. You fight hard, but after 40 minutes, you start making errors that you wouldn\'t make when fresh.',
            'We will use a "Modified Pomodoro" (40m work / 10m break). The AI will push "High Intensity" questions at the start of your session when your brain is at its peak.'
        )
        
        // Safe Player
        createResult(test, 'SAFE_PLAYER', '🛡️', 'The Safe Player', 'STEADY', 'LOW_GRIT',
            'You are a consistent worker who avoids the "red zone." You have great focus, but you tend to skip difficult problems quickly to maintain your momentum and avoid frustration.',
            'Consistent, steady performance. Good at maintaining momentum.',
            'You might "plateau." By avoiding the hardest 10% of questions, you stay safe but don\'t reach the top percentile.',
            'The AI tutor will act as a "Confidence Coach." It will give you "Scaffolded Problems"—breaking the hardest questions into 3 small parts to trick you into solving them.'
        )
        
        // Flash
        createResult(test, 'FLASH', '⚡', 'The Flash', 'BURST', 'LOW_GRIT',
            'You are fast, reactive, and thrive on variety. You get bored easily. If a concept doesn\'t "click" in the first 2 minutes, you lose interest.',
            'Fast and reactive. Excellent at quick pattern recognition.',
            'Inconsistency. Your performance depends entirely on how "interesting" the topic is.',
            'We will use "Micro-Learning." Your lessons will be 15-minute "Sprints" followed by interactive quizzes. We will use high-engagement, gamified rewards to keep your dopamine levels up.'
        )
        
        log.info "Focus Stamina results initialized successfully"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String primaryTrait, String secondaryTrait, String summary, 
                              String strengths, String traps, String aiRoadmap) {
        def result = new DiagnosticResult(
            test: test,
            resultId: resultId,
            resultTitle: title,
            emoji: emoji,
            summary: summary,
            strengths: strengths,
            traps: traps,
            aiRoadmap: aiRoadmap,
            primaryTrait: primaryTrait,
            secondaryTrait: secondaryTrait
        )
        result.save(flush: true)
    }
}


package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class CognitiveRadarService {

    /**
     * Calculate Cognitive Radar results based on responses
     * Maps Logic, Verbal, Spatial, and Speed pillars
     */
    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        // Count correct answers for each pillar
        def logicScore = 0
        def verbalScore = 0
        def spatialScore = 0
        def speedScore = 0
        
        responses.each { response ->
            if (response.isCorrect) {
                switch (response.question.scoringDimension) {
                    case 'LOGIC':
                        logicScore++
                        break
                    case 'VERBAL':
                        verbalScore++
                        break
                    case 'SPATIAL':
                        spatialScore++
                        break
                    case 'SPEED':
                        speedScore++
                        break
                }
            }
        }
        
        // Determine dominant pillars (top 2)
        def scores = [
            LOGIC: logicScore,
            VERBAL: verbalScore,
            SPATIAL: spatialScore,
            SPEED: speedScore
        ]
        
        def sortedPillars = scores.sort { -it.value }.collect { it.key }
        def primaryPillar = sortedPillars[0]
        def secondaryPillar = sortedPillars[1]
        
        // Map to Cognitive Profile
        def resultType = determineCognitiveProfile(primaryPillar, secondaryPillar)
        
        // Get result details
        def result = DiagnosticResult.findByTestAndResultId(session.test, resultType)
        
        def scoreBreakdown = [
            logic: logicScore,
            verbal: verbalScore,
            spatial: spatialScore,
            speed: speedScore,
            primaryPillar: primaryPillar,
            secondaryPillar: secondaryPillar
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
            aiRoadmap: result?.aiRoadmap,
            bestMatches: result?.bestMatches
        ]
    }
    
    /**
     * Determine Cognitive Profile based on dominant pillars
     */
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
        // Default based on highest single pillar
        return "COGNITIVE_${primary}"
    }
    
    /**
     * Initialize Cognitive Radar test questions
     */
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('COGNITIVE_RADAR')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'COGNITIVE_RADAR',
                testName: 'Brain Power Game',
                testType: 'EXAM',
                description: '',
                questionCount: 6,
                estimatedMinutes: 10,
                isActive: true
            )
            test.save(flush: true)
        }
        
        def existingQuestions = DiagnosticQuestion.findAllByTest(test)
        if (existingQuestions) {
            log.info "Cognitive Radar questions already exist"
            return
        }
        
        // Logic Pillar - Question 1
        createQuestion(test, 1, 'LOGIC',
            'If Glimp is always bigger than Glump',
            [
                [text: '✅ Glamp bigger than Glimp', value: 'YES', correct: false],
                [text: '❌ Can never tell', value: 'NO', correct: true]
            ]
        )

        // Logic Pillar - Question 2
        createQuestion(test, 2, 'LOGIC',
            'You see a pattern forming what comes next',
            [
                [text: '40', value: '40', correct: false],
                [text: '42', value: '42', correct: true]
            ]
        )

        // Verbal Pillar - Question 3
        createQuestion(test, 3, 'VERBAL',
            'What is the opposite word of STAGNANT',
            [
                [text: '😐 Calm', value: 'CALM', correct: false],
                [text: '🌊 Flowing', value: 'FLOWING', correct: true],
                [text: '🤫 Silent', value: 'SILENT', correct: false]
            ]
        )

        // Verbal Pillar - Question 4
        createQuestion(test, 4, 'VERBAL',
            'Theory is so blank that critics cannot blank',
            [
                [text: '😐 Simple... Understand', value: 'SIMPLE_UNDERSTAND', correct: false],
                [text: '🔥 Compelling... Refute', value: 'COMPELLING_REFUTE', correct: true]
            ]
        )

        // Spatial Pillar - Question 5
        createQuestion(test, 5, 'SPATIAL',
            'A cube rotates right and then flips down',
            [
                [text: '⬇️ Bottom face', value: 'BOTTOM', correct: true],
                [text: '➡️ Right face', value: 'RIGHT', correct: false],
                [text: '⏩ Front face', value: 'FRONT', correct: false]
            ]
        )

        // Speed Pillar - Question 6 (Timed)
        createQuestion(test, 6, 'SPEED',
            'Count how many times letter E appears',
            [
                [text: '4', value: '4', correct: false],
                [text: '5', value: '5', correct: false],
                [text: '6', value: '6', correct: true],
                [text: '7', value: '7', correct: false]
            ],
            5 // 5 second time limit
        )
        
        log.info "Cognitive Radar questions initialized successfully"
    }
    
    private void createQuestion(DiagnosticTest test, Integer number, String dimension, String text, List options, Integer timeLimit = null) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "COGNITIVE_RADAR_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: timeLimit ? 'TIMED' : 'MULTIPLE_CHOICE',
            scoringDimension: dimension,
            timeLimit: timeLimit
        )
        question.save(flush: true)
        
        options.eachWithIndex { opt, index ->
            def option = new DiagnosticQuestionOption(
                question: question,
                optionText: opt.text,
                optionValue: opt.value,
                displayOrder: index + 1,
                isCorrect: opt.correct
            )
            option.save(flush: true)
        }
    }
    
    /**
     * Initialize Cognitive Radar result profiles
     */
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('COGNITIVE_RADAR')
        if (!test) {
            log.error "Cognitive Radar test not found"
            return
        }
        
        def existingResults = DiagnosticResult.findAllByTest(test)
        if (existingResults) {
            log.info "Cognitive Radar results already exist"
            return
        }
        
        // Analytical Diamond
        createResult(test, 'ANALYTICAL_DIAMOND', '💎', 'The Analytical Diamond', 'LOGIC', 'SPATIAL',
            'You have a "STEM Brain." You see the world in systems and structures. You don\'t just solve problems; you deconstruct them.',
            'Natural for Math/Physics/Coding. Excellent at systematic problem-solving.',
            'May struggle with verbal reasoning and communication-heavy subjects.',
            'Our AI will bypass basic explanations and move straight to "Level 3" complex problem-solving. We will use 3D models to explain your science curriculum.',
            'IIT-JEE, Engineering Entrances, Math Olympiads'
        )
        
        // Verbal Virtuoso
        createResult(test, 'VERBAL_VIRTUOSO', '✍️', 'The Verbal Virtuoso', 'VERBAL', 'SPEED',
            'You are a master of communication and rapid processing. You can scan a 1,000-word passage and find the core argument in seconds.',
            'Natural for Law/Humanities/Literature. Excellent reading comprehension and critical reasoning.',
            'Math speed may lag behind reading speed.',
            'The AI tutor will provide you with high-level vocabulary and "Critical Reasoning" challenges. We will focus on improving your math speed.',
            'Law (CLAT/LSAT), UPSC, Management (CAT/GMAT), SAT'
        )
        
        // Precise Processor
        createResult(test, 'PRECISE_PROCESSOR', '🎯', 'The Precise Processor', 'LOGIC', 'SPEED',
            'You are a "Human Calculator." You thrive in exams with 100 questions and only 60 minutes. Your brain excels at rapid-fire logic.',
            'Excellent at rapid-fire logic and time-crunched exams.',
            'May sacrifice accuracy for speed.',
            'Since you are already fast, our AI will focus on Accuracy Calibration. We will give you questions that look easy but have hidden "logic traps" to slow you down just enough to be perfect.',
            'Banking Exams, Medical Entrances (NEET), GRE'
        )
        
        // Visual Visionary
        createResult(test, 'VISUAL_VISIONARY', '🎨', 'The Visual Visionary', 'SPATIAL', 'VERBAL',
            'You have a rare mix of creative and structural intelligence. You remember diagrams perfectly and can explain them with great clarity.',
            'Excellent visual memory and communication. Natural for design and architecture.',
            'May struggle with abstract concepts that can\'t be visualized.',
            'We will use a "Mind-Map" first approach for your coaching. Every lesson will start with a visual summary before moving into the data.',
            'Design (NID/NIFT), Architecture, Medical (Bio-heavy), Social Sciences'
        )
        
        log.info "Cognitive Radar results initialized successfully"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String primaryTrait, String secondaryTrait, String summary, 
                              String strengths, String traps, String aiRoadmap, String bestMatches) {
        def result = new DiagnosticResult(
            test: test,
            resultId: resultId,
            resultTitle: title,
            emoji: emoji,
            summary: summary,
            strengths: strengths,
            traps: traps,
            aiRoadmap: aiRoadmap,
            bestMatches: bestMatches,
            primaryTrait: primaryTrait,
            secondaryTrait: secondaryTrait
        )
        result.save(flush: true)
    }
}


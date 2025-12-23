package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class SpiritAnimalService {

    /**
     * Calculate Spirit Animal results based on responses
     * Maps Process vs. Intuition and Accuracy vs. Speed
     */
    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        // Count responses for each dimension
        def processCount = 0
        def intuitionCount = 0
        def accuracyCount = 0
        def speedCount = 0
        
        responses.each { response ->
            def value = response.answerValue
            
            // Questions 1, 3, 4, 6, 8, 9, 12 map to Process vs Intuition
            if (response.question.scoringDimension == 'PROCESS_VS_INTUITION') {
                if (value == 'A') {
                    processCount++
                } else if (value == 'B') {
                    intuitionCount++
                }
            }
            
            // Questions 2, 5, 7, 10, 11 map to Accuracy vs Speed
            if (response.question.scoringDimension == 'ACCURACY_VS_SPEED') {
                if (value == 'A') {
                    accuracyCount++
                } else if (value == 'B') {
                    speedCount++
                }
            }
        }
        
        // Determine primary and secondary traits
        def primaryTrait = processCount > intuitionCount ? 'PROCESS' : 'INTUITION'
        def secondaryTrait = accuracyCount > speedCount ? 'ACCURACY' : 'SPEED'
        
        // Map to Spirit Animal
        def resultType = determineSpiritAnimal(primaryTrait, secondaryTrait)
        
        // Get result details
        def result = DiagnosticResult.findByTestAndResultId(session.test, resultType)
        
        def scoreBreakdown = [
            process: processCount,
            intuition: intuitionCount,
            accuracy: accuracyCount,
            speed: speedCount,
            primaryTrait: primaryTrait,
            secondaryTrait: secondaryTrait
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
     * Determine Spirit Animal based on traits
     */
    private String determineSpiritAnimal(String primaryTrait, String secondaryTrait) {
        if (primaryTrait == 'PROCESS' && secondaryTrait == 'ACCURACY') {
            return 'WISE_OWL'
        } else if (primaryTrait == 'PROCESS' && secondaryTrait == 'SPEED') {
            return 'DISCIPLINED_BEE'
        } else if (primaryTrait == 'INTUITION' && secondaryTrait == 'ACCURACY') {
            return 'STRATEGIC_WOLF'
        } else if (primaryTrait == 'INTUITION' && secondaryTrait == 'SPEED') {
            return 'BOLD_TIGER'
        }
        return 'UNKNOWN'
    }
    
    /**
     * Initialize Spirit Animal test questions
     */
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('SPIRIT_ANIMAL')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'SPIRIT_ANIMAL',
                testName: ' Spirit Animal Game',
                testType: 'EXAM',
                description: '',
                questionCount: 12,
                estimatedMinutes: 5,
                isActive: true
            )
            test.save(flush: true)
        }
        
        // Check if questions already exist
        def existingQuestions = DiagnosticQuestion.findAllByTest(test)
        if (existingQuestions) {
            log.info "Spirit Animal questions already exist"
            return
        }
        
        // Question 1
        createQuestion(test, 1, 'PROCESS_VS_INTUITION',
            'You see a new tough chapter you need to learn',
            [
                [text: '📖 Read theory first', value: 'A'],
                [text: '⚡ Jump to practice', value: 'B']
            ]
        )

        // Question 2
        createQuestion(test, 2, 'ACCURACY_VS_SPEED',
            'You are 70% done and feel tired',
            [
                [text: '😵‍💫 Feel drained', value: 'A'],
                [text: '🏃 Rush to finish', value: 'B']
            ]
        )

        // Question 3
        createQuestion(test, 3, 'PROCESS_VS_INTUITION',
            'You got it wrong and trying to figure out why',
            [
                [text: '🧠 Concept not clear', value: 'A'],
                [text: '😅 Silly mistake only', value: 'B']
            ]
        )

        // Question 4
        createQuestion(test, 4, 'PROCESS_VS_INTUITION',
            'Which teacher style works best for you',
            [
                [text: '📚 Deep explanations', value: 'A'],
                [text: '⚡ Quick tricks tips', value: 'B']
            ]
        )

        // Question 5
        createQuestion(test, 5, 'ACCURACY_VS_SPEED',
            'During exam you need complete silence to focus',
            [
                [text: '🔇 Yes need it', value: 'A'],
                [text: '😐 Don\'t care much', value: 'B']
            ]
        )

        // Question 6
        createQuestion(test, 6, 'PROCESS_VS_INTUITION',
            'Your class notes usually look like this',
            [
                [text: '✨ Very organized', value: 'A'],
                [text: '📝 Messy scribbles', value: 'B']
            ]
        )

        // Question 7
        createQuestion(test, 7, 'ACCURACY_VS_SPEED',
            'You are not sure but must answer now',
            [
                [text: '❌ Leave it blank', value: 'A'],
                [text: '🎯 Trust gut feeling', value: 'B']
            ]
        )

        // Question 8
        createQuestion(test, 8, 'PROCESS_VS_INTUITION',
            'Night before exam you are still studying',
            [
                [text: '📚 Study weak topics', value: 'A'],
                [text: '😴 Sleep and trust', value: 'B']
            ]
        )

        // Question 9
        createQuestion(test, 9, 'PROCESS_VS_INTUITION',
            'Memorizing formulas and facts feels like this',
            [
                [text: '✅ Important part', value: 'A'],
                [text: '😑 Boring just skip', value: 'B']
            ]
        )

        // Question 10
        createQuestion(test, 10, 'ACCURACY_VS_SPEED',
            'Your biggest fear during exam is this',
            [
                [text: '😰 Forget the steps', value: 'A'],
                [text: '⏰ Run out time', value: 'B']
            ]
        )

        // Question 11
        createQuestion(test, 11, 'ACCURACY_VS_SPEED',
            'You finished early and have time left',
            [
                [text: '🔍 Check all answers', value: 'A'],
                [text: '✅ Done just relax', value: 'B']
            ]
        )

        // Question 12
        createQuestion(test, 12, 'PROCESS_VS_INTUITION',
            'Group study session is happening right now',
            [
                [text: '📋 Follow the syllabus', value: 'A'],
                [text: '💭 Ask what if questions', value: 'B']
            ]
        )
        
        log.info "Spirit Animal questions initialized successfully"
    }
    
    /**
     * Helper method to create a question with options
     */
    private void createQuestion(DiagnosticTest test, Integer number, String dimension, String text, List options) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "SPIRIT_ANIMAL_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'MULTIPLE_CHOICE',
            scoringDimension: dimension
        )
        question.save(flush: true)
        
        options.eachWithIndex { opt, index ->
            def option = new DiagnosticQuestionOption(
                question: question,
                optionText: opt.text,
                optionValue: opt.value,
                displayOrder: index + 1
            )
            option.save(flush: true)
        }
    }
    
    /**
     * Initialize Spirit Animal result profiles
     */
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('SPIRIT_ANIMAL')
        if (!test) {
            log.error "Spirit Animal test not found"
            return
        }
        
        // Check if results already exist
        def existingResults = DiagnosticResult.findAllByTest(test)
        if (existingResults) {
            log.info "Spirit Animal results already exist"
            return
        }
        
        // Wise Owl
        createResult(test, 'WISE_OWL', '🦉', 'The Wise Owl', 'PROCESS', 'ACCURACY',
            'You like to understand everything deeply before moving forward. You won\'t start Chapter 2 until you\'ve completely mastered Chapter 1.',
            'You understand concepts really well and are super careful with details.',
            'You spend too much time on hard questions and don\'t want to skip them, which can mess up your time.',
            'We\'ll teach you when to skip questions and how to manage your time better during exams.'
        )

        // Strategic Wolf
        createResult(test, 'STRATEGIC_WOLF', '🐺', 'The Strategic Wolf', 'INTUITION', 'ACCURACY',
            'You have a good sense for finding the right answer. You\'re great at eliminating wrong options and using smart shortcuts.',
            'You work efficiently and have strong exam instincts.',
            'You sometimes lose easy marks because you\'re overconfident and miss small details in questions.',
            'We\'ll give you tricky questions to help you catch silly mistakes and pay better attention to details.'
        )

        // Disciplined Bee
        createResult(test, 'DISCIPLINED_BEE', '🐝', 'The Disciplined Bee', 'PROCESS', 'SPEED',
            'You love structure and routine. You believe in steady improvement and can study consistently for long periods.',
            'You\'re super consistent and great at following standard methods and memorizing.',
            'You struggle when exam questions look different from what you practiced.',
            'We\'ll give you different types of questions to help you become more flexible in your thinking.'
        )

        // Bold Tiger
        createResult(test, 'BOLD_TIGER', '🐯', 'The Bold Tiger', 'INTUITION', 'SPEED',
            'You perform best under pressure and love competition. You\'re fast, bold, and thrive on challenges.',
            'You can finish exams quickly and often do better in real exams than in practice.',
            'You get bored with easy topics and forget things you learned a while ago.',
            'We\'ll make learning fun like a game and send you quick reminders to help you remember what you studied.'
        )
        
        log.info "Spirit Animal results initialized successfully"
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


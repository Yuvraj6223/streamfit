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
                testName: 'Exam Spirit Animal',
                testType: 'EXAM',
                description: 'Discover your exam personality and learning style',
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
            'A new, difficult chapter is assigned. Your first move is:',
            [
                [text: 'Read the entire theory and derivations from the textbook first.', value: 'A'],
                [text: 'Jump straight into the practice questions to see how they are asked.', value: 'B']
            ]
        )
        
        // Question 2
        createQuestion(test, 2, 'ACCURACY_VS_SPEED',
            'You are 70% through a 3-hour mock exam. How do you feel?',
            [
                [text: 'Mentally exhausted; you\'ve put deep energy into every single question.', value: 'A'],
                [text: 'Restless; you are ready to be done and see your final score.', value: 'B']
            ]
        )
        
        // Question 3
        createQuestion(test, 3, 'PROCESS_VS_INTUITION',
            'When you get a question wrong, what is your immediate thought?',
            [
                [text: 'I must have missed a fundamental step in the concept.', value: 'A'],
                [text: 'I probably made a silly calculation error or misread it.', value: 'B']
            ]
        )
        
        // Question 4
        createQuestion(test, 4, 'PROCESS_VS_INTUITION',
            'Your favorite type of teacher is one who:',
            [
                [text: 'Explains exactly how a formula was derived from scratch.', value: 'A'],
                [text: 'Shows you three different "hacks" to solve the same problem in 10 seconds.', value: 'B']
            ]
        )
        
        // Question 5
        createQuestion(test, 5, 'ACCURACY_VS_SPEED',
            'In a high-pressure exam hall, silence is:',
            [
                [text: 'Essential. Any background noise breaks your train of thought.', value: 'A'],
                [text: 'Boring. You actually prefer a little bit of ambient "buzz" to stay alert.', value: 'B']
            ]
        )
        
        // Question 6
        createQuestion(test, 6, 'PROCESS_VS_INTUITION',
            'What do your study notes look like?',
            [
                [text: 'Highly organized, color-coded, and following a clear structure.', value: 'A'],
                [text: 'Rough scribbles, diagrams, and "shortcuts" only you can decode.', value: 'B']
            ]
        )
        
        // Question 7
        createQuestion(test, 7, 'ACCURACY_VS_SPEED',
            'When you are unsure of an answer and have to guess:',
            [
                [text: 'You\'d rather leave it blank than risk a negative mark.', value: 'A'],
                [text: 'You eliminate two options and "go with your gut" on the rest.', value: 'B']
            ]
        )
        
        // Question 8
        createQuestion(test, 8, 'PROCESS_VS_INTUITION',
            'The night before a major exam, you can be found:',
            [
                [text: 'Revising your "weakest" topics one last time for total coverage.', value: 'A'],
                [text: 'Relaxing or sleeping; you trust your brain will "switch on" tomorrow.', value: 'B']
            ]
        )
        
        // Question 9
        createQuestion(test, 9, 'PROCESS_VS_INTUITION',
            'How do you feel about "Rote Memorization" (dates, formulas, lists)?',
            [
                [text: 'It\'s fine; it\'s a necessary part of the system.', value: 'A'],
                [text: 'It\'s painful; you\'d much rather "figure it out" using logic.', value: 'B']
            ]
        )
        
        // Question 10
        createQuestion(test, 10, 'ACCURACY_VS_SPEED',
            'What is your biggest fear during an exam?',
            [
                [text: 'Forgetting a crucial step in a complex problem.', value: 'A'],
                [text: 'Running out of time before you\'ve seen every question.', value: 'B']
            ]
        )
        
        // Question 11
        createQuestion(test, 11, 'ACCURACY_VS_SPEED',
            'If you finish a practice task early, you:',
            [
                [text: 'Go back to the very beginning and re-check every calculation.', value: 'A'],
                [text: 'Close the book immediately and move on to something else.', value: 'B']
            ]
        )
        
        // Question 12
        createQuestion(test, 12, 'PROCESS_VS_INTUITION',
            'In a group study session, you are typically the one who:',
            [
                [text: 'Keeps the group on the syllabus and ensures no one skips steps.', value: 'A'],
                [text: 'Challenges the group with "What if they change the question to this?"', value: 'B']
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
            'You are a "Bottom-Up" learner who refuses to build on shaky foundations. You won\'t move to Chapter 2 until you\'ve mastered Chapter 1.',
            'Incredible precision and deep conceptual understanding.',
            'You get into "ego battles" with hard questions, refusing to skip them, which kills your time management.',
            'We will focus on "Skip-Logic" training and time-boxed sprints to speed up your execution.'
        )
        
        // Strategic Wolf
        createResult(test, 'STRATEGIC_WOLF', '🐺', 'The Strategic Wolf', 'INTUITION', 'ACCURACY',
            'You have a "nose" for the right answer. You are excellent at eliminating wrong options and using logic to bypass long calculations.',
            'High efficiency and great "exam-room" intuition.',
            'You lose "easy" marks due to over-confidence and missing small details in the question text.',
            'Our AI will serve you "Trap Questions" designed to catch your silly mistakes and sharpen your attention to detail.'
        )
        
        // Disciplined Bee
        createResult(test, 'DISCIPLINED_BEE', '🐝', 'The Disciplined Bee', 'PROCESS', 'SPEED',
            'You thrive on structure. You believe in the 1% improvement rule and have the highest stamina for long-term study.',
            'High consistency and mastery of standard procedures/rote learning.',
            'You struggle when the exam "goes off-script" with questions that don\'t look like your practice books.',
            'We will use "Chaos Simulation" to give you unfamiliar question formats, building your mental flexibility.'
        )
        
        // Bold Tiger
        createResult(test, 'BOLD_TIGER', '🐯', 'The Bold Tiger', 'INTUITION', 'SPEED',
            'You are a high-pressure performer who loves the leaderboard. You are fast, aggressive, and highly competitive.',
            'You can "blitz" through papers and perform better in the actual exam than in practice.',
            'You get bored with easy subjects and struggle with long-term memory of boring facts.',
            'We will gamify your learning with "Active Recall" pings throughout the day to ensure you don\'t forget what you learned a week ago.'
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


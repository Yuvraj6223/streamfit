package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class GuessworkQuotientService {

    /**
     * Calculate Guesswork Quotient results based on confidence vs accuracy
     */
    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        // Calculate accuracy and confidence metrics
        def totalQuestions = responses.size()
        def correctAnswers = responses.count { it.isCorrect }
        def accuracy = (correctAnswers / totalQuestions) * 100
        
        // Calculate average confidence level
        def confidenceSum = responses.sum { it.confidenceLevel ?: 0 }
        def avgConfidence = (confidenceSum / totalQuestions) * 33.33 // Convert to percentage (1-3 scale to 0-100)
        
        // Calculate confidence calibration
        def calibration = Math.abs(accuracy - avgConfidence)
        
        // Determine risk profile
        def resultType = determineRiskProfile(accuracy, avgConfidence)
        
        // Get result details
        def result = DiagnosticResult.findByTestAndResultId(session.test, resultType)
        
        def scoreBreakdown = [
            accuracy: accuracy,
            avgConfidence: avgConfidence,
            calibration: calibration,
            totalQuestions: totalQuestions,
            correctAnswers: correctAnswers
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
     * Determine risk profile based on accuracy vs confidence
     */
    private String determineRiskProfile(Double accuracy, Double avgConfidence) {
        def calibration = Math.abs(accuracy - avgConfidence)
        
        if (calibration < 15) {
            // Well calibrated
            return 'BALANCED_STRATEGIST'
        } else if (avgConfidence > accuracy + 15) {
            // Over-confident
            return 'HIGH_ROLLER'
        } else if (accuracy > avgConfidence + 15) {
            // Under-confident
            return 'UNDER_ESTIMATOR'
        } else if (accuracy < 50) {
            // Low accuracy, searching
            return 'HESITANT_SEARCHER'
        }
        
        return 'BALANCED_STRATEGIST'
    }
    
    /**
     * Initialize Guesswork Quotient test questions
     */
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('GUESSWORK_QUOTIENT')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'GUESSWORK_QUOTIENT',
                testName: 'Guesswork Quotient (Risk Profile)',
                testType: 'EXAM',
                description: 'Analyze how you handle uncertainty and calculate your risk-reward ratio',
                questionCount: 10,
                estimatedMinutes: 8,
                isActive: true
            )
            test.save(flush: true)
        }
        
        def existingQuestions = DiagnosticQuestion.findAllByTest(test)
        if (existingQuestions) {
            log.info "Guesswork Quotient questions already exist"
            return
        }
        
        // Sample trivia questions with betting mechanism
        createBettingQuestion(test, 1, 'Which of these elements has the highest atomic number?',
            [
                [text: 'Gold', value: 'GOLD', correct: false],
                [text: 'Silver', value: 'SILVER', correct: false],
                [text: 'Platinum', value: 'PLATINUM', correct: true],
                [text: 'Mercury', value: 'MERCURY', correct: false]
            ]
        )
        
        createBettingQuestion(test, 2, 'What is the capital of Australia?',
            [
                [text: 'Sydney', value: 'SYDNEY', correct: false],
                [text: 'Melbourne', value: 'MELBOURNE', correct: false],
                [text: 'Canberra', value: 'CANBERRA', correct: true],
                [text: 'Brisbane', value: 'BRISBANE', correct: false]
            ]
        )
        
        createBettingQuestion(test, 3, 'Which planet has the most moons?',
            [
                [text: 'Jupiter', value: 'JUPITER', correct: false],
                [text: 'Saturn', value: 'SATURN', correct: true],
                [text: 'Uranus', value: 'URANUS', correct: false],
                [text: 'Neptune', value: 'NEPTUNE', correct: false]
            ]
        )
        
        createBettingQuestion(test, 4, 'Who wrote "1984"?',
            [
                [text: 'Aldous Huxley', value: 'HUXLEY', correct: false],
                [text: 'George Orwell', value: 'ORWELL', correct: true],
                [text: 'Ray Bradbury', value: 'BRADBURY', correct: false],
                [text: 'H.G. Wells', value: 'WELLS', correct: false]
            ]
        )
        
        createBettingQuestion(test, 5, 'What is the speed of light?',
            [
                [text: '299,792 km/s', value: '299792', correct: true],
                [text: '300,000 km/s', value: '300000', correct: false],
                [text: '299,000 km/s', value: '299000', correct: false],
                [text: '298,792 km/s', value: '298792', correct: false]
            ]
        )
        
        createBettingQuestion(test, 6, 'Which programming language was created first?',
            [
                [text: 'C', value: 'C', correct: false],
                [text: 'FORTRAN', value: 'FORTRAN', correct: true],
                [text: 'BASIC', value: 'BASIC', correct: false],
                [text: 'Pascal', value: 'PASCAL', correct: false]
            ]
        )
        
        createBettingQuestion(test, 7, 'What is the largest ocean on Earth?',
            [
                [text: 'Atlantic', value: 'ATLANTIC', correct: false],
                [text: 'Indian', value: 'INDIAN', correct: false],
                [text: 'Pacific', value: 'PACIFIC', correct: true],
                [text: 'Arctic', value: 'ARCTIC', correct: false]
            ]
        )
        
        createBettingQuestion(test, 8, 'How many bones are in the adult human body?',
            [
                [text: '196', value: '196', correct: false],
                [text: '206', value: '206', correct: true],
                [text: '216', value: '216', correct: false],
                [text: '226', value: '226', correct: false]
            ]
        )
        
        createBettingQuestion(test, 9, 'What is the chemical symbol for gold?',
            [
                [text: 'Go', value: 'GO', correct: false],
                [text: 'Gd', value: 'GD', correct: false],
                [text: 'Au', value: 'AU', correct: true],
                [text: 'Ag', value: 'AG', correct: false]
            ]
        )
        
        createBettingQuestion(test, 10, 'Which country has the longest coastline?',
            [
                [text: 'Russia', value: 'RUSSIA', correct: false],
                [text: 'Canada', value: 'CANADA', correct: true],
                [text: 'USA', value: 'USA', correct: false],
                [text: 'Indonesia', value: 'INDONESIA', correct: false]
            ]
        )
        
        log.info "Guesswork Quotient questions initialized successfully"
    }
    
    private void createBettingQuestion(DiagnosticTest test, Integer number, String text, List options) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "GUESSWORK_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'BETTING',
            scoringDimension: 'RISK_ASSESSMENT'
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
     * Initialize Guesswork Quotient result profiles
     */
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('GUESSWORK_QUOTIENT')
        if (!test) {
            log.error "Guesswork Quotient test not found"
            return
        }
        
        def existingResults = DiagnosticResult.findAllByTest(test)
        if (existingResults) {
            log.info "Guesswork Quotient results already exist"
            return
        }
        
        // Balanced Strategist
        createResult(test, 'BALANCED_STRATEGIST', '⚖️', 'The Balanced Strategist', 'CALIBRATED', 'CALIBRATED',
            'You have a rare "Self-Awareness." You know exactly what you know and, more importantly, what you don\'t. You don\'t let your ego interfere with your marking.',
            'You rarely lose marks to "stupid" guesses. Excellent self-awareness.',
            'None significant - you are well-calibrated.',
            'You are ready for high-level mock exams. The AI will focus on increasing your speed without breaking your calibration.'
        )
        
        // High Roller
        createResult(test, 'HIGH_ROLLER', '🎲', 'The High Roller', 'OVER_CONFIDENT', 'AGGRESSIVE',
            'You are aggressive. You believe you can "solve" any question, which leads you to make guesses that the data doesn\'t support.',
            'Confident and decisive. Not afraid to take risks.',
            'In a negative-marking exam, you could be losing 15-20% of your total score purely to "bad bets."',
            'The AI will introduce a "Penalty Mode." If you get a question wrong that you marked as "Certain," the AI will pause the test and force you to find the flaw in your logic.'
        )
        
        // Under-Estimator
        createResult(test, 'UNDER_ESTIMATOR', '🤔', 'The Under-Estimator', 'UNDER_CONFIDENT', 'CAUTIOUS',
            'You are too cautious. You likely leave 5-10 questions blank that you actually knew the answer to, simply because you weren\'t "100% sure."',
            'Careful and thoughtful. Rarely makes careless mistakes.',
            'You are leaving "Free Marks" on the table. You need to learn how to trust your educated intuition.',
            'The AI will give you "Elimination Drills." We will teach you how to statistically justify a guess even if you only know 2 out of 4 options are wrong.'
        )
        
        // Hesitant Searcher
        createResult(test, 'HESITANT_SEARCHER', '🔍', 'The Hesitant Searcher', 'LOW_ACCURACY', 'SEARCHING',
            'You are still building your knowledge base. You tend to second-guess yourself and struggle with confidence in your answers.',
            'Willing to learn and improve. Open to feedback.',
            'Low accuracy combined with uncertainty leads to poor performance.',
            'The AI will focus on building your foundational knowledge first, then work on confidence calibration through progressive difficulty levels.'
        )
        
        log.info "Guesswork Quotient results initialized successfully"
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


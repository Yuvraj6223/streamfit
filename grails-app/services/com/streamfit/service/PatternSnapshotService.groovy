package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class PatternSnapshotService {

    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        def visualScore = 0
        def verbalScore = 0
        def numericScore = 0
        
        responses.each { response ->
            if (response.isCorrect) {
                switch (response.question.scoringDimension) {
                    case 'VISUAL': visualScore++; break
                    case 'VERBAL': verbalScore++; break
                    case 'NUMERIC': numericScore++; break
                }
            }
        }
        
        def scores = [
            VISUAL: visualScore,
            VERBAL: verbalScore,
            NUMERIC: numericScore
        ]
        
        def dominantSkew = scores.max { it.value }.key
        def result = DiagnosticResult.findByTestAndResultId(session.test, dominantSkew)
        
        return [
            resultType: dominantSkew,
            resultTitle: result?.resultTitle ?: dominantSkew,
            resultSummary: result?.summary ?: '',
            scoreBreakdown: scores + [dominantSkew: dominantSkew],
            emoji: result?.emoji,
            profile: result?.profile,
            strengths: result?.strengths,
            bestMatches: result?.bestMatches,
            aiRoadmap: result?.aiRoadmap
        ]
    }
    
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('PATTERN_SNAPSHOT')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'PATTERN_SNAPSHOT',
                testName: 'Pattern Rush Game',
                testType: 'CAREER',
                description: 'Solve fun pattern puzzles and test your logic skills',
                questionCount: 6,
                estimatedMinutes: 3,
                isActive: true
            ).save(flush: true)
        }
        
        if (DiagnosticQuestion.findAllByTest(test)) {
            log.info "Pattern Snapshot questions already exist"
            return
        }
        
        // Visual Pattern 1
        createQuestion(test, 1, 'VISUAL', 'You almost see the pattern what comes next',
            [
                [text: '⭕ Circle', value: 'CIRCLE', correct: false],
                [text: '🔲 Square', value: 'SQUARE', correct: false],
                [text: '🔺 Triangle', value: 'TRIANGLE', correct: true],
                [text: '⬟ Pentagon', value: 'PENTAGON', correct: false]
            ]
        )

        // Visual Pattern 2
        createQuestion(test, 2, 'VISUAL', 'Fold paper twice and cut corner how many holes',
            [
                [text: '1 hole', value: '1', correct: false],
                [text: '2 holes', value: '2', correct: false],
                [text: '4 holes', value: '4', correct: true],
                [text: '8 holes', value: '8', correct: false]
            ]
        )

        // Verbal Analogy 1
        createQuestion(test, 3, 'VERBAL', 'Book is to Read as Knife is to',
            [
                [text: '⚡ Sharp', value: 'SHARP', correct: false],
                [text: '✂️ Cut', value: 'CUT', correct: true],
                [text: '🔩 Metal', value: 'METAL', correct: false],
                [text: '🥄 Spoon', value: 'SPOON', correct: false]
            ]
        )

        // Verbal Analogy 2
        createQuestion(test, 4, 'VERBAL', 'Hot is to Cold as Day is to',
            [
                [text: '☀️ Sun', value: 'SUN', correct: false],
                [text: '🌙 Night', value: 'NIGHT', correct: true],
                [text: '🌕 Moon', value: 'MOON', correct: false],
                [text: '🌑 Dark', value: 'DARK', correct: false]
            ]
        )

        // Numeric/Logic 1
        createQuestion(test, 5, 'NUMERIC', 'You see a pattern forming what is next',
            [
                [text: '18', value: '18', correct: false],
                [text: '24', value: '24', correct: false],
                [text: '32', value: '32', correct: true],
                [text: '36', value: '36', correct: false]
            ]
        )

        // Numeric/Logic 2
        createQuestion(test, 6, 'NUMERIC', 'Five machines make five widgets in five minutes',
            [
                [text: '⚡ 5 minutes', value: '5', correct: true],
                [text: '20 minutes', value: '20', correct: false],
                [text: '100 minutes', value: '100', correct: false],
                [text: '500 minutes', value: '500', correct: false]
            ]
        )
        
        log.info "Pattern Snapshot questions initialized"
    }
    
    private void createQuestion(DiagnosticTest test, Integer number, String dimension, String text, List options) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "PATTERN_SNAPSHOT_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'MULTIPLE_CHOICE',
            scoringDimension: dimension
        ).save(flush: true)
        
        options.eachWithIndex { opt, index ->
            new DiagnosticQuestionOption(
                question: question,
                optionText: opt.text,
                optionValue: opt.value,
                displayOrder: index + 1,
                isCorrect: opt.correct
            ).save(flush: true)
        }
    }
    
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('PATTERN_SNAPSHOT')
        if (!test || DiagnosticResult.findAllByTest(test)) {
            log.info "Pattern Snapshot results already exist or test not found"
            return
        }
        
        createResult(test, 'VISUAL', '👁️', 'Visual Thinker',
            'You excel at visual pattern recognition and spatial reasoning.',
            'Strong visual-spatial skills, pattern recognition.',
            'Architecture, Medicine, Design',
            'Use visual learning materials and spatial reasoning exercises.')
        
        createResult(test, 'VERBAL', '📚', 'Verbal Thinker',
            'You excel at language, analogies, and verbal reasoning.',
            'Strong language skills, verbal reasoning, communication.',
            'Law, Content, UPSC, Literature',
            'Use verbal reasoning exercises and language-based learning.')
        
        createResult(test, 'NUMERIC', '🔢', 'Numeric Thinker',
            'You excel at numerical patterns, logic, and quantitative reasoning.',
            'Strong mathematical skills, logical reasoning, problem-solving.',
            'CS, Finance, Quant Exams, Engineering',
            'Use mathematical problems and logical reasoning exercises.')
        
        log.info "Pattern Snapshot results initialized"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String summary, String strengths, String bestMatches, String aiRoadmap) {
        new DiagnosticResult(
            test: test, resultId: resultId, resultTitle: title, emoji: emoji,
            summary: summary, strengths: strengths, bestMatches: bestMatches, aiRoadmap: aiRoadmap
        ).save(flush: true)
    }
}


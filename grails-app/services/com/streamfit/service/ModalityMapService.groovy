package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class ModalityMapService {

    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        def visualCount = 0
        def auditoryCount = 0
        def kinestheticCount = 0
        def conceptualCount = 0
        
        responses.each { response ->
            switch (response.answerValue) {
                case 'A': visualCount++; break
                case 'B': auditoryCount++; break
                case 'C': kinestheticCount++; break
                case 'D': conceptualCount++; break
            }
        }
        
        def scores = [
            VISUAL: visualCount,
            AUDITORY: auditoryCount,
            KINESTHETIC: kinestheticCount,
            CONCEPTUAL: conceptualCount
        ]
        
        def dominantModality = scores.max { it.value }.key
        def result = DiagnosticResult.findByTestAndResultId(session.test, dominantModality)
        
        return [
            resultType: dominantModality,
            resultTitle: result?.resultTitle ?: dominantModality,
            resultSummary: result?.summary ?: '',
            scoreBreakdown: scores + [dominantModality: dominantModality],
            emoji: result?.emoji,
            profile: result?.profile,
            strengths: result?.strengths,
            bestMatches: result?.bestMatches,
            aiRoadmap: result?.aiRoadmap
        ]
    }
    
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('MODALITY_MAP')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'MODALITY_MAP',
                testName: 'Modality Map',
                testType: 'CAREER',
                description: 'Identifies your preferred learning input modality',
                questionCount: 6,
                estimatedMinutes: 3,
                isActive: true
            ).save(flush: true)
        }
        
        if (DiagnosticQuestion.findAllByTest(test)) {
            log.info "Modality Map questions already exist"
            return
        }
        
        createQuestion(test, 1, 'Best way to learn a new concept?',
            ['Diagrams or flowcharts', 'Lecture or podcast', 'Hands-on practice', 'Real-world analogy'])
        
        createQuestion(test, 2, 'Most memorable classes?',
            ['Ones with board work and charts', 'Teachers who spoke clearly', 'Labs and demos', 'Abstract discussions'])
        
        createQuestion(test, 3, 'Best way to revise?',
            ['Mind maps', 'Reciting aloud', 'Solving problems again', 'Explain it to someone'])
        
        createQuestion(test, 4, 'How do you take notes?',
            ['Sketches and bullets', 'Verbatim or summary audio', 'Rough scribbles while doing', 'Structure + meaning'])
        
        createQuestion(test, 5, 'Most annoying?',
            ['No visuals in textbook', 'Teacher who doesn\'t speak clearly', 'Just reading without action', 'Rote memorization'])
        
        createQuestion(test, 6, 'If you miss a class?',
            ['Request diagrams or slides', 'Ask someone to explain aloud', 'Find practice questions', 'Read summaries and reason it out'])
        
        log.info "Modality Map questions initialized"
    }
    
    private void createQuestion(DiagnosticTest test, Integer number, String text, List<String> optionTexts) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "MODALITY_MAP_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'MULTIPLE_CHOICE',
            scoringDimension: 'LEARNING_MODALITY'
        ).save(flush: true)
        
        ['A', 'B', 'C', 'D'].eachWithIndex { value, index ->
            new DiagnosticQuestionOption(
                question: question,
                optionText: optionTexts[index],
                optionValue: value,
                displayOrder: index + 1
            ).save(flush: true)
        }
    }
    
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('MODALITY_MAP')
        if (!test || DiagnosticResult.findAllByTest(test)) {
            log.info "Modality Map results already exist or test not found"
            return
        }
        
        createResult(test, 'VISUAL', '👁️', 'Visual Learner',
            'You learn best through diagrams, charts, and visual representations.',
            'Strong visual memory, excellent at spatial reasoning.',
            'Biology, Design, Chemistry, Architecture',
            'Use visual aids, mind maps, and diagrams extensively.')
        
        createResult(test, 'AUDITORY', '👂', 'Auditory Learner',
            'You learn best through listening and verbal explanations.',
            'Strong listening skills, excellent at language processing.',
            'Law, Literature, Languages, Music',
            'Use lectures, podcasts, and verbal discussions.')
        
        createResult(test, 'KINESTHETIC', '✋', 'Kinesthetic Learner',
            'You learn best through hands-on practice and physical activity.',
            'Strong practical skills, excellent at learning by doing.',
            'Surgery, Engineering, Sport Science, Lab Sciences',
            'Use hands-on practice, experiments, and physical activities.')
        
        createResult(test, 'CONCEPTUAL', '💡', 'Conceptual Learner',
            'You learn best through abstract thinking and logical reasoning.',
            'Strong analytical skills, excellent at understanding complex concepts.',
            'Computer Science, Policy, Abstract Math, Philosophy',
            'Use conceptual frameworks, logical reasoning, and abstract thinking.')
        
        log.info "Modality Map results initialized"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String summary, String strengths, String bestMatches, String aiRoadmap) {
        new DiagnosticResult(
            test: test, resultId: resultId, resultTitle: title, emoji: emoji,
            summary: summary, strengths: strengths, bestMatches: bestMatches, aiRoadmap: aiRoadmap
        ).save(flush: true)
    }
}


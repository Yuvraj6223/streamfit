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
                testName: 'Learning Style Game',
                testType: 'CAREER',
                description: '',
                questionCount: 6,
                estimatedMinutes: 3,
                isActive: true
            ).save(flush: true)
        }
        
        if (DiagnosticQuestion.findAllByTest(test)) {
            log.info "Modality Map questions already exist"
            return
        }
        
        createQuestion(test, 1, 'You don\'t understand this topic clearly',
            ['👁️ Need to see diagrams', '👂 Need to hear lecture', '✋ Need to do practice', '🧠 Need an analogy'])

        createQuestion(test, 2, 'Your most memorable class felt like this',
            ['👁️ Charts on board', '👂 Clear speaker talking', '✋ Labs and demos', '🧠 Abstract deep talk'])

        createQuestion(test, 3, 'When you revise material it works best',
            ['👁️ Draw mind maps', '👂 Recite out loud', '✋ Solve problems again', '🧠 Explain to yourself'])

        createQuestion(test, 4, 'You take notes during class like this',
            ['👁️ Sketches and bullets', '👂 Audio summary recording', '✋ Scribble while doing', '🧠 Structure the meaning'])

        createQuestion(test, 5, 'Most annoying thing when you are learning',
            ['👁️ No visuals shown', '👂 Unclear speaker voice', '✋ Just reading only', '🧠 Rote memory boring'])

        createQuestion(test, 6, 'You missed class and need to catch up',
            ['👁️ Get the slides', '👂 Hear explanation friend', '✋ Practice the questions', '🧠 Read the summaries'])
        
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


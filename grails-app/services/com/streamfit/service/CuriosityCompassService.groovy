package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class CuriosityCompassService {

    /**
     * Calculate Curiosity Compass results
     * Maps to Theorist, Builder, Empath, or Challenger
     */
    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        // Count responses for each type
        def theoristCount = 0
        def builderCount = 0
        def empathCount = 0
        def challengerCount = 0
        
        responses.each { response ->
            switch (response.answerValue) {
                case 'A':
                    theoristCount++
                    break
                case 'B':
                    builderCount++
                    break
                case 'C':
                    empathCount++
                    break
                case 'D':
                    challengerCount++
                    break
            }
        }
        
        // Determine dominant type
        def scores = [
            THEORIST: theoristCount,
            BUILDER: builderCount,
            EMPATH: empathCount,
            CHALLENGER: challengerCount
        ]
        
        def dominantType = scores.max { it.value }.key
        
        // Get result details
        def result = DiagnosticResult.findByTestAndResultId(session.test, dominantType)
        
        def scoreBreakdown = [
            theorist: theoristCount,
            builder: builderCount,
            empath: empathCount,
            challenger: challengerCount,
            dominantType: dominantType
        ]
        
        return [
            resultType: dominantType,
            resultTitle: result?.resultTitle ?: dominantType,
            resultSummary: result?.summary ?: '',
            scoreBreakdown: scoreBreakdown,
            emoji: result?.emoji,
            profile: result?.profile,
            strengths: result?.strengths,
            bestMatches: result?.bestMatches,
            aiRoadmap: result?.aiRoadmap
        ]
    }
    
    /**
     * Initialize Curiosity Compass test questions
     */
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('CURIOSITY_COMPASS')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'CURIOSITY_COMPASS',
                testName: 'Curiosity Compass',
                testType: 'CAREER',
                description: 'Identifies your cognitive orientation and interest type',
                questionCount: 6,
                estimatedMinutes: 3,
                isActive: true
            )
            test.save(flush: true)
        }
        
        def existingQuestions = DiagnosticQuestion.findAllByTest(test)
        if (existingQuestions) {
            log.info "Curiosity Compass questions already exist"
            return
        }
        
        createQuestion(test, 1, 'You watch a documentary about ancient civilizations. What excites you most?',
            [
                [text: 'Understanding the evolution of societies', value: 'A'],
                [text: 'Rebuilding the tools they used', value: 'B'],
                [text: 'Imagining how people emotionally lived', value: 'C'],
                [text: 'Questioning how true it really is', value: 'D']
            ]
        )
        
        createQuestion(test, 2, 'You\'re given a science experiment. What would you focus on?',
            [
                [text: 'Why it works', value: 'A'],
                [text: 'How to replicate or improve it', value: 'B'],
                [text: 'Who it might benefit', value: 'C'],
                [text: 'What assumptions it makes', value: 'D']
            ]
        )
        
        createQuestion(test, 3, 'When reading an article...',
            [
                [text: 'You trace the logic', value: 'A'],
                [text: 'You want to apply it', value: 'B'],
                [text: 'You think about impact', value: 'C'],
                [text: 'You look for counterarguments', value: 'D']
            ]
        )
        
        createQuestion(test, 4, 'In a debate...',
            [
                [text: 'You clarify core concepts', value: 'A'],
                [text: 'You suggest new models', value: 'B'],
                [text: 'You talk about real-world consequences', value: 'C'],
                [text: 'You challenge flaws directly', value: 'D']
            ]
        )
        
        createQuestion(test, 5, 'You prefer a teacher who...',
            [
                [text: 'Gives conceptual depth', value: 'A'],
                [text: 'Gives practical tools', value: 'B'],
                [text: 'Connects emotionally', value: 'C'],
                [text: 'Provokes critical thinking', value: 'D']
            ]
        )
        
        createQuestion(test, 6, 'What frustrates you most?',
            [
                [text: 'Shallow arguments', value: 'A'],
                [text: 'Inefficient systems', value: 'B'],
                [text: 'Indifference to suffering', value: 'C'],
                [text: 'Over-simplified truths', value: 'D']
            ]
        )
        
        log.info "Curiosity Compass questions initialized successfully"
    }
    
    private void createQuestion(DiagnosticTest test, Integer number, String text, List options) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "CURIOSITY_COMPASS_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'MULTIPLE_CHOICE',
            scoringDimension: 'CURIOSITY_TYPE'
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
     * Initialize Curiosity Compass result profiles
     */
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('CURIOSITY_COMPASS')
        if (!test) {
            log.error "Curiosity Compass test not found"
            return
        }
        
        def existingResults = DiagnosticResult.findAllByTest(test)
        if (existingResults) {
            log.info "Curiosity Compass results already exist"
            return
        }
        
        // Theorist
        createResult(test, 'THEORIST', '🔬', 'The Theorist',
            'You are driven by understanding the "why" behind everything. You love abstract concepts and theoretical frameworks.',
            'Deep analytical thinking, conceptual understanding, research-oriented.',
            'Research, Policy, Physics, Mathematics, Philosophy',
            'Focus on theoretical foundations and conceptual frameworks. Provide deep dives into underlying principles.'
        )
        
        // Builder
        createResult(test, 'BUILDER', '🔨', 'The Builder',
            'You are driven by creating and improving systems. You love practical applications and hands-on work.',
            'Practical problem-solving, systems thinking, implementation-focused.',
            'Engineering, Design, Product Development, Architecture',
            'Focus on practical applications and hands-on projects. Provide tools and frameworks for building.'
        )
        
        // Empath
        createResult(test, 'EMPATH', '❤️', 'The Empath',
            'You are driven by understanding and helping people. You care deeply about human impact and emotional connections.',
            'Emotional intelligence, people-focused, impact-oriented.',
            'Medicine, Psychology, Education, Social Work, Counseling',
            'Focus on human impact and emotional connections. Provide case studies and real-world applications.'
        )
        
        // Challenger
        createResult(test, 'CHALLENGER', '⚔️', 'The Challenger',
            'You are driven by questioning assumptions and finding flaws. You love critical thinking and debate.',
            'Critical thinking, analytical reasoning, debate skills.',
            'Law, Journalism, Philosophy, Consulting, Research',
            'Focus on critical analysis and debate. Provide challenging questions and counterarguments.'
        )
        
        log.info "Curiosity Compass results initialized successfully"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String summary, String strengths, String bestMatches, String aiRoadmap) {
        def result = new DiagnosticResult(
            test: test,
            resultId: resultId,
            resultTitle: title,
            emoji: emoji,
            summary: summary,
            strengths: strengths,
            bestMatches: bestMatches,
            aiRoadmap: aiRoadmap
        )
        result.save(flush: true)
    }
}


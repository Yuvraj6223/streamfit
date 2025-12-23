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
                testName: 'Curiosity Game',
                testType: 'CAREER',
                description: '',
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

        createQuestion(test, 1, 'You see a documentary about ancient civilizations',
            [
                [text: '🧠 How society evolved', value: 'A'],
                [text: '🔨 How they built', value: 'B'],
                [text: '❤️ How they felt', value: 'C'],
                [text: '🤔 Is it true', value: 'D']
            ]
        )

        createQuestion(test, 2, 'You hear about a new science experiment',
            [
                [text: '🧠 Why it works', value: 'A'],
                [text: '🔧 How to improve', value: 'B'],
                [text: '🌍 Who it helps', value: 'C'],
                [text: '❓ What they assumed', value: 'D']
            ]
        )

        createQuestion(test, 3, 'You are reading an article right now',
            [
                [text: '🧩 Trace the logic', value: 'A'],
                [text: '⚡ How to apply', value: 'B'],
                [text: '🌍 Think about impact', value: 'C'],
                [text: '💭 Find the flaws', value: 'D']
            ]
        )

        createQuestion(test, 4, 'You are in a debate right now',
            [
                [text: '📚 Clarify the concepts', value: 'A'],
                [text: '💡 Suggest better models', value: 'B'],
                [text: '🌍 Real world consequences', value: 'C'],
                [text: '⚔️ Challenge the flaws', value: 'D']
            ]
        )

        createQuestion(test, 5, 'Which teacher style works best for you',
            [
                [text: '🧠 Deep concepts', value: 'A'],
                [text: '🔧 Practical tools', value: 'B'],
                [text: '❤️ Emotional connection', value: 'C'],
                [text: '💭 Critical thinking', value: 'D']
            ]
        )

        createQuestion(test, 6, 'Most frustrating thing when you are learning',
            [
                [text: '😑 Shallow arguments', value: 'A'],
                [text: '🐌 Inefficient systems', value: 'B'],
                [text: '💔 People not caring', value: 'C'],
                [text: '🤦 Over simplified stuff', value: 'D']
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


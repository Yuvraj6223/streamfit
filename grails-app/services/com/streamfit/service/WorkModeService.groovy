package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class WorkModeService {

    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        def soloCount = 0
        def teamCount = 0
        def structuredCount = 0
        def flexibleCount = 0
        
        responses.each { response ->
            // Questions 1, 3, 4 map to Solo vs Team
            if (response.question.scoringDimension == 'SOLO_VS_TEAM') {
                if (response.answerValue == 'A') soloCount++
                else teamCount++
            }
            // Questions 2, 5 map to Structured vs Flexible
            if (response.question.scoringDimension == 'STRUCTURED_VS_FLEXIBLE') {
                if (response.answerValue == 'A') structuredCount++
                else flexibleCount++
            }
        }
        
        def workStyle = determineWorkStyle(soloCount > teamCount, structuredCount > flexibleCount)
        def result = DiagnosticResult.findByTestAndResultId(session.test, workStyle)
        
        return [
            resultType: workStyle,
            resultTitle: result?.resultTitle ?: workStyle,
            resultSummary: result?.summary ?: '',
            scoreBreakdown: [
                solo: soloCount,
                team: teamCount,
                structured: structuredCount,
                flexible: flexibleCount,
                workStyle: workStyle
            ],
            emoji: result?.emoji,
            profile: result?.profile,
            strengths: result?.strengths,
            bestMatches: result?.bestMatches,
            aiRoadmap: result?.aiRoadmap
        ]
    }
    
    private String determineWorkStyle(boolean isSolo, boolean isStructured) {
        if (isSolo && isStructured) return 'STRUCTURED_SOLOIST'
        if (!isSolo && isStructured) return 'STRUCTURED_COLLABORATOR'
        if (!isSolo && !isStructured) return 'FREEFORM_EXPLORER'
        return 'CHAOTIC_CREATIVE'
    }
    
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('WORK_MODE')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'WORK_MODE',
                testName: 'Work Style Game',
                testType: 'CAREER',
                description: '',
                questionCount: 5,
                estimatedMinutes: 2,
                isActive: true
            ).save(flush: true)
        }
        
        if (DiagnosticQuestion.findAllByTest(test)) {
            log.info "Work Mode questions already exist"
            return
        }
        
        createQuestion(test, 1, 'SOLO_VS_TEAM', 'You get a group assignment suddenly',
            ['👤 Work alone better', '🤝 Work with team'])

        createQuestion(test, 2, 'STRUCTURED_VS_FLEXIBLE', 'When you start tasks you prefer to',
            ['📋 Make fixed plan', '🌊 Go with flow'])

        createQuestion(test, 3, 'SOLO_VS_TEAM', 'Your best assignment would feel like this',
            ['👤 Individual work only', '🤝 Group brainstorm together'])

        createQuestion(test, 4, 'SOLO_VS_TEAM', 'You are stuck on a hard problem',
            ['🤐 Keep trying quietly', '💬 Talk it out'])

        createQuestion(test, 5, 'STRUCTURED_VS_FLEXIBLE', 'Your study session works best when it is',
            ['⏰ Timed and planned', '🌊 Spontaneous and flowing'])
        
        log.info "Work Mode questions initialized"
    }
    
    private void createQuestion(DiagnosticTest test, Integer number, String dimension, String text, List<String> optionTexts) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "WORK_MODE_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'MULTIPLE_CHOICE',
            scoringDimension: dimension
        ).save(flush: true)
        
        ['A', 'B'].eachWithIndex { value, index ->
            new DiagnosticQuestionOption(
                question: question,
                optionText: optionTexts[index],
                optionValue: value,
                displayOrder: index + 1
            ).save(flush: true)
        }
    }
    
    def initializeResults() {
        def test = DiagnosticTest.findByTestId('WORK_MODE')
        if (!test || DiagnosticResult.findAllByTest(test)) {
            log.info "Work Mode results already exist or test not found"
            return
        }
        
        createResult(test, 'STRUCTURED_SOLOIST', '🎯', 'Structured Soloist',
            'You prefer working independently with clear plans and structure.',
            'Self-motivated, organized, focused.',
            'Research, Medicine, Individual Projects',
            'Provide structured learning paths with clear milestones.')
        
        createResult(test, 'STRUCTURED_COLLABORATOR', '🤝', 'Structured Collaborator',
            'You thrive in team environments with clear roles and processes.',
            'Team player, organized, collaborative.',
            'Management, Engineering Teams, Corporate',
            'Provide collaborative projects with defined structures.')
        
        createResult(test, 'FREEFORM_EXPLORER', '🌊', 'Freeform Explorer',
            'You love exploring ideas organically with others, without rigid structure.',
            'Creative, adaptable, collaborative.',
            'Design, Startups, Innovation',
            'Provide open-ended projects and collaborative exploration.')
        
        createResult(test, 'CHAOTIC_CREATIVE', '🎨', 'Chaotic Creative',
            'You work best alone with complete freedom to explore and create.',
            'Highly creative, independent, innovative.',
            'Media, Branding, Art, Entrepreneurship',
            'Provide creative freedom and minimal structure.')
        
        log.info "Work Mode results initialized"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String summary, String strengths, String bestMatches, String aiRoadmap) {
        new DiagnosticResult(
            test: test, resultId: resultId, resultTitle: title, emoji: emoji,
            summary: summary, strengths: strengths, bestMatches: bestMatches, aiRoadmap: aiRoadmap
        ).save(flush: true)
    }
}


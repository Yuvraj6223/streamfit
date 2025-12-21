package com.streamfit.service

import com.streamfit.diagnostic.*
import grails.gorm.transactions.Transactional

@Transactional
class ChallengeDriverService {

    def calculateResults(DiagnosticTestSession session) {
        def responses = DiagnosticResponse.findAllBySession(session)
        
        def competitionCount = 0
        def challengeCount = 0
        def recognitionCount = 0
        def impactCount = 0
        
        responses.each { response ->
            switch (response.answerValue) {
                case 'A': competitionCount++; break
                case 'B': challengeCount++; break
                case 'C': recognitionCount++; break
                case 'D': impactCount++; break
            }
        }
        
        def scores = [
            COMPETITION: competitionCount,
            CHALLENGE: challengeCount,
            RECOGNITION: recognitionCount,
            IMPACT: impactCount
        ]
        
        def dominantDriver = scores.max { it.value }.key
        def result = DiagnosticResult.findByTestAndResultId(session.test, dominantDriver)
        
        return [
            resultType: dominantDriver,
            resultTitle: result?.resultTitle ?: dominantDriver,
            resultSummary: result?.summary ?: '',
            scoreBreakdown: scores + [dominantDriver: dominantDriver],
            emoji: result?.emoji,
            profile: result?.profile,
            strengths: result?.strengths,
            bestMatches: result?.bestMatches,
            aiRoadmap: result?.aiRoadmap
        ]
    }
    
    def initializeQuestions() {
        def test = DiagnosticTest.findByTestId('CHALLENGE_DRIVER')
        if (!test) {
            test = new DiagnosticTest(
                testId: 'CHALLENGE_DRIVER',
                testName: 'Challenge Driver',
                testType: 'CAREER',
                description: 'Identifies your core motivational pattern',
                questionCount: 5,
                estimatedMinutes: 2,
                isActive: true
            ).save(flush: true)
        }
        
        if (DiagnosticQuestion.findAllByTest(test)) {
            log.info "Challenge Driver questions already exist"
            return
        }
        
        createQuestion(test, 1, 'When you win, what\'s most satisfying?',
            ['Being better than others', 'Conquering a hard problem', 'Being praised or awarded', 'Making a difference'])
        
        createQuestion(test, 2, 'You join a team project. You want...',
            ['To outperform peers', 'To solve the core issue', 'To be seen as valuable', 'To do something meaningful'])
        
        createQuestion(test, 3, 'You\'re told a task is really hard. Your first reaction?',
            ['"I\'ll still beat them."', '"Bring it on."', '"Can I showcase it later?"', '"Is it worth doing?"'])
        
        createQuestion(test, 4, 'You\'re given a platform...',
            ['You want to win debates', 'You want problem-solving games', 'You want spotlight and approval', 'You want to speak for others'])
        
        createQuestion(test, 5, 'Motivation lasts longest when...',
            ['There\'s rivalry', 'It\'s intellectually hard', 'There\'s recognition', 'The outcome matters to people'])
        
        log.info "Challenge Driver questions initialized"
    }
    
    private void createQuestion(DiagnosticTest test, Integer number, String text, List<String> optionTexts) {
        def question = new DiagnosticQuestion(
            test: test,
            questionId: "CHALLENGE_DRIVER_Q${number}",
            questionText: text,
            questionNumber: number,
            questionType: 'MULTIPLE_CHOICE',
            scoringDimension: 'MOTIVATION_TYPE'
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
        def test = DiagnosticTest.findByTestId('CHALLENGE_DRIVER')
        if (!test || DiagnosticResult.findAllByTest(test)) {
            log.info "Challenge Driver results already exist or test not found"
            return
        }
        
        createResult(test, 'COMPETITION', '🏆', 'Competition Driven',
            'You are motivated by winning and being the best. You thrive in competitive environments.',
            'Highly competitive, driven to excel, performs well under pressure.',
            'CAT, Law, Trading, Competitive Exams',
            'Gamify learning with leaderboards and competitive challenges.')
        
        createResult(test, 'CHALLENGE', '🧩', 'Challenge Driven',
            'You are motivated by solving difficult problems. You love intellectual challenges.',
            'Problem-solver, intellectually curious, enjoys complexity.',
            'STEM, Puzzles, Olympiads, Research',
            'Provide increasingly difficult problems and intellectual challenges.')
        
        createResult(test, 'RECOGNITION', '⭐', 'Recognition Driven',
            'You are motivated by praise and acknowledgment. You want your work to be seen and appreciated.',
            'Seeks validation, performs well when recognized, creative.',
            'Media, Design, Content Creation, Performance',
            'Provide regular feedback, showcase achievements, and public recognition.')
        
        createResult(test, 'IMPACT', '🌍', 'Impact Driven',
            'You are motivated by making a difference. You want your work to matter and help others.',
            'Purpose-driven, empathetic, socially conscious.',
            'UPSC, Social Sciences, Public Health, NGO Work',
            'Connect learning to real-world impact and social change.')
        
        log.info "Challenge Driver results initialized"
    }
    
    private void createResult(DiagnosticTest test, String resultId, String emoji, String title, 
                              String summary, String strengths, String bestMatches, String aiRoadmap) {
        new DiagnosticResult(
            test: test, resultId: resultId, resultTitle: title, emoji: emoji,
            summary: summary, strengths: strengths, bestMatches: bestMatches, aiRoadmap: aiRoadmap
        ).save(flush: true)
    }
}


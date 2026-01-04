package com.streamfit.controller

import com.streamfit.service.DiagnosticService
import com.streamfit.service.UserService
// import com.streamfit.service.RewardService // Disabled - reward system no longer available
import grails.converters.JSON

class DashboardController {

    DiagnosticService diagnosticService
    UserService userService
    // RewardService rewardService // Disabled - reward system no longer available
    
    /**
     * Main dashboard page
     * GET /dashboard
     */
    def index() {
        def user = userService.getOrCreateAnonymousUser()

        def testHistory = diagnosticService.getUserTestHistory(user)
        def completedSessions = testHistory.findAll { it.status == 'COMPLETED' && it.gameResults?.gameResults }.sort { a, b -> b.startTime <=> a.startTime }
        
        def availableTests = diagnosticService.getAvailableTests()
        
        // Get the latest result for each game type
        def latestGameResults = [:]
        completedSessions.each { session ->
            session.gameResults.gameResults.each { gameType, result ->
                if (!latestGameResults.containsKey(gameType)) {
                    latestGameResults[gameType] = [result: result, session: session]
                }
            }
        }

        def completedTestIds = latestGameResults.keySet()

        def completedTestResults = []
        def pendingTests = []

        availableTests.each { test ->
            if (test.testId in completedTestIds) {
                def resultData = latestGameResults[test.testId]
                completedTestResults << [
                    session: [sessionId: resultData.session.sessionId, completedAt: resultData.session.endTime],
                    result: [
                        testName: test.testName,
                        emoji: '✨', // Placeholder, GSP seems to expect it
                        resultTitle: resultData.result.resultType?.toString()?.toLowerCase()?.replace('_', ' ')?.capitalize()
                    ]
                ]
            } else {
                pendingTests << test
            }
        }

        def stats = [
            totalTests: availableTests.size(),
            totalTestsCompleted: completedTestIds.size()
        ]
        
        def spiritAnimalResult = latestGameResults['SPIRIT_ANIMAL']?.result
        def cognitiveRadarResult = latestGameResults['COGNITIVE_RADAR']?.result
        def workModeResult = latestGameResults['WORK_MODE']?.result

        def model = [
            user: user,
            stats: stats,
            completedTestResults: completedTestResults,
            pendingTests: pendingTests,
            spiritAnimal: spiritAnimalResult ? [
                resultType: spiritAnimalResult.resultType,
                resultTitle: spiritAnimalResult.resultType?.toString()?.toLowerCase()?.replace('_', ' ')?.capitalize(),
                resultSummary: "Your unique strengths are becoming clear.", // Placeholder summary
                scoreBreakdown: [
                    primaryTrait: spiritAnimalResult.primaryTrait,
                    secondaryTrait: spiritAnimalResult.secondaryTrait
                ]
            ] : null,
            cognitiveRadar: cognitiveRadarResult ? [
                 scoreBreakdown: cognitiveRadarResult.scores.collectEntries{ k, v -> [k.toString().toLowerCase(), v] },
                 primaryPillar: cognitiveRadarResult.primaryPillar
            ] : null,
            workMode: workModeResult ? [
                resultTitle: workModeResult.resultType?.toString()?.toLowerCase()?.replace('_', ' ')?.capitalize()
            ] : null,
            suggestedStreams: null // Let GSP calculate it
        ]

        [model: model]
    }

    /**
     * Get dashboard data
     * GET /api/dashboard/data
     */
    def data() {
        try {
            def user = userService.getOrCreateAnonymousUser()
            
            // Get test history
            def testHistory = diagnosticService.getUserTestHistory(user)
            
            // Get user stats (without rewards)
            def userStats = userService.getUserStats(user)
            
            // Calculate completion stats
            def examTestsCompleted = testHistory.findAll { it.status == 'COMPLETED' }.size()
            def careerTestsCompleted = testHistory.findAll { it.status == 'COMPLETED' }.size()
            def totalCompleted = examTestsCompleted + careerTestsCompleted

            response.status = 200
            render([
                user: [
                    userId: user.userId,
                    name: user.name,
                    stats: userStats
                ],
                testHistory: testHistory,
                points: [
                    totalPoints: 0,
                    level: "Beginner",
                    progressToNext: 0
                ],
                badges: [],
                achievements: [],
                stats: [
                    examTestsCompleted: examTestsCompleted,
                    careerTestsCompleted: careerTestsCompleted,
                    totalCompleted: totalCompleted,
                    completionPercentage: userStats.completionPercentage
                ]
            ] as JSON)
        } catch (Exception e) {
            log.error "Error fetching dashboard data: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch dashboard data'] as JSON)
        }
    }
}


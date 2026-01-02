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

        [user: user]
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


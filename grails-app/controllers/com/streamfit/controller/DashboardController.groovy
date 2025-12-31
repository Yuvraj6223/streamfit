package com.streamfit.controller

import com.streamfit.service.DiagnosticService
import com.streamfit.service.UserService
import com.streamfit.service.RewardService
import grails.converters.JSON

class DashboardController {

    DiagnosticService diagnosticService
    UserService userService
    RewardService rewardService
    
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
            
            // Get points and level
            def pointsInfo = rewardService.getUserPointsInfo(user)
            
            // Get badges
            def badges = rewardService.getUserBadges(user)
            
            // Get achievements
            def achievements = rewardService.getUserAchievements(user)
            
            // Calculate completion stats
            def examTestsCompleted = testHistory.findAll { it.testType == 'EXAM' && it.status == 'COMPLETED' }.size()
            def careerTestsCompleted = testHistory.findAll { it.testType == 'CAREER' && it.status == 'COMPLETED' }.size()
            def totalCompleted = examTestsCompleted + careerTestsCompleted

            response.status = 200
            render([
                success: true,
                user: [
                    userId: user.userId,
                    name: user.name ?: 'Anonymous User'
                ],
                stats: [
                    totalTestsCompleted: totalCompleted,
                    examTestsCompleted: examTestsCompleted,
                    careerTestsCompleted: careerTestsCompleted,
                    totalPoints: pointsInfo.totalPoints,
                    currentLevel: pointsInfo.currentLevel,
                    pointsToNextLevel: pointsInfo.pointsToNextLevel,
                    currentStreak: pointsInfo.currentStreak,
                    longestStreak: pointsInfo.longestStreak,
                    badgesEarned: badges.size(),
                    achievementsUnlocked: achievements.size()
                ],
                testResults: testHistory,
                badges: badges.collect { userBadge ->
                    [
                        badgeId: userBadge.badge.badgeId,
                        badgeName: userBadge.badge.badgeName,
                        emoji: userBadge.badge.emoji,
                        category: userBadge.badge.category,
                        rarity: userBadge.badge.rarity,
                        earnedAt: userBadge.earnedAt,
                        isNew: userBadge.isNew
                    ]
                },
                achievements: achievements.collect { achievement ->
                    [
                        achievementType: achievement.achievementType,
                        achievementTitle: achievement.achievementTitle,
                        achievementDescription: achievement.achievementDescription,
                        emoji: achievement.emoji,
                        pointsAwarded: achievement.pointsAwarded,
                        achievedAt: achievement.achievedAt
                    ]
                }
            ] as JSON)
        } catch (Exception e) {
            log.error "Error fetching dashboard data: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch dashboard data'] as JSON)
        }
    }
}


package com.streamfit.service

import com.streamfit.user.User
import com.streamfit.reward.*
import com.streamfit.diagnostic.DiagnosticTestSession
import grails.gorm.transactions.Transactional

@Transactional
class RewardService {

    /**
     * Award points to a user
     */
    def awardPoints(User user, Integer points, String reason = null) {
        def userPoints = UserPoints.findByUser(user)
        
        if (!userPoints) {
            userPoints = new UserPoints(user: user, totalPoints: 0, currentLevel: 1)
        }
        
        userPoints.totalPoints += points
        def oldLevel = userPoints.currentLevel
        userPoints.currentLevel = userPoints.calculateLevel()
        userPoints.lastActivityDate = new Date()
        
        // Update streak
        updateStreak(userPoints)
        
        userPoints.save(flush: true)
        
        // Check if user leveled up
        def leveledUp = userPoints.currentLevel > oldLevel
        
        return [
            success: true,
            pointsAwarded: points,
            totalPoints: userPoints.totalPoints,
            currentLevel: userPoints.currentLevel,
            leveledUp: leveledUp,
            pointsToNextLevel: userPoints.getPointsToNextLevel(),
            reason: reason
        ]
    }
    
    /**
     * Award a badge to a user
     */
    def awardBadge(User user, String badgeId) {
        def badge = Badge.findByBadgeId(badgeId)
        
        if (!badge) {
            return [success: false, error: 'Badge not found']
        }
        
        // Check if user already has this badge
        def existingBadge = UserBadge.findByUserAndBadge(user, badge)
        if (existingBadge) {
            return [success: false, error: 'Badge already earned']
        }
        
        // Award the badge
        def userBadge = new UserBadge(
            user: user,
            badge: badge,
            earnedAt: new Date(),
            isNew: true
        ).save(flush: true)
        
        // Award points for the badge
        awardPoints(user, badge.pointsValue, "Earned badge: ${badge.badgeName}")
        
        return [
            success: true,
            badge: badge,
            userBadge: userBadge
        ]
    }
    
    /**
     * Process rewards after test completion
     */
    def processTestCompletionRewards(User user, DiagnosticTestSession session) {
        def rewards = [
            badges: [],
            achievements: [],
            points: 0,
            leveledUp: false,
            newLevel: 0
        ]
        
        // Base points for completing test
        def basePoints = 50
        def pointsResult = awardPoints(user, basePoints, "Completed ${session.test.testName}")
        rewards.points = basePoints
        rewards.leveledUp = pointsResult.leveledUp
        rewards.newLevel = pointsResult.currentLevel
        
        // Check for test-specific badge
        def testBadgeId = "COMPLETE_${session.test.testId}"
        def testBadge = Badge.findByBadgeId(testBadgeId)
        if (testBadge) {
            def badgeResult = awardBadge(user, testBadgeId)
            if (badgeResult.success) {
                rewards.badges << badgeResult.badge
            }
        }
        
        // Check for milestone achievements
        checkMilestoneAchievements(user, session, rewards)
        
        // Check for streak achievements
        checkStreakAchievements(user, rewards)
        
        return rewards
    }
    
    /**
     * Check and award milestone achievements
     */
    private void checkMilestoneAchievements(User user, DiagnosticTestSession session, Map rewards) {
        def completedTests = DiagnosticTestSession.countByUserAndStatus(user, 'COMPLETED')
        
        // First test achievement
        if (completedTests == 1) {
            def achievement = createAchievement(user, 'FIRST_TEST', 
                '🎯 First Steps', 'Completed your first diagnostic test!', '🎯', 100)
            rewards.achievements << achievement
            awardPoints(user, 100, 'First test achievement')
        }
        
        // 5 tests achievement
        if (completedTests == 5) {
            def achievement = createAchievement(user, 'FIVE_TESTS', 
                '⭐ Explorer', 'Completed 5 diagnostic tests!', '⭐', 250)
            rewards.achievements << achievement
            awardPoints(user, 250, '5 tests achievement')
        }
        
        // All exam tests achievement
        def examTestsCompleted = DiagnosticTestSession.createCriteria().count {
            eq('user', user)
            eq('status', 'COMPLETED')
            test {
                eq('testType', 'EXAM')
            }
        }
        if (examTestsCompleted == 4) {
            def achievement = createAchievement(user, 'ALL_EXAM_TESTS',
                '🎓 Exam Master', 'Completed all exam diagnostic tests!', '🎓', 500)
            rewards.achievements << achievement
            awardPoints(user, 500, 'All exam tests achievement')
        }

        // All career tests achievement
        def careerTestsCompleted = DiagnosticTestSession.createCriteria().count {
            eq('user', user)
            eq('status', 'COMPLETED')
            test {
                eq('testType', 'CAREER')
            }
        }
        if (careerTestsCompleted == 5) {
            def achievement = createAchievement(user, 'ALL_CAREER_TESTS',
                '🚀 Career Navigator', 'Completed all career diagnostic tests!', '🚀', 500)
            rewards.achievements << achievement
            awardPoints(user, 500, 'All career tests achievement')
        }
        
        // All tests achievement
        if (completedTests == 9) {
            def achievement = createAchievement(user, 'ALL_TESTS', 
                '👑 Complete Profile', 'Completed all diagnostic tests!', '👑', 1000)
            rewards.achievements << achievement
            awardPoints(user, 1000, 'All tests achievement')
        }
    }
    
    /**
     * Check and award streak achievements
     */
    private void checkStreakAchievements(User user, Map rewards) {
        def userPoints = UserPoints.findByUser(user)
        
        if (userPoints.currentStreak == 3) {
            def achievement = createAchievement(user, 'STREAK_3', 
                '🔥 On Fire', '3-day streak!', '🔥', 150)
            rewards.achievements << achievement
            awardPoints(user, 150, '3-day streak')
        }
        
        if (userPoints.currentStreak == 7) {
            def achievement = createAchievement(user, 'STREAK_7', 
                '⚡ Unstoppable', '7-day streak!', '⚡', 300)
            rewards.achievements << achievement
            awardPoints(user, 300, '7-day streak')
        }
        
        if (userPoints.currentStreak == 30) {
            def achievement = createAchievement(user, 'STREAK_30', 
                '💎 Diamond Dedication', '30-day streak!', '💎', 1000)
            rewards.achievements << achievement
            awardPoints(user, 1000, '30-day streak')
        }
    }
    
    /**
     * Create an achievement
     */
    private Achievement createAchievement(User user, String type, String title, String description, String emoji, Integer points) {
        // Check if achievement already exists
        def existing = Achievement.findByUserAndAchievementType(user, type)
        if (existing) {
            return existing
        }
        
        return new Achievement(
            user: user,
            achievementType: type,
            achievementTitle: title,
            achievementDescription: description,
            emoji: emoji,
            pointsAwarded: points,
            achievedAt: new Date()
        ).save(flush: true)
    }
    
    /**
     * Update user's streak
     */
    private void updateStreak(UserPoints userPoints) {
        def today = clearTime(new Date())
        def lastActivity = userPoints.lastActivityDate ? clearTime(userPoints.lastActivityDate) : null

        if (!lastActivity) {
            // First activity
            userPoints.currentStreak = 1
            userPoints.longestStreak = 1
        } else {
            // Calculate days difference
            long diffInMillis = today.getTime() - lastActivity.getTime()
            long daysDiff = diffInMillis / (1000 * 60 * 60 * 24)

            if (daysDiff == 0) {
                // Same day, no change
                return
            } else if (daysDiff == 1) {
                // Consecutive day
                userPoints.currentStreak++
                if (userPoints.currentStreak > userPoints.longestStreak) {
                    userPoints.longestStreak = userPoints.currentStreak
                }
            } else {
                // Streak broken
                userPoints.currentStreak = 1
            }
        }
    }

    /**
     * Helper method to clear time from a date
     */
    private Date clearTime(Date date) {
        if (!date) return null
        Calendar cal = Calendar.getInstance()
        cal.setTime(date)
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        return cal.getTime()
    }
    
    /**
     * Get user's badges
     */
    def getUserBadges(User user) {
        return UserBadge.findAllByUser(user, [sort: 'earnedAt', order: 'desc'])
    }
    
    /**
     * Get user's achievements
     */
    def getUserAchievements(User user) {
        return Achievement.findAllByUser(user, [sort: 'achievedAt', order: 'desc'])
    }
    
    /**
     * Get user's points and level info
     */
    def getUserPointsInfo(User user) {
        def userPoints = UserPoints.findByUser(user)
        
        if (!userPoints) {
            userPoints = new UserPoints(user: user).save(flush: true)
        }
        
        return [
            totalPoints: userPoints.totalPoints,
            currentLevel: userPoints.currentLevel,
            pointsToNextLevel: userPoints.getPointsToNextLevel(),
            currentStreak: userPoints.currentStreak,
            longestStreak: userPoints.longestStreak
        ]
    }
    
    /**
     * Initialize default badges
     */
    def initializeDefaultBadges() {
        // Test completion badges
        createBadgeIfNotExists('COMPLETE_SPIRIT_ANIMAL', '🦉 Spirit Animal Explorer', 
            'Completed the Spirit Animal diagnostic', '🦉', 'EXAM', 'COMMON', 50, 'SPIRIT_ANIMAL')
        
        createBadgeIfNotExists('COMPLETE_COGNITIVE_RADAR', '🧠 Cognitive Master', 
            'Completed the Cognitive Radar test', '🧠', 'EXAM', 'COMMON', 50, 'COGNITIVE_RADAR')
        
        createBadgeIfNotExists('COMPLETE_FOCUS_STAMINA', '⚡ Focus Champion', 
            'Completed the Focus Stamina test', '⚡', 'EXAM', 'COMMON', 50, 'FOCUS_STAMINA')
        
        createBadgeIfNotExists('COMPLETE_GUESSWORK_QUOTIENT', '🎲 Risk Analyst', 
            'Completed the Guesswork Quotient test', '🎲', 'EXAM', 'COMMON', 50, 'GUESSWORK_QUOTIENT')
        
        createBadgeIfNotExists('COMPLETE_CURIOSITY_COMPASS', '🧭 Curiosity Seeker', 
            'Completed the Curiosity Compass test', '🧭', 'CAREER', 'COMMON', 50, 'CURIOSITY_COMPASS')
        
        createBadgeIfNotExists('COMPLETE_MODALITY_MAP', '🎨 Learning Style Expert', 
            'Completed the Modality Map test', '🎨', 'CAREER', 'COMMON', 50, 'MODALITY_MAP')
        
        createBadgeIfNotExists('COMPLETE_CHALLENGE_DRIVER', '🏆 Motivation Master', 
            'Completed the Challenge Driver test', '🏆', 'CAREER', 'COMMON', 50, 'CHALLENGE_DRIVER')
        
        createBadgeIfNotExists('COMPLETE_WORK_MODE', '💼 Work Style Pro', 
            'Completed the Work Mode test', '💼', 'CAREER', 'COMMON', 50, 'WORK_MODE')
        
        createBadgeIfNotExists('COMPLETE_PATTERN_SNAPSHOT', '🔍 Pattern Detective', 
            'Completed the Pattern Snapshot test', '🔍', 'CAREER', 'COMMON', 50, 'PATTERN_SNAPSHOT')
    }
    
    private void createBadgeIfNotExists(String badgeId, String name, String description, 
                                       String emoji, String category, String rarity, 
                                       Integer points, String testId = null) {
        if (!Badge.findByBadgeId(badgeId)) {
            new Badge(
                badgeId: badgeId,
                badgeName: name,
                badgeDescription: description,
                emoji: emoji,
                category: category,
                rarity: rarity,
                pointsValue: points,
                requiredTestId: testId,
                unlockCondition: description
            ).save(flush: true)
        }
    }
}


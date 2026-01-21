package com.streamfit.controller

import com.streamfit.service.DiagnosticService
import com.streamfit.service.UnifiedPersonaService
import com.streamfit.service.UserService
import org.springframework.data.redis.core.RedisTemplate
import grails.converters.JSON
import java.util.Date
import java.text.SimpleDateFormat

class DashboardController {

    DiagnosticService diagnosticService
    UserService userService
    UnifiedPersonaService unifiedPersonaService
    RedisTemplate<String, Object> redisTemplate

    /**
     * Main dashboard page
     * GET /dashboard
     * Requires: JWT authentication or session
     */
    def index() {
        // Get user from JWT or session
        def userId = request.getAttribute('userId') as String
        def sessionId = request.getAttribute('sessionId') as String

        if (!userId && !session.userId) {
            // Not authenticated, redirect to login
            redirect(controller: 'auth', action: 'login')
            return
        }

        // Use JWT user if available, otherwise use session user
        userId = userId ?: session.userId

        def user = session.userId ? userService.getUserById(session.userId) : userService.getOrCreateAnonymousUser(session)
        if (!user) {
            flash.error = "User not found"
            redirect(controller: 'auth', action: 'login')
            return
        }

        def testHistory = diagnosticService.getUserTestHistory(user)
        def completedSessions = testHistory.findAll { it.status == 'COMPLETED' && it.gameResults }.sort { a, b -> b.startTime <=> a.startTime }
        
        def availableTests = diagnosticService.getAvailableTests()
        
        // Get the latest result for each game type
        def latestGameResults = [:]
        completedSessions.each { session ->
            session.gameResults.each { gameType, result ->
                // FIX: Corrected typo from latestGameGresults to latestGameResults
                if (!latestGameResults.containsKey(gameType)) {
                    latestGameResults[gameType] = [result: result, session: session]
                }
            }
        }

        def completedTestIds = latestGameResults.keySet()

        def completedTestResults = []
        def pendingTests = []

        def personaEmojiMap = [
            // SPIRIT_ANIMAL
            'WISE_OWL': '🦉', 'DISCIPLINED_BEE': '🐝', 'STRATEGIC_WOLF': '🐺', 'BOLD_TIGER': '🐯',
            // COGNITIVE_RADAR
            'ANALYTICAL_DIAMOND': '💎', 'VERBAL_VIRTUOSO': '✍️', 'PRECISE_PROCESSOR': '⚡', 'VISUAL_VISIONARY': '🎨',
            'COGNITIVE_LOGIC': '💎', 'COGNITIVE_VERBAL': '✍️', 'COGNITIVE_SPATIAL': '🎨', 'COGNITIVE_SPEED': '⚡',
            // CURIOSITY_COMPASS
            'THEORIST': '🔬', 'BUILDER': '🛠️', 'EMPATH': '💝', 'CHALLENGER': '🔥',
            // FOCUS_STAMINA
            'MARATHONER': '🏃', 'SPRINTER': '⚡', 'SAFE_PLAYER': '🛡️', 'QUITTER': '🚀',
            // GUESSWORK_QUOTIENT
            'BALANCED_STRATEGIST': '⚖️', 'HIGH_ROLLER': '🎰', 'UNDER_ESTIMATOR': '💎', 'HESITANT_SEARCHER': '🔍',
            // MODALITY_MAP
            'VISUAL': '👁️', 'AUDITORY': '🎧', 'KINESTHETIC': '🤲', 'CONCEPTUAL': '💭',
            // PATTERN_SNAPSHOT
            'VERBAL': '📝', 'NUMERIC': '🔢',
            // WORK_MODE
            'STRUCTURED_SOLOIST': '🎯', 'STRUCTURED_COLLABORATOR': '👥', 'FREEFORM_EXPLORER': '🌊', 'CHAOTIC_CREATIVE': '🎪',
            // PERSONALITY
            'EXTROVERT': '🦋', 'INTROVERT': '🌙'
        ]

        availableTests.each { test ->
            if (test.testId in completedTestIds) {
                def resultData = latestGameResults[test.testId]
                
                def endTime = resultData.session.endTime
                def completedAt

                if (endTime == null) {
                    completedAt = null
                } else if (endTime instanceof java.sql.Timestamp) {
                    completedAt = new Date(endTime.getTime())
                } else if (endTime instanceof String) {
                    try {
                        // Use Java's SimpleDateFormat to avoid Groovy's casting behavior
                        def sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
                        completedAt = sdf.parse(endTime)
                    } catch (Exception e) {
                        log.error("Could not parse 'completedAt' date from string: ${endTime}", e)
                        completedAt = null
                    }
                } else if (endTime instanceof Date) {
                    completedAt = endTime
                } else {
                    log.warn("Unhandled type for 'completedAt': ${endTime.getClass().getName()}")
                    completedAt = null // Fallback to null for unhandled types
                }

                def resultType = resultData.result.resultType?.toString()
                def resultTitle = resultType?.toString()?.toLowerCase()?.replace('_', ' ')?.capitalize()
                def resultKey = resultType // Default to the existing resultType

                if (test.testId == 'COGNITIVE_RADAR') {
                    def pillar = resultData.result.primaryPillar?.toString()
                    if (pillar == 'LOGIC') resultKey = 'ANALYTICAL_DIAMOND'
                    else if (pillar == 'VERBAL') resultKey = 'VERBAL_VIRTUOSO'
                    else if (pillar == 'SPATIAL') resultKey = 'VISUAL_VISIONARY'
                    else if (pillar == 'SPEED') resultKey = 'PRECISE_PROCESSOR'
                }

                def emoji = personaEmojiMap[resultKey] ?: personaEmojiMap[resultType] ?: '✨'

                completedTestResults << [
                    session: [sessionId: resultData.session.sessionId, completedAt: completedAt],
                    result: [
                        testName: test.testName,
                        emoji: emoji,
                        resultKey: resultKey,
                        resultTitle: resultTitle
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
        
        def spiritAnimalSummaries = [
            'WISE_OWL': "You like to understand everything deeply before moving forward. You won't start Chapter 2 until you've completely mastered Chapter 1.",
            'STRATEGIC_WOLF': "You have a good sense for finding the right answer. You're great at eliminating wrong options and using smart shortcuts.",
            'DISCIPLINED_BEE': "You love structure and routine. You believe in steady improvement and can study consistently for long periods.",
            'BOLD_TIGER': "You perform best under pressure and love competition. You're fast, bold, and thrive on challenges."
        ]
        
        def cognitiveRadarResult = latestGameResults['COGNITIVE_RADAR']?.result
        def workModeResult = latestGameResults['WORK_MODE']?.result

        def cognitiveRadarModel = cognitiveRadarResult ? [
            // FIX: Add safe navigation to prevent NPE if scores is null
            scoreBreakdown: cognitiveRadarResult.scores?.collectEntries{ k, v -> [k.toString().toLowerCase(), v] } ?: [:],
            primaryPillar: cognitiveRadarResult.primaryPillar
        ] : null

        def suggestedStreams = []
        // Business logic moved from GSP to controller/service
        // Only calculate if the panel will be shown (all tests completed)
        if (stats.totalTestsCompleted >= stats.totalTests && cognitiveRadarModel) {
            suggestedStreams = unifiedPersonaService.calculateSuggestedStreams(cognitiveRadarModel)
        }

        def model = [
            user: user,
            stats: stats,
            completedTestResults: completedTestResults,
            pendingTests: pendingTests,
            spiritAnimal: spiritAnimalResult ? [
                resultType: spiritAnimalResult.resultType,
                resultTitle: spiritAnimalResult.resultType?.toString()?.toLowerCase()?.replace('_', ' ')?.capitalize(),
                resultSummary: spiritAnimalResult.summary ?: spiritAnimalSummaries[spiritAnimalResult.resultType] ?: "Your unique strengths are becoming clear.",
                scoreBreakdown: [
                    primaryTrait: spiritAnimalResult.primaryTrait,
                    secondaryTrait: spiritAnimalResult.secondaryTrait
                ]
            ] : null,
            cognitiveRadar: cognitiveRadarModel,
            workMode: workModeResult ? [
                resultTitle: workModeResult.resultType?.toString()?.toLowerCase()?.replace('_', ' ')?.capitalize()
            ] : null,
            suggestedStreams: suggestedStreams
        ]

        [model: model, pageBodyClass: 'dashboard-body']
    }

    /**
     * Get dashboard data
     * GET /api/dashboard/data
     */
    def data() {
        try {
            // Fix: Check JWT userId first, then fall back to session
            def jwtUserId = request.getAttribute('userId') as String
            def userId = jwtUserId ?: session.userId

            def user = session.userId ? userService.getUserById(session.userId) : userService.getOrCreateAnonymousUser(session)

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
    
    /**
     * Cache statistics endpoint for monitoring
     * GET /admin/cache/stats
     */
    def cacheStats() {
        try {
            // Get Redis connection info
            def redisInfo = [:]
            try {
                def connection = redisTemplate?.connectionFactory?.connection
                if (connection) {
                    redisInfo = [
                        connected: true,
                        dbSize: connection.dbSize() ?: 0
                    ]
                } else {
                    redisInfo = [connected: false, error: 'No connection available']
                }
            } catch (Exception e) {
                redisInfo = [connected: false, error: e.message]
            }
            
            response.status = 200
            render([
                success: true,
                cache: [
                    note: 'Cache metrics tracking not enabled',
                    poolSettings: [
                        maxActive: 500,
                        maxIdle: 100,
                        minIdle: 50
                    ]
                ],
                redis: redisInfo,
                timestamp: new Date().format("yyyy-MM-dd'T'HH:mm:ss.SSSZ")
            ] as JSON)
        } catch (Exception e) {
            log.error "Error fetching cache stats: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch cache stats'] as JSON)
        }
    }
}

package com.streamfit.service

import com.streamfit.user.User
import com.streamfit.dashboard.LearningDNA
import com.streamfit.test.*
import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

@Transactional
class DashboardService {

    def testService
    
    def getLearningDNA(User user) {
        LearningDNA dna = LearningDNA.findByUser(user)
        
        if (!dna) {
            dna = new LearningDNA(
                user: user,
                coreTestsCompleted: 0,
                streamFitTestsCompleted: 0,
                isDashboardUnlocked: false,
                cognitiveScores: [:],
                motivationTraits: [:],
                topStreamSuggestions: [],
                streamFitScores: [:]
            )
            dna.save(flush: true)
        }
        
        return dna
    }
    
    def updateLearningStylePersona(User user, TestArchetype archetype) {
        LearningDNA dna = getLearningDNA(user)
        
        dna.learningStylePersona = archetype.archetypeName
        dna.learningStyleEmoji = archetype.archetypeEmoji
        dna.learningStyleDescription = archetype.description
        dna.coreTestsCompleted = (dna.coreTestsCompleted ?: 0) + 1
        
        checkAndUnlockDashboard(dna)
        dna.save(flush: true)
        
        return dna
    }
    
    def updateCognitiveSkew(User user, String dominantArea, Map<String, Double> scores) {
        LearningDNA dna = getLearningDNA(user)
        
        // Map cognitive areas to skew types
        def skewMap = [
            LOGIC: ['Analytical Diamond', '💎'],
            VERBAL: ['Linguistic Star', '⭐'],
            SPATIAL: ['Visual Architect', '🏛️'],
            SPEED: ['Quick Processor', '⚡']
        ]
        
        def skewInfo = skewMap[dominantArea] ?: ['Balanced Thinker', '⚖️']
        
        dna.cognitiveSkew = skewInfo[0]
        dna.cognitiveEmoji = skewInfo[1]
        dna.cognitiveScores = scores
        dna.coreTestsCompleted = (dna.coreTestsCompleted ?: 0) + 1
        
        checkAndUnlockDashboard(dna)
        dna.save(flush: true)
        
        return dna
    }
    
    def updateWorkStyle(User user, String workStyle, String emoji) {
        LearningDNA dna = getLearningDNA(user)
        
        dna.workStyle = workStyle
        dna.workStyleEmoji = emoji
        dna.workStyleDescription = getWorkStyleDescription(workStyle)
        dna.coreTestsCompleted = (dna.coreTestsCompleted ?: 0) + 1
        
        checkAndUnlockDashboard(dna)
        dna.save(flush: true)
        
        return dna
    }
    
    def updateStreamFitSuggestions(User user, List<String> streams) {
        LearningDNA dna = getLearningDNA(user)
        
        // Merge with existing suggestions
        def existingSuggestions = dna.topStreamSuggestions ?: []
        def allSuggestions = (existingSuggestions + streams).unique()
        
        // Keep top 3
        dna.topStreamSuggestions = allSuggestions.take(3)
        dna.streamFitTestsCompleted = (dna.streamFitTestsCompleted ?: 0) + 1
        
        checkAndUnlockDashboard(dna)
        dna.save(flush: true)
        
        return dna
    }
    
    def updateMotivationProfile(User user, Map traits) {
        LearningDNA dna = getLearningDNA(user)
        
        dna.motivationTraits = traits
        dna.motivationProfile = determineMotivationProfile(traits)
        
        dna.save(flush: true)
        return dna
    }
    
    private void checkAndUnlockDashboard(LearningDNA dna) {
        // Unlock dashboard if min 3 core + 2 streamfit tests completed
        if (dna.coreTestsCompleted >= 3 && dna.streamFitTestsCompleted >= 2) {
            dna.isDashboardUnlocked = true
        }
    }
    
    def getDashboardData(User user) {
        LearningDNA dna = getLearningDNA(user)
        
        if (!dna.isDashboardUnlocked) {
            return [
                unlocked: false,
                coreTestsCompleted: dna.coreTestsCompleted,
                streamFitTestsCompleted: dna.streamFitTestsCompleted,
                coreTestsRequired: 3,
                streamFitTestsRequired: 2,
                message: 'Complete at least 3 Core tests and 2 StreamFit tests to unlock your Learning DNA Dashboard'
            ]
        }
        
        // Get completed test sessions
        def completedSessions = testService.getCompletedTests(user)
        
        // Build comprehensive dashboard data
        return [
            unlocked: true,
            learningStyle: [
                persona: dna.learningStylePersona,
                emoji: dna.learningStyleEmoji,
                description: dna.learningStyleDescription
            ],
            cognitiveProfile: [
                skew: dna.cognitiveSkew,
                emoji: dna.cognitiveEmoji,
                scores: dna.cognitiveScores,
                radarData: buildRadarChartData(dna.cognitiveScores)
            ],
            workStyle: [
                style: dna.workStyle,
                emoji: dna.workStyleEmoji,
                description: dna.workStyleDescription
            ],
            motivation: [
                profile: dna.motivationProfile,
                traits: dna.motivationTraits
            ],
            streamFit: [
                topSuggestions: dna.topStreamSuggestions,
                scores: dna.streamFitScores,
                recommendations: buildStreamRecommendations(dna.topStreamSuggestions)
            ],
            progress: [
                coreTestsCompleted: dna.coreTestsCompleted,
                streamFitTestsCompleted: dna.streamFitTestsCompleted,
                totalTestsCompleted: completedSessions.size(),
                completionPercentage: calculateOverallCompletion(dna)
            ],
            badges: generateBadges(dna),
            shareableCard: generateShareableCard(dna)
        ]
    }
    
    private Map buildRadarChartData(Map<String, Double> scores) {
        if (!scores) return [:]
        
        return [
            labels: scores.keySet().toList(),
            datasets: [
                [
                    label: 'Your Cognitive Profile',
                    data: scores.values().toList(),
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 2
                ]
            ]
        ]
    }
    
    private List buildStreamRecommendations(List<String> streams) {
        def streamDetails = [
            'SCIENCE': [
                name: 'Science',
                icon: '🔬',
                description: 'Perfect for analytical minds who love discovery',
                careers: ['Research Scientist', 'Medical Professional', 'Biotechnologist']
            ],
            'COMMERCE': [
                name: 'Commerce',
                icon: '💼',
                description: 'Ideal for strategic thinkers and business minds',
                careers: ['Business Analyst', 'Entrepreneur', 'Financial Advisor']
            ],
            'ARTS': [
                name: 'Arts',
                icon: '🎨',
                description: 'Great for creative and expressive individuals',
                careers: ['Designer', 'Writer', 'Social Scientist']
            ],
            'ENGINEERING': [
                name: 'Engineering',
                icon: '⚙️',
                description: 'Best for problem-solvers and builders',
                careers: ['Software Engineer', 'Mechanical Engineer', 'Architect']
            ],
            'MEDICAL': [
                name: 'Medical',
                icon: '⚕️',
                description: 'For those passionate about healthcare',
                careers: ['Doctor', 'Surgeon', 'Healthcare Administrator']
            ]
        ]
        
        return streams.collect { stream ->
            streamDetails[stream] ?: [
                name: stream,
                icon: '📚',
                description: 'Explore this exciting field',
                careers: []
            ]
        }
    }
    
    private List generateBadges(LearningDNA dna) {
        def badges = []
        
        if (dna.learningStylePersona) {
            badges << [
                type: 'LEARNING_STYLE',
                emoji: dna.learningStyleEmoji,
                label: dna.learningStylePersona
            ]
        }
        
        if (dna.cognitiveSkew) {
            badges << [
                type: 'COGNITIVE',
                emoji: dna.cognitiveEmoji,
                label: dna.cognitiveSkew
            ]
        }
        
        if (dna.workStyle) {
            badges << [
                type: 'WORK_STYLE',
                emoji: dna.workStyleEmoji,
                label: dna.workStyle
            ]
        }
        
        if (dna.coreTestsCompleted >= 4) {
            badges << [
                type: 'ACHIEVEMENT',
                emoji: '🏆',
                label: 'Core Master'
            ]
        }
        
        if (dna.streamFitTestsCompleted >= 5) {
            badges << [
                type: 'ACHIEVEMENT',
                emoji: '⭐',
                label: 'Stream Explorer'
            ]
        }
        
        return badges
    }
    
    private Map generateShareableCard(LearningDNA dna) {
        return [
            title: 'My Learning DNA',
            persona: "${dna.learningStyleEmoji} ${dna.learningStylePersona}",
            cognitive: "${dna.cognitiveEmoji} ${dna.cognitiveSkew}",
            workStyle: "${dna.workStyleEmoji} ${dna.workStyle}",
            topStream: dna.topStreamSuggestions?.first(),
            shareText: "I'm a ${dna.learningStylePersona} with ${dna.cognitiveSkew} strengths! Discover your Learning DNA on StreamFit 🚀"
        ]
    }
    
    private Double calculateOverallCompletion(LearningDNA dna) {
        int totalTests = 9
        int completed = (dna.coreTestsCompleted ?: 0) + (dna.streamFitTestsCompleted ?: 0)
        return (completed / totalTests) * 100
    }
    
    private String getWorkStyleDescription(String workStyle) {
        def descriptions = [
            'Sprinter': 'You work best in short, intense bursts of focused energy',
            'Marathon Runner': 'You excel at sustained, long-term focus and dedication',
            'Burst Worker': 'You thrive with varied tasks and flexible schedules',
            'Steady Pacer': 'You maintain consistent productivity throughout'
        ]
        
        return descriptions[workStyle] ?: 'Your unique work style drives your success'
    }
    
    private String determineMotivationProfile(Map traits) {
        // Analyze traits to determine overall motivation profile
        // This is a simplified version
        if (traits.curiosity == 'HIGH' && traits.challenge == 'HIGH') {
            return 'Growth Seeker'
        } else if (traits.collaboration == 'HIGH') {
            return 'Team Player'
        } else if (traits.independence == 'HIGH') {
            return 'Self-Starter'
        } else {
            return 'Balanced Achiever'
        }
    }
}


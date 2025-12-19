package com.streamfit.service

import com.streamfit.user.User
import com.streamfit.dashboard.LearningDNA
import grails.gorm.transactions.Transactional
import groovy.json.JsonOutput

@Transactional
class UserService {

    def createOrGetUser(Map params) {
        String userId = params.userId ?: UUID.randomUUID().toString()

        User user = User.findByUserId(userId)

        if (!user) {
            user = new User(
                userId: userId,
                name: params.name,
                email: params.email,
                phoneNumber: params.phoneNumber,
                age: params.age as Integer,
                gender: params.gender,
                educationLevel: params.educationLevel,
                currentStream: params.currentStream,
                ipAddress: params.ipAddress,
                userAgent: params.userAgent,
                referralSource: params.referralSource,
                agreedToTerms: params.agreedToTerms as Boolean ?: false,
                optInForUpdates: params.optInForUpdates as Boolean ?: false
            )

            if (!user.save(flush: true)) {
                log.error "Failed to create user: ${user.errors}"
                return null
            }

            // Create Learning DNA for the user
            createLearningDNA(user)

            log.info "Created new user: ${user.userId}"
        } else {
            // Update user info if provided
            if (params.name) user.name = params.name
            if (params.email) user.email = params.email
            if (params.phoneNumber) user.phoneNumber = params.phoneNumber
            if (params.age) user.age = params.age as Integer

            user.save(flush: true)
        }

        return user
    }

    def createLearningDNA(User user) {
        if (!LearningDNA.findByUser(user)) {
            def dna = new LearningDNA(
                user: user,
                coreTestsCompleted: 0,
                streamFitTestsCompleted: 0,
                isDashboardUnlocked: false
            )

            // Set JSON fields as strings
            dna.cognitiveScores = JsonOutput.toJson([:])
            dna.motivationTraits = JsonOutput.toJson([:])
            dna.topStreamSuggestions = JsonOutput.toJson([])
            dna.streamFitScores = JsonOutput.toJson([:])

            if (!dna.save(flush: true)) {
                log.error "Failed to create Learning DNA: ${dna.errors}"
                return null
            }

            return dna
        }

        return LearningDNA.findByUser(user)
    }
    
    def getUserById(String userId) {
        return User.findByUserId(userId)
    }
    
    def updateUserPreferences(User user, Map preferences) {
        if (preferences.containsKey('optInForUpdates')) {
            user.optInForUpdates = preferences.optInForUpdates as Boolean
        }
        if (preferences.containsKey('prebookedStreamMap')) {
            user.prebookedStreamMap = preferences.prebookedStreamMap as Boolean
        }
        
        return user.save(flush: true)
    }
    
    def getUserStats(User user) {
        def dna = LearningDNA.findByUser(user)
        
        return [
            totalTestsCompleted: (dna?.coreTestsCompleted ?: 0) + (dna?.streamFitTestsCompleted ?: 0),
            coreTestsCompleted: dna?.coreTestsCompleted ?: 0,
            streamFitTestsCompleted: dna?.streamFitTestsCompleted ?: 0,
            isDashboardUnlocked: dna?.isDashboardUnlocked ?: false,
            completionPercentage: calculateCompletionPercentage(dna)
        ]
    }
    
    private Double calculateCompletionPercentage(LearningDNA dna) {
        if (!dna) return 0.0
        
        int totalRequired = 5 // 3 core + 2 streamfit minimum
        int completed = Math.min(dna.coreTestsCompleted, 3) + Math.min(dna.streamFitTestsCompleted, 2)
        
        return (completed / totalRequired) * 100
    }
}


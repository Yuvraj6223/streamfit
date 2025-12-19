package com.streamfit.dashboard

import com.streamfit.user.User
import grails.converters.JSON
import groovy.json.JsonSlurper

class LearningDNA {
    
    User user
    
    // Learning Style Persona
    String learningStylePersona
    String learningStyleEmoji
    String learningStyleDescription
    
    // Cognitive Skew
    String cognitiveSkew
    String cognitiveEmoji
    String cognitiveScores // JSON string: Logic, Verbal, Spatial, Speed

    // Work Style
    String workStyle
    String workStyleEmoji
    String workStyleDescription

    // Motivation Profile
    String motivationProfile
    String motivationTraits // JSON string

    // StreamFit Suggestions
    String topStreamSuggestions // JSON string
    String streamFitScores // JSON string
    
    // Completion Status
    Integer coreTestsCompleted = 0
    Integer streamFitTestsCompleted = 0
    Boolean isDashboardUnlocked = false
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [user: User]
    
    static constraints = {
        learningStylePersona nullable: true, maxSize: 100
        learningStyleEmoji nullable: true, maxSize: 10
        learningStyleDescription nullable: true, maxSize: 1000
        cognitiveSkew nullable: true, maxSize: 100
        cognitiveEmoji nullable: true, maxSize: 10
        cognitiveScores nullable: true
        workStyle nullable: true, maxSize: 100
        workStyleEmoji nullable: true, maxSize: 10
        workStyleDescription nullable: true, maxSize: 1000
        motivationProfile nullable: true, maxSize: 100
        motivationTraits nullable: true
        topStreamSuggestions nullable: true
        streamFitScores nullable: true
        coreTestsCompleted min: 0, max: 4
        streamFitTestsCompleted min: 0, max: 5
    }
    
    static mapping = {
        table 'learning_dna'
        version false
        cognitiveScores type: 'text'
        motivationTraits type: 'text'
        topStreamSuggestions type: 'text'
        streamFitScores type: 'text'
    }

    // Helper methods to parse JSON strings
    Map getCognitiveScoresMap() {
        if (!cognitiveScores) return [:]
        try {
            return new JsonSlurper().parseText(cognitiveScores) as Map
        } catch (Exception e) {
            return [:]
        }
    }

    Map getMotivationTraitsMap() {
        if (!motivationTraits) return [:]
        try {
            return new JsonSlurper().parseText(motivationTraits) as Map
        } catch (Exception e) {
            return [:]
        }
    }

    List getTopStreamSuggestionsList() {
        if (!topStreamSuggestions) return []
        try {
            return new JsonSlurper().parseText(topStreamSuggestions) as List
        } catch (Exception e) {
            return []
        }
    }

    Map getStreamFitScoresMap() {
        if (!streamFitScores) return [:]
        try {
            return new JsonSlurper().parseText(streamFitScores) as Map
        } catch (Exception e) {
            return [:]
        }
    }

    String toString() {
        return "Learning DNA for ${user}"
    }
}


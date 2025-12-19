package com.streamfit.test

class TestArchetype {
    
    TestDefinition testDefinition
    String archetypeCode
    String archetypeName
    String archetypeEmoji
    String description
    String traits
    String careerSuggestions
    String imageUrl
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [testDefinition: TestDefinition]
    
    static constraints = {
        archetypeCode blank: false, maxSize: 50
        archetypeName blank: false, maxSize: 100
        archetypeEmoji nullable: true, maxSize: 10
        description nullable: true, maxSize: 1000
        traits nullable: true, maxSize: 500
        careerSuggestions nullable: true, maxSize: 1000
        imageUrl nullable: true, url: true
    }
    
    static mapping = {
        table 'test_archetype'
        version false
        description sqlType: 'text'
        careerSuggestions sqlType: 'text'
    }
    
    String toString() {
        return "${archetypeEmoji} ${archetypeName}"
    }
}


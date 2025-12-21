package com.streamfit.personality

class PersonalityTrait {
    
    PersonalityTestSession session
    String traitKey // e.g., "introverted", "observant"
    String label // e.g., "Energy", "Mind"
    String color // e.g., "blue", "yellow"
    Integer score
    Integer pct // percentage
    String trait // e.g., "Introverted", "Observant"
    String link
    Boolean reverse
    String description
    String snippet
    String imageAlt
    String imageSrc
    
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [session: PersonalityTestSession]
    
    static constraints = {
        traitKey blank: false, maxSize: 50
        label blank: false, maxSize: 50
        color blank: false, maxSize: 20
        score nullable: true
        pct nullable: true, min: 0, max: 100
        trait blank: false, maxSize: 100
        link nullable: true, url: true
        reverse nullable: true
        description nullable: true, maxSize: 2000
        snippet nullable: true, maxSize: 2000
        imageAlt nullable: true, maxSize: 500
        imageSrc nullable: true, url: true
    }
    
    static mapping = {
        table 'personality_trait'
        version false
        description sqlType: 'text'
        snippet sqlType: 'text'
    }
    
    String toString() {
        return "${label}: ${trait}"
    }
}


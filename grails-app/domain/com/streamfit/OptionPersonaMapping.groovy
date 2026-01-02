package com.streamfit

class OptionPersonaMapping {
    GameOption gameOption
    String personaType // Result type like 'ANALYTICAL_DIAMOND', 'THEORIST', etc.
    String traitCategory // 'PRIMARY', 'SECONDARY', etc.
    Integer weight // Weight of this option in calculating the persona
    String mappingRule // JSON string for complex mapping rules
    
    static constraints = {
        gameOption nullable: false, unique: true
        personaType blank: false, maxSize: 100
        traitCategory inList: ['PRIMARY', 'SECONDARY', 'TERTIARY', 'NEUTRAL']
        weight nullable: false, min: 0, max: 100
        mappingRule nullable: true, maxSize: 1000
    }
    
    static mapping = {
        table 'option_persona_mapping'
        version false
        mappingRule type: 'text'
    }
    
    static belongsTo = [gameOption: GameOption]
}

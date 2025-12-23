import com.streamfit.diagnostic.*

// Script to update test descriptions and names to simpler language
// Run this in Grails console or as a script

DiagnosticTest.withTransaction {
    println "Updating test descriptions to simpler language..."
    
    // Update Spirit Animal Test
    def spiritAnimal = DiagnosticTest.findByTestId('SPIRIT_ANIMAL')
    if (spiritAnimal) {
        spiritAnimal.testName = 'Exam Spirit Animal Game'
        spiritAnimal.description = 'Find out what kind of learner you are and how you handle exams'
        spiritAnimal.save(flush: true)
        println "✓ Updated Spirit Animal test"
    }

    // Update Cognitive Radar Test
    def cognitiveRadar = DiagnosticTest.findByTestId('COGNITIVE_RADAR')
    if (cognitiveRadar) {
        cognitiveRadar.testName = 'Brain Strengths Game'
        cognitiveRadar.description = 'Find out what your brain is naturally good at'
        cognitiveRadar.save(flush: true)
        println "✓ Updated Cognitive Radar test"
    }

    // Update Focus Stamina Test
    def focusStamina = DiagnosticTest.findByTestId('FOCUS_STAMINA')
    if (focusStamina) {
        focusStamina.testName = 'Focus & Stress Game'
        focusStamina.description = 'See how long you can focus and how you handle stress'
        focusStamina.save(flush: true)
        println "✓ Updated Focus Stamina test"
    }

    // Update Guesswork Quotient Test
    def guesswork = DiagnosticTest.findByTestId('GUESSWORK_QUOTIENT')
    if (guesswork) {
        guesswork.testName = 'Guessing Skills Game'
        guesswork.description = 'See how good you are at making smart guesses'
        guesswork.save(flush: true)
        println "✓ Updated Guesswork Quotient test"
    }

    // Update Curiosity Compass Test
    def curiosity = DiagnosticTest.findByTestId('CURIOSITY_COMPASS')
    if (curiosity) {
        curiosity.testName = 'What Interests You Game'
        curiosity.description = 'Discover what topics and activities you naturally enjoy'
        curiosity.save(flush: true)
        println "✓ Updated Curiosity Compass test"
    }

    // Update Modality Map Test
    def modality = DiagnosticTest.findByTestId('MODALITY_MAP')
    if (modality) {
        modality.testName = 'How You Learn Best Game'
        modality.description = 'Find out if you learn better by seeing, hearing, or doing'
        modality.save(flush: true)
        println "✓ Updated Modality Map test"
    }

    // Update Challenge Driver Test
    def challenge = DiagnosticTest.findByTestId('CHALLENGE_DRIVER')
    if (challenge) {
        challenge.testName = 'What Motivates You Game'
        challenge.description = 'Discover what drives you to work hard and succeed'
        challenge.save(flush: true)
        println "✓ Updated Challenge Driver test"
    }

    // Update Work Mode Test
    def workMode = DiagnosticTest.findByTestId('WORK_MODE')
    if (workMode) {
        workMode.testName = 'How You Like to Work Game'
        workMode.description = 'Find out if you work better alone or with others'
        workMode.save(flush: true)
        println "✓ Updated Work Mode test"
    }

    // Update Pattern Snapshot Test
    def pattern = DiagnosticTest.findByTestId('PATTERN_SNAPSHOT')
    if (pattern) {
        pattern.testName = 'Quick Brain Games'
        pattern.description = 'Test your skills with fun pattern and logic puzzles'
        pattern.save(flush: true)
        println "✓ Updated Pattern Snapshot test"
    }
    
    println "\nAll test descriptions updated successfully!"
    println "Please restart the application for changes to take full effect."
}


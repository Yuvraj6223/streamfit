import com.streamfit.diagnostic.*

// Script to update Spirit Animal result descriptions to simpler language for 14-20 year olds
// Run this in Grails console or as a script

DiagnosticResult.withTransaction {
    println "Updating Spirit Animal results to simpler language..."
    
    def test = DiagnosticTest.findByTestId('SPIRIT_ANIMAL')
    if (!test) {
        println "ERROR: Spirit Animal test not found!"
        return
    }
    
    // Update Wise Owl
    def wiseOwl = DiagnosticResult.findByTestAndResultId(test, 'WISE_OWL')
    if (wiseOwl) {
        wiseOwl.summary = "You like to understand everything deeply before moving forward. You won't start Chapter 2 until you've completely mastered Chapter 1."
        wiseOwl.strengths = 'You understand concepts really well and are super careful with details.'
        wiseOwl.traps = "You spend too much time on hard questions and don't want to skip them, which can mess up your time."
        wiseOwl.aiRoadmap = "We'll teach you when to skip questions and how to manage your time better during exams."
        wiseOwl.save(flush: true)
        println "✓ Updated Wise Owl"
    }
    
    // Update Strategic Wolf
    def strategicWolf = DiagnosticResult.findByTestAndResultId(test, 'STRATEGIC_WOLF')
    if (strategicWolf) {
        strategicWolf.summary = "You have a good sense for finding the right answer. You're great at eliminating wrong options and using smart shortcuts."
        strategicWolf.strengths = 'You work efficiently and have strong exam instincts.'
        strategicWolf.traps = "You sometimes lose easy marks because you're overconfident and miss small details in questions."
        strategicWolf.aiRoadmap = "We'll give you tricky questions to help you catch silly mistakes and pay better attention to details."
        strategicWolf.save(flush: true)
        println "✓ Updated Strategic Wolf"
    }
    
    // Update Disciplined Bee
    def disciplinedBee = DiagnosticResult.findByTestAndResultId(test, 'DISCIPLINED_BEE')
    if (disciplinedBee) {
        disciplinedBee.summary = 'You love structure and routine. You believe in steady improvement and can study consistently for long periods.'
        disciplinedBee.strengths = "You're super consistent and great at following standard methods and memorizing."
        disciplinedBee.traps = 'You struggle when exam questions look different from what you practiced.'
        disciplinedBee.aiRoadmap = "We'll give you different types of questions to help you become more flexible in your thinking."
        disciplinedBee.save(flush: true)
        println "✓ Updated Disciplined Bee"
    }
    
    // Update Bold Tiger
    def boldTiger = DiagnosticResult.findByTestAndResultId(test, 'BOLD_TIGER')
    if (boldTiger) {
        boldTiger.summary = 'You perform best under pressure and love competition. You\'re fast, bold, and thrive on challenges.'
        boldTiger.strengths = 'You can finish exams quickly and often do better in real exams than in practice.'
        boldTiger.traps = 'You get bored with easy topics and forget things you learned a while ago.'
        boldTiger.aiRoadmap = "We'll make learning fun like a game and send you quick reminders to help you remember what you studied."
        boldTiger.save(flush: true)
        println "✓ Updated Bold Tiger"
    }
    
    println "\nAll Spirit Animal results updated successfully!"
}


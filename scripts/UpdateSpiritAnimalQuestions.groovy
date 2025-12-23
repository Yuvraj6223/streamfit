import com.streamfit.diagnostic.*

// Script to update Spirit Animal questions to simpler language for 14-20 year olds
// Run this in Grails console or as a script

DiagnosticQuestion.withTransaction {
    println "Updating Spirit Animal questions to simpler language..."
    
    def test = DiagnosticTest.findByTestId('SPIRIT_ANIMAL')
    if (!test) {
        println "ERROR: Spirit Animal test not found!"
        return
    }
    
    // Update Question 1
    def q1 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q1')
    if (q1) {
        q1.questionText = 'When you start a new tough chapter, what do you do first?'
        q1.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q1, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Read all the theory from the textbook first'
            options[0].save(flush: true)
            options[1].optionText = 'Jump straight to practice questions to see what they ask'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 1"
    }
    
    // Update Question 2
    def q2 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q2')
    if (q2) {
        q2.questionText = "You're 70% done with a 3-hour practice exam. How do you feel?"
        q2.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q2, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = "Tired - I've put a lot of effort into every question"
            options[0].save(flush: true)
            options[1].optionText = 'Restless - I just want to finish and see my score'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 2"
    }
    
    // Update Question 3
    def q3 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q3')
    if (q3) {
        q3.questionText = "When you get a question wrong, what's your first thought?"
        q3.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q3, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = "I didn't understand the concept properly"
            options[0].save(flush: true)
            options[1].optionText = 'I probably made a silly mistake or misread it'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 3"
    }
    
    // Update Question 4
    def q4 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q4')
    if (q4) {
        q4.questionText = 'What kind of teacher do you like best?'
        q4.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q4, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'One who explains how formulas work from the beginning'
            options[0].save(flush: true)
            options[1].optionText = 'One who shows quick tricks to solve problems fast'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 4"
    }
    
    // Update Question 5
    def q5 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q5')
    if (q5) {
        q5.questionText = 'During an exam, complete silence is:'
        q5.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q5, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Important - any noise breaks my focus'
            options[0].save(flush: true)
            options[1].optionText = 'Boring - I actually like a little background noise'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 5"
    }
    
    // Update Question 6
    def q6 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q6')
    if (q6) {
        q6.questionText = 'What do your study notes look like?'
        q6.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q6, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Very organized, color-coded, and neat'
            options[0].save(flush: true)
            options[1].optionText = 'Messy scribbles and shortcuts only I understand'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 6"
    }
    
    // Update Question 7
    def q7 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q7')
    if (q7) {
        q7.questionText = "When you're not sure of an answer and have to guess:"
        q7.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q7, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = "I'd rather leave it blank than lose marks"
            options[0].save(flush: true)
            options[1].optionText = 'I eliminate wrong options and go with my gut feeling'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 7"
    }
    
    // Update Question 8
    def q8 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q8')
    if (q8) {
        q8.questionText = 'The night before a big exam, you are:'
        q8.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q8, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Studying my weak topics one last time'
            options[0].save(flush: true)
            options[1].optionText = "Relaxing or sleeping - I trust I'll do well tomorrow"
            options[1].save(flush: true)
        }
        println "✓ Updated Question 8"
    }
    
    // Update Question 9
    def q9 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q9')
    if (q9) {
        q9.questionText = 'How do you feel about memorizing things (dates, formulas, lists)?'
        q9.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q9, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = "It's okay - it's part of studying"
            options[0].save(flush: true)
            options[1].optionText = "It's boring - I'd rather understand and figure it out"
            options[1].save(flush: true)
        }
        println "✓ Updated Question 9"
    }
    
    // Update Question 10
    def q10 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q10')
    if (q10) {
        q10.questionText = 'What scares you most during an exam?'
        q10.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q10, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Forgetting an important step in solving a problem'
            options[0].save(flush: true)
            options[1].optionText = 'Running out of time before finishing all questions'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 10"
    }
    
    // Update Question 11
    def q11 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q11')
    if (q11) {
        q11.questionText = 'If you finish a practice test early, you:'
        q11.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q11, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Go back and check all my answers carefully'
            options[0].save(flush: true)
            options[1].optionText = 'Close the book and move on to something else'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 11"
    }
    
    // Update Question 12
    def q12 = DiagnosticQuestion.findByQuestionId('SPIRIT_ANIMAL_Q12')
    if (q12) {
        q12.questionText = 'In a group study session, you usually:'
        q12.save(flush: true)
        
        def options = DiagnosticQuestionOption.findAllByQuestion(q12, [sort: 'displayOrder'])
        if (options.size() >= 2) {
            options[0].optionText = 'Make sure everyone follows the syllabus step by step'
            options[0].save(flush: true)
            options[1].optionText = 'Ask "what if" questions to challenge the group'
            options[1].save(flush: true)
        }
        println "✓ Updated Question 12"
    }
    
    println "\nAll Spirit Animal questions updated successfully!"
}


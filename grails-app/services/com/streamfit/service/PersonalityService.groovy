package com.streamfit.service

import grails.gorm.transactions.Transactional
import com.streamfit.personality.PersonalityQuestion
import com.streamfit.personality.PersonalityQuestionOption

@Transactional
class PersonalityService {

    // Seeds default personality questions and options if none exist
    void initializeDefaultQuestions() {
        if (com.streamfit.personality.PersonalityQuestion.count() > 0) {
            return
        }

        List<String> questions = [
            'I prefer structured routines over spontaneous activities.',
            'I feel energized when working in a team rather than alone.',
            'I often look for patterns and connections others may miss.',
            'I stay focused and calm under pressure.',
            'I enjoy exploring new ideas even if they are unconventional.'
        ]

        int number = 1
        questions.each { qText ->
            createQuestionWithLikertOptions(qText, number++)
        }
    }

    private void createQuestionWithLikertOptions(String questionText, int questionNumber) {
        

        String questionId = base64(questionText)

        def existing = PersonalityQuestion.findByQuestionId(questionId)
        if (existing) {
            return
        }

        def question = new PersonalityQuestion(
            questionId: questionId,
            questionText: questionText,
            questionNumber: questionNumber
        )
        question.save(failOnError: true, flush: true)

        // Likert scale options from -3 to 3
        List<Map> options = [
            [text: 'Strongly disagree', value: -3],
            [text: 'Disagree', value: -2],
            [text: 'Somewhat disagree', value: -1],
            [text: 'Somewhat agree', value: 1],
            [text: 'Agree', value: 2],
            [text: 'Strongly agree', value: 3]
        ]

        int order = 1
        options.each { opt ->
            new PersonalityQuestionOption(
                question: question,
                optionText: opt.text,
                optionValue: opt.value,
                displayOrder: order++
            ).save(failOnError: true, flush: true)
        }
    }

    private static String base64(String input) {
        return java.util.Base64.getEncoder().encodeToString(input.getBytes('UTF-8'))
    }
}


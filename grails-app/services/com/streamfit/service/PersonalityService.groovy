package com.streamfit.service

import com.streamfit.personality.*
import com.streamfit.user.User
import grails.gorm.transactions.Transactional
import groovy.json.JsonSlurper
import groovy.json.JsonOutput

@Transactional
class PersonalityService {

    def analyticsService

    /**
     * Get all personality test questions
     * Returns questions with options similar to the React API
     */
    def getPersonalityQuestions() {
        def questions = PersonalityQuestion.list(sort: 'questionNumber', order: 'asc')

        if (!questions) {
            // Initialize default questions if not present
            questions = initializeDefaultQuestions()
        }

        return questions.collect { question ->
            def options = PersonalityQuestionOption.findAllByQuestion(question, [sort: 'displayOrder'])

            [
                id: question.questionId,
                text: question.questionText,
                options: options.collect { opt ->
                    [
                        text: opt.optionText,
                        value: opt.optionValue
                    ]
                }
            ]
        }
    }

    /**
     * Initialize default personality test questions
     * Based on 16personalities standard questions
     */
    private def initializeDefaultQuestions() {
        def defaultQuestions = [
            "You regularly make new friends.",
            "You spend a lot of your free time exploring various random topics that pique your interest.",
            "Seeing other people cry can easily make you feel like you want to cry too.",
            "You often make a backup plan for a backup plan.",
            "You usually stay calm, even under a lot of pressure.",
            "At social events, you rarely try to introduce yourself to new people and mostly talk to the ones you already know.",
            "You prefer to completely finish one project before starting another.",
            "You are very sentimental.",
            "You like to use organizing tools like schedules and lists.",
            "Even a small mistake can cause you to doubt your overall abilities and knowledge.",
            "You feel comfortable just walking up to someone you find interesting and striking up a conversation.",
            "You are not too interested in discussing various interpretations and analyses of creative works.",
            "You are more inclined to follow your head than your heart.",
            "You usually prefer just doing what you feel like at any given moment instead of planning a particular daily routine.",
            "You rarely worry about whether you make a good impression on people you meet.",
            "You enjoy participating in group activities.",
            "You like books and movies that make you come up with your own interpretation of the ending.",
            "Your happiness comes more from helping others accomplish things than your own accomplishments.",
            "You are interested in so many things that you find it difficult to choose what to try next.",
            "You are prone to worrying that things will take a turn for the worse.",
            "You avoid leadership roles in group settings.",
            "You are definitely not an artistic type of person.",
            "You think the world would be a better place if people relied more on rationality and less on their feelings.",
            "You prefer to do your chores before allowing yourself to relax.",
            "You enjoy watching people argue.",
            "You tend to avoid drawing attention to yourself.",
            "Your mood can change very quickly.",
            "You lose patience with people who are not as efficient as you.",
            "You often end up doing things at the last possible moment.",
            "You have always been fascinated by the question of what, if anything, happens after death.",
            "You usually prefer to be around others rather than on your own.",
            "You become bored or lose interest when the discussion gets highly theoretical.",
            "You find it easy to empathize with a person whose experiences are very different from yours.",
            "You usually postpone finalizing decisions for as long as possible.",
            "You rarely second-guess the choices that you have made.",
            "After a long and exhausting week, a lively social event is just what you need.",
            "You enjoy going to art museums.",
            "You often have a hard time understanding other people's feelings.",
            "You like to have a to-do list for each day.",
            "You rarely feel insecure.",
            "You avoid making phone calls.",
            "You often spend a lot of time trying to understand views that are very different from your own.",
            "In your social circle, you are often the one who contacts your friends and initiates activities.",
            "If your plans are interrupted, your top priority is to get back on track as soon as possible.",
            "You are still bothered by mistakes that you made a long time ago.",
            "You rarely contemplate the reasons for human existence or the meaning of life.",
            "Your emotions control you more than you control them.",
            "You take great care not to make people look bad, even when it is completely their fault.",
            "Your personal work style is closer to spontaneous bursts of energy than organized and consistent efforts.",
            "When someone thinks highly of you, you wonder how long it will take them to feel disappointed in you.",
            "You would love a job that requires you to work alone most of the time.",
            "You believe that pondering abstract philosophical questions is a waste of time.",
            "You feel more drawn to places with busy, bustling atmospheres than quiet, intimate places.",
            "You know at first glance how someone is feeling.",
            "You often feel overwhelmed.",
            "You complete things methodically without skipping over any steps.",
            "You are very intrigued by things labeled as controversial.",
            "You would pass along a good opportunity if you thought someone else needed it more.",
            "You struggle with deadlines.",
            "You feel confident that things will work out for you."
        ]

        def questions = []
        defaultQuestions.eachWithIndex { questionText, index ->
            def questionId = Base64.encoder.encodeToString(questionText.bytes).replaceAll('=', '')

            def question = new PersonalityQuestion(
                questionId: questionId,
                questionText: questionText,
                questionNumber: index + 1
            )

            if (question.save(flush: true)) {
                // Add default options
                def defaultOptions = [
                    [text: "Disagree strongly", value: -3, order: 1],
                    [text: "Disagree moderately", value: -2, order: 2],
                    [text: "Disagree a little", value: -1, order: 3],
                    [text: "Neither agree nor disagree", value: 0, order: 4],
                    [text: "Agree a little", value: 1, order: 5],
                    [text: "Agree moderately", value: 2, order: 6],
                    [text: "Agree strongly", value: 3, order: 7]
                ]

                defaultOptions.each { opt ->
                    new PersonalityQuestionOption(
                        question: question,
                        optionText: opt.text,
                        optionValue: opt.value,
                        displayOrder: opt.order
                    ).save(flush: true)
                }

                questions << question
            }
        }

        log.info "Initialized ${questions.size()} personality questions"
        return questions
    }

    /**
     * Submit personality test answers and calculate results
     * This mimics the behavior of the React API
     */
    def submitPersonalityTest(User user, List answers, String gender) {
        // Create test session
        def session = new PersonalityTestSession(
            user: user,
            sessionId: UUID.randomUUID().toString(),
            gender: gender,
            status: 'IN_PROGRESS',
            startedAt: new Date()
        )

        if (!session.save(flush: true)) {
            log.error "Failed to create personality test session: ${session.errors}"
            return [success: false, error: 'Failed to create test session']
        }

        // Save responses
        answers.each { answer ->
            def questionText = new String(Base64.decoder.decode(answer.id))

            def response = new PersonalityResponse(
                session: session,
                questionId: answer.id,
                questionText: questionText,
                answerValue: answer.value as Integer,
                answeredAt: new Date()
            )

            if (!response.save(flush: true)) {
                log.error "Failed to save response: ${response.errors}"
            }
        }

        // Calculate personality type
        def results = calculatePersonalityType(session, answers)

        // Update session with results
        session.status = 'COMPLETED'
        session.completedAt = new Date()
        session.personality = results.personality
        session.variant = results.variant
        session.niceName = results.niceName
        session.role = results.role
        session.strategy = results.strategy
        session.avatarSrc = results.avatarSrc
        session.avatarAlt = results.avatarAlt
        session.avatarSrcStatic = results.avatarSrcStatic
        session.profileUrl = results.profileUrl
        session.save(flush: true)

        // Save traits
        results.traits?.each { traitData ->
            def trait = new PersonalityTrait(
                session: session,
                traitKey: traitData.key,
                label: traitData.label,
                color: traitData.color,
                score: traitData.score,
                pct: traitData.pct,
                trait: traitData.trait,
                link: traitData.link,
                reverse: traitData.reverse,
                description: traitData.description,
                snippet: traitData.snippet,
                imageAlt: traitData.imageAlt,
                imageSrc: traitData.imageSrc
            )

            if (!trait.save(flush: true)) {
                log.error "Failed to save trait: ${trait.errors}"
            }
        }

        // Track analytics
        analyticsService?.trackEvent(user, 'PERSONALITY_TEST_COMPLETED', [
            sessionId: session.sessionId,
            personality: results.personality,
            variant: results.variant
        ])

        return [
            success: true,
            sessionId: session.sessionId,
            niceName: results.niceName,
            personality: results.personality,
            variant: results.variant,
            role: results.role,
            strategy: results.strategy,
            avatarSrc: results.avatarSrc,
            avatarAlt: results.avatarAlt,
            avatarSrcStatic: results.avatarSrcStatic,
            profileUrl: results.profileUrl,
            traits: results.traits
        ]
    }

    /**
     * Calculate personality type based on answers
     * This is a simplified version - in production, you would integrate with 16personalities API
     */
    private def calculatePersonalityType(PersonalityTestSession session, List answers) {
        // Calculate scores for each dimension
        def scores = calculateDimensionScores(answers)

        // Determine personality type (MBTI-like)
        def personality = determinePersonalityCode(scores)
        def variant = scores.identity > 0 ? 'A' : 'T' // Assertive vs Turbulent

        // Get personality metadata
        def metadata = getPersonalityMetadata(personality, variant, session.gender)

        // Calculate traits
        def traits = calculateTraits(scores)

        return [
            personality: personality,
            variant: variant,
            niceName: metadata.niceName,
            role: metadata.role,
            strategy: metadata.strategy,
            avatarSrc: metadata.avatarSrc,
            avatarAlt: metadata.avatarAlt,
            avatarSrcStatic: metadata.avatarSrcStatic,
            profileUrl: metadata.profileUrl,
            traits: traits
        ]
    }

    /**
     * Calculate dimension scores from answers
     */
    private def calculateDimensionScores(List answers) {
        // Map questions to dimensions (simplified mapping)
        // In production, this would be based on actual 16personalities question mapping
        def energyQuestions = [0, 5, 10, 15, 20, 25, 30, 35, 40, 50, 52] // Introverted vs Extraverted
        def mindQuestions = [1, 6, 11, 16, 21, 26, 31, 36, 41, 45, 51] // Intuitive vs Observant
        def natureQuestions = [2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 53] // Thinking vs Feeling
        def tacticsQuestions = [3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 55] // Judging vs Prospecting
        def identityQuestions = [4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 58, 59] // Assertive vs Turbulent

        def scores = [
            energy: 0,
            mind: 0,
            nature: 0,
            tactics: 0,
            identity: 0
        ]

        answers.eachWithIndex { answer, index ->
            def value = answer.value as Integer

            if (energyQuestions.contains(index)) {
                scores.energy += value
            }
            if (mindQuestions.contains(index)) {
                scores.mind += value
            }
            if (natureQuestions.contains(index)) {
                scores.nature += value
            }
            if (tacticsQuestions.contains(index)) {
                scores.tactics += value
            }
            if (identityQuestions.contains(index)) {
                scores.identity += value
            }
        }

        return scores
    }

    /**
     * Determine personality code from scores
     */
    private String determinePersonalityCode(Map scores) {
        def code = ''

        // Energy: I (Introverted) vs E (Extraverted)
        code += scores.energy < 0 ? 'I' : 'E'

        // Mind: N (Intuitive) vs S (Observant/Sensing)
        code += scores.mind > 0 ? 'N' : 'S'

        // Nature: T (Thinking) vs F (Feeling)
        code += scores.nature > 0 ? 'T' : 'F'

        // Tactics: J (Judging) vs P (Prospecting/Perceiving)
        code += scores.tactics < 0 ? 'J' : 'P'

        return code
    }

    /**
     * Get personality metadata (name, role, strategy, avatar)
     */
    private def getPersonalityMetadata(String personality, String variant, String gender) {
        def genderSuffix = gender?.toLowerCase() == 'female' ? 'female' : 'male'

        // Personality type names and metadata
        def personalityData = [
            'INTJ': [niceName: 'Architect', role: 'Analyst', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'INTP': [niceName: 'Logician', role: 'Analyst', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'ENTJ': [niceName: 'Commander', role: 'Analyst', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'ENTP': [niceName: 'Debater', role: 'Analyst', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'INFJ': [niceName: 'Advocate', role: 'Diplomat', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'INFP': [niceName: 'Mediator', role: 'Diplomat', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'ENFJ': [niceName: 'Protagonist', role: 'Diplomat', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'ENFP': [niceName: 'Campaigner', role: 'Diplomat', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'ISTJ': [niceName: 'Logistician', role: 'Sentinel', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'ISFJ': [niceName: 'Defender', role: 'Sentinel', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'ESTJ': [niceName: 'Executive', role: 'Sentinel', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'ESFJ': [niceName: 'Consul', role: 'Sentinel', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'ISTP': [niceName: 'Virtuoso', role: 'Explorer', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'ISFP': [niceName: 'Adventurer', role: 'Explorer', strategy: variant == 'A' ? 'Confident Individualism' : 'Constant Improvement'],
            'ESTP': [niceName: 'Entrepreneur', role: 'Explorer', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement'],
            'ESFP': [niceName: 'Entertainer', role: 'Explorer', strategy: variant == 'A' ? 'People Mastery' : 'Social Engagement']
        ]

        def data = personalityData[personality] ?: [niceName: 'Unknown', role: 'Unknown', strategy: 'Unknown']
        def typeSlug = personality.toLowerCase()
        def niceName = data.niceName.toLowerCase().replaceAll(' ', '-')

        return [
            niceName: data.niceName,
            role: data.role,
            strategy: data.strategy,
            avatarSrc: "https://www.16personalities.com/static/animations/avatars/all/${niceName}-${genderSuffix}.json",
            avatarAlt: "${personality} avatar",
            avatarSrcStatic: "https://www.16personalities.com/static/images/personality-types/avatars/${typeSlug}-${niceName}-${genderSuffix}.svg?v=3",
            profileUrl: "https://www.16personalities.com/${typeSlug}-personality"
        ]
    }



    /**
     * Calculate trait details from scores
     */
    private def calculateTraits(Map scores) {
        def traits = []

        // Energy trait
        def energyScore = Math.abs(scores.energy)
        def energyPct = Math.min(100, 50 + (energyScore * 2))
        traits << [
            key: scores.energy < 0 ? 'introverted' : 'extraverted',
            label: 'Energy',
            color: 'blue',
            score: energyScore,
            pct: energyPct,
            trait: scores.energy < 0 ? 'Introverted' : 'Extraverted',
            link: 'https://www.16personalities.com/articles/energy-introverted-vs-extraverted',
            reverse: false,
            description: scores.energy < 0 ?
                'Introverted individuals tend to prefer fewer, yet deep and meaningful, social interactions and often feel drawn to calmer environments.' :
                'Extraverted individuals are energized by social interactions and tend to be action-oriented.',
            snippet: scores.energy < 0 ?
                'You likely prefer fewer, yet deep and meaningful, social interactions and feel drawn to calmer environments.' :
                'You likely enjoy being around others and feel energized by social interactions.',
            imageAlt: 'Energy trait illustration',
            imageSrc: "https://www.16personalities.com/static/images/theory/traits/16personalities_trait_${scores.energy < 0 ? 'introverted' : 'extraverted'}.svg"
        ]

        // Mind trait
        def mindScore = Math.abs(scores.mind)
        def mindPct = Math.min(100, 50 + (mindScore * 2))
        traits << [
            key: scores.mind > 0 ? 'intuitive' : 'observant',
            label: 'Mind',
            color: 'yellow',
            score: mindScore,
            pct: mindPct,
            trait: scores.mind > 0 ? 'Intuitive' : 'Observant',
            link: 'https://www.16personalities.com/articles/mind-intuitive-vs-observant',
            reverse: false,
            description: scores.mind > 0 ?
                'Intuitive individuals are very imaginative, open-minded, and curious. They value originality and focus on hidden meanings and distant possibilities.' :
                'Observant individuals are pragmatic and down-to-earth. They tend to have a strong focus on what is happening or very likely to happen.',
            snippet: scores.mind > 0 ?
                'You\'re likely imaginative and open-minded, focusing on hidden meanings and future possibilities.' :
                'You\'re likely pragmatic and down-to-earth, with a strong focus on what is happening or very likely to happen.',
            imageAlt: 'Mind trait illustration',
            imageSrc: "https://www.16personalities.com/static/images/theory/traits/16personalities_trait_${scores.mind > 0 ? 'intuitive' : 'observant'}.svg"
        ]

        // Nature trait
        def natureScore = Math.abs(scores.nature)
        def naturePct = Math.min(100, 50 + (natureScore * 2))
        traits << [
            key: scores.nature > 0 ? 'thinking' : 'feeling',
            label: 'Nature',
            color: 'green',
            score: natureScore,
            pct: naturePct,
            trait: scores.nature > 0 ? 'Thinking' : 'Feeling',
            link: 'https://www.16personalities.com/articles/nature-thinking-vs-feeling',
            reverse: true,
            description: scores.nature > 0 ?
                'Thinking individuals focus on objectivity and rationality, often dismissing emotions in favor of logic.' :
                'Feeling individuals are sensitive and emotionally expressive. They value emotional expression and are empathetic.',
            snippet: scores.nature > 0 ?
                'You likely focus on objectivity and rationality, putting effectiveness above social harmony.' :
                'You likely value emotional expression and are empathetic to others\' feelings.',
            imageAlt: 'Nature trait illustration',
            imageSrc: "https://www.16personalities.com/static/images/theory/traits/16personalities_trait_${scores.nature > 0 ? 'thinking' : 'feeling'}.svg"
        ]

        // Tactics trait
        def tacticsScore = Math.abs(scores.tactics)
        def tacticsPct = Math.min(100, 50 + (tacticsScore * 2))
        traits << [
            key: scores.tactics < 0 ? 'judging' : 'prospecting',
            label: 'Tactics',
            color: 'purple',
            score: tacticsScore,
            pct: tacticsPct,
            trait: scores.tactics < 0 ? 'Judging' : 'Prospecting',
            link: 'https://www.16personalities.com/articles/tactics-judging-vs-prospecting',
            reverse: false,
            description: scores.tactics < 0 ?
                'Judging individuals are decisive, thorough, and highly organized. They value clarity and closure.' :
                'Prospecting individuals are very good at improvising and adapting to opportunities.',
            snippet: scores.tactics < 0 ?
                'You\'re likely decisive and organized, valuing clarity and closure.' :
                'You\'re likely very good at improvising and adapting. You tend to be flexible and value novelty above stability.',
            imageAlt: 'Tactics trait illustration',
            imageSrc: "https://www.16personalities.com/static/images/theory/traits/16personalities_trait_${scores.tactics < 0 ? 'judging' : 'prospecting'}.svg"
        ]

        // Identity trait
        def identityScore = Math.abs(scores.identity)
        def identityPct = Math.min(100, 50 + (identityScore * 2))
        traits << [
            key: scores.identity > 0 ? 'assertive' : 'turbulent',
            label: 'Identity',
            color: 'red',
            score: identityScore,
            pct: identityPct,
            trait: scores.identity > 0 ? 'Assertive' : 'Turbulent',
            link: 'https://www.16personalities.com/articles/identity-assertive-vs-turbulent',
            reverse: true,
            description: scores.identity > 0 ?
                'Assertive individuals are self-assured, even-tempered, and resistant to stress.' :
                'Turbulent individuals are self-conscious and sensitive to stress. They are perfectionistic and eager to improve.',
            snippet: scores.identity > 0 ?
                'You\'re likely self-assured, even-tempered, and resistant to stress, refusing to worry too much.' :
                'You\'re likely self-conscious and driven to improve, seeking to better yourself constantly.',
            imageAlt: 'Identity trait illustration',
            imageSrc: "https://www.16personalities.com/static/images/theory/traits/16personalities_trait_${scores.identity > 0 ? 'assertive' : 'turbulent'}.svg"
        ]

        return traits
    }

    /**
     * Get user's personality test history
     */
    def getUserPersonalityHistory(User user) {
        return PersonalityTestSession.findAllByUser(user, [sort: 'dateCreated', order: 'desc'])
    }

    /**
     * Get personality test session by ID
     */
    def getPersonalitySession(String sessionId) {
        return PersonalityTestSession.findBySessionId(sessionId)
    }
}
package com.streamfit.controller


import com.streamfit.service.UserService
import com.streamfit.service.PersonalityService
import grails.converters.JSON

class PersonalityController {

    PersonalityService personalityService
    UserService userService
    
    /**
     * Main personality test page - Free for all users
     */
    def index() {
        // No login required - show test introduction
        [:]
    }
    
    /**
     * API endpoint: Get all personality test questions
     * GET /api/personality/questions
     */
    def questions() {
        try {
            def questions = personalityService.getPersonalityQuestions()
            
            response.status = 200
            render(questions as JSON)
        } catch (Exception e) {
            log.error "Error fetching personality questions: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch questions'] as JSON)
        }
    }
    
    /**
     * API endpoint: Submit personality test answers
     * POST /api/personality/submit
     * 
     * Request body:
     * {
     *   "answers": [
     *     {"id": "base64_encoded_question", "value": -3 to 3},
     *     ...
     *   ],
     *   "gender": "Male" | "Female" | "Other"
     * }
     */
    def submit() {
        try {
            def params = request.JSON ?: params
            def answers = params.answers
            def gender = params.gender
            
            // Validate input
            if (!answers || answers.isEmpty()) {
                response.status = 400
                render([success: false, error: 'Answers are required'] as JSON)
                return
            }
            
            if (!gender || !['Male', 'Female', 'Other'].contains(gender)) {
                response.status = 400
                render([success: false, error: 'Valid gender is required (Male, Female, or Other)'] as JSON)
                return
            }
            
            // Get or create user
            def userId = session.userId
            def user
            
            if (userId) {
                user = userService.getUserById(userId)
            }
            
            if (!user) {
                // Create anonymous user for personality test
                user = userService.createAnonymousUser()
                session.userId = user.userId
            }
            
            // Submit test
            def result = personalityService.submitPersonalityTest(user, answers, gender)
            
            if (result.success) {
                response.status = 200
                render(result as JSON)
            } else {
                response.status = 500
                render(result as JSON)
            }
        } catch (Exception e) {
            log.error "Error submitting personality test: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to submit test'] as JSON)
        }
    }
    
    /**
     * View personality test result - Free for all users
     */
    def result(String sessionId) {
        // Allow anonymous users to view results
        def testSession = personalityService.getPersonalitySession(sessionId)

        if (!testSession) {
            flash.error = "Invalid test session"
            redirect action: 'index'
            return
        }

        if (testSession.status != 'COMPLETED') {
            flash.error = "Test not completed"
            redirect action: 'index'
            return
        }

        def traits = com.streamfit.personality.PersonalityTrait.findAllBySession(testSession, [sort: 'id'])

        // Check if user is logged in for premium features
        def userId = session.userId
        def user = userId ? userService.getUserById(userId) : null
        def isAnonymous = !user || user.userId.startsWith('anon_')

        [
            session: testSession,
            traits: traits,
            user: user,
            isAnonymous: isAnonymous
        ]
    }
    
    /**
     * Start personality test (web interface) - Free for all users
     */
    def start() {
        // No login required - anyone can take the test
        [:]
    }
    
    /**
     * API endpoint: Get personality test result by session ID
     * GET /api/personality/result/:sessionId
     */
    def getResult(String sessionId) {
        try {
            def testSession = personalityService.getPersonalitySession(sessionId)

            if (!testSession) {
                response.status = 404
                render([success: false, error: 'Session not found'] as JSON)
                return
            }

            if (testSession.status != 'COMPLETED') {
                response.status = 400
                render([success: false, error: 'Test not completed'] as JSON)
                return
            }

            def traits = com.streamfit.personality.PersonalityTrait.findAllBySession(testSession, [sort: 'id'])

            def result = [
                success: true,
                niceName: testSession.niceName,
                personality: testSession.personality,
                variant: testSession.variant,
                role: testSession.role,
                strategy: testSession.strategy,
                avatarSrc: testSession.avatarSrc,
                avatarAlt: testSession.avatarAlt,
                avatarSrcStatic: testSession.avatarSrcStatic,
                profileUrl: testSession.profileUrl,
                traits: traits.collect { trait ->
                    [
                        key: trait.traitKey,
                        label: trait.label,
                        color: trait.color,
                        score: trait.score,
                        pct: trait.pct,
                        trait: trait.trait,
                        link: trait.link,
                        reverse: trait.reverse,
                        description: trait.description,
                        snippet: trait.snippet,
                        imageAlt: trait.imageAlt,
                        imageSrc: trait.imageSrc
                    ]
                }
            ]

            response.status = 200
            render(result as JSON)
        } catch (Exception e) {
            log.error "Error fetching personality result: ${e.message}", e
            response.status = 500
            render([success: false, error: 'Failed to fetch result'] as JSON)
        }
    }

    /**
     * Personality types overview page
     */
    def types() {
        [:]
    }
}


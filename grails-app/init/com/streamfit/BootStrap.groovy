package com.streamfit

import com.streamfit.test.*

class BootStrap {

    def init = { servletContext ->
        log.info "Initializing StreamFit application..."

        // Initialize all test data
        initializeTestData()

        log.info "StreamFit application initialized successfully!"
        log.info "Database: MySQL - wsuser schema with normalized tables"
    }
    
    def destroy = {
    }
    
    private void initializeTestData() {
        try {
            // Initialize Exam Spirit Animal Test
            if (!TestDefinition.findByTestCode('EXAM_SPIRIT_ANIMAL')) {
                createExamSpiritAnimalTest()
            }

            // Initialize Cognitive Strength Radar Test
            if (!TestDefinition.findByTestCode('COGNITIVE_RADAR')) {
                createCognitiveRadarTest()
            }

            // Initialize Focus & Stamina Test
            if (!TestDefinition.findByTestCode('FOCUS_STAMINA')) {
                createFocusStaminaTest()
            }

            // Initialize Risk Profile Test
            if (!TestDefinition.findByTestCode('RISK_PROFILE')) {
                createRiskProfileTest()
            }

            // Initialize Curiosity Compass Test
            if (!TestDefinition.findByTestCode('CURIOSITY_COMPASS')) {
                createCuriosityCompassTest()
            }

            // Initialize Modality Map Test
            if (!TestDefinition.findByTestCode('MODALITY_MAP')) {
                createModalityMapTest()
            }

            // Initialize Challenge Driver Test
            if (!TestDefinition.findByTestCode('CHALLENGE_DRIVER')) {
                createChallengeDriverTest()
            }

            // Initialize Work Mode Preference Test
            if (!TestDefinition.findByTestCode('WORK_MODE')) {
                createWorkModeTest()
            }

            // Initialize Pattern Snapshot Test
            if (!TestDefinition.findByTestCode('PATTERN_SNAPSHOT')) {
                createPatternSnapshotTest()
            }
        } catch (Exception e) {
            log.error "Error initializing test data: ${e.message}", e
        }
    }
    
    private void createExamSpiritAnimalTest() {
        def test = new TestDefinition(
            testCode: 'EXAM_SPIRIT_ANIMAL',
            testName: 'Exam Spirit Animal',
            description: 'Discover your behavioral learning style',
            category: 'CORE',
            estimatedMinutes: 3,
            totalQuestions: 8,
            isActive: true
        ).save(flush: true)
        
        // Question 1
        new TestQuestion(
            testDefinition: test,
            questionNumber: 1,
            questionText: 'The night before a big exam, you:',
            questionType: 'SINGLE_CHOICE'
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 1),
            optionText: 'Review everything one last time systematically',
            optionValue: 'OWL',
            displayOrder: 1
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 1),
            optionText: 'Get a good sleep - you\'ve prepared enough',
            optionValue: 'WOLF',
            displayOrder: 2
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 1),
            optionText: 'Cram as much as possible',
            optionValue: 'CHEETAH',
            displayOrder: 3
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 1),
            optionText: 'Study with friends and quiz each other',
            optionValue: 'DOLPHIN',
            displayOrder: 4
        ).save(flush: true)
        
        // Question 2
        new TestQuestion(
            testDefinition: test,
            questionNumber: 2,
            questionText: 'When learning something new, you prefer to:',
            questionType: 'SINGLE_CHOICE'
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 2),
            optionText: 'Read detailed notes and textbooks',
            optionValue: 'OWL',
            displayOrder: 1
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 2),
            optionText: 'Figure out the pattern and apply it',
            optionValue: 'WOLF',
            displayOrder: 2
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 2),
            optionText: 'Jump in and learn by doing',
            optionValue: 'CHEETAH',
            displayOrder: 3
        ).save(flush: true)
        
        new QuestionOption(
            question: TestQuestion.findByTestDefinitionAndQuestionNumber(test, 2),
            optionText: 'Discuss and learn from others',
            optionValue: 'DOLPHIN',
            displayOrder: 4
        ).save(flush: true)
        
        // Add more questions following the same pattern...
        // For brevity, I'll add the scoring archetypes
        
        // Create Archetypes
        new TestArchetype(
            testDefinition: test,
            archetypeCode: 'OWL',
            archetypeName: 'Methodical Owl',
            archetypeEmoji: '🦉',
            description: 'You are systematic, thorough, and detail-oriented. You excel with structured learning.',
            traits: 'Organized, Analytical, Patient',
            careerSuggestions: 'Research, Engineering, Medicine, Law'
        ).save(flush: true)
        
        new TestArchetype(
            testDefinition: test,
            archetypeCode: 'WOLF',
            archetypeName: 'Strategic Wolf',
            archetypeEmoji: '🐺',
            description: 'You are strategic and pattern-focused. You see the big picture and plan accordingly.',
            traits: 'Strategic, Independent, Focused',
            careerSuggestions: 'Business Strategy, Architecture, Data Science'
        ).save(flush: true)
        
        new TestArchetype(
            testDefinition: test,
            archetypeCode: 'CHEETAH',
            archetypeName: 'Agile Cheetah',
            archetypeEmoji: '🐆',
            description: 'You are fast-paced and action-oriented. You thrive under pressure and learn by doing.',
            traits: 'Quick, Adaptive, Energetic',
            careerSuggestions: 'Entrepreneurship, Sales, Emergency Services, Sports'
        ).save(flush: true)
        
        new TestArchetype(
            testDefinition: test,
            archetypeCode: 'DOLPHIN',
            archetypeName: 'Collaborative Dolphin',
            archetypeEmoji: '🐬',
            description: 'You are social and collaborative. You learn best through interaction and teamwork.',
            traits: 'Social, Empathetic, Communicative',
            careerSuggestions: 'Teaching, HR, Counseling, Marketing'
        ).save(flush: true)
    }
    
    private void createCognitiveRadarTest() {
        def test = new TestDefinition(
            testCode: 'COGNITIVE_RADAR',
            testName: 'Cognitive Strength Radar',
            description: 'Measure your Logic, Verbal, Spatial, and Speed aptitudes',
            category: 'CORE',
            estimatedMinutes: 8,
            totalQuestions: 16,
            isActive: true
        ).save(flush: true)
        
        // Logic Questions (4)
        createLogicQuestions(test)
        
        // Verbal Questions (4)
        createVerbalQuestions(test)
        
        // Spatial Questions (4)
        createSpatialQuestions(test)
        
        // Speed Questions (4)
        createSpeedQuestions(test)
    }
    
    private void createLogicQuestions(TestDefinition test) {
        // Logic Q1
        def q1 = new TestQuestion(
            testDefinition: test,
            questionNumber: 1,
            questionText: 'If all Bloops are Razzies and all Razzies are Lazzies, then all Bloops are definitely Lazzies.',
            questionType: 'SINGLE_CHOICE',
            cognitiveArea: 'LOGIC'
        ).save(flush: true)
        
        new QuestionOption(question: q1, optionText: 'True', optionValue: 'CORRECT', displayOrder: 1, isCorrect: true).save(flush: true)
        new QuestionOption(question: q1, optionText: 'False', optionValue: 'INCORRECT', displayOrder: 2, isCorrect: false).save(flush: true)
    }
    
    private void createVerbalQuestions(TestDefinition test) {
        // Verbal Q1
        def q5 = new TestQuestion(
            testDefinition: test,
            questionNumber: 5,
            questionText: 'Choose the word most similar to "Eloquent":',
            questionType: 'SINGLE_CHOICE',
            cognitiveArea: 'VERBAL'
        ).save(flush: true)
        
        new QuestionOption(question: q5, optionText: 'Articulate', optionValue: 'CORRECT', displayOrder: 1, isCorrect: true).save(flush: true)
        new QuestionOption(question: q5, optionText: 'Quiet', optionValue: 'INCORRECT', displayOrder: 2, isCorrect: false).save(flush: true)
        new QuestionOption(question: q5, optionText: 'Confused', optionValue: 'INCORRECT', displayOrder: 3, isCorrect: false).save(flush: true)
        new QuestionOption(question: q5, optionText: 'Simple', optionValue: 'INCORRECT', displayOrder: 4, isCorrect: false).save(flush: true)
    }
    
    private void createSpatialQuestions(TestDefinition test) {
        // Spatial questions would include image-based pattern recognition
        // For now, creating text-based spatial reasoning
        def q9 = new TestQuestion(
            testDefinition: test,
            questionNumber: 9,
            questionText: 'A cube is painted red on all faces. It is cut into 27 smaller cubes. How many small cubes have exactly 2 red faces?',
            questionType: 'SINGLE_CHOICE',
            cognitiveArea: 'SPATIAL'
        ).save(flush: true)
        
        new QuestionOption(question: q9, optionText: '12', optionValue: 'CORRECT', displayOrder: 1, isCorrect: true).save(flush: true)
        new QuestionOption(question: q9, optionText: '8', optionValue: 'INCORRECT', displayOrder: 2, isCorrect: false).save(flush: true)
        new QuestionOption(question: q9, optionText: '6', optionValue: 'INCORRECT', displayOrder: 3, isCorrect: false).save(flush: true)
        new QuestionOption(question: q9, optionText: '4', optionValue: 'INCORRECT', displayOrder: 4, isCorrect: false).save(flush: true)
    }
    
    private void createSpeedQuestions(TestDefinition test) {
        // Speed questions are timed simple calculations
        def q13 = new TestQuestion(
            testDefinition: test,
            questionNumber: 13,
            questionText: '47 + 38 = ?',
            questionType: 'SINGLE_CHOICE',
            cognitiveArea: 'SPEED',
            timeLimit: 10
        ).save(flush: true)
        
        new QuestionOption(question: q13, optionText: '85', optionValue: 'CORRECT', displayOrder: 1, isCorrect: true).save(flush: true)
        new QuestionOption(question: q13, optionText: '75', optionValue: 'INCORRECT', displayOrder: 2, isCorrect: false).save(flush: true)
        new QuestionOption(question: q13, optionText: '95', optionValue: 'INCORRECT', displayOrder: 3, isCorrect: false).save(flush: true)
        new QuestionOption(question: q13, optionText: '83', optionValue: 'INCORRECT', displayOrder: 4, isCorrect: false).save(flush: true)
    }
    
    // Placeholder methods for other tests
    private void createFocusStaminaTest() {
        new TestDefinition(
            testCode: 'FOCUS_STAMINA',
            testName: 'Focus & Stamina Test',
            description: 'Discover your work style and grit level',
            category: 'CORE',
            estimatedMinutes: 5,
            totalQuestions: 10,
            isActive: true
        ).save(flush: true)
    }
    
    private void createRiskProfileTest() {
        new TestDefinition(
            testCode: 'RISK_PROFILE',
            testName: 'Risk Profile',
            description: 'Understand your guessing confidence vs accuracy',
            category: 'CORE',
            estimatedMinutes: 4,
            totalQuestions: 12,
            isActive: true
        ).save(flush: true)
    }
    
    private void createCuriosityCompassTest() {
        new TestDefinition(
            testCode: 'CURIOSITY_COMPASS',
            testName: 'Curiosity Compass',
            description: 'Explore what drives your curiosity',
            category: 'STREAMFIT',
            estimatedMinutes: 3,
            totalQuestions: 8,
            isActive: true
        ).save(flush: true)
    }
    
    private void createModalityMapTest() {
        new TestDefinition(
            testCode: 'MODALITY_MAP',
            testName: 'Modality Map',
            description: 'Discover your preferred learning modality',
            category: 'STREAMFIT',
            estimatedMinutes: 3,
            totalQuestions: 8,
            isActive: true
        ).save(flush: true)
    }
    
    private void createChallengeDriverTest() {
        new TestDefinition(
            testCode: 'CHALLENGE_DRIVER',
            testName: 'Challenge Driver',
            description: 'What type of challenges motivate you?',
            category: 'STREAMFIT',
            estimatedMinutes: 3,
            totalQuestions: 8,
            isActive: true
        ).save(flush: true)
    }
    
    private void createWorkModeTest() {
        new TestDefinition(
            testCode: 'WORK_MODE',
            testName: 'Work Mode Preference',
            description: 'Solo or collaborative - what\'s your style?',
            category: 'STREAMFIT',
            estimatedMinutes: 3,
            totalQuestions: 8,
            isActive: true
        ).save(flush: true)
    }
    
    private void createPatternSnapshotTest() {
        new TestDefinition(
            testCode: 'PATTERN_SNAPSHOT',
            testName: 'Pattern Snapshot',
            description: 'Timed logic game to test pattern recognition',
            category: 'STREAMFIT',
            estimatedMinutes: 5,
            totalQuestions: 10,
            isActive: true,
            isTimed: true
        ).save(flush: true)
    }
}


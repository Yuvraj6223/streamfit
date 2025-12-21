<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Diagnostic Test - StreamFit</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
    :root {
        /* BRAND PALETTE - SOFT POP */
        --bg-warm: #FDFCF8;
        --text-dark: #1A1825;
        --text-grey: #8E8C9A;

        /* VITAMIN COLORS */
        --pop-coral: #FF8F7D;
        --pop-purple: #9F97F3;
        --pop-teal: #73D2DE;
        --pop-yellow: #FFD86D;
        --pop-cream: #FFF4F0;

        /* SURFACES */
        --card-base: #FFFFFF;
        /* CLAYMORPHISM SHADOWS */
        --shadow-soft: 0 12px 30px -10px rgba(28, 26, 40, 0.04);
        --shadow-float: 0 20px 40px -12px rgba(159, 151, 243, 0.2);

        /* ANIMATION */
        --ease-elastic: cubic-bezier(0.34, 1.56, 0.64, 1);
        --ease-smooth: cubic-bezier(0.16, 1, 0.3, 1);
    }

    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        background-color: var(--bg-warm);
        color: var(--text-dark);
        margin: 0;
        min-height: 100vh;
        overflow-x: hidden;
        -webkit-font-smoothing: antialiased;
    }

    /* --- AMBIENT BACKGROUND --- */
    .scenery-layer {
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        z-index: -1;
        overflow: hidden;
        background: var(--bg-warm);
    }
    .blob {
        position: absolute;
        filter: blur(80px);
        opacity: 0.5;
        animation: float-blob 20s infinite ease-in-out alternate;
    }
    .b-1 { top: -10%; right: -5%; width: 600px; height: 600px;
        background: var(--pop-purple); border-radius: 40% 60% 70% 30%; }
    .b-2 { bottom: -10%; left: -10%; width: 700px;
        height: 700px; background: var(--pop-teal); border-radius: 60% 40% 30% 70%; animation-delay: -5s; }
    .b-3 { top: 40%;
        left: 40%; width: 400px; height: 400px; background: var(--pop-coral); opacity: 0.3; border-radius: 30% 70%; animation-duration: 18s;
    }

    @keyframes float-blob {
        0% { transform: translate(0, 0) rotate(0deg); }
        100% { transform: translate(40px, 40px) rotate(10deg); }
    }

    /* --- LAYOUT --- */
    .test-page {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 20px;
        position: relative;
        z-index: 1;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .mobile-container {
        background: var(--card-base);
        border-radius: 32px;
        padding: 48px 56px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
        margin: 0 auto;
        width: 100%;
        max-width: 100%;
    }

    /* --- PROGRESS BAR --- */
    .progress-container {
        margin-bottom: 24px;
    }

    .progress-bar {
        height: 10px;
        background: #F0F0F3;
        border-radius: 100px;
        overflow: hidden;
        position: relative;
    }

    .progress-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--pop-teal), var(--pop-purple));
        border-radius: 100px;
        width: 0%;
        transition: width 0.5s var(--ease-smooth);
    }

    .progress-text {
        margin-top: 8px;
        text-align: center;
        font-weight: 700;
        color: var(--text-grey);
        font-size: 0.85rem;
    }

    /* --- STEP CONTAINERS --- */
    .step-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
        display: flex;
        flex-direction: column;
    }

    .step-container.hidden {
        display: none;
    }

    .step-container h2 {
        font-size: clamp(2rem, 4vw, 2.5rem);
        font-weight: 800;
        letter-spacing: -0.03em;
        margin: 0 0 16px 0;
        line-height: 1.2;
        color: var(--text-dark);
    }

    .step-container p {
        font-size: 1.1rem;
        color: var(--text-grey);
        line-height: 1.6;
        font-weight: 600;
        margin: 0 0 32px 0;
    }

    /* --- GENDER SELECTION --- */
    .gender-options {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        margin-bottom: 32px;
    }

    .gender-btn {
        background: white;
        border: 2px solid #F0F0F5;
        border-radius: 20px;
        padding: 32px 20px;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-family: inherit;
        font-size: 1.1rem;
        font-weight: 700;
        color: var(--text-dark);
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 12px;
    }

    .gender-btn:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow-float);
        border-color: var(--pop-purple);
    }

    .gender-btn.selected {
        background: linear-gradient(135deg, #F4F3FF 0%, #E5E2FF 100%);
        border-color: var(--pop-purple);
        box-shadow: var(--shadow-float);
    }

    .gender-icon {
        font-size: 3.5rem;
    }

    /* --- TEST GRID --- */
    .test-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 24px;
        margin-bottom: 0;
        max-height: none;
        overflow: visible;
    }

    .test-card {
        background: white;
        border-radius: 24px;
        padding: 28px;
        border: 2px solid #F0F0F5;
        transition: all 0.3s var(--ease-elastic);
        cursor: pointer;
        box-shadow: var(--shadow-soft);
        height: 100%;
        display: flex;
        flex-direction: column;
        position: relative;
    }

    .test-card:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow-float);
        border-color: var(--pop-purple);
    }

    .test-card.selected {
        background: linear-gradient(135deg, #F4F3FF 0%, #E5E2FF 100%);
        border-color: var(--pop-purple);
        box-shadow: var(--shadow-float);
    }

    .test-icon {
        font-size: 3.5rem;
        margin-bottom: 16px;
        text-align: center;
    }

    .test-start-btn {
        margin-top: 16px;
        padding: 14px 28px;
        background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
        color: white;
        border: none;
        border-radius: 100px;
        font-weight: 700;
        font-size: 1.05rem;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-family: inherit;
        width: 100%;
        display: none;
        box-shadow: var(--shadow-float);
    }

    .test-card.selected .test-start-btn {
        display: block;
    }

    .test-start-btn:hover {
        transform: translateY(-2px) scale(1.02);
        box-shadow: 0 20px 40px -12px rgba(159, 151, 243, 0.4);
    }

    .test-badge {
        padding: 6px 14px;
        border-radius: 10px;
        font-size: 0.75rem;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        display: inline-block;
        margin-bottom: 16px;
        width: fit-content;
    }

    .test-badge.diagnostic {
        background: rgba(159, 151, 243, 0.1);
        color: var(--pop-purple);
    }

    .test-badge.exam {
        background: rgba(115, 210, 222, 0.1);
        color: var(--pop-teal);
    }

    .test-badge.career {
        background: rgba(255, 143, 125, 0.1);
        color: var(--pop-coral);
    }

    .test-card h3 {
        font-weight: 800;
        color: var(--text-dark);
        margin: 0 0 12px 0;
        font-size: 1.3rem;
        letter-spacing: -0.02em;
    }

    .test-card p {
        color: var(--text-grey);
        font-weight: 600;
        line-height: 1.6;
        margin: 0 0 10px 0;
        font-size: 1rem;
    }

    /* --- QUESTION CONTAINER --- */
    .question-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
    }

    .question-container.hidden {
        display: none;
    }

    .question-text {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 32px;
        line-height: 1.5;
        text-align: center;
    }

    .options-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 16px;
        margin-bottom: 32px;
    }

    .option {
        background: white;
        border: 2px solid #F0F0F5;
        border-radius: 18px;
        padding: 20px 24px;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-weight: 600;
        color: var(--text-dark);
        font-size: 1.05rem;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 80px;
    }

    .option:hover {
        transform: translateY(-3px);
        border-color: var(--pop-purple);
        box-shadow: var(--shadow-soft);
    }

    .option.selected {
        background: linear-gradient(135deg, #F4F3FF 0%, #E5E2FF 100%);
        border-color: var(--pop-purple);
        box-shadow: var(--shadow-float);
        color: var(--text-dark);
        font-weight: 700;
        position: relative;
        overflow: hidden;
    }

    .option.selected::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        height: 4px;
        background: var(--pop-purple);
        width: 0%;
        animation: autoAdvanceProgress 3s linear forwards;
    }

    @keyframes autoAdvanceProgress {
        from { width: 0%; }
        to { width: 100%; }
    }

    /* --- BUTTONS --- */
    .btn {
        padding: 16px 32px;
        border-radius: 100px;
        font-weight: 700;
        font-size: 1.05rem;
        border: none;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-family: inherit;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-primary {
        background: var(--text-dark);
        color: white;
        box-shadow: var(--shadow-float);
    }

    .btn-primary:hover:not(:disabled) {
        transform: translateY(-2px) scale(1.01);
        box-shadow: 0 20px 40px -12px rgba(159, 151, 243, 0.4);
    }

    .btn-primary:disabled {
        background: #E5E5EA;
        color: #999;
        cursor: not-allowed;
        box-shadow: none;
    }

    .btn-secondary {
        background: white;
        color: var(--text-dark);
        border: 2px solid #F0F0F5;
        box-shadow: var(--shadow-soft);
    }

    .btn-secondary:hover:not(:disabled) {
        transform: translateY(-2px);
        border-color: var(--pop-purple);
        box-shadow: var(--shadow-float);
    }

    .btn-secondary:disabled {
        background: #F5F5F5;
        color: #999;
        cursor: not-allowed;
        border-color: #E5E5EA;
    }

    .navigation-buttons {
        display: flex;
        gap: 12px;
        justify-content: space-between;
        margin-top: 32px;
    }

    .navigation-buttons .btn {
        flex: 1;
    }



    /* --- TABLET --- */
    @media (max-width: 1024px) {
        .test-page {
            max-width: 900px;
            padding: 30px 16px;
        }

        .mobile-container {
            padding: 36px 32px;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .options-container {
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        }
    }

    /* --- SMALL TABLET --- */
    @media (max-width: 900px) {
        .test-page {
            padding: 24px 12px;
        }

        .mobile-container {
            padding: 32px 24px;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 14px;
        }

        .test-card {
            padding: 22px 18px;
        }

        .test-icon {
            font-size: 2.8rem;
        }

        .step-container h2 {
            font-size: 1.8rem;
        }

        .step-container p {
            font-size: 1rem;
        }
    }

    /* --- MOBILE --- */
    @media (max-width: 768px) {
        body {
            overflow-x: hidden;
        }

        .test-page {
            padding: 12px 8px;
            max-width: 100%;
        }

        .mobile-container {
            padding: 24px 16px;
            margin: 0;
            border-radius: 20px;
            width: calc(100% - 16px);
            max-width: 100%;
        }

        .progress-container {
            margin-bottom: 20px;
        }

        .progress-bar {
            height: 8px;
        }

        .progress-text {
            font-size: 0.75rem;
            margin-top: 6px;
        }

        .step-container h2 {
            font-size: 1.5rem;
            margin-bottom: 12px;
        }

        .step-container p {
            font-size: 0.9rem;
            margin-bottom: 20px;
        }

        .gender-options {
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-bottom: 20px;
        }

        .gender-btn {
            padding: 16px 8px;
            font-size: 0.85rem;
            border-radius: 16px;
        }

        .gender-icon {
            font-size: 2.5rem;
            margin-bottom: 4px;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .test-card {
            padding: 16px 12px;
            border-radius: 20px;
        }

        .test-icon {
            font-size: 2.5rem;
            margin-bottom: 8px;
        }

        .test-card h3 {
            font-size: 0.95rem;
            margin-bottom: 6px;
            line-height: 1.2;
        }

        .test-card p {
            font-size: 0.75rem;
            margin-bottom: 4px;
            line-height: 1.4;
        }

        .test-card p:last-of-type {
            font-size: 0.7rem !important;
            margin-bottom: 0;
        }

        .test-badge {
            font-size: 0.6rem;
            padding: 4px 8px;
            margin-bottom: 8px;
        }

        .test-start-btn {
            padding: 10px 16px;
            font-size: 0.85rem;
            margin-top: 10px;
        }

        .question-text {
            font-size: 1.1rem;
            margin-bottom: 20px;
            text-align: left;
        }

        .options-container {
            grid-template-columns: 1fr;
            gap: 10px;
            margin-bottom: 20px;
        }

        .option {
            padding: 16px 18px;
            font-size: 0.9rem;
            min-height: 56px;
            text-align: left;
        }

        .navigation-buttons {
            flex-direction: column;
            gap: 10px;
            margin-top: 20px;
        }

        .navigation-buttons .btn {
            width: 100%;
            justify-content: center;
        }

        .btn {
            padding: 14px 20px;
            font-size: 0.95rem;
        }
    }

    /* --- EXTRA SMALL MOBILE --- */
    @media (max-width: 480px) {
        .test-page {
            padding: 8px 4px;
        }

        .mobile-container {
            padding: 20px 12px;
            border-radius: 16px;
        }

        .step-container h2 {
            font-size: 1.3rem;
        }

        .step-container p {
            font-size: 0.85rem;
        }

        .gender-btn {
            padding: 14px 6px;
            font-size: 0.8rem;
        }

        .gender-icon {
            font-size: 2.2rem;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 8px;
        }

        .test-card {
            padding: 14px 10px;
            border-radius: 18px;
        }

        .test-icon {
            font-size: 2.2rem;
            margin-bottom: 6px;
        }

        .test-card h3 {
            font-size: 0.85rem;
            margin-bottom: 4px;
            line-height: 1.2;
        }

        .test-card p {
            font-size: 0.7rem;
            margin-bottom: 3px;
            line-height: 1.3;
        }

        .test-card p:last-of-type {
            font-size: 0.65rem !important;
        }

        .test-badge {
            font-size: 0.55rem;
            padding: 3px 7px;
            margin-bottom: 6px;
        }

        .test-start-btn {
            padding: 9px 14px;
            font-size: 0.8rem;
            margin-top: 8px;
        }

        .question-text {
            font-size: 1rem;
        }

        .option {
            padding: 14px 16px;
            font-size: 0.85rem;
            min-height: 50px;
        }
    }

    /* UTILS */
    .animate-in { opacity: 0; animation: reveal 0.8s var(--ease-smooth) forwards; }
    @keyframes reveal { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

<div class="test-page">
    <div class="mobile-container animate-in">
            <!-- Progress Bar -->
            <div class="progress-container">
                <div class="progress-bar">
                    <div class="progress-fill" id="progressBar"></div>
                </div>
                <div class="progress-text">
                    <span id="progressText">Step 1 of 3</span>
                </div>
            </div>

            <!-- Step 1: Gender Selection -->
            <div id="genderSelection" class="step-container">
                <button id="genderNextBtn" class="btn btn-primary action-button-top" disabled onclick="showTestSelection()">
                    Continue →
                </button>
                <h2>Before we begin...</h2>
                <p>Please select your gender for personalized results:</p>
                <div class="gender-options">
                    <button class="gender-btn" data-gender="Male">
                        <span class="gender-icon">👨</span>
                        <div>Male</div>
                    </button>
                    <button class="gender-btn" data-gender="Female">
                        <span class="gender-icon">👩</span>
                        <div>Female</div>
                    </button>
                    <button class="gender-btn" data-gender="Other">
                        <span class="gender-icon">🧑</span>
                        <div>Other</div>
                    </button>
                </div>
            </div>

            <!-- Step 2: Test Selection -->
            <div id="testSelection" class="step-container hidden">
                <h2>Choose Your Diagnostic Test</h2>
                <p>Select one test to discover insights about yourself:</p>
                <div id="testGrid" class="test-grid">
                    <!-- Tests will be loaded here -->
                </div>
            </div>

            <!-- Step 3: Question Container -->
            <div id="questionContainer" class="question-container hidden">
                <div class="question-text" id="questionText"></div>
                <div class="options-container" id="optionsContainer">
                    <!-- Options will be dynamically inserted here -->
                </div>
                <div class="navigation-buttons">
                    <button id="prevBtn" class="btn btn-secondary" onclick="previousQuestion()">
                        ← Previous
                    </button>
                    <button id="nextBtn" class="btn btn-primary" onclick="nextQuestion()">
                        Next →
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let selectedGender = null;
        let selectedTest = null;
        let allTests = [];
        let questions = [];
        let currentQuestionIndex = 0;
        let answers = [];
        let sessionId = null;
        let autoAdvanceTimer = null;

        // Load tests on page load
        document.addEventListener('DOMContentLoaded', function() {
            setupGenderSelection();
            loadTests();
        });

        // Setup gender selection
        function setupGenderSelection() {
            const genderButtons = document.querySelectorAll('.gender-btn');
            const nextBtn = document.getElementById('genderNextBtn');

            genderButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    // Remove selected class from all buttons
                    genderButtons.forEach(b => b.classList.remove('selected'));

                    // Add selected class to clicked button
                    this.classList.add('selected');
                    selectedGender = this.dataset.gender;

                    // Enable next button
                    nextBtn.disabled = false;
                });
            });
        }

        // Load all diagnostic tests
        async function loadTests() {
            try {
                const response = await fetch('/api/diagnostic/tests');
                if (!response.ok) throw new Error('Failed to load tests');

                allTests = await response.json();
                renderTests();
            } catch (error) {
                console.error('Error loading tests:', error);
                alert('Failed to load tests. Please try again.');
            }
        }

        // Test emoji mapping
        const testEmojis = {
            'SPIRIT_ANIMAL': '🦉',
            'COGNITIVE_RADAR': '🧠',
            'FOCUS_STAMINA': '⚡',
            'GUESSWORK_QUOTIENT': '🎲',
            'CURIOSITY_COMPASS': '🧭',
            'MODALITY_MAP': '🎨',
            'CHALLENGE_DRIVER': '🏆',
            'WORK_MODE': '💼',
            'PATTERN_SNAPSHOT': '🔍'
        };

        // Render tests in grid
        function renderTests() {
            const testGrid = document.getElementById('testGrid');
            testGrid.innerHTML = allTests.map(test => {
                const emoji = testEmojis[test.testId] || '📝';
                return '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
                    '<div class="test-icon">' + emoji + '</div>' +
                    '<div class="test-badge ' + test.testType.toLowerCase() + '">' + test.testType + '</div>' +
                    '<h3>' + test.testName + '</h3>' +
                    '<p>' + (test.description || '') + '</p>' +
                    '<p style="font-size: 0.9rem; color: #999; margin-bottom: 0;">' +
                        test.questionCount + ' questions • ' + test.estimatedMinutes + ' min' +
                    '</p>' +
                    '<button class="test-start-btn" onclick="event.stopPropagation(); startTest()">Start Test →</button>' +
                '</div>';
            }).join('');
        }

        // Select a test
        function selectTest(testId) {
            const testCards = document.querySelectorAll('.test-card');
            testCards.forEach(card => card.classList.remove('selected'));

            const selectedCard = document.querySelector('[data-test-id="' + testId + '"]');
            selectedCard.classList.add('selected');

            selectedTest = allTests.find(t => t.testId === testId);
        }

        // Show test selection
        function showTestSelection() {
            document.getElementById('genderSelection').classList.add('hidden');
            document.getElementById('testSelection').classList.remove('hidden');
            updateProgress(33, 'Step 2 of 3');
        }

        // Start the test
        async function startTest() {
            try {
                // Start test session
                const response = await fetch('/api/diagnostic/start', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ testId: selectedTest.testId })
                });

                if (!response.ok) throw new Error('Failed to start test');

                const result = await response.json();
                sessionId = result.sessionId;

                // Load questions
                const questionsResponse = await fetch('/api/diagnostic/questions/' + selectedTest.testId);
                if (!questionsResponse.ok) throw new Error('Failed to load questions');

                questions = await questionsResponse.json();
                answers = new Array(questions.length).fill(null);

                // Show question container
                document.getElementById('testSelection').classList.add('hidden');
                document.getElementById('questionContainer').classList.remove('hidden');
                updateProgress(66, 'Question 1 of ' + questions.length);

                // Show first question
                showQuestion(0);
            } catch (error) {
                console.error('Error starting test:', error);
                alert('Failed to start test. Please try again.');
            }
        }

        // Show question
        function showQuestion(index) {
            // Clear any existing timer when changing questions
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            currentQuestionIndex = index;
            const question = questions[index];

            // Update question text
            document.getElementById('questionText').textContent = question.questionText;

            // Update progress
            const progress = 66 + (((index + 1) / questions.length) * 34);
            updateProgress(progress, 'Question ' + (index + 1) + ' of ' + questions.length);

            // Render options
            const optionsContainer = document.getElementById('optionsContainer');
            optionsContainer.innerHTML = '';

            question.options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'option';
                optionDiv.dataset.value = option.optionValue;
                optionDiv.textContent = option.optionText;

                // Check if this option was previously selected
                if (answers[index] === option.optionValue) {
                    optionDiv.classList.add('selected');
                }

                optionDiv.addEventListener('click', function() {
                    selectOption(option.optionValue);
                });

                optionsContainer.appendChild(optionDiv);
            });

            // Update navigation buttons
            updateNavigationButtons();
        }

        // Select option
        function selectOption(value) {
            // Clear any existing timer
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            // Save answer
            answers[currentQuestionIndex] = value;

            // Update UI - remove selected class from all first
            const options = document.querySelectorAll('.option');
            options.forEach(opt => {
                opt.classList.remove('selected');
                // Remove and re-add to restart animation
                void opt.offsetWidth; // Trigger reflow
            });

            // Add selected class to chosen option
            options.forEach(opt => {
                if (opt.dataset.value === value) {
                    opt.classList.add('selected');
                }
            });

            // Enable next button
            document.getElementById('nextBtn').disabled = false;

            // Auto-advance after 3 seconds
            autoAdvanceTimer = setTimeout(() => {
                if (currentQuestionIndex < questions.length - 1) {
                    showQuestion(currentQuestionIndex + 1);
                } else {
                    // Last question - just keep it selected, user needs to click submit
                    // Don't auto-submit
                }
            }, 3000);
        }

        // Next question
        function nextQuestion() {
            if (answers[currentQuestionIndex] === null) {
                alert('Please select an answer');
                return;
            }

            if (currentQuestionIndex < questions.length - 1) {
                showQuestion(currentQuestionIndex + 1);
            } else {
                // Submit test
                submitTest();
            }
        }

        // Previous question
        function previousQuestion() {
            // Clear any existing timer
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            if (currentQuestionIndex > 0) {
                showQuestion(currentQuestionIndex - 1);
            }
        }

        // Update navigation buttons
        function updateNavigationButtons() {
            const prevBtn = document.getElementById('prevBtn');
            const nextBtn = document.getElementById('nextBtn');

            prevBtn.disabled = currentQuestionIndex === 0;
            nextBtn.disabled = answers[currentQuestionIndex] === null;

            if (currentQuestionIndex === questions.length - 1) {
                nextBtn.textContent = 'Submit Test';
            } else {
                nextBtn.textContent = 'Next →';
            }
        }

        // Update progress
        function updateProgress(percentage, text) {
            document.getElementById('progressBar').style.width = percentage + '%';
            document.getElementById('progressText').textContent = text;
        }

        // Submit test
        async function submitTest() {
            // Validate all questions answered
            const unanswered = answers.filter(a => a === null).length;
            if (unanswered > 0) {
                alert('Please answer all questions. ' + unanswered + ' question(s) remaining.');
                return;
            }

            updateProgress(100, 'Processing results...');

            try {
                // Prepare answers in the format expected by the API
                const formattedAnswers = questions.map((q, index) => ({
                    questionId: q.questionId,
                    answerValue: answers[index],
                    timeSpent: 0
                }));

                const response = await fetch('/api/diagnostic/submit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        sessionId: sessionId,
                        answers: formattedAnswers
                    })
                });

                if (!response.ok) throw new Error('Failed to submit test');

                const result = await response.json();

                if (result.success) {
                    // Redirect to results page
                    window.location.href = '/diagnostic/result/' + sessionId;
                } else {
                    throw new Error(result.error || 'Failed to submit test');
                }
            } catch (error) {
                console.error('Error submitting test:', error);
                alert('Failed to submit test. Please try again.');

                // Restore UI
                document.getElementById('questionContainer').classList.remove('hidden');
                updateProgress(66, 'Question ' + (currentQuestionIndex + 1) + ' of ' + questions.length);
            }
        }
    </script>
</body>
</html>


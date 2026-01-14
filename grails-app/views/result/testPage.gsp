<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <g:set var="pageTitle" value="${test.testName} - Free Student Diagnostic Test | LearnerDNA" />
    <g:set var="pageDescription" value="${test.description} - Take this ${test.estimatedMinutes}-minute diagnostic test to discover insights about your learning style and cognitive strengths. Free, no signup required." />
    <g:set var="pageKeywords" value="${test.testName}, diagnostic test, learning assessment, student test" />

    <!-- Quiz Schema for Test Page -->
    <g:set var="structuredData">
    {
        "@context": "https://schema.org",
        "@type": "Quiz",
        "name": "${test.testName}",
        "description": "${test.description}",
        "educationalLevel": "High School",
        "timeRequired": "PT${test.estimatedMinutes}M",
        "numberOfQuestions": ${test.questionCount},
        "provider": {
            "@type": "EducationalOrganization",
            "name": "LearnerDNA",
            "url": "${request.scheme}://${request.serverName}"
        },
        "isAccessibleForFree": true,
        "inLanguage": "en-IN"
    }
    </g:set>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle}</title>
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

    /* Prevent scrolling on mobile - fit everything in viewport */
    @media (max-width: 768px) {
        body {
            overflow: hidden;
            position: fixed;
            width: 100%;
            height: 100vh;
        }
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
    .test-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 40px 0;
        position: relative;
        z-index: 1;
    }

    .test-header {
        background: var(--card-base);
        border-radius: 32px;
        padding: 50px 40px;
        margin: 0 24px 30px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
        text-align: center;
    }

    .test-header h1 {
        font-size: clamp(2rem, 5vw, 2.8rem);
        margin-bottom: 20px;
        color: var(--text-dark);
        font-weight: 800;
        letter-spacing: -0.03em;
        line-height: 1.2;
    }

    .test-header p {
        font-size: 1.15rem;
        color: var(--text-grey);
        margin-bottom: 24px;
        line-height: 1.7;
        font-weight: 600;
    }

    .test-meta {
        display: flex;
        justify-content: center;
        gap: 24px;
        font-size: 1rem;
        color: var(--text-grey);
        font-weight: 700;
        flex-wrap: wrap;
    }

    .test-meta span {
        background: var(--pop-cream);
        padding: 8px 16px;
        border-radius: 12px;
    }

    .progress-container {
        display: none !important;
    }

    .progress-bar {
        display: none !important;
    }

    .progress-fill {
        display: none !important;
    }

    .progress-text {
        display: none !important;
    }

    .question-card {
        background: var(--card-base);
        border-radius: 32px;
        padding: 50px 40px;
        margin: 0 24px 20px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
        display: none;
    }

    .question-card.active {
        display: block;
        animation: slideIn 0.5s var(--ease-smooth);
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* HIDE QUESTION NUMBERS - This is a game, not a test */
    .question-number {
        display: none !important;
    }

    /* Game Moment Text - Centered, Short, Impactful */
    .question-text {
        font-size: clamp(1.6rem, 4vw, 2.4rem);
        font-weight: 900;
        color: var(--text-dark);
        margin-bottom: 48px;
        line-height: 1.3;
        letter-spacing: -0.03em;
        text-align: center;
        text-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    /* Countdown/Tension Phase */
    .countdown-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 180px;
        margin-bottom: 40px;
    }

    .countdown-bar {
        width: 100%;
        max-width: 400px;
        height: 12px;
        background: rgba(255, 255, 255, 0.4);
        border-radius: 50px;
        overflow: hidden;
        margin-bottom: 24px;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .countdown-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--pop-coral) 0%, var(--pop-yellow) 100%);
        width: 100%;
        animation: countdownPulse 2s ease-in-out forwards;
        box-shadow: 0 0 20px rgba(255, 143, 125, 0.6);
    }

    @keyframes countdownPulse {
        0% { width: 100%; opacity: 1; }
        100% { width: 0%; opacity: 0.5; }
    }

    .countdown-text {
        font-size: 1.2rem;
        font-weight: 700;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
        animation: pulse 1s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% { opacity: 0.6; transform: scale(1); }
        50% { opacity: 1; transform: scale(1.05); }
    }

    /* Options appear AFTER countdown */
    .options-container {
        display: flex;
        flex-direction: column;
        gap: 18px;
        opacity: 0;
        transform: translateY(20px);
    }

    .options-container.show {
        animation: optionsAppear 0.5s var(--ease-elastic) forwards;
    }

    @keyframes optionsAppear {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Action Buttons - NOT answer choices */
    .option {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.85) 100%);
        backdrop-filter: blur(10px);
        border: 3px solid rgba(159, 151, 243, 0.3);
        border-radius: 24px;
        padding: 26px 32px;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-size: 1.15rem;
        font-weight: 700;
        color: var(--text-dark);
        box-shadow: 0 8px 24px rgba(159, 151, 243, 0.15);
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .option::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(159, 151, 243, 0.05) 0%, rgba(115, 210, 222, 0.05) 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .option:hover::before {
        opacity: 1;
    }

    .option:hover {
        background: linear-gradient(135deg, rgba(159, 151, 243, 0.15) 0%, rgba(115, 210, 222, 0.15) 100%);
        border-color: var(--pop-purple);
        transform: translateY(-4px) scale(1.01);
        box-shadow: 0 16px 40px rgba(159, 151, 243, 0.25);
    }

    .option.selected {
        background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
        color: white;
        border-color: var(--pop-teal);
        font-weight: 800;
        transform: translateY(-4px) scale(1.02);
        box-shadow: 0 12px 32px rgba(115, 210, 222, 0.4);
        position: relative;
        overflow: hidden;
    }

    .option.selected::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        height: 6px;
        background: rgba(255, 255, 255, 0.9);
        width: 0%;
        animation: autoAdvanceProgress 2s linear forwards;
        box-shadow: 0 0 10px rgba(255, 255, 255, 0.6);
    }

    @keyframes autoAdvanceProgress {
        from { width: 0%; }
        to { width: 100%; }
    }

    /* HIDE NAVIGATION BUTTONS - Game auto-advances */
    .navigation-buttons {
        display: none !important;
    }

    .btn {
        display: none !important;
    }

    /* Game Progress Dots */
    .game-progress-meter {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin-top: 32px;
    }

    .progress-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(159, 151, 243, 0.2);
        transition: all 0.3s var(--ease-elastic);
    }

    .progress-dot.completed {
        background: linear-gradient(135deg, var(--pop-teal) 0%, var(--pop-purple) 100%);
        box-shadow: 0 0 12px rgba(115, 210, 222, 0.6);
        transform: scale(1.2);
    }

    .progress-dot.current {
        background: linear-gradient(135deg, var(--pop-yellow) 0%, var(--pop-coral) 100%);
        box-shadow: 0 0 16px rgba(255, 216, 109, 0.8);
        transform: scale(1.4);
        animation: currentDotPulse 1.5s ease-in-out infinite;
    }

    @keyframes currentDotPulse {
        0%, 100% { transform: scale(1.4); opacity: 1; }
        50% { transform: scale(1.6); opacity: 0.8; }
    }

    .loading {
        text-align: center;
        padding: 80px 20px;
        font-size: 1.3rem;
        color: var(--text-grey);
        font-weight: 600;
    }

    /* --- RESPONSIVE - FIT EVERYTHING IN ONE SCREEN --- */
    @media (max-width: 768px) {
        body {
            overflow: hidden;
        }

        .test-container {
            padding: 4px 0;
            max-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* HIDE test header completely on mobile to save space */
        .test-header {
            display: none !important;
        }

        .progress-container {
            margin: 0 8px 6px;
            padding: 6px 0;
            position: relative;
            top: 0;
        }

        .progress-bar {
            height: 4px;
            margin: 0 8px;
        }

        .progress-text {
            font-size: 0.7rem;
            margin-top: 4px;
            text-align: center;
            font-weight: 700;
        }

        .question-card {
            padding: 12px 8px;
            margin: 0 8px;
            max-height: calc(100vh - 60px);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
            border-radius: 24px;
        }

        .question-text {
            font-size: 0.95rem;
            margin-bottom: 10px;
            line-height: 1.2;
            padding: 0 6px;
            font-weight: 800;
        }

        .countdown-container {
            min-height: 60px;
            margin-bottom: 12px;
        }

        .countdown-bar {
            max-width: 200px;
            height: 6px;
        }

        .countdown-text {
            font-size: 0.8rem;
        }

        .options-container {
            gap: 8px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            overflow-y: auto;
            padding: 2px 0;
        }

        .option {
            padding: 14px 16px;
            font-size: 0.85rem;
            min-height: 50px;
            line-height: 1.2;
            border-radius: 16px;
        }

        .game-progress-meter {
            margin-top: 8px;
            padding: 6px 0;
        }

        .progress-dot {
            width: 6px;
            height: 6px;
            gap: 6px;
        }
    }
    </style>
</head>
<body>

<!-- Ambient Background -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

    <div class="test-container">
        <div class="test-header">
            <h1>${test.testName}</h1>
            <p>${test.description}</p>
            <div class="test-meta">
                <span>🎮 ${test.questionCount} levels</span>
                <span>⏱️ ${test.estimatedMinutes} min</span>
            </div>
        </div>

        <div class="progress-container" style="background: transparent !important; backdrop-filter: none !important; -webkit-backdrop-filter: none !important; box-shadow: none !important; border: none !important;">
            <div class="progress-bar">
                <div class="progress-fill" id="progress-fill" style="width: 0%"></div>
            </div>
            <div class="progress-text" id="progress-text">Loading game...</div>
        </div>

        <div id="questions-container">
            <div class="loading">Loading game...</div>
        </div>
    </div>
    
    <script>
        let currentQuestionIndex = 0;
        let questions = [];
        let answers = [];
        let sessionId = null;
        let autoAdvanceTimer = null;
        const testId = '${test.testId}';

        // Save page state to localStorage
        function savePageState() {
            const state = {
                testId: testId,
                sessionId: sessionId,
                currentQuestionIndex: currentQuestionIndex,
                answers: answers,
                questions: questions,
                timestamp: Date.now()
            };
            localStorage.setItem('diagnostic_test_state_' + testId, JSON.stringify(state));
        }

        // Restore page state from localStorage
        function restorePageState() {
            try {
                const savedState = localStorage.getItem('diagnostic_test_state_' + testId);
                if (!savedState) return false;

                const state = JSON.parse(savedState);

                // Only restore if less than 1 hour old
                if (Date.now() - state.timestamp > 3600000) {
                    localStorage.removeItem('diagnostic_test_state_' + testId);
                    return false;
                }

                // Restore state variables
                if (state.sessionId) sessionId = state.sessionId;
                if (state.currentQuestionIndex !== undefined) currentQuestionIndex = state.currentQuestionIndex;
                if (state.answers) answers = state.answers;
                if (state.questions) questions = state.questions;

                return true;
            } catch (error) {
                console.error('Error restoring page state:', error);
                localStorage.removeItem('diagnostic_test_state_' + testId);
                return false;
            }
        }

        // Clear page state from localStorage
        function clearPageState() {
            localStorage.removeItem('diagnostic_test_state_' + testId);
        }

        // Load questions and start session
        async function initTest() {
            try {
                // Try to restore saved state first
                const restored = restorePageState();

                if (restored && sessionId && questions.length > 0) {
                    // State was restored, just render and show current question
                    renderQuestions();
                    showQuestion(currentQuestionIndex);
                    savePageState(); // Update timestamp
                } else {
                    // Start new session
                    const sessionResponse = await fetch('/api/diagnostic/start', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({ testId: testId })
                    });
                    const sessionData = await sessionResponse.json();
                    sessionId = sessionData.sessionId;

                    // Load questions
                    const questionsResponse = await fetch('/api/diagnostic/questions/' + testId);
                    questions = await questionsResponse.json();

                    // Initialize answers array
                    answers = questions.map(q => ({
                        questionId: q.questionId,
                        answerValue: null,
                        timeSpent: 0
                    }));

                    renderQuestions();
                    showQuestion(0);
                    savePageState();
                }
            } catch (error) {
                console.error('Error initializing test:', error);
                alert('Failed to load test. Please try again.');
            }
        }
        
        function renderQuestions() {
            const container = document.getElementById('questions-container');
            var html = '';

            questions.forEach(function(q, index) {
                html += '<div class="question-card" data-index="' + index + '">' +
                    '<div class="countdown-container" style="display: none;">' +
                        '<div class="countdown-bar">' +
                            '<div class="countdown-fill"></div>' +
                        '</div>' +
                        '<div class="countdown-text">Get Ready...</div>' +
                    '</div>' +
                    '<div class="question-text">' + q.questionText + '</div>' +
                    '<div class="options-container"></div>' +
                    '<div class="game-progress-meter"></div>' +
                '</div>';
            });

            container.innerHTML = html;
        }
        
        function showQuestion(index) {
            // Clear any existing timer
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            // Hide all cards
            document.querySelectorAll('.question-card').forEach(function(card) {
                card.classList.remove('active');
            });

            const currentCard = document.querySelector('[data-index="' + index + '"]');
            currentCard.classList.add('active');
            currentQuestionIndex = index;

            // Update progress with game language
            updateProgress();

            const question = questions[index];
            const countdownContainer = currentCard.querySelector('.countdown-container');
            const optionsContainer = currentCard.querySelector('.options-container');
            const questionText = currentCard.querySelector('.question-text');

            // Hide options initially
            optionsContainer.classList.remove('show');
            optionsContainer.innerHTML = '';
            questionText.style.opacity = '0';

            // Show countdown phase
            countdownContainer.style.display = 'flex';

            // Reset countdown animation
            const countdownFill = countdownContainer.querySelector('.countdown-fill');
            countdownFill.style.animation = 'none';
            void countdownFill.offsetWidth; // Trigger reflow
            countdownFill.style.animation = 'countdownPulse 2s ease-in-out forwards';

            // Fade in question text
            setTimeout(() => {
                questionText.style.transition = 'opacity 0.5s ease';
                questionText.style.opacity = '1';
            }, 100);

            // After countdown (2 seconds), show reaction options
            setTimeout(() => {
                countdownContainer.style.display = 'none';

                // Render action buttons
                question.options.forEach(function(opt) {
                    const optionDiv = document.createElement('div');
                    optionDiv.className = 'option';
                    optionDiv.dataset.value = opt.optionValue;
                    optionDiv.textContent = opt.optionText;

                    // Check if previously selected
                    if (answers[index].answerValue === opt.optionValue) {
                        optionDiv.classList.add('selected');
                    }

                    optionDiv.addEventListener('click', function() {
                        selectOption(index, opt.optionValue);
                    });

                    optionsContainer.appendChild(optionDiv);
                });

                // Show options with animation
                optionsContainer.classList.add('show');

                // Update progress dots
                updateGameProgressDots(currentCard);
            }, 2000);
        }

        function selectOption(questionIndex, value) {
            // Clear any existing timer
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            // Remove previous selection and trigger reflow to restart animation
            const options = document.querySelectorAll('[data-index="' + questionIndex + '"] .option');
            options.forEach(function(opt) {
                opt.classList.remove('selected');
                void opt.offsetWidth; // Trigger reflow
            });

            // Add new selection
            event.target.classList.add('selected');

            // Save answer
            answers[questionIndex].answerValue = value;

            // Save state to localStorage
            savePageState();

            // Auto-advance after 2 seconds (faster game pace)
            autoAdvanceTimer = setTimeout(function() {
                if (currentQuestionIndex < questions.length - 1) {
                    // Fade out current screen
                    const currentCard = document.querySelector('[data-index="' + currentQuestionIndex + '"]');
                    currentCard.style.opacity = '0';
                    currentCard.style.transform = 'translateY(-20px)';

                    setTimeout(() => {
                        currentCard.style.opacity = '1';
                        currentCard.style.transform = 'translateY(0)';
                        showQuestion(currentQuestionIndex + 1);
                    }, 300);
                } else {
                    // Last question - auto-submit after showing selection
                    setTimeout(function() {
                        submitTest();
                    }, 1000);
                }
            }, 2000);
        }
        
        // Update Game Progress Dots
        function updateGameProgressDots(card) {
            const progressMeter = card.querySelector('.game-progress-meter');
            if (!progressMeter) return;

            progressMeter.innerHTML = '';

            questions.forEach((q, index) => {
                const dot = document.createElement('div');
                dot.className = 'progress-dot';

                if (index < currentQuestionIndex) {
                    dot.classList.add('completed');
                } else if (index === currentQuestionIndex) {
                    dot.classList.add('current');
                }

                progressMeter.appendChild(dot);
            });
        }

        function updateProgress() {
            const answeredCount = answers.filter(function(a) { return a.answerValue !== null; }).length;
            const percentage = (answeredCount / questions.length) * 100;
            document.getElementById('progress-fill').style.width = percentage + '%';

            // Update progress text with game language
            const progressText = document.getElementById('progress-text');
            if (progressText) {
                progressText.textContent = 'Level ' + (currentQuestionIndex + 1) + ' of ' + questions.length;
            }
        }
        
        async function submitTest() {
            try {
                const response = await fetch('/api/diagnostic/submit', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        sessionId: sessionId,
                        answers: answers
                    })
                });
                
                const result = await response.json();
                
                if (result.success) {
                    // Clear saved state before redirecting
                    clearPageState();
                    // Redirect to results page
                    window.location.href = '/diagnostic/result/' + sessionId;
                } else {
                    alert('Failed to submit test. Please try again.');
                }
            } catch (error) {
                console.error('Error submitting test:', error);
                alert('Failed to submit test. Please try again.');
            }
        }
        
        // Initialize test on page load
        document.addEventListener('DOMContentLoaded', initTest);
    </script>
</body>
</html>


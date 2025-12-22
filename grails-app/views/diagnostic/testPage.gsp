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
        position: sticky;
        top: 0;
        background: var(--bg-warm);
        padding: 16px 0;
        margin: 0 0 20px;
        z-index: 100;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    }

    .progress-bar {
        background: #F0F0F3;
        height: 12px;
        border-radius: 100px;
        margin: 0 24px;
        overflow: hidden;
        position: relative;
    }

    .progress-fill {
        background: linear-gradient(90deg, var(--pop-teal), var(--pop-purple));
        height: 100%;
        transition: width 0.5s var(--ease-smooth);
        border-radius: 100px;
    }

    .progress-text {
        text-align: center;
        font-size: 0.85rem;
        font-weight: 700;
        color: var(--text-grey);
        margin-top: 8px;
        text-transform: uppercase;
        letter-spacing: 0.05em;
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

    .question-number {
        font-size: 0.9rem;
        color: var(--text-grey);
        margin-bottom: 16px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .question-text {
        font-size: clamp(1.4rem, 3vw, 1.8rem);
        font-weight: 800;
        color: var(--text-dark);
        margin-bottom: 32px;
        line-height: 1.4;
        letter-spacing: -0.02em;
    }

    .options-container {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .option {
        background: white;
        border: 2px solid #F0F0F5;
        border-radius: 20px;
        padding: 24px;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-size: 1.1rem;
        font-weight: 600;
        color: var(--text-dark);
        box-shadow: var(--shadow-soft);
    }

    .option:hover {
        background: linear-gradient(135deg, rgba(159, 151, 243, 0.1) 0%, rgba(115, 210, 222, 0.1) 100%);
        border-color: var(--pop-purple);
        transform: translateY(-2px);
        box-shadow: var(--shadow-float);
    }

    .option.selected {
        background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
        color: white;
        border-color: var(--pop-purple);
        font-weight: 700;
        transform: translateY(-2px);
        box-shadow: var(--shadow-float);
        position: relative;
        overflow: hidden;
    }

    .option.selected::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        height: 4px;
        background: rgba(255, 255, 255, 0.8);
        width: 0%;
        animation: autoAdvanceProgress 3s linear forwards;
    }

    @keyframes autoAdvanceProgress {
        from { width: 0%; }
        to { width: 100%; }
    }

    .navigation-buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 40px;
        gap: 16px;
    }

    .btn {
        padding: 18px 40px;
        border-radius: 100px;
        font-size: 1.1rem;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        border: none;
        font-family: inherit;
    }

    .btn-primary {
        background: var(--text-dark);
        color: white;
        box-shadow: var(--shadow-float);
    }

    .btn-primary:hover:not(:disabled) {
        transform: translateY(-3px) scale(1.02);
        box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.4);
    }

    .btn-secondary {
        background: white;
        color: var(--text-dark);
        border: 2px solid #F0F0F5;
        box-shadow: var(--shadow-soft);
    }

    .btn-secondary:hover {
        transform: translateY(-3px);
        border-color: var(--pop-purple);
        box-shadow: var(--shadow-float);
    }

    .btn:disabled {
        opacity: 0.4;
        cursor: not-allowed;
        transform: none !important;
    }

    .loading {
        text-align: center;
        padding: 80px 20px;
        font-size: 1.3rem;
        color: var(--text-grey);
        font-weight: 600;
    }

    /* --- RESPONSIVE --- */
    @media (max-width: 768px) {
        .test-container {
            padding: 30px 0;
        }

        .test-header,
        .question-card,
        .progress-bar {
            margin-left: 16px;
            margin-right: 16px;
        }

        .test-header,
        .question-card {
            padding: 40px 24px;
        }

        .navigation-buttons {
            flex-direction: column;
        }

        .btn {
            width: 100%;
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
                <span>📊 ${test.questionCount} questions</span>
                <span>⏱️ ${test.estimatedMinutes} minutes</span>
            </div>
        </div>
        
        <div class="progress-container">
            <div class="progress-bar">
                <div class="progress-fill" id="progress-fill" style="width: 0%"></div>
            </div>
            <div class="progress-text" id="progress-text">Question 0 of ${test.questionCount}</div>
        </div>

        <div id="questions-container">
            <div class="loading">Loading questions...</div>
        </div>
    </div>
    
    <script>
        let currentQuestionIndex = 0;
        let questions = [];
        let answers = [];
        let sessionId = null;
        let autoAdvanceTimer = null;
        const testId = '${test.testId}';
        
        // Load questions and start session
        async function initTest() {
            try {
                // Start session
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
            } catch (error) {
                console.error('Error initializing test:', error);
                alert('Failed to load test. Please try again.');
            }
        }
        
        function renderQuestions() {
            const container = document.getElementById('questions-container');
            var html = '';

            questions.forEach(function(q, index) {
                var optionsHtml = '';
                q.options.forEach(function(opt) {
                    optionsHtml += '<div class="option" data-value="' + opt.optionValue + '" onclick="selectOption(' + index + ', \'' + opt.optionValue + '\')">' +
                        opt.optionText +
                    '</div>';
                });

                var prevButtonStyle = index === 0 ? 'style="visibility: hidden"' : '';
                var nextButtonText = index === questions.length - 1 ? 'Submit' : 'Next →';

                html += '<div class="question-card" data-index="' + index + '">' +
                    '<div class="question-number">Question ' + (index + 1) + ' of ' + questions.length + '</div>' +
                    '<div class="question-text">' + q.questionText + '</div>' +
                    '<div class="options-container">' + optionsHtml + '</div>' +
                    '<div class="navigation-buttons">' +
                        '<button class="btn btn-secondary" onclick="previousQuestion()" ' + prevButtonStyle + '>← Previous</button>' +
                        '<button class="btn btn-primary" id="next-btn-' + index + '" onclick="nextQuestion()" disabled>' + nextButtonText + '</button>' +
                    '</div>' +
                '</div>';
            });

            container.innerHTML = html;
        }
        
        function showQuestion(index) {
            // Clear any existing timer when changing questions
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            document.querySelectorAll('.question-card').forEach(function(card) {
                card.classList.remove('active');
            });
            document.querySelector('[data-index="' + index + '"]').classList.add('active');

            currentQuestionIndex = index;
            updateProgress();

            // Restore selected answer if exists
            const answer = answers[index];
            if (answer.answerValue) {
                const option = document.querySelector('[data-index="' + index + '"] [data-value="' + answer.answerValue + '"]');
                if (option) {
                    option.classList.add('selected');
                    document.getElementById('next-btn-' + index).disabled = false;
                }
            }
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

            // Enable next button
            document.getElementById('next-btn-' + questionIndex).disabled = false;

            // Auto-advance after 3 seconds
            autoAdvanceTimer = setTimeout(function() {
                if (currentQuestionIndex < questions.length - 1) {
                    showQuestion(currentQuestionIndex + 1);
                } else {
                    // Last question - just keep it selected, user needs to click submit
                    // Don't auto-submit
                }
            }, 3000);
        }
        
        function nextQuestion() {
            // Clear any existing timer
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            if (currentQuestionIndex < questions.length - 1) {
                showQuestion(currentQuestionIndex + 1);
            } else {
                submitTest();
            }
        }
        
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
        
        function updateProgress() {
            const answeredCount = answers.filter(function(a) { return a.answerValue !== null; }).length;
            const percentage = (answeredCount / questions.length) * 100;
            document.getElementById('progress-fill').style.width = percentage + '%';

            // Update progress text
            const progressText = document.getElementById('progress-text');
            if (progressText) {
                progressText.textContent = 'Question ' + (currentQuestionIndex + 1) + ' of ' + questions.length;
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


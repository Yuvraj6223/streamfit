<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Diagnostic Test - StreamFit</title>
    <style>
        .test-page {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .mobile-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .progress-container {
            background: white;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .progress-bar {
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            transition: width 0.3s ease;
            width: 0%;
        }

        .progress-text {
            text-align: center;
            font-size: 14px;
            color: #666;
            font-weight: 600;
        }

        .step-container {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .step-container h2 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }

        .step-container p {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .gender-options, .test-grid {
            display: grid;
            gap: 15px;
            margin-bottom: 20px;
        }

        .gender-options {
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        }

        .test-grid {
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        }

        .gender-btn, .test-card {
            padding: 20px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

        .gender-btn:hover, .test-card:hover {
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
        }

        .gender-btn.selected, .test-card.selected {
            border-color: #667eea;
            background: #f0f4ff;
        }

        .gender-icon {
            font-size: 48px;
            display: block;
            margin-bottom: 10px;
        }

        .test-card h3 {
            color: #333;
            margin: 10px 0;
            font-size: 18px;
        }

        .test-card p {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }

        .test-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .test-badge.exam {
            background: #e3f2fd;
            color: #1976d2;
        }

        .test-badge.career {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        .btn {
            padding: 15px 40px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .question-container {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .question-text {
            font-size: 22px;
            color: #333;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .options-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .option {
            padding: 18px 24px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 16px;
        }

        .option:hover {
            border-color: #667eea;
            background: #f0f4ff;
        }

        .option.selected {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }

        .navigation-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            justify-content: space-between;
        }

        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #d0d0d0;
        }

        .hidden {
            display: none !important;
        }
    </style>
</head>
<body>
    <div class="test-page">
        <div class="mobile-container">
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
                <button id="genderNextBtn" class="btn btn-primary" disabled onclick="showTestSelection()">
                    Continue →
                </button>
            </div>

            <!-- Step 2: Test Selection -->
            <div id="testSelection" class="step-container hidden">
                <h2>Choose Your Diagnostic Test</h2>
                <p>Select one test to discover insights about yourself:</p>
                <div id="testGrid" class="test-grid">
                    <!-- Tests will be loaded here -->
                </div>
                <button id="testNextBtn" class="btn btn-primary" disabled onclick="startTest()">
                    Start Test →
                </button>
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

        // Render tests in grid
        function renderTests() {
            const testGrid = document.getElementById('testGrid');
            testGrid.innerHTML = allTests.map(test => {
                return '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
                    '<div class="test-badge ' + test.testType.toLowerCase() + '">' + test.testType + '</div>' +
                    '<h3>' + test.testName + '</h3>' +
                    '<p>' + (test.description || '') + '</p>' +
                    '<p style="font-size: 12px; color: #999;">' +
                        test.questionCount + ' questions • ' + test.estimatedMinutes + ' min' +
                    '</p>' +
                '</div>';
            }).join('');
        }

        // Select a test
        function selectTest(testId) {
            const testCards = document.querySelectorAll('.test-card');
            testCards.forEach(card => card.classList.remove('selected'));

            const selectedCard = document.querySelector(`[data-test-id="${'$'}{testId}"]`);
            selectedCard.classList.add('selected');

            selectedTest = allTests.find(t => t.testId === testId);
            document.getElementById('testNextBtn').disabled = false;
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
            // Save answer
            answers[currentQuestionIndex] = value;

            // Update UI
            const options = document.querySelectorAll('.option');
            options.forEach(opt => {
                opt.classList.remove('selected');
                if (opt.dataset.value === value) {
                    opt.classList.add('selected');
                }
            });

            // Enable next button
            document.getElementById('nextBtn').disabled = false;
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
                alert(`Please answer all questions. ${'$'}{unanswered} question(s) remaining.`);
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
                updateProgress(66, `Question ${'$'}{currentQuestionIndex + 1} of ${'$'}{questions.length}`);
            }
        }
    </script>
</body>
</html>


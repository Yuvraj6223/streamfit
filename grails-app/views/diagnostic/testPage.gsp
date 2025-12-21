<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>${test.testName} - StreamFit</title>
    <style>
        .test-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .test-header {
            background: white;
            border-radius: 16px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .test-header h1 {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #333;
        }
        
        .test-header p {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 20px;
        }
        
        .test-meta {
            display: flex;
            justify-content: center;
            gap: 30px;
            font-size: 1rem;
            color: #888;
        }
        
        .question-card {
            background: white;
            border-radius: 16px;
            padding: 40px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            display: none;
        }
        
        .question-card.active {
            display: block;
            animation: slideIn 0.3s ease;
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
            color: #888;
            margin-bottom: 10px;
        }
        
        .question-text {
            font-size: 1.5rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 30px;
            line-height: 1.5;
        }
        
        .options-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .option {
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }
        
        .option:hover {
            background: #e8e9ff;
            border-color: #667eea;
        }
        
        .option.selected {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: #667eea;
        }
        
        .navigation-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .btn {
            padding: 12px 30px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #e0e0e0;
            color: #666;
        }
        
        .btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .progress-bar {
            background: #e0e0e0;
            height: 8px;
            border-radius: 4px;
            margin-bottom: 30px;
            overflow: hidden;
        }
        
        .progress-fill {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            height: 100%;
            transition: width 0.3s ease;
        }
        
        .loading {
            text-align: center;
            padding: 60px 20px;
            font-size: 1.2rem;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="test-container">
        <div class="test-header">
            <h1>${test.testName}</h1>
            <p>${test.description}</p>
            <div class="test-meta">
                <span>📊 ${test.questionCount} questions</span>
                <span>⏱️ ${test.estimatedMinutes} minutes</span>
            </div>
        </div>
        
        <div class="progress-bar">
            <div class="progress-fill" id="progress-fill" style="width: 0%"></div>
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
                const questionsResponse = await fetch(`/api/diagnostic/questions/${'$'}{testId}`);
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
            container.innerHTML = questions.map((q, index) => `
                <div class="question-card" data-index="${'$'}{index}">
                    <div class="question-number">Question ${'$'}{index + 1} of ${'$'}{questions.length}</div>
                    <div class="question-text">${'$'}{q.questionText}</div>
                    <div class="options-container">
                        ${'$'}{q.options.map(opt => `
                            <div class="option" data-value="${'$'}{opt.optionValue}" onclick="selectOption(${'$'}{index}, '${'$'}{opt.optionValue}')">
                                ${'$'}{opt.optionText}
                            </div>
                        `).join('')}
                    </div>
                    <div class="navigation-buttons">
                        <button class="btn btn-secondary" onclick="previousQuestion()" ${'$'}{index === 0 ? 'style="visibility: hidden"' : ''}>
                            ← Previous
                        </button>
                        <button class="btn btn-primary" id="next-btn-${'$'}{index}" onclick="nextQuestion()" disabled>
                            ${'$'}{index === questions.length - 1 ? 'Submit' : 'Next →'}
                        </button>
                    </div>
                </div>
            `).join('');
        }
        
        function showQuestion(index) {
            document.querySelectorAll('.question-card').forEach(card => {
                card.classList.remove('active');
            });
            document.querySelector(`[data-index="${'$'}{index}"]`).classList.add('active');

            currentQuestionIndex = index;
            updateProgress();

            // Restore selected answer if exists
            const answer = answers[index];
            if (answer.answerValue) {
                const option = document.querySelector(`[data-index="${'$'}{index}"] [data-value="${'$'}{answer.answerValue}"]`);
                if (option) {
                    option.classList.add('selected');
                    document.getElementById(`next-btn-${'$'}{index}`).disabled = false;
                }
            }
        }
        
        function selectOption(questionIndex, value) {
            // Remove previous selection
            document.querySelectorAll(`[data-index="${'$'}{questionIndex}"] .option`).forEach(opt => {
                opt.classList.remove('selected');
            });

            // Add new selection
            event.target.classList.add('selected');

            // Save answer
            answers[questionIndex].answerValue = value;

            // Enable next button
            document.getElementById(`next-btn-${'$'}{questionIndex}`).disabled = false;
        }
        
        function nextQuestion() {
            if (currentQuestionIndex < questions.length - 1) {
                showQuestion(currentQuestionIndex + 1);
            } else {
                submitTest();
            }
        }
        
        function previousQuestion() {
            if (currentQuestionIndex > 0) {
                showQuestion(currentQuestionIndex - 1);
            }
        }
        
        function updateProgress() {
            const answeredCount = answers.filter(a => a.answerValue !== null).length;
            const percentage = (answeredCount / questions.length) * 100;
            document.getElementById('progress-fill').style.width = `${'$'}{percentage}%`;
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
                    window.location.href = `/diagnostic/result/${'$'}{sessionId}`;
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


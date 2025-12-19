<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>${testDefinition.testName} - Question ${progress.current + 1}</title>
</head>
<body>
    <div class="test-page">
        <div class="mobile-container">
            <!-- Progress Bar -->
            <div class="progress-container">
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${progress.percentage}%"></div>
                </div>
                <div class="progress-text">
                    Question ${progress.current + 1} of ${progress.total}
                </div>
            </div>
            
            <!-- Test Header -->
            <div class="test-header">
                <h1 class="test-name">${testDefinition.testName}</h1>
                <g:if test="${question.timeLimit}">
                    <div class="timer" id="timer">
                        <span class="timer-icon">⏱️</span>
                        <span id="time-remaining">${question.timeLimit}</span>s
                    </div>
                </g:if>
            </div>
            
            <!-- Question Card -->
            <div class="question-card">
                <div class="question-number">Question ${question.questionNumber}</div>
                
                <g:if test="${question.imageUrl}">
                    <div class="question-image">
                        <img src="${question.imageUrl}" alt="Question image"/>
                    </div>
                </g:if>
                
                <h2 class="question-text">${question.questionText}</h2>
                
                <!-- Options -->
                <div class="options-container" id="options-container">
                    <g:each in="${options}" var="option">
                        <div class="option-card" data-option-id="${option.id}">
                            <g:if test="${option.imageUrl}">
                                <div class="option-image">
                                    <img src="${option.imageUrl}" alt="Option image"/>
                                </div>
                            </g:if>
                            <div class="option-text">${option.optionText}</div>
                            <div class="option-check">✓</div>
                        </div>
                    </g:each>
                </div>
                
                <!-- Submit Button -->
                <button id="submit-btn" class="btn btn-primary btn-large btn-block" disabled>
                    Select an answer to continue
                </button>
            </div>
            
            <!-- Abandon Test -->
            <div class="test-actions">
                <button id="abandon-btn" class="btn-text">
                    Exit Test
                </button>
            </div>
        </div>
    </div>
    
    <style>
        .test-page {
            min-height: 100vh;
            padding: 20px 0;
        }
        
        .progress-container {
            margin-bottom: 30px;
        }
        
        .progress-bar {
            height: 8px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 8px;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #4ade80 0%, #22c55e 100%);
            transition: width 0.3s ease;
        }
        
        .progress-text {
            text-align: center;
            color: white;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .test-header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }
        
        .test-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .timer {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 1.1rem;
            font-weight: 600;
        }
        
        .timer.warning {
            background: rgba(239, 68, 68, 0.8);
            animation: pulse 1s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .question-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .question-number {
            color: #667eea;
            font-weight: 600;
            margin-bottom: 16px;
            font-size: 0.9rem;
            text-transform: uppercase;
        }
        
        .question-image {
            margin-bottom: 20px;
            border-radius: 12px;
            overflow: hidden;
        }
        
        .question-image img {
            width: 100%;
            height: auto;
        }
        
        .question-text {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 30px;
            color: #333;
            line-height: 1.5;
        }
        
        .options-container {
            margin-bottom: 30px;
        }
        
        .option-card {
            background: #f8f9fa;
            border: 2px solid transparent;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }
        
        .option-card:hover {
            background: #e9ecef;
            transform: translateX(4px);
        }
        
        .option-card.selected {
            background: #ede9fe;
            border-color: #667eea;
        }
        
        .option-image {
            margin-bottom: 12px;
            border-radius: 8px;
            overflow: hidden;
        }
        
        .option-image img {
            width: 100%;
            height: auto;
        }
        
        .option-text {
            font-size: 1.1rem;
            color: #333;
            font-weight: 500;
        }
        
        .option-check {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: #667eea;
            color: white;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }
        
        .option-card.selected .option-check {
            display: flex;
        }
        
        .test-actions {
            text-align: center;
            margin-top: 20px;
        }
        
        .btn-text {
            background: none;
            border: none;
            color: white;
            font-size: 0.9rem;
            cursor: pointer;
            text-decoration: underline;
            opacity: 0.8;
        }
        
        .btn-text:hover {
            opacity: 1;
        }
    </style>
    
    <content tag="scripts">
        <script>
            let selectedOptionId = null;
            let startTime = Date.now();
            let timeLimit = ${question.timeLimit ?: 0};
            let timerInterval = null;
            
            // Option selection
            document.querySelectorAll('.option-card').forEach(card => {
                card.addEventListener('click', function() {
                    // Remove previous selection
                    document.querySelectorAll('.option-card').forEach(c => c.classList.remove('selected'));
                    
                    // Add selection to clicked card
                    this.classList.add('selected');
                    selectedOptionId = this.dataset.optionId;
                    
                    // Enable submit button
                    const submitBtn = document.getElementById('submit-btn');
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Continue →';
                });
            });
            
            // Timer functionality
            if (timeLimit > 0) {
                let timeRemaining = timeLimit;
                const timerElement = document.getElementById('time-remaining');
                const timerContainer = document.getElementById('timer');
                
                timerInterval = setInterval(() => {
                    timeRemaining--;
                    timerElement.textContent = timeRemaining;
                    
                    if (timeRemaining <= 5) {
                        timerContainer.classList.add('warning');
                    }
                    
                    if (timeRemaining <= 0) {
                        clearInterval(timerInterval);
                        submitAnswer();
                    }
                }, 1000);
            }
            
            // Submit answer
            document.getElementById('submit-btn').addEventListener('click', submitAnswer);
            
            function submitAnswer() {
                if (!selectedOptionId && timeLimit === 0) return;
                
                const timeTaken = Math.floor((Date.now() - startTime) / 1000);
                
                if (timerInterval) {
                    clearInterval(timerInterval);
                }
                
                // Disable button
                const submitBtn = document.getElementById('submit-btn');
                submitBtn.disabled = true;
                submitBtn.textContent = 'Submitting...';
                
                // Submit via AJAX
                fetch('${createLink(controller: 'test', action: 'submitAnswer')}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        sessionId: '${session.sessionId}',
                        questionNumber: ${question.questionNumber},
                        optionId: selectedOptionId,
                        timeTaken: timeTaken
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        if (data.isCompleted) {
                            window.location.href = data.redirectUrl;
                        } else {
                            window.location.reload();
                        }
                    } else {
                        alert('Error submitting answer. Please try again.');
                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Continue →';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error submitting answer. Please try again.');
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Continue →';
                });
            }
            
            // Abandon test
            document.getElementById('abandon-btn').addEventListener('click', function() {
                if (confirm('Are you sure you want to exit this test? Your progress will be lost.')) {
                    fetch('${createLink(controller: 'test', action: 'abandon')}', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            sessionId: '${session.sessionId}'
                        })
                    })
                    .then(() => {
                        window.location.href = '${createLink(controller: 'home', action: 'index')}';
                    });
                }
            });
        </script>
    </content>
</body>
</html>


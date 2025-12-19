<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>${testDefinition.testName} - Results</title>
</head>
<body>
    <div class="result-page">
        <div class="mobile-container">
            <!-- Success Animation -->
            <div class="success-animation">
                <div class="checkmark">✓</div>
                <h1 class="success-title">Test Complete!</h1>
            </div>
            
            <!-- Results Card -->
            <div class="result-card">
                <h2 class="result-title">${testDefinition.testName}</h2>
                
                <g:each in="${results}" var="result">
                    <g:if test="${result.archetype}">
                        <!-- Archetype Result -->
                        <div class="archetype-result">
                            <div class="archetype-emoji">${result.archetype.archetypeEmoji}</div>
                            <h3 class="archetype-name">${result.archetype.archetypeName}</h3>
                            <p class="archetype-description">${result.archetype.description}</p>
                            
                            <div class="traits-section">
                                <h4>Your Traits</h4>
                                <p class="traits">${result.archetype.traits}</p>
                            </div>
                            
                            <g:if test="${result.archetype.careerSuggestions}">
                                <div class="careers-section">
                                    <h4>Career Suggestions</h4>
                                    <p class="careers">${result.archetype.careerSuggestions}</p>
                                </div>
                            </g:if>
                        </div>
                    </g:if>
                    
                    <g:elseif test="${result.resultType == 'COGNITIVE_SCORE'}">
                        <!-- Cognitive Score -->
                        <div class="score-item">
                            <div class="score-label">${result.resultKey}</div>
                            <div class="score-bar">
                                <div class="score-fill" style="width: ${result.scorePercentage}%"></div>
                            </div>
                            <div class="score-value">${result.scorePercentage.round(1)}%</div>
                        </div>
                    </g:elseif>
                    
                    <g:elseif test="${result.resultType == 'WORK_STYLE'}">
                        <!-- Work Style -->
                        <div class="work-style-result">
                            <h3>${result.scoreLabel}</h3>
                            <p>${result.resultValue}</p>
                        </div>
                    </g:elseif>
                </g:each>
            </div>
            
            <!-- Share Section -->
            <div class="share-section">
                <h3 class="share-title">Share Your Results</h3>
                <div class="share-buttons">
                    <button class="share-btn whatsapp" data-platform="whatsapp">
                        <span class="share-icon">📱</span>
                        WhatsApp
                    </button>
                    <button class="share-btn instagram" data-platform="instagram">
                        <span class="share-icon">📸</span>
                        Instagram
                    </button>
                    <button class="share-btn telegram" data-platform="telegram">
                        <span class="share-icon">✈️</span>
                        Telegram
                    </button>
                </div>
            </div>
            
            <!-- CTA Section -->
            <div class="cta-section">
                <div class="cta-card">
                    <h3 class="cta-title">Want Your Full StreamMap Report?</h3>
                    <p class="cta-text">
                        Get detailed insights, personalized recommendations, and career guidance
                    </p>
                    <button id="prebook-btn" class="btn btn-primary btn-large btn-block">
                        Prebook Now (Free) 🎯
                    </button>
                </div>
            </div>
            
            <!-- Navigation -->
            <div class="result-actions">
                <a href="${createLink(controller: 'test', action: 'index')}" class="btn btn-secondary btn-block">
                    Take Another Test
                </a>
                <a href="${createLink(controller: 'dashboard', action: 'index')}" class="btn btn-primary btn-block">
                    View Dashboard 📊
                </a>
            </div>
        </div>
    </div>
    
    <style>
        .result-page {
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .success-animation {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }
        
        .checkmark {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #22c55e;
            color: white;
            font-size: 3rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            animation: scaleIn 0.5s ease;
        }
        
        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }
        
        .success-title {
            font-size: 2rem;
            font-weight: 700;
        }
        
        .result-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .result-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 24px;
            color: #333;
            text-align: center;
        }
        
        .archetype-result {
            text-align: center;
        }
        
        .archetype-emoji {
            font-size: 5rem;
            margin-bottom: 16px;
        }
        
        .archetype-name {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 16px;
            color: #667eea;
        }
        
        .archetype-description {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 24px;
            line-height: 1.6;
        }
        
        .traits-section, .careers-section {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            text-align: left;
        }
        
        .traits-section h4, .careers-section h4 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        
        .traits, .careers {
            color: #666;
            line-height: 1.6;
        }
        
        .score-item {
            margin-bottom: 20px;
        }
        
        .score-label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        
        .score-bar {
            height: 24px;
            background: #e9ecef;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 4px;
        }
        
        .score-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transition: width 1s ease;
        }
        
        .score-value {
            text-align: right;
            font-weight: 600;
            color: #667eea;
        }
        
        .share-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .share-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        
        .share-buttons {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
        }
        
        .share-btn {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 16px 12px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            color: #333;
        }
        
        .share-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .share-btn.whatsapp:hover {
            background: #25D366;
            color: white;
            border-color: #25D366;
        }
        
        .share-btn.instagram:hover {
            background: linear-gradient(45deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
            color: white;
            border-color: transparent;
        }
        
        .share-btn.telegram:hover {
            background: #0088cc;
            color: white;
            border-color: #0088cc;
        }
        
        .share-icon {
            display: block;
            font-size: 1.5rem;
            margin-bottom: 4px;
        }
        
        .cta-section {
            margin-bottom: 20px;
        }
        
        .cta-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            color: white;
        }
        
        .cta-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 12px;
        }
        
        .cta-text {
            margin-bottom: 20px;
            opacity: 0.95;
            line-height: 1.6;
        }
        
        .result-actions {
            display: grid;
            gap: 12px;
        }
    </style>
    
    <content tag="scripts">
        <script>
            // Share functionality
            document.querySelectorAll('.share-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const platform = this.dataset.platform;
                    
                    // Get share links
                    fetch('${createLink(controller: 'share', action: 'links')}', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            testCode: '${testDefinition.testCode}'
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success && data.links[platform]) {
                            // Track share
                            fetch('${createLink(controller: 'share', action: 'track')}', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify({
                                    platform: platform,
                                    testCode: '${testDefinition.testCode}'
                                })
                            });
                            
                            // Open share link
                            window.open(data.links[platform], '_blank');
                        }
                    });
                });
            });
            
            // Prebook functionality
            document.getElementById('prebook-btn').addEventListener('click', function() {
                this.disabled = true;
                this.textContent = 'Processing...';
                
                fetch('${createLink(controller: 'analytics', action: 'prebook')}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        leadType: 'STREAMMAP_REPORT'
                    })
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        this.textContent = 'Prebooked! ✓';
                        this.classList.add('btn-success');
                    } else {
                        alert('Error: ' + data.message);
                        this.disabled = false;
                        this.textContent = 'Prebook Now (Free) 🎯';
                    }
                });
            });
        </script>
    </content>
</body>
</html>


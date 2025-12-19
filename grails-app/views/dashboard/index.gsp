<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>My Learning DNA Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</head>
<body>
    <div class="dashboard-page">
        <div class="mobile-container">
            <g:if test="${!dashboard.unlocked}">
                <!-- Locked Dashboard -->
                <div class="locked-dashboard">
                    <div class="lock-icon">🔒</div>
                    <h1 class="lock-title">Dashboard Locked</h1>
                    <p class="lock-message">${dashboard.message}</p>
                    
                    <div class="progress-requirements">
                        <div class="requirement-item">
                            <div class="requirement-label">Core Tests</div>
                            <div class="requirement-progress">
                                <div class="requirement-bar">
                                    <div class="requirement-fill" style="width: ${(dashboard.coreTestsCompleted / dashboard.coreTestsRequired) * 100}%"></div>
                                </div>
                                <div class="requirement-text">${dashboard.coreTestsCompleted} / ${dashboard.coreTestsRequired}</div>
                            </div>
                        </div>
                        
                        <div class="requirement-item">
                            <div class="requirement-label">StreamFit Tests</div>
                            <div class="requirement-progress">
                                <div class="requirement-bar">
                                    <div class="requirement-fill" style="width: ${(dashboard.streamFitTestsCompleted / dashboard.streamFitTestsRequired) * 100}%"></div>
                                </div>
                                <div class="requirement-text">${dashboard.streamFitTestsCompleted} / ${dashboard.streamFitTestsRequired}</div>
                            </div>
                        </div>
                    </div>
                    
                    <a href="${createLink(controller: 'test', action: 'index')}" class="btn btn-primary btn-large">
                        Take More Tests 🚀
                    </a>
                </div>
            </g:if>
            <g:else>
                <!-- Unlocked Dashboard -->
                <div class="dashboard-header">
                    <h1 class="dashboard-title">
                        <span class="emoji">🧬</span>
                        Your Learning DNA
                    </h1>
                    <p class="dashboard-subtitle">Personalized insights based on your test results</p>
                </div>
                
                <!-- Badges Section -->
                <div class="badges-section">
                    <h2 class="section-title">Your Badges</h2>
                    <div class="badges-grid">
                        <g:each in="${dashboard.badges}" var="badge">
                            <div class="badge-card">
                                <div class="badge-emoji">${badge.emoji}</div>
                                <div class="badge-label">${badge.label}</div>
                            </div>
                        </g:each>
                    </div>
                </div>
                
                <!-- Learning Style -->
                <g:if test="${dashboard.learningStyle?.persona}">
                    <div class="dna-card">
                        <h2 class="card-title">
                            <span class="emoji">${dashboard.learningStyle.emoji}</span>
                            Learning Style
                        </h2>
                        <h3 class="persona-name">${dashboard.learningStyle.persona}</h3>
                        <p class="persona-description">${dashboard.learningStyle.description}</p>
                    </div>
                </g:if>
                
                <!-- Cognitive Profile -->
                <g:if test="${dashboard.cognitiveProfile?.skew}">
                    <div class="dna-card">
                        <h2 class="card-title">
                            <span class="emoji">${dashboard.cognitiveProfile.emoji}</span>
                            Cognitive Strength
                        </h2>
                        <h3 class="persona-name">${dashboard.cognitiveProfile.skew}</h3>
                        
                        <g:if test="${dashboard.cognitiveProfile.radarData}">
                            <div class="chart-container">
                                <canvas id="radarChart"></canvas>
                            </div>
                        </g:if>
                    </div>
                </g:if>
                
                <!-- Work Style -->
                <g:if test="${dashboard.workStyle?.style}">
                    <div class="dna-card">
                        <h2 class="card-title">
                            <span class="emoji">${dashboard.workStyle.emoji}</span>
                            Work Style
                        </h2>
                        <h3 class="persona-name">${dashboard.workStyle.style}</h3>
                        <p class="persona-description">${dashboard.workStyle.description}</p>
                    </div>
                </g:if>
                
                <!-- StreamFit Recommendations -->
                <g:if test="${dashboard.streamFit?.recommendations}">
                    <div class="dna-card">
                        <h2 class="card-title">
                            <span class="emoji">🎯</span>
                            Your Top Stream Matches
                        </h2>
                        
                        <div class="streams-grid">
                            <g:each in="${dashboard.streamFit.recommendations}" var="stream">
                                <div class="stream-card">
                                    <div class="stream-icon">${stream.icon}</div>
                                    <h3 class="stream-name">${stream.name}</h3>
                                    <p class="stream-description">${stream.description}</p>
                                    <g:if test="${stream.careers}">
                                        <div class="stream-careers">
                                            <strong>Careers:</strong>
                                            <ul>
                                                <g:each in="${stream.careers}" var="career">
                                                    <li>${career}</li>
                                                </g:each>
                                            </ul>
                                        </div>
                                    </g:if>
                                </div>
                            </g:each>
                        </div>
                    </div>
                </g:if>
                
                <!-- Shareable Card -->
                <div class="share-card">
                    <h2 class="card-title">Share Your Learning DNA</h2>
                    <div class="shareable-preview">
                        <div class="preview-content">
                            <h3>My Learning DNA</h3>
                            <p>${dashboard.shareableCard?.persona}</p>
                            <p>${dashboard.shareableCard?.cognitive}</p>
                            <p>${dashboard.shareableCard?.workStyle}</p>
                        </div>
                    </div>
                    
                    <div class="share-buttons">
                        <button class="share-btn whatsapp" data-platform="whatsapp">
                            📱 WhatsApp
                        </button>
                        <button class="share-btn instagram" data-platform="instagram">
                            📸 Instagram
                        </button>
                        <button class="share-btn telegram" data-platform="telegram">
                            ✈️ Telegram
                        </button>
                    </div>
                </div>
                
                <!-- CTA for Full Report -->
                <div class="cta-card">
                    <h2 class="cta-title">Want Your Complete StreamMap Report?</h2>
                    <p class="cta-text">
                        Get detailed analysis, personalized study plans, and career roadmaps
                    </p>
                    <button id="prebook-btn" class="btn btn-primary btn-large btn-block">
                        Prebook Full Report (Free) 🎯
                    </button>
                </div>
            </g:else>
        </div>
    </div>
    
    <style>
        .dashboard-page {
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .locked-dashboard {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .lock-icon {
            font-size: 5rem;
            margin-bottom: 20px;
        }
        
        .lock-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 16px;
            color: #333;
        }
        
        .lock-message {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .progress-requirements {
            margin-bottom: 30px;
        }
        
        .requirement-item {
            margin-bottom: 20px;
        }
        
        .requirement-label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        
        .requirement-bar {
            height: 24px;
            background: #e9ecef;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 4px;
        }
        
        .requirement-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }
        
        .requirement-text {
            text-align: right;
            font-weight: 600;
            color: #667eea;
        }
        
        .dashboard-header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }
        
        .dashboard-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 12px;
        }
        
        .dashboard-title .emoji {
            font-size: 3rem;
        }
        
        .dashboard-subtitle {
            font-size: 1.1rem;
            opacity: 0.95;
        }
        
        .badges-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }
        
        .badges-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
            gap: 16px;
        }
        
        .badge-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            padding: 20px;
            text-align: center;
            color: white;
        }
        
        .badge-emoji {
            font-size: 2.5rem;
            margin-bottom: 8px;
        }
        
        .badge-label {
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .dna-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }
        
        .card-title .emoji {
            font-size: 1.5rem;
        }
        
        .persona-name {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 12px;
            color: #667eea;
        }
        
        .persona-description {
            font-size: 1.1rem;
            color: #666;
            line-height: 1.6;
        }
        
        .chart-container {
            margin-top: 20px;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .streams-grid {
            display: grid;
            gap: 16px;
        }
        
        .stream-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
        }
        
        .stream-icon {
            font-size: 2.5rem;
            margin-bottom: 12px;
        }
        
        .stream-name {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }
        
        .stream-description {
            color: #666;
            margin-bottom: 12px;
            line-height: 1.5;
        }
        
        .stream-careers ul {
            margin-top: 8px;
            padding-left: 20px;
        }
        
        .stream-careers li {
            color: #666;
            margin-bottom: 4px;
        }
        
        .share-card, .cta-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .shareable-preview {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 20px;
            color: white;
            text-align: center;
        }
        
        .preview-content h3 {
            font-size: 1.5rem;
            margin-bottom: 12px;
        }
        
        .preview-content p {
            margin-bottom: 8px;
            font-size: 1.1rem;
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
            padding: 12px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            color: #333;
        }
        
        .cta-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: center;
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
    </style>
    
    <content tag="scripts">
        <g:if test="${dashboard.unlocked && dashboard.cognitiveProfile?.radarData}">
            <script>
                // Render Radar Chart
                const ctx = document.getElementById('radarChart');
                new Chart(ctx, {
                    type: 'radar',
                    data: ${raw(dashboard.cognitiveProfile.radarData as grails.converters.JSON)},
                    options: {
                        scales: {
                            r: {
                                beginAtZero: true,
                                max: 100
                            }
                        },
                        plugins: {
                            legend: {
                                display: false
                            }
                        }
                    }
                });
            </script>
        </g:if>
        
        <script>
            // Share functionality
            document.querySelectorAll('.share-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const platform = this.dataset.platform;
                    
                    fetch('${createLink(controller: 'share', action: 'links')}', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'}
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success && data.links[platform]) {
                            fetch('${createLink(controller: 'share', action: 'track')}', {
                                method: 'POST',
                                headers: {'Content-Type': 'application/json'},
                                body: JSON.stringify({platform: platform})
                            });
                            window.open(data.links[platform], '_blank');
                        }
                    });
                });
            });
            
            // Prebook functionality
            const prebookBtn = document.getElementById('prebook-btn');
            if (prebookBtn) {
                prebookBtn.addEventListener('click', function() {
                    this.disabled = true;
                    this.textContent = 'Processing...';
                    
                    fetch('${createLink(controller: 'analytics', action: 'prebook')}', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({leadType: 'STREAMMAP_REPORT'})
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert(data.message);
                            this.textContent = 'Prebooked! ✓';
                        } else {
                            alert('Error: ' + data.message);
                            this.disabled = false;
                            this.textContent = 'Prebook Full Report (Free) 🎯';
                        }
                    });
                });
            }
        </script>
    </content>
</body>
</html>


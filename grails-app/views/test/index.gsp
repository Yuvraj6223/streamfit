<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>All Tests - StreamFit</title>
</head>
<body>
    <div class="tests-page">
        <div class="mobile-container">
            <div class="page-header">
                <h1 class="page-title">
                    <span class="emoji">🎯</span>
                    Discover Your Learning DNA
                </h1>
                <p class="page-subtitle">
                    Complete tests to unlock your personalized dashboard
                </p>
            </div>
            
            <!-- Progress Overview -->
            <div class="progress-overview">
                <div class="progress-stat">
                    <div class="stat-value">${stats.coreCompleted}</div>
                    <div class="stat-label">Core Tests</div>
                </div>
                <div class="progress-stat">
                    <div class="stat-value">${stats.streamFitCompleted}</div>
                    <div class="stat-label">StreamFit Tests</div>
                </div>
                <div class="progress-stat">
                    <div class="stat-value">${stats.totalCompleted}</div>
                    <div class="stat-label">Total Completed</div>
                </div>
            </div>
            
            <!-- Core Diagnostics -->
            <div class="test-section">
                <h2 class="section-title">
                    <span class="emoji">🧠</span>
                    Core Diagnostics
                </h2>
                <p class="section-description">
                    Understand your learning style, cognitive strengths, and work preferences
                </p>
                
                <div class="test-grid">
                    <g:each in="${coreTests}" var="test">
                        <div class="test-card ${test.completed ? 'completed' : ''}">
                            <div class="test-icon">${test.emoji}</div>
                            <h3 class="test-name">${test.testName}</h3>
                            <p class="test-description">${test.description}</p>
                            
                            <div class="test-meta">
                                <span class="test-duration">⏱️ ${test.estimatedMinutes} min</span>
                                <span class="test-questions">📝 ${test.questionsCount} questions</span>
                            </div>
                            
                            <g:if test="${test.completed}">
                                <div class="test-status completed">
                                    <span class="status-icon">✓</span>
                                    Completed
                                </div>
                                <a href="${createLink(controller: 'test', action: 'result', params: [code: test.testCode])}" 
                                   class="btn btn-secondary btn-block">
                                    View Results
                                </a>
                            </g:if>
                            <g:else>
                                <a href="${createLink(controller: 'test', action: 'start', params: [code: test.testCode])}" 
                                   class="btn btn-primary btn-block">
                                    Start Test →
                                </a>
                            </g:else>
                        </div>
                    </g:each>
                </div>
            </div>
            
            <!-- StreamFit Tests -->
            <div class="test-section">
                <h2 class="section-title">
                    <span class="emoji">🎓</span>
                    StreamFit Tests
                </h2>
                <p class="section-description">
                    Discover which academic streams and careers align with your strengths
                </p>
                
                <div class="test-grid">
                    <g:each in="${streamFitTests}" var="test">
                        <div class="test-card ${test.completed ? 'completed' : ''}">
                            <div class="test-icon">${test.emoji}</div>
                            <h3 class="test-name">${test.testName}</h3>
                            <p class="test-description">${test.description}</p>
                            
                            <div class="test-meta">
                                <span class="test-duration">⏱️ ${test.estimatedMinutes} min</span>
                                <span class="test-questions">📝 ${test.questionsCount} questions</span>
                            </div>
                            
                            <g:if test="${test.completed}">
                                <div class="test-status completed">
                                    <span class="status-icon">✓</span>
                                    Completed
                                </div>
                                <a href="${createLink(controller: 'test', action: 'result', params: [code: test.testCode])}" 
                                   class="btn btn-secondary btn-block">
                                    View Results
                                </a>
                            </g:if>
                            <g:else>
                                <a href="${createLink(controller: 'test', action: 'start', params: [code: test.testCode])}" 
                                   class="btn btn-primary btn-block">
                                    Start Test →
                                </a>
                            </g:else>
                        </div>
                    </g:each>
                </div>
            </div>
            
            <!-- Dashboard CTA -->
            <g:if test="${dashboardUnlocked}">
                <div class="dashboard-cta">
                    <h3>🎉 Your Dashboard is Ready!</h3>
                    <p>View your complete Learning DNA profile</p>
                    <a href="${createLink(controller: 'dashboard', action: 'index')}" 
                       class="btn btn-primary btn-large btn-block">
                        View Dashboard →
                    </a>
                </div>
            </g:if>
        </div>
    </div>
    
    <style>
        .tests-page {
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 30px;
            color: white;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 12px;
        }
        
        .page-title .emoji {
            font-size: 2.5rem;
            display: block;
            margin-bottom: 12px;
        }
        
        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.95;
        }
        
        .progress-overview {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 30px;
        }
        
        .progress-stat {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 16px;
            text-align: center;
            color: white;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 4px;
        }
        
        .stat-label {
            font-size: 0.85rem;
            opacity: 0.9;
        }
        
        .test-section {
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: white;
        }
        
        .section-title .emoji {
            font-size: 1.8rem;
        }
        
        .section-description {
            color: white;
            opacity: 0.9;
            margin-bottom: 20px;
        }
        
        .test-grid {
            display: grid;
            gap: 16px;
        }
        
        .test-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        
        .test-card:hover {
            transform: translateY(-4px);
        }
        
        .test-card.completed {
            border: 2px solid #22c55e;
        }
        
        .test-icon {
            font-size: 3rem;
            margin-bottom: 12px;
        }
        
        .test-name {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }
        
        .test-description {
            color: #666;
            margin-bottom: 16px;
            line-height: 1.5;
        }
        
        .test-meta {
            display: flex;
            gap: 16px;
            margin-bottom: 16px;
            font-size: 0.9rem;
            color: #888;
        }
        
        .test-status {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            border-radius: 8px;
            margin-bottom: 12px;
            font-weight: 600;
        }
        
        .test-status.completed {
            background: #d1fae5;
            color: #065f46;
        }
        
        .status-icon {
            font-size: 1.2rem;
        }
        
        .dashboard-cta {
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            color: white;
        }
        
        .dashboard-cta h3 {
            font-size: 1.5rem;
            margin-bottom: 8px;
        }
        
        .dashboard-cta p {
            margin-bottom: 20px;
            opacity: 0.95;
        }
    </style>
</body>
</html>


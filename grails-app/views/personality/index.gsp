<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Personality Test - StreamFit</title>
</head>
<body>
    <div class="personality-page">
        <div class="mobile-container">
            <div class="page-header">
                <div class="free-badge">100% FREE • NO LOGIN REQUIRED</div>
                <h1 class="page-title">
                    <span class="emoji">🧠</span>
                    16 Personalities Test
                </h1>
                <p class="page-subtitle">
                    Discover your personality type and understand yourself better
                </p>
            </div>
            
            <!-- Test History -->
            <g:if test="${history}">
                <div class="test-section">
                    <h2 class="section-title">Your Test History</h2>
                    
                    <div class="history-grid">
                        <g:each in="${history}" var="session">
                            <div class="history-card">
                                <div class="history-header">
                                    <div class="personality-badge">
                                        ${session.personality}-${session.variant}
                                    </div>
                                    <div class="test-date">
                                        <g:formatDate date="${session.completedAt}" format="MMM dd, yyyy"/>
                                    </div>
                                </div>
                                <h3 class="personality-name">${session.niceName}</h3>
                                <p class="personality-role">${session.role} - ${session.strategy}</p>
                                <a href="${createLink(action: 'result', params: [sessionId: session.sessionId])}" 
                                   class="btn btn-secondary btn-block">
                                    View Results
                                </a>
                            </div>
                        </g:each>
                    </div>
                </div>
            </g:if>
            
            <!-- Start New Test -->
            <div class="test-section">
                <div class="start-card">
                    <div class="start-icon">🎯</div>
                    <h2>Take the Personality Test</h2>
                    <p class="start-description">
                        Answer 60 questions to discover your personality type based on the 16 Personalities framework.
                        This test takes approximately 10-15 minutes to complete.
                    </p>
                    
                    <div class="test-features">
                        <div class="feature">
                            <span class="feature-icon">✨</span>
                            <span>100% Free</span>
                        </div>
                        <div class="feature">
                            <span class="feature-icon">⏱️</span>
                            <span>10-15 minutes</span>
                        </div>
                        <div class="feature">
                            <span class="feature-icon">📝</span>
                            <span>60 questions</span>
                        </div>
                        <div class="feature">
                            <span class="feature-icon">🎨</span>
                            <span>Instant results</span>
                        </div>
                    </div>

                    <a href="${createLink(action: 'start')}" class="btn btn-primary btn-large btn-block">
                        Start Free Test →
                    </a>
                </div>
            </div>
            
            <!-- About the Test -->
            <div class="test-section">
                <h2 class="section-title">About the Test</h2>
                <div class="about-card">
                    <p>
                        The 16 Personalities test is based on the Myers-Briggs Type Indicator (MBTI) framework,
                        which categorizes personalities into 16 distinct types based on four key dimensions:
                    </p>
                    <ul class="dimensions-list">
                        <li>
                            <strong>Energy:</strong> Introverted (I) vs. Extraverted (E)
                        </li>
                        <li>
                            <strong>Mind:</strong> Intuitive (N) vs. Observant (S)
                        </li>
                        <li>
                            <strong>Nature:</strong> Thinking (T) vs. Feeling (F)
                        </li>
                        <li>
                            <strong>Tactics:</strong> Judging (J) vs. Prospecting (P)
                        </li>
                        <li>
                            <strong>Identity:</strong> Assertive (A) vs. Turbulent (T)
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <style>
        .personality-page {
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
        }

        .free-badge {
            display: inline-block;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.85rem;
            letter-spacing: 1px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
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
        
        .test-section {
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            color: white;
        }
        
        .history-grid {
            display: grid;
            gap: 16px;
        }
        
        .history-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .history-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }
        
        .personality-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 12px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .test-date {
            color: #888;
            font-size: 0.9rem;
        }
        
        .personality-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }
        
        .personality-role {
            color: #666;
            margin-bottom: 16px;
        }
        
        .start-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .start-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }
        
        .start-card h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 16px;
            color: #333;
        }
        
        .start-description {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .test-features {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .feature {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #555;
        }
        
        .feature-icon {
            font-size: 1.5rem;
        }
        
        .about-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .about-card p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .dimensions-list {
            list-style: none;
            padding: 0;
        }
        
        .dimensions-list li {
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            color: #555;
        }
        
        .dimensions-list li:last-child {
            border-bottom: none;
        }
        
        .dimensions-list strong {
            color: #333;
        }
    </style>
</body>
</html>


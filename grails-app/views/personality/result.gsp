<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>${session.niceName} - Personality Test Results</title>
</head>
<body>
    <div class="personality-result-page">
        <div class="mobile-container">
            <!-- Result Header -->
            <div class="result-header">
                <div class="personality-type-badge">
                    ${session.personality}-${session.variant}
                </div>
                <h1 class="personality-name">${session.niceName}</h1>
                <p class="personality-subtitle">${session.role} - ${session.strategy}</p>
                
                <div class="avatar-container">
                    <img src="${session.avatarSrcStatic}" alt="${session.avatarAlt}" class="personality-avatar"/>
                </div>
            </div>
            
            <!-- Traits Section -->
            <div class="traits-section">
                <h2 class="section-title">Your Personality Traits</h2>
                
                <div class="traits-grid">
                    <g:each in="${traits}" var="trait">
                        <div class="trait-card trait-${trait.color}">
                            <div class="trait-header">
                                <h3 class="trait-label">${trait.label}</h3>
                                <span class="trait-percentage">${trait.pct}%</span>
                            </div>
                            
                            <div class="trait-name">${trait.trait}</div>
                            
                            <div class="trait-bar">
                                <div class="trait-fill" style="width: ${trait.pct}%"></div>
                            </div>
                            
                            <p class="trait-snippet">${trait.snippet}</p>
                            
                            <div class="trait-description">
                                <p>${trait.description}</p>
                            </div>
                            
                            <g:if test="${trait.link}">
                                <a href="${trait.link}" target="_blank" class="trait-link">
                                    Learn more →
                                </a>
                            </g:if>
                        </div>
                    </g:each>
                </div>
            </div>
            
            <!-- Premium Features Section (for anonymous users) -->
            <g:if test="${isAnonymous}">
                <div class="premium-section">
                    <div class="premium-card">
                        <div class="premium-icon">🎁</div>
                        <h2 class="premium-title">Unlock Premium Features</h2>
                        <p class="premium-description">
                            Create a free account to access detailed personality reports,
                            career recommendations, and exclusive pre-booking opportunities!
                        </p>

                        <div class="premium-features">
                            <div class="premium-feature">
                                <span class="feature-icon">📊</span>
                                <div class="feature-content">
                                    <h3>Detailed Reports</h3>
                                    <p>Get comprehensive analysis of your personality traits</p>
                                </div>
                            </div>
                            <div class="premium-feature">
                                <span class="feature-icon">💼</span>
                                <div class="feature-content">
                                    <h3>Career Insights</h3>
                                    <p>Discover careers that match your personality type</p>
                                </div>
                            </div>
                            <div class="premium-feature">
                                <span class="feature-icon">🎯</span>
                                <div class="feature-content">
                                    <h3>Pre-booking Access</h3>
                                    <p>Reserve your spot for exclusive events and workshops</p>
                                </div>
                            </div>
                            <div class="premium-feature">
                                <span class="feature-icon">📈</span>
                                <div class="feature-content">
                                    <h3>Track Progress</h3>
                                    <p>Save and compare your results over time</p>
                                </div>
                            </div>
                        </div>

                        <div class="premium-actions">
                            <a href="${createLink(controller: 'user', action: 'register')}" class="btn btn-primary btn-large">
                                Create Free Account
                            </a>
                            <a href="${createLink(controller: 'user', action: 'login')}" class="btn btn-secondary">
                                Already have an account? Sign In
                            </a>
                        </div>
                    </div>
                </div>
            </g:if>

            <!-- Actions -->
            <div class="actions-section">
                <g:if test="${!isAnonymous}">
                    <a href="${createLink(controller: 'user', action: 'detailedReport', params: [sessionId: session.sessionId])}" class="btn btn-primary btn-large btn-block">
                        📊 View Detailed Report
                    </a>
                    <a href="${createLink(controller: 'user', action: 'prebooking')}" class="btn btn-success btn-block">
                        🎯 Pre-book Consultation
                    </a>
                </g:if>
                <a href="${session.profileUrl}" target="_blank" class="btn btn-outline btn-block">
                    View Full Profile on 16Personalities.com
                </a>
                <a href="${createLink(action: 'index')}" class="btn btn-secondary btn-block">
                    Take Test Again
                </a>
            </div>
        </div>
    </div>
    
    <style>
        .personality-result-page {
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .result-header {
            text-align: center;
            margin-bottom: 40px;
            color: white;
        }
        
        .personality-type-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 16px;
        }
        
        .personality-name {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 12px;
        }
        
        .personality-subtitle {
            font-size: 1.2rem;
            opacity: 0.95;
            margin-bottom: 30px;
        }
        
        .avatar-container {
            margin: 30px 0;
        }
        
        .personality-avatar {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: white;
            padding: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        
        .traits-section {
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 24px;
            color: white;
            text-align: center;
        }
        
        .traits-grid {
            display: grid;
            gap: 20px;
        }
        
        .trait-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .trait-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .trait-label {
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            color: #888;
            margin: 0;
        }
        
        .trait-percentage {
            font-size: 1.2rem;
            font-weight: 700;
        }
        
        .trait-name {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 12px;
            color: #333;
        }
        
        .trait-bar {
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
            margin-bottom: 16px;
        }
        
        .trait-fill {
            height: 100%;
            border-radius: 4px;
            transition: width 0.5s ease;
        }
        
        .trait-blue .trait-fill {
            background: linear-gradient(90deg, #3b82f6 0%, #2563eb 100%);
        }
        
        .trait-blue .trait-percentage {
            color: #3b82f6;
        }
        
        .trait-yellow .trait-fill {
            background: linear-gradient(90deg, #fbbf24 0%, #f59e0b 100%);
        }
        
        .trait-yellow .trait-percentage {
            color: #f59e0b;
        }
        
        .trait-green .trait-fill {
            background: linear-gradient(90deg, #10b981 0%, #059669 100%);
        }
        
        .trait-green .trait-percentage {
            color: #10b981;
        }
        
        .trait-purple .trait-fill {
            background: linear-gradient(90deg, #8b5cf6 0%, #7c3aed 100%);
        }
        
        .trait-purple .trait-percentage {
            color: #8b5cf6;
        }
        
        .trait-red .trait-fill {
            background: linear-gradient(90deg, #ef4444 0%, #dc2626 100%);
        }
        
        .trait-red .trait-percentage {
            color: #ef4444;
        }
        
        .trait-snippet {
            color: #555;
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 16px;
            font-weight: 500;
        }
        
        .trait-description {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 16px;
        }
        
        .trait-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .trait-link:hover {
            text-decoration: underline;
        }
        
        .actions-section {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        /* Premium Section Styles */
        .premium-section {
            margin: 40px 0;
        }

        .premium-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            color: white;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .premium-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }

        .premium-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 16px;
            color: white;
        }

        .premium-description {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 32px;
            opacity: 0.95;
        }

        .premium-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
            text-align: left;
        }

        .premium-feature {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 20px;
            display: flex;
            gap: 16px;
            align-items: flex-start;
        }

        .feature-icon {
            font-size: 2rem;
            flex-shrink: 0;
        }

        .feature-content h3 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: white;
        }

        .feature-content p {
            font-size: 0.9rem;
            opacity: 0.9;
            margin: 0;
        }

        .premium-actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
            max-width: 400px;
            margin: 0 auto;
        }

        .btn-outline {
            background: transparent;
            border: 2px solid white;
            color: white;
        }

        .btn-outline:hover {
            background: white;
            color: #667eea;
        }

        .btn-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
        }

        @media (max-width: 768px) {
            .premium-card {
                padding: 30px 20px;
            }

            .premium-title {
                font-size: 1.5rem;
            }

            .premium-features {
                grid-template-columns: 1fr;
            }
        }
    </style>
</body>
</html>


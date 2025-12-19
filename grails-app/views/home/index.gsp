<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>StreamFit - Discover Your Learning DNA</title>
</head>
<body>
    <div class="home-page">
        <!-- Hero Section -->
        <section class="hero">
            <div class="mobile-container">
                <div class="hero-content">
                    <h1 class="hero-title">
                        <span class="emoji">🧬</span>
                        Discover Your<br/>
                        <span class="gradient-text">Learning DNA</span>
                    </h1>
                    <p class="hero-subtitle">
                        Unlock your cognitive strengths, learning style, and perfect career stream through fun, gamified tests
                    </p>
                    
                    <g:if test="${!user}">
                        <a href="${createLink(controller: 'user', action: 'register')}" class="btn btn-primary btn-large">
                            Get Started 🚀
                        </a>
                    </g:if>
                    <g:else>
                        <a href="${createLink(controller: 'test', action: 'index')}" class="btn btn-primary btn-large">
                            Continue Your Journey 🎯
                        </a>
                    </g:else>
                </div>
            </div>
        </section>
        
        <!-- Core Tests Section -->
        <section class="tests-section">
            <div class="mobile-container">
                <h2 class="section-title">
                    <span class="emoji">⚡</span>
                    Core Diagnostics
                </h2>
                <p class="section-subtitle">Discover your fundamental learning traits</p>
                
                <div class="test-grid">
                    <g:each in="${coreTests}" var="test">
                        <div class="test-card">
                            <div class="test-icon">
                                <g:if test="${test.testCode == 'EXAM_SPIRIT_ANIMAL'}">🦉</g:if>
                                <g:elseif test="${test.testCode == 'COGNITIVE_RADAR'}">🎯</g:elseif>
                                <g:elseif test="${test.testCode == 'FOCUS_STAMINA'}">⚡</g:elseif>
                                <g:else>🎲</g:else>
                            </div>
                            <h3 class="test-title">${test.testName}</h3>
                            <p class="test-description">${test.description}</p>
                            <div class="test-meta">
                                <span class="test-time">⏱️ ${test.estimatedMinutes} min</span>
                                <span class="test-questions">📝 ${test.totalQuestions} questions</span>
                            </div>
                            <a href="${createLink(controller: 'test', action: 'start', params: [testCode: test.testCode])}" 
                               class="btn btn-secondary btn-block">
                                Start Test
                            </a>
                        </div>
                    </g:each>
                </div>
            </div>
        </section>
        
        <!-- StreamFit Tests Section -->
        <section class="tests-section streamfit-section">
            <div class="mobile-container">
                <h2 class="section-title">
                    <span class="emoji">🎨</span>
                    StreamFit Tests
                </h2>
                <p class="section-subtitle">Find your perfect career stream</p>
                
                <div class="test-grid">
                    <g:each in="${streamFitTests}" var="test">
                        <div class="test-card streamfit-card">
                            <div class="test-icon">
                                <g:if test="${test.testCode == 'CURIOSITY_COMPASS'}">🧭</g:if>
                                <g:elseif test="${test.testCode == 'MODALITY_MAP'}">🗺️</g:elseif>
                                <g:elseif test="${test.testCode == 'CHALLENGE_DRIVER'}">🏆</g:elseif>
                                <g:elseif test="${test.testCode == 'WORK_MODE'}">👥</g:elseif>
                                <g:else>🧩</g:else>
                            </div>
                            <h3 class="test-title">${test.testName}</h3>
                            <p class="test-description">${test.description}</p>
                            <div class="test-meta">
                                <span class="test-time">⏱️ ${test.estimatedMinutes} min</span>
                                <span class="test-questions">📝 ${test.totalQuestions} questions</span>
                            </div>
                            <a href="${createLink(controller: 'test', action: 'start', params: [testCode: test.testCode])}" 
                               class="btn btn-secondary btn-block">
                                Start Test
                            </a>
                        </div>
                    </g:each>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="cta-section">
            <div class="mobile-container">
                <div class="cta-card">
                    <h2 class="cta-title">Ready to unlock your potential?</h2>
                    <p class="cta-text">
                        Complete at least 3 Core tests and 2 StreamFit tests to unlock your personalized Learning DNA Dashboard
                    </p>
                    <g:if test="${!user}">
                        <a href="${createLink(controller: 'user', action: 'register')}" class="btn btn-primary btn-large">
                            Start Your Journey 🚀
                        </a>
                    </g:if>
                    <g:else>
                        <a href="${createLink(controller: 'dashboard', action: 'index')}" class="btn btn-primary btn-large">
                            View Dashboard 📊
                        </a>
                    </g:else>
                </div>
            </div>
        </section>
    </div>
    
    <style>
        /* Reset and Base Styles */
        .home-page {
            padding-bottom: 60px;
            width: 100%;
            overflow-x: hidden;
        }

        /* Hero Section */
        .hero {
            padding: 60px 0 40px;
            text-align: center;
            color: white;
            width: 100%;
        }

        .hero-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        .hero-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin: 0 0 20px 0;
            line-height: 1.2;
            text-align: center;
            width: 100%;
        }

        .hero-title .emoji {
            font-size: 3rem;
            display: block;
            margin-bottom: 10px;
            text-align: center;
        }

        .gradient-text {
            background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: inline-block;
        }

        .hero-subtitle {
            font-size: 1.1rem;
            margin: 0 0 30px 0;
            opacity: 0.95;
            line-height: 1.6;
            text-align: center;
            max-width: 90%;
            margin-left: auto;
            margin-right: auto;
        }

        /* Tests Section */
        .tests-section {
            padding: 40px 0;
            background: white;
            margin: 20px 0;
            border-radius: 20px;
            width: 100%;
        }

        .streamfit-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        .section-title {
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin: 0 0 10px 0;
            color: #333;
            width: 100%;
        }

        .section-title .emoji {
            font-size: 2.5rem;
            display: inline-block;
            vertical-align: middle;
        }

        .section-subtitle {
            text-align: center;
            color: #666;
            margin: 0 0 30px 0;
            font-size: 1.1rem;
            width: 100%;
        }

        /* Test Grid */
        .test-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            width: 100%;
            margin: 0;
            padding: 0;
        }

        @media (min-width: 768px) {
            .test-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Test Cards */
        .test-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 100%;
            box-sizing: border-box;
        }

        .test-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
        }

        .streamfit-card {
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
        }

        .test-icon {
            font-size: 3rem;
            margin: 0 0 16px 0;
            line-height: 1;
            text-align: left;
            width: 100%;
        }

        .test-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin: 0 0 12px 0;
            color: #333;
            text-align: left;
            width: 100%;
        }

        .test-description {
            color: #666;
            margin: 0 0 16px 0;
            line-height: 1.5;
            text-align: left;
            width: 100%;
            flex-grow: 1;
        }

        .test-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            margin: 0 0 16px 0;
            font-size: 0.9rem;
            color: #888;
            width: 100%;
        }

        .test-time,
        .test-questions {
            white-space: nowrap;
        }

        /* Buttons */
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            text-align: center;
            box-sizing: border-box;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .btn-large {
            padding: 16px 32px;
            font-size: 1.1rem;
        }

        .btn-block {
            display: block;
            width: 100%;
            margin: 0;
        }

        /* CTA Section */
        .cta-section {
            padding: 40px 0;
            width: 100%;
        }

        .cta-card {
            background: white;
            border-radius: 20px;
            padding: 40px 24px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            width: 100%;
            box-sizing: border-box;
        }

        .cta-title {
            font-size: 2rem;
            font-weight: 700;
            margin: 0 0 16px 0;
            color: #333;
            text-align: center;
        }

        .cta-text {
            font-size: 1.1rem;
            color: #666;
            margin: 0 0 24px 0;
            line-height: 1.6;
            text-align: center;
        }

        /* Mobile Responsive Adjustments */
        @media (max-width: 480px) {
            .hero-title {
                font-size: 2rem;
            }

            .hero-title .emoji {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1rem;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .section-title .emoji {
                font-size: 2rem;
            }

            .test-title {
                font-size: 1.1rem;
            }

            .test-icon {
                font-size: 2.5rem;
            }

            .cta-title {
                font-size: 1.5rem;
            }

            .cta-text {
                font-size: 1rem;
            }

            .cta-card {
                padding: 30px 20px;
            }
        }
    </style>
</body>
</html>


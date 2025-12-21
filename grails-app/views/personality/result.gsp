<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${session.niceName} - Personality Test Results</title>
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
    .personality-result-page {
        max-width: 900px;
        margin: 0 auto;
        padding: 40px 24px;
        position: relative;
        z-index: 1;
        min-height: 100vh;
    }

    .mobile-container {
        background: transparent;
    }
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

    <!-- Ambient Background -->
    <div class="scenery-layer">
        <div class="blob b-1"></div>
        <div class="blob b-2"></div>
        <div class="blob b-3"></div>
    </div>

    <style>
        /* --- RESULT HEADER --- */
        .result-header {
            text-align: center;
            margin-bottom: 50px;
            background: var(--card-base);
            border-radius: 32px;
            padding: 50px 40px;
            box-shadow: var(--shadow-float);
            border: 1px solid rgba(255,255,255,0.5);
        }

        .personality-type-badge {
            display: inline-block;
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
            color: white;
            padding: 12px 28px;
            border-radius: 100px;
            font-weight: 800;
            font-size: 1.1rem;
            margin-bottom: 20px;
            letter-spacing: 0.05em;
            box-shadow: var(--shadow-float);
        }

        .personality-name {
            font-size: clamp(2rem, 5vw, 3rem);
            font-weight: 800;
            margin-bottom: 16px;
            color: var(--text-dark);
            letter-spacing: -0.03em;
            line-height: 1.2;
        }

        .personality-subtitle {
            font-size: 1.2rem;
            color: var(--text-grey);
            margin-bottom: 30px;
            font-weight: 600;
        }

        .avatar-container {
            margin: 30px 0 0 0;
        }

        .personality-avatar {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--pop-cream) 0%, white 100%);
            padding: 20px;
            box-shadow: var(--shadow-float);
            transition: transform 0.3s var(--ease-elastic);
        }

        .personality-avatar:hover {
            transform: scale(1.05) rotate(5deg);
        }

        /* --- TRAITS SECTION --- */
        .traits-section {
            margin-bottom: 50px;
        }

        .section-title {
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 800;
            margin-bottom: 32px;
            color: var(--text-dark);
            text-align: center;
            letter-spacing: -0.02em;
        }

        .traits-grid {
            display: grid;
            gap: 24px;
        }

        .trait-card {
            background: var(--card-base);
            border-radius: 28px;
            padding: 32px;
            box-shadow: var(--shadow-float);
            border: 1px solid rgba(255,255,255,0.5);
            transition: all 0.3s var(--ease-elastic);
        }

        .trait-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.3);
        }

        .trait-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .trait-label {
            font-size: 0.85rem;
            font-weight: 800;
            text-transform: uppercase;
            color: var(--text-grey);
            margin: 0;
            letter-spacing: 0.08em;
        }

        .trait-percentage {
            font-size: 1.4rem;
            font-weight: 800;
        }

        .trait-name {
            font-size: 1.6rem;
            font-weight: 800;
            margin-bottom: 16px;
            color: var(--text-dark);
            letter-spacing: -0.02em;
        }

        .trait-bar {
            height: 12px;
            background: #F0F0F3;
            border-radius: 100px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .trait-fill {
            height: 100%;
            border-radius: 100px;
            transition: width 1s var(--ease-smooth);
        }

        .trait-blue .trait-fill {
            background: linear-gradient(90deg, var(--pop-teal) 0%, #5BC0DE 100%);
        }

        .trait-blue .trait-percentage {
            color: var(--pop-teal);
        }

        .trait-yellow .trait-fill {
            background: linear-gradient(90deg, var(--pop-yellow) 0%, #FFB84D 100%);
        }

        .trait-yellow .trait-percentage {
            color: #F5A623;
        }

        .trait-green .trait-fill {
            background: linear-gradient(90deg, #10b981 0%, #059669 100%);
        }

        .trait-green .trait-percentage {
            color: #10b981;
        }

        .trait-purple .trait-fill {
            background: linear-gradient(90deg, var(--pop-purple) 0%, #8B7FE8 100%);
        }

        .trait-purple .trait-percentage {
            color: var(--pop-purple);
        }

        .trait-red .trait-fill {
            background: linear-gradient(90deg, var(--pop-coral) 0%, #FF6B5A 100%);
        }

        .trait-red .trait-percentage {
            color: var(--pop-coral);
        }

        .trait-snippet {
            color: var(--text-grey);
            font-size: 1.05rem;
            line-height: 1.7;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .trait-description {
            color: var(--text-grey);
            font-size: 1rem;
            line-height: 1.7;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .trait-description p {
            margin: 0;
        }

        .trait-link {
            color: var(--pop-purple);
            text-decoration: none;
            font-weight: 700;
            font-size: 0.95rem;
            transition: all 0.3s var(--ease-elastic);
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .trait-link:hover {
            transform: translateX(5px);
            color: var(--pop-teal);
        }

        /* --- ACTIONS SECTION --- */
        .actions-section {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-top: 40px;
        }

        /* --- PREMIUM SECTION --- */
        .premium-section {
            margin: 50px 0;
        }

        .premium-card {
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
            border-radius: 32px;
            padding: 50px 40px;
            text-align: center;
            color: white;
            box-shadow: var(--shadow-float);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .premium-icon {
            font-size: 4rem;
            margin-bottom: 24px;
            animation: float-blob 3s infinite ease-in-out alternate;
        }

        .premium-title {
            font-size: clamp(1.8rem, 4vw, 2.5rem);
            font-weight: 800;
            margin-bottom: 20px;
            color: white;
            letter-spacing: -0.02em;
        }

        .premium-description {
            font-size: 1.15rem;
            line-height: 1.7;
            margin-bottom: 40px;
            opacity: 0.95;
            font-weight: 600;
        }

        .premium-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
            text-align: left;
        }

        .premium-feature {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 24px;
            display: flex;
            gap: 16px;
            align-items: flex-start;
            transition: all 0.3s var(--ease-elastic);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .premium-feature:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-5px);
        }

        .feature-icon {
            font-size: 2.5rem;
            flex-shrink: 0;
        }

        .feature-content h3 {
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: white;
        }

        .feature-content p {
            font-size: 0.95rem;
            opacity: 0.9;
            margin: 0;
            line-height: 1.6;
        }

        .premium-actions {
            display: flex;
            flex-direction: column;
            gap: 16px;
            max-width: 450px;
            margin: 0 auto;
        }

        /* --- BUTTONS --- */
        .btn {
            padding: 16px 32px;
            border-radius: 100px;
            font-weight: 700;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s var(--ease-elastic);
            font-family: inherit;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--text-dark);
            color: white;
            box-shadow: var(--shadow-float);
        }

        .btn-primary:hover {
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

        .btn-outline {
            background: transparent;
            border: 2px solid white;
            color: white;
        }

        .btn-outline:hover {
            background: white;
            color: var(--pop-purple);
            transform: translateY(-3px);
        }

        .btn-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            box-shadow: var(--shadow-float);
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
            transform: translateY(-3px) scale(1.02);
        }

        .btn-large {
            padding: 18px 40px;
            font-size: 1.1rem;
        }

        .btn-block {
            width: 100%;
        }

        /* --- ANIMATIONS --- */
        @keyframes reveal {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-in {
            opacity: 0;
            animation: reveal 0.8s var(--ease-smooth) forwards;
        }

        .d-1 { animation-delay: 0.1s; }
        .d-2 { animation-delay: 0.2s; }
        .d-3 { animation-delay: 0.3s; }

        /* --- RESPONSIVE --- */
        @media (max-width: 768px) {
            .personality-result-page {
                padding: 30px 16px;
            }

            .result-header {
                padding: 40px 24px;
            }

            .personality-avatar {
                width: 150px;
                height: 150px;
            }

            .trait-card {
                padding: 24px;
            }

            .premium-card {
                padding: 40px 24px;
            }

            .premium-features {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Animate trait bars on load
            setTimeout(function() {
                var traitFills = document.querySelectorAll('.trait-fill');
                traitFills.forEach(function(fill) {
                    var width = fill.style.width;
                    fill.style.width = '0%';
                    setTimeout(function() {
                        fill.style.width = width;
                    }, 100);
                });
            }, 500);

            // Add animation classes
            var resultHeader = document.querySelector('.result-header');
            var traitCards = document.querySelectorAll('.trait-card');
            var premiumCard = document.querySelector('.premium-card');
            var actionsSection = document.querySelector('.actions-section');

            if (resultHeader) resultHeader.classList.add('animate-in');

            traitCards.forEach(function(card, index) {
                card.classList.add('animate-in');
                card.style.animationDelay = (0.2 + index * 0.1) + 's';
            });

            if (premiumCard) {
                premiumCard.classList.add('animate-in');
                premiumCard.style.animationDelay = '0.5s';
            }

            if (actionsSection) {
                actionsSection.classList.add('animate-in');
                actionsSection.style.animationDelay = '0.6s';
            }
        });
    </script>
</body>
</html>


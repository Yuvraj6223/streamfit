<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Personality Test - StreamFit</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>

<!-- Ambient Background -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

    <div class="personality-page">
        <div class="mobile-container">
            <div class="page-header">
                <div class="free-badge">100% FREE • NO LOGIN REQUIRED</div>
                <h1 class="page-title">
                    <span class="emoji">🧠</span>
                    LearnerDNA Test
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

    .personality-page {
        min-height: 100vh;
        padding: 60px 0;
        position: relative;
        z-index: 1;
    }

    .mobile-container {
        max-width: 900px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .page-header {
        text-align: center;
        margin-bottom: 60px;
    }

    .free-badge {
        display: inline-block;
        background: linear-gradient(135deg, var(--pop-teal) 0%, #5BC0CC 100%);
        color: white;
        padding: 12px 24px;
        border-radius: 100px;
        font-weight: 800;
        font-size: 0.85rem;
        letter-spacing: 1.5px;
        margin-bottom: 24px;
        box-shadow: var(--shadow-float);
        animation: pulse 3s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }

    .page-title {
        font-size: clamp(2rem, 5vw, 3rem);
        font-weight: 800;
        margin-bottom: 16px;
        color: var(--text-dark);
        letter-spacing: -0.03em;
        line-height: 1.2;
    }

    .page-title .emoji {
        font-size: clamp(3rem, 7vw, 4rem);
        display: block;
        margin-bottom: 16px;
        animation: float-blob 3s infinite ease-in-out alternate;
    }

    .page-subtitle {
        font-size: 1.25rem;
        color: var(--text-grey);
        font-weight: 600;
        line-height: 1.6;
    }

    .test-section {
        margin-bottom: 50px;
    }

    .section-title {
        font-size: 1.8rem;
        font-weight: 800;
        margin-bottom: 24px;
        color: var(--text-dark);
        letter-spacing: -0.02em;
    }

    .history-grid {
        display: grid;
        gap: 20px;
    }

    .history-card {
        background: var(--card-base);
        border-radius: 28px;
        padding: 32px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
        transition: all 0.3s var(--ease-elastic);
    }

    .history-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.3);
    }

    .history-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .personality-badge {
        background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
        color: white;
        padding: 8px 16px;
        border-radius: 12px;
        font-weight: 700;
        font-size: 0.9rem;
        letter-spacing: 0.5px;
    }

    .test-date {
        color: var(--text-grey);
        font-size: 0.9rem;
        font-weight: 600;
    }

    .personality-name {
        font-size: 1.6rem;
        font-weight: 800;
        margin-bottom: 8px;
        color: var(--text-dark);
        letter-spacing: -0.02em;
    }

    .personality-role {
        color: var(--text-grey);
        margin-bottom: 20px;
        font-weight: 600;
    }

    .start-card {
        background: var(--card-base);
        border-radius: 32px;
        padding: 60px 50px;
        text-align: center;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
    }

    .start-icon {
        font-size: 5rem;
        margin-bottom: 24px;
        animation: float-blob 3s infinite ease-in-out alternate;
    }

    .start-card h2 {
        font-size: 2.2rem;
        font-weight: 800;
        margin-bottom: 20px;
        color: var(--text-dark);
        letter-spacing: -0.02em;
    }

    .start-description {
        color: var(--text-grey);
        margin-bottom: 40px;
        line-height: 1.7;
        font-size: 1.1rem;
        font-weight: 500;
    }

    .test-features {
        display: flex;
        justify-content: center;
        gap: 32px;
        margin-bottom: 40px;
        flex-wrap: wrap;
    }

    .feature {
        display: flex;
        align-items: center;
        gap: 10px;
        color: var(--text-dark);
        font-weight: 700;
    }

    .feature-icon {
        font-size: 1.8rem;
    }

    .about-card {
        background: var(--card-base);
        border-radius: 28px;
        padding: 40px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
    }

    .about-card p {
        color: var(--text-grey);
        line-height: 1.7;
        margin-bottom: 24px;
        font-size: 1.1rem;
        font-weight: 500;
    }

    .dimensions-list {
        list-style: none;
        padding: 0;
    }

    .dimensions-list li {
        padding: 16px 0;
        border-bottom: 1px solid rgba(142, 140, 154, 0.15);
        color: var(--text-grey);
        font-weight: 500;
        font-size: 1.05rem;
    }

    .dimensions-list li:last-child {
        border-bottom: none;
    }

    .dimensions-list strong {
        color: var(--text-dark);
        font-weight: 800;
    }

    /* --- BUTTONS --- */
    .btn {
        display: inline-block;
        padding: 18px 40px;
        border-radius: 100px;
        font-weight: 700;
        font-size: 1.1rem;
        text-decoration: none;
        transition: all 0.3s var(--ease-elastic);
        cursor: pointer;
        border: none;
        font-family: inherit;
        text-align: center;
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

    .btn-large {
        padding: 20px 50px;
        font-size: 1.2rem;
    }

    .btn-block {
        display: block;
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

    /* --- RESPONSIVE --- */
    @media (max-width: 768px) {
        .personality-page {
            padding: 40px 0;
        }

        .mobile-container {
            padding: 0 16px;
        }

        .page-header {
            margin-bottom: 40px;
        }

        .start-card {
            padding: 40px 30px;
        }

        .test-features {
            gap: 20px;
        }

        .history-card {
            padding: 24px;
        }

        .about-card {
            padding: 30px 24px;
        }
    }
    </style>

    <script>
        // Add animation on scroll
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.history-card, .start-card, .about-card');
            cards.forEach(function(card, index) {
                card.classList.add('animate-in');
                card.style.animationDelay = (index * 0.1) + 's';
            });
        });
    </script>
</body>
</html>


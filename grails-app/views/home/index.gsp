<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>What's Your Learning Superpower? 🎮 | StreamFit</title>
</head>
<body>
<!-- Ambient Background Layer - Enhanced with Neon Glow -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
    <div class="particle-container" id="particles"></div>
</div>

<div class="landing-page">

    <!-- 1. HERO GAME PORTAL - INSTANT ACTION -->
    <section class="hero-section game-portal">
        <div class="mobile-container">
            <div class="hero-content">

                <!-- Live Player Counter -->
                <div class="live-counter pulse-glow">
                    <span class="live-dot"></span>
                    <span class="live-text"><strong>1,247</strong> people playing right now 🔥</span>
                </div>

                <!-- Big Simple Headline -->
                <h1 class="hero-title game-title">
                    What's Your Learning<br>
                    Superpower? 🎮
                </h1>

                <!-- One-liner Sub-headline -->
                <p class="hero-subtitle game-subtitle">
                    Find your brain type in 3 minutes ⚡
                </p>

                <!-- Animated Character Preview Cards -->
                <div class="character-selection">
                    <div class="character-card" data-character="owl">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'owl.png')}" alt="Wise Owl" class="character-image"/>
                        </div>
                        <div class="character-name">Wise Owl</div>
                        <div class="character-trait">Deep Thinker</div>
                    </div>
                    <div class="character-card" data-character="wolf">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'wolf.png')}" alt="Strategic Wolf" class="character-image"/>
                        </div>
                        <div class="character-name">Strategic Wolf</div>
                        <div class="character-trait">Quick Decider</div>
                    </div>
                    <div class="character-card" data-character="tiger">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'tiger.png')}" alt="Bold Tiger" class="character-image"/>
                        </div>
                        <div class="character-name">Bold Tiger</div>
                        <div class="character-trait">Creative Sprinter</div>
                    </div>
                    <div class="character-card" data-character="bee">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'bee.png')}" alt="Disciplined Bee" class="character-image"/>
                        </div>
                        <div class="character-name">Disciplined Bee</div>
                        <div class="character-trait">Steady Builder</div>
                    </div>
                </div>

                <!-- Giant Play Now Button -->
                <a href="${createLink(controller: 'personality', action: 'start')}"
                   class="btn btn-primary btn-play-now pulse-animation"
                   data-track="hero_play_now">
                    <span class="btn-icon">🚀</span>
                    <span class="btn-text">Play Now</span>
                </a>

                <!-- Quick Trust Signals -->
                <div class="quick-trust">
                    <span class="trust-item">⚡ 3 min to start</span>
                    <span class="trust-divider">•</span>
                    <span class="trust-item">✅ 100% free</span>
                    <span class="trust-divider">•</span>
                    <span class="trust-item">🔥 12,847+ played</span>
                </div>
            </div>
        </div>
    </section>

    <!-- 2. LIVE MINI-GAME DEMO - INSTANT INTERACTION -->
    <section class="mini-game-section">
        <div class="mobile-container">
            <h2 class="section-title game-title">Try It Right Now 👇</h2>
            <p class="section-subtitle">Answer 1 question, get a sneak peek</p>

            <!-- Interactive Demo Question -->
            <div class="demo-question-card">
                <div class="demo-question-header">
                    <span class="demo-badge">DEMO</span>
                    <span class="demo-timer">⚡ 5 sec</span>
                </div>
                <h3 class="demo-question-text">Quick - which emoji describes you in exams?</h3>
                <div class="demo-options">
                    <button class="demo-option" data-result="wolf">
                        <span class="demo-emoji">😰</span>
                        <span class="demo-label">Stressed but focused</span>
                    </button>
                    <button class="demo-option" data-result="tiger">
                        <span class="demo-emoji">😎</span>
                        <span class="demo-label">Confident & quick</span>
                    </button>
                    <button class="demo-option" data-result="owl">
                        <span class="demo-emoji">🤓</span>
                        <span class="demo-label">Overthinking everything</span>
                    </button>
                    <button class="demo-option" data-result="bee">
                        <span class="demo-emoji">😴</span>
                        <span class="demo-label">Calm & prepared</span>
                    </button>
                </div>
                <div class="demo-result" id="demoResult" style="display: none;">
                    <div class="demo-result-content">
                        <div class="demo-result-icon" id="demoResultIcon">🐺</div>
                        <p class="demo-result-text" id="demoResultText">Hmm... you might be a Strategic Wolf!</p>
                        <a href="${createLink(controller: 'personality', action: 'start')}"
                           class="btn btn-primary btn-demo-cta">
                            Find Out For Sure 🎯
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 3. QUICK VISUAL RESULTS SHOWCASE -->
    <section class="results-showcase-section">
        <div class="mobile-container">
            <h2 class="section-title">What You'll Unlock 🎁</h2>

            <div class="benefits-grid">
                <div class="benefit-card">
                    <div class="benefit-icon">🎯</div>
                    <div class="benefit-text">Find YOUR subjects in 3 min</div>
                </div>
                <div class="benefit-card">
                    <div class="benefit-icon">🧠</div>
                    <div class="benefit-text">How your brain works</div>
                </div>
                <div class="benefit-card">
                    <div class="benefit-icon">🚀</div>
                    <div class="benefit-text">Top 3 career matches</div>
                </div>
                <div class="benefit-card">
                    <div class="benefit-icon">📊</div>
                    <div class="benefit-text">Proof for your parents</div>
                </div>
            </div>
        </div>
    </section>

    <!-- 4. GAME LEVELS - HOW IT WORKS -->
    <section class="game-levels-section">
        <div class="mobile-container">
            <h2 class="section-title">3 Levels to Your Superpower 🎮</h2>

            <div class="game-levels">
                <!-- Level 1 -->
                <div class="game-level level-unlocked">
                    <div class="level-number">
                        <span class="level-badge">LEVEL 1</span>
                        <span class="level-status unlocked">🔓 UNLOCKED</span>
                    </div>
                    <div class="level-content">
                        <div class="level-icon">🦉</div>
                        <h3 class="level-title">Find Your Animal</h3>
                        <p class="level-desc">3 min • Instant results</p>
                    </div>
                </div>

                <!-- Level 2 -->
                <div class="game-level level-locked">
                    <div class="level-number">
                        <span class="level-badge">LEVEL 2</span>
                        <span class="level-status locked">🔒 UNLOCK NEXT</span>
                    </div>
                    <div class="level-content">
                        <div class="level-icon">🧠</div>
                        <h3 class="level-title">Brain Superpowers</h3>
                        <p class="level-desc">+8 mini-games (optional)</p>
                    </div>
                </div>

                <!-- Level 3 -->
                <div class="game-level level-locked">
                    <div class="level-number">
                        <span class="level-badge">BOSS LEVEL</span>
                        <span class="level-status locked">🏆 FINAL REWARD</span>
                    </div>
                    <div class="level-content">
                        <div class="level-icon">📊</div>
                        <h3 class="level-title">Your Complete Profile</h3>
                        <p class="level-desc">Stream match + career paths</p>
                    </div>
                </div>
            </div>

            <!-- Time Reframe -->
            <div class="time-reframe">
                <p class="time-text">
                    <span class="time-highlight">Just 3 minutes to start!</span><br>
                    Most students stop after 2-3 tests and that's totally fine! 😊
                </p>
            </div>
        </div>
    </section>

    <!-- 5. SOCIAL PROOF - GAMING ACHIEVEMENT STYLE -->
    <section class="social-proof-section">
        <div class="mobile-container">
            <div class="achievement-header">
                <h2 class="section-title">🏆 12,847 Superpowers Unlocked This Month</h2>
            </div>

            <!-- Instagram-style Feed -->
            <div class="social-feed">
                <div class="feed-card">
                    <div class="feed-header">
                        <div class="feed-avatar">
                            <img src="${assetPath(src: 'wolf.png')}" alt="Wolf" class="feed-avatar-image"/>
                        </div>
                        <div class="feed-info">
                            <div class="feed-name">Rohan</div>
                            <div class="feed-time">just discovered he's a Strategic Wolf</div>
                        </div>
                    </div>
                    <div class="feed-quote">"Yo this test is actually legit 😳"</div>
                </div>

                <div class="feed-card">
                    <div class="feed-header">
                        <div class="feed-avatar">
                            <img src="${assetPath(src: 'tiger.png')}" alt="Tiger" class="feed-avatar-image"/>
                        </div>
                        <div class="feed-info">
                            <div class="feed-name">Kavya</div>
                            <div class="feed-time">unlocked Bold Tiger 2 min ago</div>
                        </div>
                    </div>
                    <div class="feed-quote">"Finally makes sense why I hate slow classes 🐯"</div>
                </div>

                <div class="feed-card">
                    <div class="feed-header">
                        <div class="feed-avatar">
                            <img src="${assetPath(src: 'owl.png')}" alt="Owl" class="feed-avatar-image"/>
                        </div>
                        <div class="feed-info">
                            <div class="feed-name">Aditya</div>
                            <div class="feed-time">became a Wise Owl 5 min ago</div>
                        </div>
                    </div>
                    <div class="feed-quote">"I'm an Owl apparently... explains SO much"</div>
                </div>
            </div>

            <!-- Quick Stats -->
            <div class="quick-stats">
                <div class="stat-item">
                    <div class="stat-number">9/10</div>
                    <div class="stat-label">say this beats asking 10 friends</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">2,000+</div>
                    <div class="stat-label">shared on Instagram this month</div>
                </div>
            </div>
        </div>
    </section>



    <!-- 6. FINAL CTA - GAME-STYLE URGENT -->
    <section class="final-cta-section game-cta">
        <div class="mobile-container">
            <div class="final-cta-content">
                <!-- Countdown Timer -->
                <div class="live-activity">
                    <span class="activity-pulse"></span>
                    <span class="activity-text">2,000 students playing RIGHT NOW</span>
                </div>

                <!-- Direct Headline -->
                <h2 class="final-headline">Your Friends Are Already Playing</h2>
                <p class="final-subtext">Don't Get Left Behind</p>

                <!-- Giant Play Button -->
                <a href="${createLink(controller: 'personality', action: 'start')}"
                   class="btn btn-primary btn-final-play mega-button"
                   data-track="final_play_now">
                    <span class="mega-icon">🚀</span>
                    <span class="mega-text">PLAY NOW</span>
                </a>

                <!-- Quick Reassurance -->
                <p class="final-reassurance">
                    Start playing in 10 seconds ⚡ • No studying needed - just be yourself
                </p>

                <!-- Trust Pills -->
                <div class="trust-pills">
                    <span class="trust-pill">✅ Free forever</span>
                    <span class="trust-pill">⚡ 3 min to start</span>
                    <span class="trust-pill">🔥 12,847+ played</span>
                </div>
            </div>
        </div>
    </section>

</div>

<!-- Scroll to Top Button -->
<button class="scroll-to-top" id="scrollToTop" title="Back to top">
    <span>↑</span>
</button>

<style>
/* Import Fonts */
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700;800;900&display=swap');

/* StreamFit Color Palette - Soft Pop Mental Wellness Theme */
:root {
    /* BRAND PALETTE - VIBRANT GAMIFIED THEME (From Reference Image) */
    --bg-warm: #F5F3FF;  /* Light purple background */
    --text-dark: #2D2A45;  /* Deep purple-gray for text */
    --text-grey: #7B7896;  /* Medium purple-gray */

    /* PRIMARY COLORS - Vibrant Gamified Palette */
    --pop-purple: #8B7FE8;  /* Main purple */
    --pop-purple-light: #A89FF3;  /* Light purple */
    --pop-purple-lighter: #C4B5FD;  /* Lighter purple */
    --pop-cyan: #5FE3D0;  /* Bright cyan/turquoise */
    --pop-cyan-light: #7FDBDA;  /* Light cyan */
    --pop-cyan-lighter: #A0E7E5;  /* Lighter cyan */
    --pop-pink: #FFB4D6;  /* Soft pink */
    --pop-pink-light: #FFC4E1;  /* Light pink */
    --pop-yellow: #FFE17B;  /* Pastel yellow */
    --pop-yellow-light: #FFEB99;  /* Light yellow */
    --pop-coral: #FF9AB8;  /* Coral pink */

    /* GRADIENT BACKGROUNDS */
    --gradient-purple-cyan: linear-gradient(135deg, #8B7FE8 0%, #5FE3D0 100%);
    --gradient-pink-purple: linear-gradient(135deg, #FFB4D6 0%, #A89FF3 100%);
    --gradient-cyan-yellow: linear-gradient(135deg, #5FE3D0 0%, #FFE17B 100%);
    --gradient-purple-pink: linear-gradient(135deg, #8B7FE8 0%, #FFB4D6 100%);

    /* SURFACES */
    --card-base: rgba(255, 255, 255, 0.85);  /* Semi-transparent white */
    --card-glass: rgba(255, 255, 255, 0.25);  /* Glassmorphism */

    /* GLASSMORPHISM SHADOWS */
    --shadow-soft: 0 12px 30px -10px rgba(139, 127, 232, 0.15);
    --shadow-float: 0 20px 40px -12px rgba(139, 127, 232, 0.25);
    --shadow-glow-purple: 0 8px 32px rgba(139, 127, 232, 0.3);
    --shadow-glow-cyan: 0 8px 32px rgba(95, 227, 208, 0.3);
    --shadow-glow-pink: 0 8px 32px rgba(255, 180, 214, 0.3);

    /* ANIMATION */
    --ease-elastic: cubic-bezier(0.34, 1.56, 0.64, 1);
    --ease-smooth: cubic-bezier(0.16, 1, 0.3, 1);

    /* Legacy mappings for compatibility */
    --navy-blue: #8B7FE8;      /* Maps to pop-purple */
    --bright-blue: #5FE3D0;    /* Maps to pop-cyan */
    --orange: #FF9AB8;         /* Maps to pop-coral */
    --gold: #FFE17B;           /* Maps to pop-yellow */
    --white: #FFFFFF;
    --light-gray: #F5F3FF;     /* Maps to bg-warm */
    --light-blue: #E8E4FF;     /* Light purple tint */
    --light-orange: #FFE8F0;   /* Light pink tint */
    --light-gold: #FFF8E8;     /* Light yellow tint */
    --dark-navy: #2D2A45;      /* Maps to text-dark */
    --text-dark-navy: #2D2A45; /* Maps to text-dark */
    --text-medium-gray: #7B7896; /* Maps to text-grey */
    --text-light-gray: #A89FF3; /* Light purple-gray */
    --text-white: #FFFFFF;
    --border-gray: rgba(139, 127, 232, 0.2);
    --success-green: #5FE3D0;  /* Maps to pop-cyan */
    --success-green-light: rgba(95, 227, 208, 0.15);
    --success-green-dark: #3ABFA8;
    --success-green-bg: rgba(95, 227, 208, 0.05);
    --error-red: #FF9AB8;      /* Maps to pop-coral */
    --error-red-light: rgba(255, 154, 184, 0.15);
    --error-red-dark: #FF7BA0;
    --footer-bg: #2D2A45;      /* Maps to text-dark */
    --orange-hover: #FF7BA0;   /* Darker coral on hover */
    --success-dark: #3ABFA8;

    /* Typography */
    --font-display: 'Plus Jakarta Sans', 'Outfit', sans-serif;
    --font-body: 'Plus Jakarta Sans', 'Space Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: var(--font-body);
    line-height: 1.6;
    color: var(--text-dark);
    background: var(--bg-warm);
    -webkit-font-smoothing: antialiased;
}

/* Apply Display Font to All Headlines */
h1, h2, h3, h4, h5, h6,
.hero-title,
.section-title,
.final-headline,
.discover-card h3,
.journey-step h3,
.story-card h3,
.testimonial-name,
.faq-question,
.transformation-title,
.instagram-title {
    font-family: var(--font-display);
    font-weight: 800;
    letter-spacing: -0.02em;  /* Tighter tracking for display font */
}

/* ========================================
           UNIFIED ICON SYSTEM - Design Guidelines
           ========================================

           PROBLEM: Mixed emoji styles (animal emojis vs flat icons) create visual inconsistency

           SOLUTION: Standardized icon categories with consistent visual treatment

           ICON CATEGORIES:
           1. Learning Animals (Primary Brand Icons)
              - 🦉 Owl (Wise/Analytical)
              - 🐺 Wolf (Strategic/Intuitive)
              - 🐝 Bee (Collaborative/Systematic)
              - 🐯 Tiger (Bold/Creative)

           2. Action Icons (Geometric/Abstract)
              - 🎯 Target (Goals/Precision)
              - 💎 Diamond (Value/Quality)
              - 🚀 Rocket (Growth/Speed)
              - ⚡ Lightning (Energy/Quick)
              - 🔥 Fire (Hot/Trending)
              - ✅ Checkmark (Success/Complete)

           3. Emotion Icons (Faces/Expressions)
              - 😰 Anxious Face (Problem state)
              - 🎯 Focused (Solution state)
              - 💡 Lightbulb (Insight/Idea)

           4. Social Proof Icons
              - ⭐ Star (Rating)
              - 📱 Phone (Social/Mobile)
              - 👨‍🎓 Student (User persona)

           FUTURE: Replace with custom SVG icon set for full brand control
           (Recommended: Duotone style with brand colors)
        ======================================== */

.icon-emoji {
    font-style: normal;
    font-weight: normal;
    display: inline-block;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));  /* Subtle depth for all icons */
}

/* Icon sizing system */
.icon-sm { font-size: 1.5rem; }
.icon-md { font-size: 2.5rem; }
.icon-lg { font-size: 4rem; }
.icon-xl { font-size: 5rem; }

/* Ensure all emojis render consistently across browsers */
.student-icon,
.result-badge,
.big-icon,
.chest-icon,
.result-icon,
.story-emoji,
.transform-emoji,
.screenshot-badge,
.insta-avatar {
    font-family: 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji', sans-serif;
}

/* ========================================
           MOBILE-FIRST OPTIMIZATIONS
           ========================================

           THUMB-FRIENDLY TARGETS:
           - Minimum 56px height for all CTAs (Apple/Google guidelines)
           - Minimum 48px for secondary buttons
           - Adequate spacing between tappable elements

           PERFORMANCE:
           - Horizontal scroll for card grids (reduce vertical scroll fatigue)
           - Sticky bottom CTA bar (always visible conversion path)
           - Reduced section padding (less scrolling)
        ======================================== */

/* Sticky Mobile CTA Bar - Always visible on mobile */
.mobile-sticky-cta {
    display: none;  /* Hidden on desktop */
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: var(--card-base);
    padding: 12px 20px;
    box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.1);
    z-index: 1000;
    animation: slideUpIn 0.4s ease-out;
    border-top: 1px solid rgba(255, 255, 255, 0.5);
}

@keyframes slideUpIn {
    from {
        transform: translateY(100%);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

.mobile-sticky-cta .btn {
    width: 100%;
    min-height: 52px;  /* Optimized for mobile */
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-weight: 700;
    background: #ffffff;
    color: #000000;
    border: 2px solid #000000;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.15);
    border-radius: 30px;
    outline: none !important;
    -webkit-tap-highlight-color: transparent !important;
}

.mobile-sticky-cta .btn:focus,
.mobile-sticky-cta .btn:active,
.mobile-sticky-cta .btn:focus-visible {
    outline: none !important;
    outline-style: none !important;
    outline-width: 0 !important;
    -webkit-tap-highlight-color: transparent !important;
}

.mobile-sticky-cta .btn:active {
    transform: scale(0.98);  /* Tactile feedback */
    background: linear-gradient(135deg, #FF5239 0%, #FF6B53 100%);
}

/* Scroll to Top Button */
.scroll-to-top {
    position: fixed;
    bottom: 100px;
    right: 20px;
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, var(--ocean-blue) 0%, var(--soft-teal-blue) 100%);
    color: var(--pure-white);
    border: none;
    border-radius: 50%;
    font-size: 1.5rem;
    cursor: pointer;
    box-shadow: 0 4px 16px rgba(58, 109, 137, 0.3);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 999;
    display: flex;
    align-items: center;
    justify-content: center;
}

.scroll-to-top.visible {
    opacity: 1;
    visibility: visible;
}

.scroll-to-top:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 24px rgba(58, 109, 137, 0.4);
}

.scroll-to-top:active {
    transform: translateY(-2px);
}

/* Horizontal Scroll Hint - Shows on mobile to indicate swipeable cards */
.scroll-hint {
    display: none;
    text-align: center;
    color: var(--text-light-gray);
    font-size: 0.9rem;
    margin-top: 10px;
    font-weight: 500;
}

.scroll-hint::after {
    content: ' 👉';
    animation: swipeHint 1.5s ease-in-out infinite;
}

@keyframes swipeHint {
    0%, 100% { transform: translateX(0); }
    50% { transform: translateX(10px); }
}

/* Scroll Navigation - Dots and Arrows */
.scroll-navigation {
    display: none;  /* Hidden by default, shown on mobile */
    align-items: center;
    justify-content: center;
    gap: 20px;
    margin-top: 30px;
    margin-bottom: 10px;
}

.scroll-dots {
    display: flex;
    gap: 10px;
    align-items: center;
}

.scroll-dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: #D1D5DB;
    cursor: pointer;
    transition: all 0.3s ease;
}

.scroll-dot.active {
    background: var(--ocean-blue);
    width: 12px;
    height: 12px;
}

.scroll-arrow {
    background: transparent;
    border: none;
    font-size: 2rem;
    color: #9CA3AF;
    cursor: pointer;
    padding: 5px 10px;
    transition: all 0.3s ease;
    line-height: 1;
}

.scroll-arrow:hover {
    color: var(--ocean-blue);
    transform: scale(1.2);
}

.scroll-arrow:active {
    transform: scale(0.95);
}

.scroll-arrow-left {
    margin-right: 5px;
}

.scroll-arrow-right {
    margin-left: 5px;
}

/* --- AMBIENT BACKGROUND --- */
.scenery-layer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    overflow: hidden;
    background: var(--bg-warm);
}

.blob {
    position: absolute;
    filter: blur(80px);
    opacity: 0.4;
    animation: float-blob 20s infinite ease-in-out alternate;
}

.b-1 {
    top: -10%;
    right: -5%;
    width: 600px;
    height: 600px;
    background: var(--pop-purple);  /* Purple blob */
    border-radius: 40% 60% 70% 30%;
}

.b-2 {
    bottom: -10%;
    left: -10%;
    width: 700px;
    height: 700px;
    background: var(--pop-cyan);  /* Cyan blob */
    border-radius: 60% 40% 30% 70%;
    animation-delay: -5s;
}

.b-3 {
    top: 40%;
    left: 40%;
    width: 400px;
    height: 400px;
    background: var(--pop-pink);  /* Pink blob */
    opacity: 0.35;
    border-radius: 30% 70%;
    animation-duration: 18s;
}

@keyframes float-blob {
    0% {
        transform: translate(0, 0) rotate(0deg);
    }
    100% {
        transform: translate(40px, 40px) rotate(10deg);
    }
}

.landing-page {
    background: transparent;
    position: relative;
}

.mobile-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Mobile-first container optimization */
@media (max-width: 768px) {
    .mobile-container {
        padding: 0 16px;
    }

    /* Improve touch targets for mobile */
    a, button {
        -webkit-tap-highlight-color: rgba(255, 107, 83, 0.2);
    }

    /* Smooth scrolling for mobile */
    html {
        scroll-behavior: smooth;
        -webkit-overflow-scrolling: touch;
    }
}

@media (max-width: 480px) {
    .mobile-container {
        padding: 0 14px;
    }
}

/* ========================================
   GAMIFIED LANDING PAGE STYLES
   ======================================== */

/* Particle System */
.particle-container {
    position: absolute;
    width: 100%;
    height: 100%;
    pointer-events: none;
}

/* 1. HERO GAME PORTAL */
.hero-section.game-portal {
    padding: 60px 0 80px;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.hero-content {
    max-width: 900px;
    margin: 0 auto;
}

/* Live Counter - Enhanced with glassmorphism */
.live-counter {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: var(--card-glass);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 2px solid rgba(139, 127, 232, 0.3);
    padding: 10px 24px;
    border-radius: 50px;
    margin-bottom: 25px;
    animation: pulse-glow 2s ease-in-out infinite;
    box-shadow: var(--shadow-glow-purple);
}

.live-dot {
    width: 10px;
    height: 10px;
    background: var(--pop-pink);
    border-radius: 50%;
    animation: pulse-dot 1.5s ease-in-out infinite;
    box-shadow: 0 0 10px rgba(255, 180, 214, 0.6);
}

@keyframes pulse-dot {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(1.3); }
}

@keyframes pulse-glow {
    0%, 100% {
        box-shadow: 0 8px 32px rgba(139, 127, 232, 0.25), 0 0 15px rgba(139, 127, 232, 0.3);
    }
    50% {
        box-shadow: 0 8px 32px rgba(139, 127, 232, 0.35), 0 0 25px rgba(139, 127, 232, 0.5);
    }
}

.live-text {
    font-size: 1rem;
    font-weight: 700;
    color: var(--text-dark);
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* Game Title */
.hero-title.game-title {
    font-size: 3.5rem;
    font-weight: 900;
    color: var(--text-dark);
    margin-bottom: 15px;
    line-height: 1.1;
    letter-spacing: -0.03em;
    text-shadow: 0 2px 10px rgba(159, 151, 243, 0.2);
}

.hero-subtitle.game-subtitle {
    font-size: 1.4rem;
    color: var(--text-grey);
    margin-bottom: 40px;
    font-weight: 600;
}

/* Character Selection Cards */
.character-selection {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 15px;
    margin-bottom: 40px;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
}

.character-card {
    background: var(--card-base);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 24px;
    padding: 28px 18px;
    text-align: center;
    cursor: pointer;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 3px solid rgba(139, 127, 232, 0.3);
    box-shadow: var(--shadow-soft);
    position: relative;
    overflow: hidden;
}

.character-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(139, 127, 232, 0.12) 0%, rgba(95, 227, 208, 0.12) 100%);
    opacity: 0;
    transition: opacity 0.4s ease;
}

.character-card:hover::before {
    opacity: 1;
}

.character-card:hover {
    transform: translateY(-14px) scale(1.08);
    border-color: rgba(139, 127, 232, 0.6);
    box-shadow: var(--shadow-glow-purple);
}

.character-icon {
    font-size: 4.2rem;
    margin-bottom: 14px;
    display: block;
    filter: drop-shadow(0 6px 12px rgba(0, 0, 0, 0.12));
    position: relative;
    z-index: 1;
}

.character-image {
    width: 100%;
    max-width: 120px;
    border-radius: 50%;
    height: auto;
    display: block;
    margin: 0 auto;
    object-fit: contain;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.character-card:hover .character-image {
    transform: scale(1.1);
}

.bounce-hover {
    animation: float-gentle 3s ease-in-out infinite;
}

@keyframes float-gentle {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-12px); }
}

.character-card:nth-child(1) .bounce-hover { animation-delay: 0s; }
.character-card:nth-child(2) .bounce-hover { animation-delay: 0.25s; }
.character-card:nth-child(3) .bounce-hover { animation-delay: 0.5s; }
.character-card:nth-child(4) .bounce-hover { animation-delay: 0.75s; }

.character-name {
    font-size: 1.15rem;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 6px;
    letter-spacing: -0.01em;
    position: relative;
    z-index: 1;
}

.character-trait {
    font-size: 0.9rem;
    color: var(--text-grey);
    font-weight: 600;
    position: relative;
    z-index: 1;
}

/* Giant Play Now Button - Enhanced */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    padding: 20px 45px;
    border-radius: 50px;
    font-weight: 800;
    text-decoration: none;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: none;
    cursor: pointer;
    font-size: 1.3rem;
    background: var(--gradient-purple-cyan);
    color: #FFFFFF;
    box-shadow: var(--shadow-glow-purple), 0 0 0 1px rgba(255, 255, 255, 0.1) inset;
    position: relative;
    overflow: hidden;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    transition: left 0.6s ease;
}

.btn:hover::before {
    left: 100%;
}

.btn:hover {
    transform: translateY(-6px) scale(1.06);
    box-shadow: var(--shadow-glow-cyan), 0 0 0 1px rgba(255, 255, 255, 0.2) inset;
}

.btn:focus,
.btn:active,
.btn-primary:focus,
.btn-primary:active,
a:focus,
a:active,
button:focus,
button:active {
    outline: none !important;
    -webkit-tap-highlight-color: transparent !important;
}

.btn-primary {
    background: var(--gradient-purple-cyan);
    color: #FFFFFF;
    border: none;
}

.btn-primary:hover {
    transform: translateY(-5px) scale(1.05);
    box-shadow: var(--shadow-glow-purple);
}

.btn-primary:active {
    transform: translateY(-2px) scale(1.02);
}

/* Play Now Button Specific */
.btn-play-now {
    padding: 20px 50px;
    font-size: 1.4rem;
    margin-bottom: 20px;
}

.pulse-animation {
    animation: pulse-scale 2s ease-in-out infinite;
}

@keyframes pulse-scale {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
}

.btn-icon {
    font-size: 1.6rem;
}

.btn-text {
    font-weight: 800;
    letter-spacing: 0.5px;
}

/* Quick Trust Signals */
.quick-trust {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 20px;
    font-size: 0.95rem;
    color: var(--text-grey);
}

.trust-item {
    font-weight: 600;
}

.trust-divider {
    color: var(--text-grey);
    opacity: 0.5;
}

/* ========================================
   2. MINI-GAME DEMO SECTION
   ======================================== */

.mini-game-section {
    padding: 60px 0;
    background: transparent;
}

.section-title {
    font-size: 2.5rem;
    font-weight: 900;
    color: var(--text-dark);
    margin-bottom: 15px;
    text-align: center;
}

.section-title.game-title {
    background: var(--gradient-purple-cyan);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.section-subtitle {
    font-size: 1.2rem;
    color: var(--text-grey);
    text-align: center;
    margin-bottom: 40px;
    font-weight: 600;
}

.demo-question-card {
    background: var(--card-base);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border-radius: 32px;
    padding: 45px;
    max-width: 720px;
    margin: 0 auto;
    box-shadow: var(--shadow-glow-purple), 0 0 0 1px rgba(139, 127, 232, 0.1);
    border: 3px solid rgba(139, 127, 232, 0.3);
    position: relative;
    overflow: hidden;
}

.demo-question-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(139, 127, 232, 0.08) 0%, rgba(95, 227, 208, 0.08) 100%);
    pointer-events: none;
}

.demo-question-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.demo-badge {
    background: var(--pop-yellow);
    color: var(--text-dark);
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 800;
}

.demo-timer {
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--pop-coral);
}

.demo-question-text {
    font-size: 1.8rem;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 30px;
    text-align: center;
}

.demo-options {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
    margin-bottom: 20px;
}

.demo-option {
    background: var(--card-glass);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    border: 3px solid rgba(139, 127, 232, 0.3);
    border-radius: 24px;
    padding: 24px;
    cursor: pointer;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    position: relative;
    z-index: 1;
}

.demo-option:hover {
    transform: translateY(-8px) scale(1.08);
    border-color: rgba(95, 227, 208, 0.6);
    background: var(--card-base);
    box-shadow: var(--shadow-glow-cyan);
}

.demo-emoji {
    font-size: 3.5rem;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
}

.demo-label {
    font-size: 1.05rem;
    font-weight: 800;
    color: var(--text-dark);
    text-align: center;
    letter-spacing: -0.01em;
}

.demo-result {
    margin-top: 20px;
    padding: 30px;
    background: linear-gradient(135deg, rgba(139, 127, 232, 0.15), rgba(95, 227, 208, 0.15));
    border-radius: 20px;
    text-align: center;
    animation: slideIn 0.5s ease-out;
}

@keyframes slideIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.demo-result-icon {
    font-size: 4rem;
    margin-bottom: 15px;
}

.demo-result-image {
    width: 120px;
    height: auto;
    display: block;
    margin: 0 auto 15px;
    filter: drop-shadow(0 8px 16px rgba(139, 127, 232, 0.4));
    animation: bounceIn 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

@keyframes bounceIn {
    0% { transform: scale(0); opacity: 0; }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); opacity: 1; }
}

.demo-result-text {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 20px;
}

.btn-demo-cta {
    margin-top: 10px;
}

/* ========================================
   3. RESULTS SHOWCASE SECTION
   ======================================== */

.results-showcase-section {
    padding: 60px 0;
    background: transparent;
}

.benefits-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    max-width: 900px;
    margin: 0 auto;
}

.benefit-card {
    background: var(--card-base);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 24px;
    padding: 30px 22px;
    text-align: center;
    box-shadow: var(--shadow-soft);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 2px solid rgba(139, 127, 232, 0.2);
    position: relative;
    overflow: hidden;
}

.benefit-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(139, 127, 232, 0.1) 0%, rgba(255, 180, 214, 0.1) 100%);
    opacity: 0;
    transition: opacity 0.4s ease;
}

.benefit-card:hover::before {
    opacity: 1;
}

.benefit-card:hover {
    transform: translateY(-12px) scale(1.05);
    border-color: rgba(139, 127, 232, 0.5);
    box-shadow: var(--shadow-glow-purple);
}

.benefit-icon {
    font-size: 3.5rem;
    margin-bottom: 18px;
    display: block;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    position: relative;
    z-index: 1;
}

.benefit-text {
    font-size: 1.05rem;
    font-weight: 800;
    color: var(--text-dark);
    line-height: 1.5;
    position: relative;
    z-index: 1;
}

/* ========================================
   4. GAME LEVELS SECTION
   ======================================== */

.game-levels-section {
    padding: 60px 0;
    background: transparent;
}

.game-levels {
    max-width: 700px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.game-level {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.88) 100%);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 28px;
    padding: 28px 35px;
    display: flex;
    align-items: center;
    gap: 28px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 3px solid rgba(255, 255, 255, 0.5);
    position: relative;
    overflow: hidden;
}

.game-level::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(58, 124, 165, 0.08) 0%, rgba(115, 210, 222, 0.08) 100%);
    opacity: 0;
    transition: opacity 0.4s ease;
}

.game-level:hover::before {
    opacity: 1;
}

.game-level.level-unlocked {
    border-color: rgba(58, 124, 165, 0.4);
}

.game-level.level-unlocked::before {
    opacity: 1;
}

.game-level.level-locked {
    opacity: 0.65;
    border-color: rgba(0, 0, 0, 0.15);
}

.game-level:hover {
    transform: translateX(12px) scale(1.02);
    box-shadow: 0 14px 40px rgba(58, 124, 165, 0.25);
}

.level-number {
    display: flex;
    flex-direction: column;
    gap: 8px;
    min-width: 120px;
}

.level-badge {
    background: var(--pop-purple);
    color: white;
    padding: 6px 12px;
    border-radius: 15px;
    font-size: 0.75rem;
    font-weight: 800;
    text-align: center;
}

.level-status {
    font-size: 0.85rem;
    font-weight: 700;
    text-align: center;
}

.level-status.unlocked {
    color: var(--pop-teal);
}

.level-status.locked {
    color: var(--text-grey);
}

.level-content {
    flex: 1;
    display: flex;
    align-items: center;
    gap: 20px;
}

.level-icon {
    font-size: 3rem;
}

.level-title {
    font-size: 1.3rem;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 5px;
}

.level-desc {
    font-size: 0.95rem;
    color: var(--text-grey);
    font-weight: 600;
}

.time-reframe {
    text-align: center;
    margin-top: 40px;
    padding: 25px;
    background: var(--pop-cream);
    border-radius: 20px;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
}

.time-text {
    font-size: 1.1rem;
    color: var(--text-dark);
    line-height: 1.6;
}

.time-highlight {
    font-size: 1.3rem;
    font-weight: 800;
    color: var(--pop-coral);
}

/* ========================================
   5. SOCIAL PROOF SECTION
   ======================================== */

.social-proof-section {
    padding: 60px 0;
    background: transparent;
}

.achievement-header {
    text-align: center;
    margin-bottom: 40px;
}

.social-feed {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    max-width: 1000px;
    margin: 0 auto 40px;
}

.feed-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.88) 100%);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 24px;
    padding: 24px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 2px solid rgba(255, 255, 255, 0.5);
    position: relative;
    overflow: hidden;
}

.feed-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(255, 107, 83, 0.08) 0%, rgba(159, 151, 243, 0.08) 100%);
    opacity: 0;
    transition: opacity 0.4s ease;
}

.feed-card:hover::before {
    opacity: 1;
}

.feed-card:hover {
    transform: translateY(-10px) scale(1.03);
    border-color: rgba(159, 151, 243, 0.5);
    box-shadow: 0 16px 40px rgba(159, 151, 243, 0.35);
}

.feed-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 15px;
}

.feed-avatar {
    font-size: 2.5rem;
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--pop-cream);
    border-radius: 50%;
    overflow: hidden;
}

.feed-avatar-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    padding: 5px;
}

.feed-info {
    flex: 1;
}

.feed-name {
    font-size: 1rem;
    font-weight: 800;
    color: var(--text-dark);
}

.feed-time {
    font-size: 0.85rem;
    color: var(--text-grey);
    font-weight: 600;
}

.feed-quote {
    font-size: 1rem;
    color: var(--text-dark);
    line-height: 1.5;
    font-weight: 600;
}

.quick-stats {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    max-width: 700px;
    margin: 0 auto;
}

.stat-item {
    background: var(--card-base);
    border-radius: 20px;
    padding: 30px;
    text-align: center;
    box-shadow: var(--shadow-soft);
}

.stat-number {
    font-size: 3rem;
    font-weight: 900;
    color: var(--pop-coral);
    margin-bottom: 10px;
}

.stat-label {
    font-size: 1rem;
    color: var(--text-dark);
    font-weight: 700;
    line-height: 1.4;
}

/* ========================================
   6. FINAL CTA SECTION
   ======================================== */

.final-cta-section.game-cta {
    padding: 80px 0;
    background: linear-gradient(135deg, rgba(139, 127, 232, 0.12), rgba(255, 180, 214, 0.12));
    text-align: center;
}

.final-cta-content {
    max-width: 700px;
    margin: 0 auto;
}

.live-activity {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: rgba(255, 107, 83, 0.15);
    border: 2px solid var(--pop-coral);
    padding: 10px 25px;
    border-radius: 50px;
    margin-bottom: 25px;
}

.activity-pulse {
    width: 10px;
    height: 10px;
    background: var(--pop-coral);
    border-radius: 50%;
    animation: pulse-dot 1.5s ease-in-out infinite;
}

.activity-text {
    font-size: 1rem;
    font-weight: 700;
    color: var(--text-dark);
}

.final-headline {
    font-size: 3rem;
    font-weight: 900;
    color: var(--text-dark);
    margin-bottom: 15px;
    line-height: 1.2;
}

.final-subtext {
    font-size: 1.3rem;
    color: var(--text-grey);
    margin-bottom: 40px;
    font-weight: 700;
}

.btn-final-play.mega-button {
    padding: 25px 60px;
    font-size: 1.6rem;
    margin-bottom: 20px;
    box-shadow: 0 15px 40px rgba(255, 107, 83, 0.4);
}

.mega-icon {
    font-size: 2rem;
}

.mega-text {
    font-weight: 900;
    letter-spacing: 1px;
}

.final-reassurance {
    font-size: 1rem;
    color: var(--text-grey);
    margin-bottom: 25px;
    font-weight: 600;
}

.trust-pills {
    display: flex;
    justify-content: center;
    gap: 15px;
    flex-wrap: wrap;
}

.trust-pill {
    background: var(--card-base);
    padding: 10px 20px;
    border-radius: 25px;
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--text-dark);
    box-shadow: var(--shadow-soft);
}



/* Trust Badges - Prominent Design */
.trust-badges {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    max-width: 800px;
    margin: 0 auto 40px;
}

.trust-badge {
    background: var(--card-base);
    border: 1px solid rgba(255, 255, 255, 0.5);
    border-radius: 24px;
    padding: 20px 15px;
    display: flex;
    align-items: center;
    gap: 15px;
    box-shadow: var(--shadow-soft);
    transition: all 0.3s var(--ease-elastic);
}

.trust-badge:hover {
    transform: translateY(-5px);
    box-shadow: var(--shadow-float);
}

.trust-icon {
    font-size: 2rem;
    color: var(--pop-teal);
    flex-shrink: 0;
}

.trust-text {
    text-align: left;
    font-size: 0.95rem;
    line-height: 1.4;
    color: var(--text-dark);
    font-weight: 600;
}

.trust-text strong {
    display: block;
    color: var(--text-dark);
    font-size: 1.05rem;
    margin-bottom: 2px;
    font-weight: 800;
}

/* Quick Social Proof */
.quick-proof {
    background: var(--card-base);
    border: 1px solid rgba(255, 255, 255, 0.5);
    border-radius: 24px;
    padding: 20px 30px;
    max-width: 600px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    gap: 20px;
    box-shadow: var(--shadow-soft);
}

.proof-avatars {
    display: flex;
    gap: -10px;
}

.avatar {
    font-size: 2.5rem;
    display: inline-block;
    margin-left: -10px;
    background: var(--white);
    border-radius: 50%;
    border: 2px solid rgba(255, 255, 255, 0.5);
}

.avatar:first-child {
    margin-left: 0;
}

.proof-text {
    text-align: left;
    font-size: 1rem;
    color: var(--text-dark);
    line-height: 1.5;
    font-weight: 600;
}

.proof-text strong {
    color: var(--text-dark);
    font-weight: 800;
}


/* 2. OUTCOME-FOCUSED DISCOVER SECTION */
.discover-section {
    padding: 80px 0;
    background: transparent;
}

.section-title {
    font-size: 3.2rem;  /* Increased by 28% from 2.5rem */
    font-weight: 900;
    color: var(--text-dark);
    text-align: center;
    margin-bottom: 15px;
    letter-spacing: -0.03em;
}

.section-subtitle {
    font-size: 1.25rem;
    color: var(--text-grey);
    text-align: center;
    margin-bottom: 15px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
    font-weight: 600;
}

.section-emotional-anchor {
    font-size: 1.1rem;
    color: var(--text-grey);
    text-align: center;
    margin-bottom: 50px;
    font-style: italic;
    font-weight: 600;
}

.card-reassurance {
    font-size: 0.95rem;
    color: var(--text-grey);
    font-style: italic;
    margin-top: 8px;
    font-weight: 600;
}

.discover-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
}

@media (max-width: 1024px) {
    .discover-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

.outcome-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.88) 100%);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 28px;
    padding: 28px 24px 24px;
    text-align: center;
    border: 2px solid rgba(255, 255, 255, 0.6);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.1);
    position: relative;
    overflow: hidden;
}

.outcome-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(255, 107, 83, 0.1) 0%, rgba(159, 151, 243, 0.1) 100%);
    opacity: 0;
    transition: opacity 0.4s ease;
}

.outcome-card:hover::before {
    opacity: 1;
}

.outcome-card:hover {
    transform: translateY(-14px) scale(1.05);
    box-shadow: 0 20px 50px rgba(159, 151, 243, 0.3);
    border-color: rgba(159, 151, 243, 0.5);
}

.discover-icon {
    font-size: 3.5rem;
    margin-bottom: 16px;
    display: inline-block;
    animation: iconBounce 2.5s ease-in-out infinite;
    filter: drop-shadow(0 6px 12px rgba(0, 0, 0, 0.12));
    position: relative;
    z-index: 1;
}

@keyframes iconBounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.outcome-card:nth-child(1) .discover-icon { animation-delay: 0s; }
.outcome-card:nth-child(2) .discover-icon { animation-delay: 0.25s; }
.outcome-card:nth-child(3) .discover-icon { animation-delay: 0.5s; }
.outcome-card:nth-child(4) .discover-icon { animation-delay: 0.75s; }

.outcome-card h3 {
    font-size: 1.2rem;
    color: var(--text-dark);
    margin-bottom: 12px;
    font-weight: 900;
    line-height: 1.3;
    letter-spacing: -0.01em;
    position: relative;
    z-index: 1;
}

.outcome-card p {
    color: var(--text-dark);
    font-size: 1rem;
    line-height: 1.6;
    margin-bottom: 14px;
    font-weight: 600;
    position: relative;
    z-index: 1;
}

.outcome-card p strong {
    color: var(--text-dark);
    font-weight: 800;
}

/* Benefit Tags */
.card-benefit {
    margin-top: 12px;
}

.benefit-tag {
    display: inline-block;
    background: var(--gradient-pink-purple);
    color: #FFFFFF;
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 700;
    box-shadow: var(--shadow-glow-pink);
}

/* 3. PROGRESSIVE REVEAL - GAMIFIED JOURNEY */
.tests-section {
    padding: 80px 0;
    background: transparent;
}

.journey-step {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(255, 255, 255, 0.92) 100%);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border-radius: 36px;
    padding: 45px;
    margin-bottom: 35px;
    border: 2px solid rgba(255, 255, 255, 0.6);
    box-shadow: 0 14px 40px rgba(0, 0, 0, 0.1);
    position: relative;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    overflow: hidden;
}

.journey-step::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    opacity: 0.5;
    pointer-events: none;
}

.journey-step:hover {
    transform: translateY(-12px) scale(1.02);
    box-shadow: 0 20px 55px rgba(0, 0, 0, 0.15);
}

.step-primary::before {
    background: linear-gradient(135deg, rgba(115, 210, 222, 0.08) 0%, transparent 100%);
}

.step-secondary::before {
    background: linear-gradient(135deg, rgba(159, 151, 243, 0.08) 0%, transparent 100%);
}

.step-reward::before {
    background: linear-gradient(135deg, rgba(255, 216, 109, 0.12) 0%, transparent 100%);
}

.step-badge {
    position: absolute;
    top: -15px;
    left: 30px;
    background: var(--text-dark);
    color: var(--card-base);
    padding: 8px 24px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 800;
    letter-spacing: 1px;
    box-shadow: var(--shadow-soft);
}

.step-primary .step-badge {
    background: var(--pop-teal);
    color: var(--card-base);
}

.step-reward .step-badge {
    background: var(--pop-yellow);
    color: var(--text-dark);
}

.step-content {
    display: grid;
    grid-template-columns: 200px 1fr;
    gap: 40px;
    align-items: center;
}

.step-visual {
    text-align: center;
}

.big-icon {
    font-size: 6rem;
    margin-bottom: 15px;
    animation: float 3s ease-in-out infinite;
}

.unlock-indicator {
    background: #4CAF50;
    color: var(--pure-white);
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 700;
    display: inline-block;
}

.treasure-chest {
    position: relative;
}

.chest-icon {
    font-size: 6rem;
    animation: bounce 2s ease-in-out infinite;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-15px); }
}

.chest-badge {
    position: absolute;
    top: -10px;
    right: -10px;
    background: #FF5722;
    color: var(--pure-white);
    padding: 6px 14px;
    border-radius: 50%;
    font-size: 0.9rem;
    font-weight: 800;
    box-shadow: 0 4px 12px rgba(255, 87, 34, 0.4);
}

.results-preview {
    position: relative;
}

.result-icon {
    font-size: 6rem;
}

.result-sparkle {
    position: absolute;
    top: 0;
    right: 20px;
    font-size: 2rem;
    animation: sparkle 1.5s ease-in-out infinite;
}

@keyframes sparkle {
    0%, 100% { opacity: 0.3; transform: scale(1); }
    50% { opacity: 1; transform: scale(1.2); }
}

.step-info h3 {
    font-size: 2rem;
    color: var(--charcoal-teal);
    margin-bottom: 15px;
    font-weight: 800;
}

.step-description {
    font-size: 1.2rem;
    color: var(--soft-text);
    line-height: 1.7;
    margin-bottom: 20px;
}

.step-description strong {
    color: var(--ocean-blue);
    font-weight: 700;
}

.step-micro-reassurance {
    font-size: 0.95rem;
    color: var(--text-medium-gray);
    font-style: italic;
    margin-top: 10px;
    margin-bottom: 10px;
}

.step-benefit {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

.benefit-pill {
    background: linear-gradient(135deg, var(--cyber-yellow) 0%, #FFC700 100%);
    color: var(--dark-text);
    padding: 8px 18px;
    border-radius: 20px;
    font-size: 0.95rem;
    font-weight: 800;
    border: none;
    box-shadow: 0 3px 10px rgba(255, 214, 10, 0.3);
}

.benefit-pill.gold {
    background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);
    color: var(--dark-text);
    border: none;
    box-shadow: 0 3px 10px rgba(255, 165, 0, 0.4);
}

.mini-tests-preview {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
    margin-top: 15px;
}

.mini-test {
    background: var(--pure-white);
    border: 2px solid var(--sky-blue);
    color: var(--charcoal-teal);
    padding: 6px 14px;
    border-radius: 16px;
    font-size: 0.9rem;
    font-weight: 600;
}

/* Time Commitment - Reframed */
.time-commitment {
    text-align: center;
    margin-top: 50px;
    padding: 40px;
    background: rgba(255, 255, 255, 0.7);
    border-radius: 24px;
    border: 2px solid var(--sky-blue);
}

.time-box {
    display: inline-block;
    margin-bottom: 20px;
}

.time-number {
    font-size: 5rem;
    font-weight: 800;
    color: var(--ocean-blue);
    display: block;
    line-height: 1;
}

.time-label {
    font-size: 1.2rem;
    color: var(--soft-text);
    font-weight: 600;
}

.time-message {
    font-size: 1.3rem;
    color: var(--charcoal-teal);
    max-width: 600px;
    margin: 0 auto;
    line-height: 1.6;
    font-weight: 500;
}

/* 4. FEAR-ADDRESSING STORY SECTION */
.story-section {
    padding: 80px 0;
    background: transparent;
}

.story-header {
    text-align: center;
    margin-bottom: 50px;
}

.story-subtitle {
    font-size: 1.3rem;
    color: var(--text-grey);
    font-style: italic;
    margin-top: 10px;
    font-weight: 600;
}

.story-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
    margin-bottom: 50px;
}

.story-card {
    background: var(--card-base);
    border-radius: 32px;
    padding: 40px 35px;
    border: 1px solid rgba(255, 255, 255, 0.5);
    box-shadow: var(--shadow-soft);
    transition: all 0.3s var(--ease-elastic);
}

.mistake-card {
    background: linear-gradient(135deg, #ffffff 0%, rgba(255, 107, 83, 0.1) 100%);
}

.success-card {
    background: linear-gradient(135deg, #ffffff 0%, rgba(115, 210, 222, 0.1) 100%);
}

.story-card:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-float);
}

.story-emoji {
    font-size: 5rem;
    margin-bottom: 20px;
    text-align: center;
}

.story-card h3 {
    font-size: 1.6rem;
    color: var(--text-dark);
    margin-bottom: 15px;
    font-weight: 800;
    line-height: 1.3;
}

.story-card p {
    font-size: 1.15rem;
    color: var(--text-dark);
    line-height: 1.7;
    margin-bottom: 20px;
    font-weight: 500;
}

.story-outcome {
    padding: 15px 20px;
    border-radius: 16px;
    margin-top: 20px;
}

.story-outcome.bad {
    background: rgba(255, 107, 83, 0.15);
    border: 2px solid rgba(255, 107, 83, 0.3);
}

.story-outcome.good {
    background: rgba(115, 210, 222, 0.15);
    border: 2px solid rgba(115, 210, 222, 0.3);
}

.outcome-label {
    font-weight: 800;
    font-size: 0.95rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.outcome-text {
    display: block;
    margin-top: 8px;
    font-size: 1.05rem;
    font-weight: 600;
}

.story-outcome.bad .outcome-label,
.story-outcome.bad .outcome-text {
    color: var(--error-red-dark);
}

.story-outcome.good .outcome-label,
.story-outcome.good .outcome-text {
    color: var(--success-dark);
}

/* Urgency Box */
.urgency-box {
    background: var(--pop-cream);
    border: 1px solid rgba(255, 255, 255, 0.5);
    border-radius: 32px;
    padding: 50px 40px;
    text-align: center;
    margin: 50px 0;
    box-shadow: var(--shadow-soft);
}

.urgency-icon {
    font-size: 4rem;
    margin-bottom: 20px;
}

.urgency-box h3 {
    font-size: 2.2rem;
    color: var(--text-dark);
    margin-bottom: 20px;
    font-weight: 800;
}

.urgency-box p {
    font-size: 1.3rem;
    color: var(--text-dark);
    line-height: 1.7;
    max-width: 700px;
    margin: 0 auto 30px;
    font-weight: 500;
}

.urgency-box p strong {
    color: var(--text-dark);
    font-weight: 800;
}

.btn-urgency {
    padding: 14px 28px;
    font-size: 1rem;
    font-weight: 700;
}

/* Journey Preview */
.journey-preview {
    margin-top: 60px;
}

.journey-title {
    font-size: 2rem;
    color: var(--charcoal-teal);
    text-align: center;
    margin-bottom: 40px;
    font-weight: 800;
}

.journey-timeline {
    max-width: 800px;
    margin: 0 auto;
}

.timeline-item {
    display: grid;
    grid-template-columns: 60px 1fr;
    gap: 25px;
    margin-bottom: 30px;
    position: relative;
}

.timeline-item:not(:last-child)::after {
    content: '';
    position: absolute;
    left: 29px;
    top: 60px;
    width: 2px;
    height: calc(100% + 10px);
    background: linear-gradient(180deg, var(--ocean-blue) 0%, var(--sky-blue) 100%);
}

.timeline-dot {
    width: 60px;
    height: 60px;
    background: linear-gradient(135deg, var(--ocean-blue) 0%, var(--soft-teal-blue) 100%);
    color: var(--pure-white);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.8rem;
    font-weight: 800;
    box-shadow: 0 4px 16px rgba(43, 95, 126, 0.3);
    flex-shrink: 0;
}

.timeline-content {
    background: var(--pure-white);
    padding: 25px 30px;
    border-radius: 20px;
    border: 2px solid var(--sky-blue);
    box-shadow: 0 4px 16px rgba(168, 218, 220, 0.15);
}

.timeline-content h4 {
    font-size: 1.4rem;
    color: var(--charcoal-teal);
    margin-bottom: 10px;
    font-weight: 700;
}

.timeline-content p {
    font-size: 1.1rem;
    color: var(--soft-text);
    line-height: 1.6;
}

/* 5. TESTIMONIALS SECTION - SIMPLE & CLEAN */
.results-section {
    padding: 80px 0;
    background: transparent;
}

.testimonials-header {
    text-align: center;
    margin-bottom: 50px;
}

.testimonials-icon {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, #F4A261 0%, #E76F51 100%);
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
    margin: 0 auto 20px;
    box-shadow: 0 8px 24px rgba(244, 162, 97, 0.3);
}

.testimonials-label {
    font-size: 0.9rem;
    font-weight: 700;
    color: var(--ocean-blue);
    letter-spacing: 1.5px;
    text-transform: uppercase;
    margin-bottom: 15px;
}

.results-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
    margin-bottom: 30px;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
    justify-content: center;
}

/* Desktop: 3 cards centered */
@media (min-width: 1024px) {
    .results-grid {
        grid-template-columns: repeat(3, 1fr);
        max-width: 800px;
    }
}

@media (min-width: 769px) and (max-width: 1023px) {
    .results-grid {
        grid-template-columns: repeat(3, 1fr);
        max-width: 750px;
    }
}

/* Testimonial Card - Enhanced Design */
.testimonial-card {
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(255, 255, 255, 0.92) 100%);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 24px;
    padding: 24px 20px;
    border: 2px solid rgba(255, 255, 255, 0.6);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.1);
    position: relative;
    max-width: 290px;
    margin: 0 auto;
    overflow: hidden;
}

.testimonial-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(58, 124, 165, 0.08) 0%, rgba(159, 151, 243, 0.08) 100%);
    opacity: 0;
    transition: opacity 0.4s ease;
}

.testimonial-card:hover::before {
    opacity: 1;
}

.testimonial-card:hover {
    transform: translateY(-12px) scale(1.05);
    box-shadow: 0 18px 45px rgba(58, 124, 165, 0.25);
    border-color: rgba(58, 124, 165, 0.4);
}

.testimonial-avatar {
    position: relative;
    width: 45px;
    height: 45px;
    margin-bottom: 10px;
}

.testimonial-avatar img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    border: 2px solid var(--light-blue-bg);
}

.verified-badge {
    position: absolute;
    bottom: -2px;
    right: -2px;
    width: 20px;
    height: 20px;
    background: #4CAF50;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.65rem;
    font-weight: bold;
    border: 2px solid var(--pure-white);
}

.testimonial-header-info {
    margin-bottom: 12px;
}

.testimonial-name {
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--charcoal-teal);
    margin-bottom: 4px;
}

.testimonial-type {
    font-size: 0.7rem;
    font-weight: 600;
    color: var(--ocean-blue);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.testimonial-text {
    font-size: 0.85rem;
    color: var(--soft-text);
    line-height: 1.5;
    text-align: left;
    margin-bottom: 10px;
}

.testimonial-location {
    font-size: 0.75rem;
    color: var(--soft-text);
    font-style: italic;
}

/* 6. CREDIBLE SOCIAL PROOF WITH URGENCY */
.social-proof-section {
    padding: 80px 0;
    background: transparent;
}

.stats-bar {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    margin-bottom: 40px;
}

.stat-item {
    text-align: center;
    padding: 35px 25px;
    background: var(--pure-white);
    border-radius: 24px;
    border: 2px solid var(--sky-blue);
    box-shadow: 0 6px 20px rgba(168, 218, 220, 0.2);
    transition: all 0.3s ease;
}

.stat-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 32px rgba(168, 218, 220, 0.3);
}

.highlight-stat {
    border-color: #4CAF50;
    border-width: 3px;
    background: linear-gradient(135deg, #ffffff 0%, #f0fff4 100%);
}

.stat-icon {
    font-size: 3rem;
    margin-bottom: 15px;
}

.stat-number-large {
    font-size: 3.5rem;
    font-weight: 800;
    color: var(--ocean-blue);
    margin-bottom: 10px;
}

.stat-label {
    font-size: 1.1rem;
    color: var(--soft-text);
    font-weight: 600;
    line-height: 1.5;
    margin-bottom: 10px;
}

.stat-context {
    font-size: 0.9rem;
    color: var(--ocean-blue);
    font-weight: 500;
    margin-top: 10px;
}

.stat-link {
    color: var(--ocean-blue);
    text-decoration: none;
    font-weight: 700;
    transition: all 0.3s ease;
}

.stat-link:hover {
    color: var(--soft-teal-blue);
    text-decoration: underline;
}

/* Urgency Signal */
.urgency-signal {
    text-align: center;
    background: linear-gradient(135deg, #FFF3E0 0%, #FFE0B2 100%);
    border: 2px solid #FF9800;
    border-radius: 50px;
    padding: 15px 30px;
    margin: 40px auto;
    max-width: 500px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    box-shadow: 0 4px 16px rgba(255, 152, 0, 0.2);
}

.urgency-pulse {
    width: 12px;
    height: 12px;
    background: #FF5722;
    border-radius: 50%;
    animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(1.3); }
}

.urgency-text {
    font-size: 1.1rem;
    color: var(--charcoal-teal);
    font-weight: 600;
}

.urgency-text strong {
    color: #FF6F00;
    font-weight: 800;
}

/* Trust Section */
.trust-section {
    text-align: center;
    margin: 50px 0;
    padding: 40px 30px;
    background: var(--pure-white);
    border-radius: 24px;
    border: 2px solid var(--sky-blue);
}

.trust-title {
    font-size: 1.3rem;
    color: var(--soft-text);
    margin-bottom: 30px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.trust-logos {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 30px;
    align-items: center;
}

.trust-logo-item {
    text-align: center;
}

.logo-placeholder {
    font-size: 3rem;
    margin-bottom: 10px;
    opacity: 0.7;
}

.logo-text {
    display: block;
    font-size: 0.9rem;
    color: var(--soft-text);
    font-weight: 600;
}

/* Testimonials Section */
.testimonials-section {
    margin-top: 50px;
}

.credibility-anchor {
    font-size: 1rem;
    color: var(--text-medium-gray);
    text-align: center;
    margin-bottom: 20px;
    font-weight: 500;
}

.testimonials-title {
    font-size: 2rem;
    color: var(--charcoal-teal);
    text-align: center;
    margin-bottom: 40px;
    font-weight: 800;
}

.testimonials-scroll {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
}

.testimonial-item {
    background: var(--pure-white);
    border-radius: 24px;
    padding: 35px 30px;
    border: 2px solid var(--sky-blue);
    transition: all 0.3s ease;
    box-shadow: 0 6px 20px rgba(168, 218, 220, 0.2);
}

.testimonial-item:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 32px rgba(168, 218, 220, 0.3);
    border-color: var(--ocean-blue);
}

.testimonial-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.testimonial-badge {
    font-size: 3rem;
}

.testimonial-rating {
    font-size: 1rem;
    color: #FFB300;
}

.testimonial-item p {
    color: var(--soft-text);
    font-size: 1.1rem;
    line-height: 1.8;
    margin-bottom: 20px;
}

.testimonial-author {
    color: var(--ocean-blue);
    font-weight: 700;
    font-size: 1rem;
    margin-bottom: 8px;
}

.testimonial-verified {
    color: #4CAF50;
    font-size: 0.9rem;
    font-weight: 600;
}

/* BEFORE/AFTER TRANSFORMATIONS */
.transformation-section {
    margin-top: 60px;
    padding: 40px 24px;
    background: linear-gradient(135deg, #f0fff4 0%, #ffffff 100%);
    border-radius: 20px;
    border: 2px solid #4CAF50;
}

.transformation-title {
    font-size: 1.8rem;
    color: var(--charcoal-teal);
    text-align: center;
    margin-bottom: 8px;
    font-weight: 800;
}

.transformation-subtitle {
    font-size: 1rem;
    color: var(--soft-text);
    text-align: center;
    margin-bottom: 30px;
}

.transformations-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 20px;
}

.transformation-card {
    background: var(--pure-white);
    border-radius: 20px;
    padding: 24px 20px;
    display: grid;
    grid-template-columns: 1fr auto 1fr;
    gap: 16px;
    align-items: center;
    border: 2px solid var(--sky-blue);
    box-shadow: 0 4px 12px rgba(168, 218, 220, 0.15);
    transition: all 0.3s ease;
}

.transformation-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(168, 218, 220, 0.25);
}

.transformation-before,
.transformation-after {
    text-align: center;
}

.transform-label {
    font-size: 0.7rem;
    font-weight: 800;
    letter-spacing: 0.8px;
    padding: 5px 12px;
    border-radius: 16px;
    display: inline-block;
    margin-bottom: 10px;
}

.before-label {
    background: #ffcdd2;
    color: #c62828;
}

.after-label {
    background: #c8e6c9;
    color: #2e7d32;
}

.transform-emoji {
    font-size: 2.2rem;
    margin-bottom: 10px;
}

.transformation-before p,
.transformation-after p {
    font-size: 0.85rem;
    color: var(--soft-text);
    line-height: 1.5;
    margin-bottom: 10px;
}

.transform-student {
    font-size: 0.75rem;
    color: var(--ocean-blue);
    font-weight: 600;
}

.transform-result {
    font-size: 0.85rem;
    color: #2e7d32;
    font-weight: 700;
}

.transformation-arrow {
    font-size: 2rem;
    color: var(--ocean-blue);
    font-weight: 800;
    line-height: 1;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* INSTAGRAM SOCIAL PROOF */
.instagram-proof-section {
    margin-top: 60px;
    padding: 50px 30px;
    background: linear-gradient(135deg, #fafafa 0%, #ffffff 100%);
    border-radius: 24px;
    border: 2px solid #E1306C;
}

.instagram-title {
    font-size: 2.2rem;
    color: var(--charcoal-teal);
    text-align: center;
    margin-bottom: 15px;
    font-weight: 800;
}

.sharing-use-case {
    font-size: 1.1rem;
    color: var(--text-medium-gray);
    text-align: center;
    margin-bottom: 25px;
    font-style: italic;
}

.instagram-stat {
    text-align: center;
    background: linear-gradient(135deg, #833AB4 0%, #E1306C 100%);
    color: var(--pure-white);
    padding: 20px 30px;
    border-radius: 50px;
    display: inline-flex;
    align-items: center;
    gap: 15px;
    margin: 0 auto 40px;
    display: flex;
    justify-content: center;
    max-width: 600px;
    box-shadow: 0 6px 20px rgba(225, 48, 108, 0.3);
}

.instagram-icon {
    font-size: 2rem;
}

.instagram-text {
    font-size: 1.2rem;
    font-weight: 600;
}

.instagram-text strong {
    font-weight: 800;
}

.instagram-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
    margin-bottom: 40px;
}

.instagram-post {
    background: var(--pure-white);
    border-radius: 16px;
    border: 1px solid #dbdbdb;
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.instagram-post:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.insta-header {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 15px;
    border-bottom: 1px solid #efefef;
}

.insta-avatar {
    font-size: 2rem;
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: var(--light-blue-bg);
    border-radius: 50%;
}

.insta-username {
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--charcoal-teal);
}

.insta-image {
    background: linear-gradient(135deg, var(--light-blue-bg) 0%, var(--soft-cream) 100%);
    padding: 40px;
    text-align: center;
}

.result-screenshot {
    background: var(--pure-white);
    border-radius: 16px;
    padding: 30px;
    border: 2px solid var(--sky-blue);
    display: inline-block;
}

.screenshot-badge {
    font-size: 4rem;
    margin-bottom: 10px;
}

.screenshot-text {
    font-size: 1.3rem;
    font-weight: 800;
    color: var(--charcoal-teal);
}

.insta-caption {
    padding: 15px;
    font-size: 0.95rem;
    color: var(--charcoal-teal);
    line-height: 1.5;
}

.insta-likes {
    padding: 0 15px 15px;
    font-size: 0.9rem;
    color: var(--soft-text);
    font-weight: 600;
}

.instagram-cta {
    text-align: center;
    padding: 40px 20px 20px;
}

.instagram-cta p {
    font-size: 1.3rem;
    color: var(--charcoal-teal);
    margin-bottom: 20px;
    font-weight: 600;
}

.btn-instagram {
    padding: 14px 28px;
    font-size: 1rem;
    font-weight: 800;
}

/* 7. FINAL CTA - Enhanced Urgent Close */
.final-cta-section {
    padding: 100px 0;
    text-align: center;
    background: transparent;
    position: relative;
    overflow: hidden;
}

.final-cta-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background:
            radial-gradient(circle at 20% 50%, rgba(255, 107, 83, 0.15) 0%, transparent 60%),
            radial-gradient(circle at 80% 50%, rgba(159, 151, 243, 0.15) 0%, transparent 60%);
    pointer-events: none;
    animation: pulse-bg 8s ease-in-out infinite;
}

@keyframes pulse-bg {
    0%, 100% { opacity: 0.8; }
    50% { opacity: 1; }
}

.final-cta-content {
    position: relative;
    z-index: 1;
}

/* Urgency Badge at Top */
.final-urgency-badge {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: var(--gradient-pink-purple);
    color: #FFFFFF;
    padding: 12px 25px;
    border-radius: 50px;
    font-size: 0.95rem;
    font-weight: 700;
    margin-bottom: 30px;
    box-shadow: var(--shadow-glow-pink);
}

.urgency-pulse-dot {
    width: 10px;
    height: 10px;
    background: var(--card-base);
    border-radius: 50%;
    animation: pulse 2s ease-in-out infinite;
}

/* Direct Question Headline */
.final-headline {
    font-size: 4.2rem;  /* Increased by 30% from 3.2rem */
    color: var(--text-dark);
    margin-bottom: 20px;
    font-weight: 900;
    line-height: 1.1;
    letter-spacing: -0.03em;
}

/* Empathy Line */
.final-empathy {
    font-size: 1.3rem;
    color: var(--text-grey);
    margin-bottom: 20px;
    font-style: italic;
    font-weight: 600;
}

/* Value Proposition */
.final-subtext {
    font-size: 1.5rem;
    color: var(--text-dark);
    margin-bottom: 40px;
    font-weight: 500;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
}

.final-subtext strong {
    color: var(--text-dark);
    font-weight: 800;
}

/* Parent Reassurance */
.parent-reassurance {
    font-size: 1.1rem;
    color: var(--text-grey);
    margin-top: 15px;
    margin-bottom: 30px;
    font-weight: 600;
}

/* Primary CTA Button - Enhanced */
.btn-final-cta {
    padding: 18px 45px;
    font-size: 1.2rem;
    font-weight: 800;
    background: var(--gradient-purple-cyan);
    color: #FFFFFF;
    border: none;
    border-radius: 50px;
    box-shadow: var(--shadow-glow-purple), 0 0 0 1px rgba(255, 255, 255, 0.1) inset;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    display: inline-block;
    text-decoration: none;
    animation: gentlePulse 3s ease-in-out infinite;
    position: relative;
    overflow: hidden;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.btn-final-cta::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
    transition: left 0.6s ease;
}

.btn-final-cta:hover::before {
    left: 100%;
}

.btn-final-cta:hover {
    transform: translateY(-6px) scale(1.08);
    box-shadow: var(--shadow-glow-cyan), 0 0 0 1px rgba(255, 255, 255, 0.2) inset;
}

@keyframes gentlePulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.03); }
}

/* Trust Signals Below CTA */
.final-trust-signals {
    display: flex;
    justify-content: center;
    gap: 40px;
    margin-top: 35px;
    flex-wrap: wrap;
}

.trust-signal-item {
    display: flex;
    align-items: center;
    gap: 10px;
    color: var(--text-dark);
    font-size: 1.1rem;
    font-weight: 600;
}

.signal-icon {
    font-size: 1.5rem;
}

/* Risk Reversal */
.risk-reversal {
    margin-top: 40px;
    padding: 20px 30px;
    background: rgba(255, 152, 0, 0.12);
    border: 2px solid #FF9800;
    border-radius: 16px;
    display: inline-block;
}

.risk-reversal p {
    color: #2B2B2B;
    font-size: 1.1rem;
    margin: 0;
    font-weight: 500;
}

.risk-reversal strong {
    color: #E65100;
    font-weight: 700;
}

/* Final Objection Handler */
.final-objection {
    margin-top: 30px;
    padding: 25px 35px;
    background: linear-gradient(135deg, rgba(255, 152, 0, 0.2) 0%, rgba(255, 152, 0, 0.15) 100%);
    border-left: 4px solid #E65100;
    border-radius: 12px;
    max-width: 650px;
    margin-left: auto;
    margin-right: auto;
}

.objection-text {
    color: #2B2B2B;
    font-size: 1.15rem;
    margin: 0;
    font-style: italic;
    font-weight: 500;
}

.objection-text strong {
    color: #E65100;
    font-weight: 800;
    font-style: normal;
}

/* RESPONSIVE DESIGN */
@media (max-width: 768px) {
    /* Show sticky mobile CTA */
    .mobile-sticky-cta {
        display: block;
    }

    /* Add bottom padding to prevent content hiding behind sticky CTA */
    .landing-page {
        padding-bottom: 80px;
    }

    /* Adjust scroll-to-top button position on mobile to avoid sticky CTA */
    .scroll-to-top {
        bottom: 90px;
        right: 15px;
        width: 45px;
        height: 45px;
        font-size: 1.3rem;
    }

    /* THUMB-FRIENDLY CTA BUTTONS - 48px minimum for mobile */
    .btn {
        min-height: 48px;
        padding: 14px 28px;
        font-size: 1.05rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        width: 100%;
        max-width: 100%;
    }

    /* Nav CTA should NOT be full width */
    .nav-cta {
        width: auto;
        max-width: none;
        display: inline-flex;
    }

    .btn-primary,
    .btn-secondary {
        min-height: 48px;
    }

    .btn-hero-cta,
    .btn-final-cta {
        font-size: 0.95rem;
        padding: 12px 24px;
    }

    /* Reduce vertical spacing between sections */
    .hero-section {
        padding: 30px 0 50px;
    }

    .discover-section,
    .tests-section,
    .story-section,
    .results-section,
    .social-proof-section,
    .testimonials-section,
    .faq-section {
        padding: 50px 0;  /* Reduced from 80px */
    }

    .final-cta-section {
        padding: 50px 0;  /* Reduced from 100px */
    }

    .student-icon {
        font-size: 4rem;
    }

    .stream-option {
        font-size: 0.95rem;
        padding: 8px 14px;
    }

    .confusion-normalizer {
        font-size: 0.85rem;
        margin-bottom: 10px;
    }

    .hero-title {
        font-size: 2rem;
        line-height: 1.2;
        margin-bottom: 20px;
    }

    .hero-subtitle {
        font-size: 1.1rem;
        line-height: 1.5;
    }

    .time-benefit {
        padding: 10px 25px;
    }

    .time-text {
        font-size: 1rem;
    }

    .trust-badges {
        grid-template-columns: 1fr;
        gap: 15px;
    }

    .quick-proof {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }

    .proof-text {
        text-align: center;
    }

    .section-title {
        font-size: 1.6rem;
        line-height: 1.3;
        margin-bottom: 20px;
    }

    .section-subtitle {
        font-size: 1rem;
        line-height: 1.6;
    }

    /* HORIZONTAL SCROLL FOR CARDS - Reduce vertical scroll fatigue */
    .discover-grid,
    .results-grid,
    .testimonials-scroll {
        display: flex;
        overflow-x: auto;
        scroll-snap-type: x mandatory;
        gap: 16px;
        padding-bottom: 20px;
        padding-left: 16px;
        padding-right: 16px;
        margin-left: -16px;
        margin-right: -16px;
        -webkit-overflow-scrolling: touch;  /* Smooth scrolling on iOS */
    }

    .discover-grid::-webkit-scrollbar,
    .results-grid::-webkit-scrollbar,
    .testimonials-scroll::-webkit-scrollbar {
        height: 8px;
    }

    .discover-grid::-webkit-scrollbar-track,
    .results-grid::-webkit-scrollbar-track,
    .testimonials-scroll::-webkit-scrollbar-track {
        background: var(--light-blue-bg);
        border-radius: 10px;
    }

    .discover-grid::-webkit-scrollbar-thumb,
    .results-grid::-webkit-scrollbar-thumb,
    .testimonials-scroll::-webkit-scrollbar-thumb {
        background: var(--electric-blue);
        border-radius: 10px;
    }

    .discover-card,
    .testimonial-card {
        min-width: calc(100vw - 64px);
        max-width: calc(100vw - 64px);
        flex-shrink: 0;
        scroll-snap-align: center;
        padding: 20px 18px;
    }

    .discover-card h3,
    .testimonial-card h3 {
        font-size: 1.05rem;
        margin-bottom: 8px;
    }

    .discover-card p,
    .testimonial-card p {
        font-size: 0.85rem;
        line-height: 1.4;
        margin-bottom: 10px;
    }

    .discover-icon {
        font-size: 2.2rem;
        margin-bottom: 8px;
    }

    .benefit-tag {
        font-size: 0.75rem;
        padding: 5px 12px;
    }

    /* Testimonial specific mobile styles */
    .testimonial-avatar {
        width: 45px;
        height: 45px;
        margin-bottom: 10px;
    }

    .testimonial-avatar img {
        width: 45px;
        height: 45px;
    }

    .testimonial-name {
        font-size: 0.95rem;
    }

    .testimonial-type {
        font-size: 0.7rem;
    }

    .testimonial-text {
        font-size: 0.85rem;
        line-height: 1.4;
    }

    .testimonial-location {
        font-size: 0.75rem;
    }

    /* Show scroll hint on mobile */
    .scroll-hint {
        display: block;
    }

    /* Show scroll navigation on mobile */
    .scroll-navigation {
        display: flex;
    }

    /* Reduce background blob intensity on mobile for cleaner look */
    .blob {
        opacity: 0.25;  /* Reduced from 0.5 */
        filter: blur(100px);  /* Increased blur for softer effect */
    }

    .b-1 {
        width: 400px;
        height: 400px;
    }

    .b-2 {
        width: 500px;
        height: 500px;
    }

    .b-3 {
        width: 300px;
        height: 300px;
        opacity: 0.15;  /* Even more subtle for the middle blob */
    }

    /* Keep story grid and stats vertical */
    .story-grid,
    .stats-bar,
    .trust-logos {
        grid-template-columns: 1fr;
    }


    /* ========================================
       GAMIFIED SECTIONS - MOBILE RESPONSIVE
       ======================================== */

    /* Hero Game Portal - Mobile */
    .hero-title.game-title {
        font-size: 2rem;
        line-height: 1.2;
    }

    .hero-subtitle.game-subtitle {
        font-size: 1.1rem;
    }

    .character-selection {
        grid-template-columns: repeat(2, 1fr);
        gap: 12px;
    }

    .character-icon {
        font-size: 2.5rem;
    }

    .character-image {
        max-width: 80px;
    }

    .character-name {
        font-size: 0.9rem;
    }

    .character-trait {
        font-size: 0.75rem;
    }

    .btn-play-now {
        padding: 16px 35px;
        font-size: 1.1rem;
    }

    .live-counter {
        padding: 6px 16px;
        font-size: 0.85rem;
    }

    .quick-trust {
        font-size: 0.85rem;
        gap: 8px;
    }

    /* Mini-Game Demo - Mobile */
    .section-title {
        font-size: 1.8rem;
    }

    .section-subtitle {
        font-size: 1rem;
    }

    .demo-question-card {
        padding: 25px 20px;
    }

    .demo-question-text {
        font-size: 1.3rem;
    }

    .demo-options {
        grid-template-columns: 1fr;
        gap: 12px;
    }

    .demo-emoji {
        font-size: 2.5rem;
    }

    .demo-label {
        font-size: 0.9rem;
    }

    .demo-result-icon {
        font-size: 3rem;
    }

    .demo-result-image {
        width: 90px;
    }

    .demo-result-text {
        font-size: 1.1rem;
    }

    /* Benefits Grid - Mobile */
    .benefits-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }

    .benefit-icon {
        font-size: 2.5rem;
    }

    .benefit-text {
        font-size: 0.9rem;
    }

    /* Game Levels - Mobile */
    .game-level {
        flex-direction: column;
        padding: 20px;
        gap: 15px;
    }

    .level-number {
        width: 100%;
        flex-direction: row;
        justify-content: space-between;
    }

    .level-content {
        flex-direction: column;
        text-align: center;
    }

    .level-title {
        font-size: 1.1rem;
    }

    .level-desc {
        font-size: 0.85rem;
    }

    .time-reframe {
        padding: 20px;
    }

    .time-text {
        font-size: 1rem;
    }

    .time-highlight {
        font-size: 1.1rem;
    }

    /* Social Feed - Mobile */
    .social-feed {
        grid-template-columns: 1fr;
        gap: 15px;
    }

    .feed-card {
        padding: 18px;
    }

    .quick-stats {
        grid-template-columns: 1fr;
        gap: 15px;
    }

    .stat-number {
        font-size: 2.5rem;
    }

    .stat-label {
        font-size: 0.9rem;
    }

    /* Final CTA - Mobile */
    .final-headline {
        font-size: 2rem;
        line-height: 1.2;
    }

    .final-subtext {
        font-size: 1.1rem;
    }

    .btn-final-play.mega-button {
        padding: 18px 40px;
        font-size: 1.2rem;
    }

    .mega-icon {
        font-size: 1.5rem;
    }

    .trust-pills {
        gap: 10px;
    }

    .trust-pill {
        padding: 8px 16px;
        font-size: 0.85rem;
    }

    /* Social Proof - Mobile */
    .stat-item {
        padding: 25px 20px;
    }

    .stat-icon {
        font-size: 2.5rem;
    }

    .stat-number-large {
        font-size: 3rem;
    }

    .stat-label {
        font-size: 1rem;
    }

    .urgency-signal {
        flex-direction: column;
        gap: 10px;
        padding: 15px 20px;
    }

    .urgency-text {
        font-size: 1rem;
    }

    .trust-section {
        padding: 30px 20px;
    }

    .trust-logos {
        gap: 20px;
    }

    .testimonials-title {
        font-size: 1.7rem;
    }

    .testimonial-item {
        padding: 25px 20px;
    }

    .testimonial-badge {
        font-size: 2.5rem;
    }

    .testimonial-item p {
        font-size: 1.05rem;
    }

    /* Transformations - Mobile */
    .transformation-section {
        padding: 24px 16px;
        margin-top: 40px;
    }

    .transformation-title {
        font-size: 1.4rem;
        margin-bottom: 6px;
    }

    .transformation-subtitle {
        font-size: 0.9rem;
        margin-bottom: 20px;
    }

    .transformations-grid {
        grid-template-columns: 1fr;
        gap: 16px;
    }

    .transformation-card {
        grid-template-columns: 1fr;
        gap: 12px;
        padding: 18px 16px;
    }

    .transformation-arrow {
        transform: rotate(90deg);
        font-size: 1.5rem;
        margin: 8px 0;
        padding: 0;
        line-height: 1;
    }

    .transformation-before,
    .transformation-after {
        padding: 0;
    }

    .transform-emoji {
        font-size: 1.8rem;
        margin-bottom: 8px;
    }

    .transform-label {
        font-size: 0.65rem;
        padding: 4px 10px;
        margin-bottom: 8px;
    }

    .transformation-before p,
    .transformation-after p {
        font-size: 0.8rem;
        line-height: 1.4;
        margin-bottom: 8px;
    }

    .transform-student {
        font-size: 0.7rem;
    }

    .transform-result {
        font-size: 0.75rem;
    }

    /* Instagram Proof - Mobile */
    .instagram-proof-section {
        padding: 35px 20px;
    }

    .instagram-title {
        font-size: 1.8rem;
    }

    .instagram-stat {
        flex-direction: column;
        gap: 10px;
        padding: 18px 25px;
    }

    .instagram-text {
        font-size: 1.1rem;
    }

    .instagram-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }

    .instagram-cta p {
        font-size: 1.15rem;
    }

    .btn-instagram {
        padding: 12px 24px;
        font-size: 0.95rem;
    }

    /* FAQ - Mobile */
    .faq-question {
        font-size: 1.05rem;
        padding: 18px 20px 18px 30px;
    }

    .faq-answer p {
        font-size: 1rem;
        padding: 0 20px 18px 30px;
    }

    .critical-faq::before {
        font-size: 1.2rem;
        top: 18px;
    }

    /* Final CTA - Mobile */
    .final-cta-section {
        padding: 60px 0;
    }

    .final-urgency-badge {
        font-size: 0.9rem;
        padding: 10px 20px;
    }

    .final-headline {
        font-size: 2.2rem;
    }

    .final-subtext {
        font-size: 1.25rem;
        padding: 0 20px;
    }

    .btn-final-cta {
        padding: 12px 24px;
        font-size: 0.95rem;
    }

    .final-trust-signals {
        flex-direction: column;
        gap: 20px;
    }

    .trust-signal-item {
        font-size: 1.05rem;
    }

    .risk-reversal {
        padding: 18px 25px;
        margin-left: 20px;
        margin-right: 20px;
    }

    .risk-reversal p {
        font-size: 1.05rem;
    }

    .final-objection {
        padding: 20px 25px;
        margin-left: 20px;
        margin-right: 20px;
    }

    .objection-text {
        font-size: 1.05rem;
    }

    /* Story Section - Mobile */
    .story-card {
        padding: 30px 25px;
    }

    .story-emoji {
        font-size: 4rem;
    }

    .story-card h3 {
        font-size: 1.4rem;
    }

    .urgency-box {
        padding: 35px 25px;
    }

    .urgency-box h3 {
        font-size: 1.8rem;
    }

    .urgency-box p {
        font-size: 1.15rem;
    }

    .journey-title {
        font-size: 1.7rem;
    }

    .timeline-item {
        grid-template-columns: 50px 1fr;
        gap: 20px;
    }

    .timeline-dot {
        width: 50px;
        height: 50px;
        font-size: 1.5rem;
    }

    .timeline-item:not(:last-child)::after {
        left: 24px;
    }

    .timeline-content {
        padding: 20px 20px;
    }

    .timeline-content h4 {
        font-size: 1.2rem;
    }

    .timeline-content p {
        font-size: 1rem;
    }

    /* Results Section - Mobile */
    .results-grid {
        grid-template-columns: 1fr;
        gap: 25px;
        padding: 0 20px;
    }

    /* Testimonials - Mobile */
    .testimonials-icon {
        width: 60px;
        height: 60px;
        font-size: 2rem;
    }

    .testimonial-card {
        padding: 25px 20px;
        max-width: 100%;
    }

    .testimonial-name {
        font-size: 1.1rem;
    }

    .testimonial-type {
        font-size: 0.8rem;
    }

    .testimonial-text {
        font-size: 1rem;
    }

    /* Journey Steps - Mobile */
    .journey-step {
        padding: 30px 20px;
    }

    .step-content {
        grid-template-columns: 1fr;
        gap: 25px;
    }

    .big-icon,
    .chest-icon,
    .result-icon {
        font-size: 4rem;
    }

    .step-info h3 {
        font-size: 1.6rem;
    }

    .step-description {
        font-size: 1.1rem;
    }

    .time-number {
        font-size: 4rem;
    }

    .time-message {
        font-size: 1.15rem;
    }

    .btn-hero-cta {
        padding: 18px 40px;
        font-size: 1.2rem;
    }

    .final-cta-content h2 {
        font-size: 2rem;
    }

    .btn-mega-cta {
        padding: 18px 40px;
        font-size: 1.2rem;
    }
}

@media (max-width: 480px) {
    .student-icon {
        font-size: 3.5rem;
    }

    .stream-options {
        gap: 10px;
    }

    .stream-option {
        font-size: 0.9rem;
        padding: 6px 14px;
    }

    .hero-title {
        font-size: 1.75rem;
        line-height: 1.25;
    }

    .hero-subtitle {
        font-size: 1rem;
        line-height: 1.5;
    }

    .btn-hero-cta {
        padding: 16px 35px;
        font-size: 1.1rem;
    }

    .trust-badge {
        padding: 16px 14px;
        gap: 12px;
    }

    .trust-icon {
        font-size: 1.8rem;
    }

    .trust-text {
        font-size: 0.85rem;
        line-height: 1.4;
    }

    .trust-text strong {
        font-size: 0.95rem;
    }

    .section-title {
        font-size: 1.4rem;
        line-height: 1.3;
    }

    /* Story Section - Small Mobile */
    .story-grid {
        gap: 20px;
    }

    .story-card {
        padding: 25px 20px;
    }

    .story-emoji {
        font-size: 3.5rem;
    }

    .story-card h3 {
        font-size: 1.25rem;
    }

    .story-card p {
        font-size: 1.05rem;
    }

    .urgency-box {
        padding: 30px 20px;
    }

    .urgency-icon {
        font-size: 3rem;
    }

    .urgency-box h3 {
        font-size: 1.6rem;
    }

    .urgency-box p {
        font-size: 1.05rem;
    }

    .btn-urgency {
        padding: 12px 24px;
        font-size: 0.95rem;
    }

    .journey-title {
        font-size: 1.5rem;
    }

    .timeline-item {
        grid-template-columns: 45px 1fr;
        gap: 15px;
    }

    .timeline-dot {
        width: 45px;
        height: 45px;
        font-size: 1.3rem;
    }

    .timeline-item:not(:last-child)::after {
        left: 22px;
    }

    .timeline-content {
        padding: 18px 18px;
    }

    .timeline-content h4 {
        font-size: 1.1rem;
    }

    .timeline-content p {
        font-size: 0.95rem;
    }

    /* Results Section - Small Mobile */
    .results-grid {
        gap: 20px;
    }

    .result-card {
        padding: 35px 20px 25px;
    }

    .surprise-badge {
        font-size: 0.7rem;
        padding: 6px 14px;
        right: 10px;
        top: -12px;
    }

    .verified-label {
        font-size: 0.65rem;
        padding: 5px 12px;
        left: 10px;
        top: -12px;
    }

    /* Testimonials - Small Mobile */
    .testimonials-icon {
        width: 50px;
        height: 50px;
        font-size: 1.8rem;
    }

    .testimonial-card {
        padding: 20px 18px;
        max-width: 100%;
    }

    .testimonial-avatar img {
        width: 50px;
        height: 50px;
    }

    .testimonial-avatar {
        width: 50px;
        height: 50px;
    }

    .verified-badge {
        width: 20px;
        height: 20px;
        font-size: 0.7rem;
    }

    .testimonial-name {
        font-size: 1rem;
    }

    .testimonial-type {
        font-size: 0.75rem;
    }

    .testimonial-text {
        font-size: 0.95rem;
    }

    /* Social Proof - Small Mobile */
    .stat-icon {
        font-size: 2rem;
    }

    .stat-number-large {
        font-size: 2.5rem;
    }

    .stat-label {
        font-size: 0.95rem;
    }

    .urgency-signal {
        padding: 12px 18px;
    }

    .urgency-text {
        font-size: 0.95rem;
    }

    .trust-section {
        padding: 25px 15px;
    }

    .trust-title {
        font-size: 1.1rem;
    }

    .logo-placeholder {
        font-size: 2.5rem;
    }

    .logo-text {
        font-size: 0.85rem;
    }

    .testimonials-title {
        font-size: 1.5rem;
    }

    .testimonial-item {
        padding: 20px 18px;
    }

    .testimonial-badge {
        font-size: 2rem;
    }

    .testimonial-rating {
        font-size: 0.9rem;
    }

    .testimonial-item p {
        font-size: 1rem;
    }

    .testimonial-author {
        font-size: 0.95rem;
    }

    .testimonial-verified {
        font-size: 0.85rem;
    }

    /* Transformations - Small Mobile */
    .transformation-section {
        padding: 20px 12px;
        margin-top: 30px;
    }

    .transformation-title {
        font-size: 1.25rem;
    }

    .transformation-subtitle {
        font-size: 0.85rem;
    }

    .transformation-card {
        padding: 16px 12px;
    }

    .transform-emoji {
        font-size: 2rem;
    }

    .transformation-before p,
    .transformation-after p {
        font-size: 0.95rem;
    }

    /* Instagram Proof - Small Mobile */
    .instagram-proof-section {
        padding: 30px 15px;
    }

    .instagram-title {
        font-size: 1.6rem;
    }

    .instagram-stat {
        padding: 15px 20px;
    }

    .instagram-icon {
        font-size: 1.5rem;
    }

    .instagram-text {
        font-size: 1rem;
    }

    .insta-image {
        padding: 30px;
    }

    .result-screenshot {
        padding: 20px;
    }

    .screenshot-badge {
        font-size: 3rem;
    }

    .screenshot-text {
        font-size: 1.1rem;
    }

    .insta-caption {
        font-size: 0.9rem;
    }

    .instagram-cta p {
        font-size: 1.05rem;
    }

    .btn-instagram {
        padding: 10px 20px;
        font-size: 0.9rem;
    }

    /* FAQ - Small Mobile */
    .faq-question {
        font-size: 1rem;
        padding: 16px 18px 16px 28px;
    }

    .faq-icon {
        font-size: 1.3rem;
    }

    .faq-answer p {
        font-size: 0.95rem;
        padding: 0 18px 16px 28px;
    }

    .critical-faq::before {
        font-size: 1rem;
        top: 16px;
        left: -3px;
    }

    /* Final CTA - Small Mobile */
    .final-cta-section {
        padding: 50px 0;
    }

    .final-urgency-badge {
        font-size: 0.85rem;
        padding: 10px 18px;
        gap: 8px;
    }

    .urgency-pulse-dot {
        width: 8px;
        height: 8px;
    }

    .final-headline {
        font-size: 1.9rem;
        padding: 0 15px;
    }

    .final-subtext {
        font-size: 1.1rem;
        padding: 0 15px;
    }

    .btn-final-cta {
        padding: 10px 20px;
        font-size: 0.9rem;
    }

    .trust-signal-item {
        font-size: 1rem;
    }

    .signal-icon {
        font-size: 1.3rem;
    }

    .risk-reversal {
        padding: 16px 20px;
        margin-left: 15px;
        margin-right: 15px;
    }

    .risk-reversal p {
        font-size: 1rem;
    }

    .final-objection {
        padding: 18px 20px;
        margin-left: 15px;
        margin-right: 15px;
    }

    .objection-text {
        font-size: 1rem;
    }

    /* Journey Steps - Small Mobile */
    .journey-step {
        padding: 25px 15px;
    }

    .step-badge {
        left: 15px;
        font-size: 0.75rem;
        padding: 6px 16px;
    }

    .big-icon,
    .chest-icon,
    .result-icon {
        font-size: 3.5rem;
    }

    .step-info h3 {
        font-size: 1.4rem;
    }

    .step-description {
        font-size: 1rem;
    }

    .benefit-pill {
        font-size: 0.85rem;
        padding: 6px 14px;
    }

    .time-commitment {
        padding: 30px 20px;
    }

    .time-number {
        font-size: 3.5rem;
    }

    .time-message {
        font-size: 1.05rem;
    }
}
</style>

<script>
    // Scroll Navigation for Discover Section
    document.addEventListener('DOMContentLoaded', function() {
        const discoverGrid = document.querySelector('.discover-grid');
        const scrollDots = document.querySelectorAll('.scroll-dot');
        const leftArrow = document.querySelector('.scroll-arrow-left');
        const rightArrow = document.querySelector('.scroll-arrow-right');

        if (!discoverGrid || !scrollDots.length) return;

        const cards = discoverGrid.querySelectorAll('.discover-card');
        const cardWidth = cards[0]?.offsetWidth || 280;
        const gap = 20;

        // Update active dot based on scroll position
        function updateActiveDot() {
            const scrollLeft = discoverGrid.scrollLeft;
            const scrollWidth = discoverGrid.scrollWidth - discoverGrid.clientWidth;
            const scrollPercentage = scrollLeft / scrollWidth;
            const activeIndex = Math.round(scrollPercentage * (scrollDots.length - 1));

            scrollDots.forEach((dot, index) => {
                dot.classList.toggle('active', index === activeIndex);
            });
        }

        // Scroll to specific card
        function scrollToCard(index) {
            const scrollPosition = index * (cardWidth + gap);
            discoverGrid.scrollTo({
                left: scrollPosition,
                behavior: 'smooth'
            });
        }

        // Dot click handlers
        scrollDots.forEach((dot, index) => {
            dot.addEventListener('click', () => scrollToCard(index));
        });

        // Arrow click handlers
        leftArrow?.addEventListener('click', () => {
            const currentScroll = discoverGrid.scrollLeft;
            const newScroll = Math.max(0, currentScroll - (cardWidth + gap));
            discoverGrid.scrollTo({
                left: newScroll,
                behavior: 'smooth'
            });
        });

        rightArrow?.addEventListener('click', () => {
            const currentScroll = discoverGrid.scrollLeft;
            const maxScroll = discoverGrid.scrollWidth - discoverGrid.clientWidth;
            const newScroll = Math.min(maxScroll, currentScroll + (cardWidth + gap));
            discoverGrid.scrollTo({
                left: newScroll,
                behavior: 'smooth'
            });
        });

        // Update dots on scroll
        discoverGrid.addEventListener('scroll', updateActiveDot);

        // Initial update
        updateActiveDot();
    });

    // Scroll to Top Button functionality
    const scrollToTopBtn = document.getElementById('scrollToTop');

    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            scrollToTopBtn.classList.add('visible');
        } else {
            scrollToTopBtn.classList.remove('visible');
        }
    });

    scrollToTopBtn.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });

    // Demo Question Interaction
    const demoOptions = document.querySelectorAll('.demo-option');
    const demoResult = document.getElementById('demoResult');
    const demoResultIcon = document.getElementById('demoResultIcon');
    const demoResultText = document.getElementById('demoResultText');

    const resultData = {
        wolf: { image: '${assetPath(src: "wolf.png")}', text: 'Hmm... you might be a Strategic Wolf!' },
        tiger: { image: '${assetPath(src: "tiger.png")}', text: 'Hmm... you might be a Bold Tiger!' },
        owl: { image: '${assetPath(src: "owl.png")}', text: 'Hmm... you might be a Wise Owl!' },
        bee: { image: '${assetPath(src: "bee.png")}', text: 'Hmm... you might be a Disciplined Bee!' }
    };

    demoOptions.forEach(option => {
        option.addEventListener('click', function() {
            const result = this.dataset.result;
            const data = resultData[result];

            // Update result content with image
            demoResultIcon.innerHTML = '<img src="' + data.image + '" alt="' + result + '" class="demo-result-image" />';
            demoResultText.textContent = data.text;

            // Show result with animation
            demoResult.style.display = 'block';

            // Add confetti effect (simple version)
            createConfetti();
        });
    });

    function createConfetti() {
        const colors = ['#FF6B53', '#9F97F3', '#3A7CA5', '#FFD86D'];
        for (let i = 0; i < 30; i++) {
            const confetti = document.createElement('div');
            const randomColor = colors[Math.floor(Math.random() * colors.length)];
            const randomLeft = Math.random() * 100;
            confetti.style.cssText = 'position: fixed; width: 10px; height: 10px; background: ' + randomColor + '; left: ' + randomLeft + '%; top: -10px; opacity: 1; pointer-events: none; z-index: 9999; border-radius: 50%;';
            document.body.appendChild(confetti);

            const duration = Math.random() * 3 + 2;
            const xMovement = (Math.random() - 0.5) * 200;
            const randomRotation = Math.random() * 360;

            confetti.animate([
                { transform: 'translateY(0) translateX(0) rotate(0deg)', opacity: 1 },
                { transform: 'translateY(100vh) translateX(' + xMovement + 'px) rotate(' + randomRotation + 'deg)', opacity: 0 }
            ], {
                duration: duration * 1000,
                easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
            });

            setTimeout(function() { confetti.remove(); }, duration * 1000);
        }
    }
</script>
</body>
</html>


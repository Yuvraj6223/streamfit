<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>What's Your Learning Superpower? 🎮 | StreamFit</title>

    <!-- Critical resource hints for performance -->
    <link rel="preload" as="image" href="${assetPath(src: 'owl.png')}" fetchpriority="high">
    <link rel="preload" as="image" href="${assetPath(src: 'wolf.png')}" fetchpriority="high">
    <link rel="preload" as="image" href="${assetPath(src: 'tiger.png')}" fetchpriority="high">
    <link rel="preload" as="image" href="${assetPath(src: 'bee.png')}" fetchpriority="high">

    <!-- Preconnect to critical origins -->
    <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <!-- Critical inline CSS for instant rendering -->
    <style>
        /* Prevent layout shift during load */
        .hero-section { min-height: 100vh; }
        .character-selection { display: grid; gap: 20px; }
        .enhanced-background-wrapper { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; }

        /* Loading optimization */
        body { overflow-x: hidden; }

        /* Android-specific instant optimizations */
        @media (max-width: 768px) {
            * { -webkit-tap-highlight-color: transparent; }
            img { will-change: auto; }
        }

        /* Continue Game Modal */
        .continue-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .continue-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
        }

        .continue-modal-content {
            position: relative;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(255, 255, 255, 0.95) 100%);
            border-radius: 32px;
            padding: 48px 40px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border: 3px solid rgba(139, 127, 232, 0.3);
            text-align: center;
            animation: modalSlideIn 0.4s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-30px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .continue-modal-title {
            font-size: 2rem;
            font-weight: 900;
            color: #2D2A45;
            margin: 0 0 16px 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .continue-modal-text {
            font-size: 1.1rem;
            color: #7B7896;
            margin: 0 0 32px 0;
            font-weight: 600;
        }

        .continue-modal-game-info {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            background: rgba(139, 127, 232, 0.1);
            border-radius: 20px;
            padding: 16px 24px;
            margin: 0 0 32px 0;
        }

        .continue-game-emoji {
            font-size: 2.5rem;
        }

        .continue-game-name {
            font-size: 1.2rem;
            font-weight: 800;
            color: #2D2A45;
        }

        .continue-modal-buttons {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .btn-continue, .btn-new-game {
            padding: 18px 32px;
            border-radius: 20px;
            font-weight: 800;
            font-size: 1.1rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: all 0.3s ease;
            border: 3px solid;
        }

        .btn-continue {
            background: #5FE3D0;
            color: #2D2A45;
            border-color: rgba(255, 255, 255, 0.6);
            box-shadow: 0 6px 0 #3ABFA8, 0 8px 16px rgba(95, 227, 208, 0.4);
        }

        .btn-continue:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 0 #3ABFA8, 0 12px 24px rgba(95, 227, 208, 0.5);
        }

        .btn-new-game {
            background: rgba(139, 127, 232, 0.15);
            color: #2D2A45;
            border-color: rgba(139, 127, 232, 0.3);
            box-shadow: 0 4px 12px rgba(139, 127, 232, 0.2);
        }

        .btn-new-game:hover {
            background: rgba(139, 127, 232, 0.25);
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(139, 127, 232, 0.3);
        }

        .continue-modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(139, 127, 232, 0.1);
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            font-size: 1.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #7B7896;
        }

        .continue-modal-close:hover {
            background: rgba(139, 127, 232, 0.2);
            transform: rotate(90deg);
        }

        @media (max-width: 768px) {
            .continue-modal-content {
                padding: 36px 28px;
            }

            .continue-modal-title {
                font-size: 1.6rem;
            }

            .continue-modal-text {
                font-size: 1rem;
            }

            .btn-continue, .btn-new-game {
                padding: 16px 28px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Enhanced Background Wrapper - Game-like Visual Layers -->
<div class="enhanced-background-wrapper">
    <!-- Layer 1: Enhanced Gradient Mesh with Soft Blobs -->
    <div class="gradient-blobs">
        <div class="blob-shape blob-blue"></div>
        <div class="blob-shape blob-mint"></div>
        <div class="blob-shape blob-peach"></div>
        <div class="blob-shape blob-lavender"></div>
    </div>

    <!-- Layer 2: Floating Star/Sparkle Decorations -->
    <div class="star-decorations">
        <span class="star star-1">⭐</span>
        <span class="star star-2">✨</span>
        <span class="star star-3">💫</span>
        <span class="star star-4">⭐</span>
        <span class="star star-5">✨</span>
        <span class="star star-6">💫</span>
        <span class="star star-7">⭐</span>
        <span class="star star-8">✨</span>
    </div>

    <!-- Layer 3: Floating Educational Icons -->
    <div class="floating-icons">
        <span class="float-icon icon-1">🧠</span>
        <span class="float-icon icon-2">⚡</span>
        <span class="float-icon icon-3">🎯</span>
        <span class="float-icon icon-4">💡</span>
        <span class="float-icon icon-5">🧠</span>
        <span class="float-icon icon-6">⚡</span>
        <span class="float-icon icon-7">💡</span>
        <span class="float-icon icon-8">🏆</span>
        <span class="float-icon icon-9">📚</span>
        <span class="float-icon icon-10">🚀</span>
    </div>

    <!-- Layer 4: Character Illustrations in Corners -->
    <div class="character-corners">
        <div class="corner-character corner-owl">🦉</div>
        <div class="corner-character corner-wolf">🐺</div>
    </div>

    <!-- Layer 5: Tiny Particle Effects -->
    <div class="particle-system">
        <span class="particle p-1"></span>
        <span class="particle p-2"></span>
        <span class="particle p-3"></span>
        <span class="particle p-4"></span>
        <span class="particle p-5"></span>
        <span class="particle p-6"></span>
        <span class="particle p-7"></span>
        <span class="particle p-8"></span>
        <span class="particle p-9"></span>
        <span class="particle p-10"></span>
        <span class="particle p-11"></span>
        <span class="particle p-12"></span>
        <span class="particle p-13"></span>
        <span class="particle p-14"></span>
        <span class="particle p-15"></span>
        <span class="particle p-16"></span>
        <span class="particle p-17"></span>
        <span class="particle p-18"></span>
        <span class="particle p-19"></span>
        <span class="particle p-20"></span>
    </div>
</div>

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
                            <img src="${assetPath(src: 'owl.png')}" alt="Wise Owl" class="character-image" loading="eager" decoding="async"/>
                        </div>
                        <div class="character-name">Wise Owl</div>
                        <div class="character-trait">Deep Thinker</div>
                    </div>
                    <div class="character-card" data-character="wolf">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'wolf.png')}" alt="Strategic Wolf" class="character-image" loading="eager" decoding="async"/>
                        </div>
                        <div class="character-name">Strategic Wolf</div>
                        <div class="character-trait">Quick Decider</div>
                    </div>
                    <div class="character-card" data-character="tiger">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'tiger.png')}" alt="Bold Tiger" class="character-image" loading="eager" decoding="async"/>
                        </div>
                        <div class="character-name">Bold Tiger</div>
                        <div class="character-trait">Creative Sprinter</div>
                    </div>
                    <div class="character-card" data-character="bee">
                        <div class="character-icon bounce-hover">
                            <img src="${assetPath(src: 'bee.png')}" alt="Disciplined Bee" class="character-image" loading="eager" decoding="async"/>
                        </div>
                        <div class="character-name">Disciplined Bee</div>
                        <div class="character-trait">Steady Builder</div>
                    </div>
                </div>

                <!-- Giant Play Now Button -->
                <a href="#" id="playNowBtn"
                   class="btn-primary-unified pulse-animation"
                   data-track="hero_play_now">
                    <span class="btn-icon">🚀</span>
                    <span class="btn-text">Play Now (3 min)</span>
                </a>

                <!-- Quick Trust Signals -->
                <div class="quick-trust">
                    <span class="trust-item">✅ 100% free</span>
                    <span class="trust-divider">•</span>
                    <span class="trust-item">🔥 12,847+ played</span>
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

    <!-- 4. SNEAK PEEK - GAME LEVEL PREVIEW -->
    <section class="sneak-peek-section">
        <div class="mobile-container">
            <!-- Section Header -->
            <div class="sneak-peek-header">
                <h2 class="section-title">What's Inside? 🎮</h2>
                <p class="section-subtitle">Unlock your profile one game at a time</p>
            </div>

            <!-- Game Map - Vertical Progression -->
            <div class="game-map">

                <!-- LEVEL 1 - UNLOCKED (Visible & Friendly) -->
                <div class="game-map-level level-unlocked" data-level="1">
                    <div class="level-checkpoint">
                        <div class="checkpoint-circle unlocked-checkpoint">
                            <span class="checkpoint-icon">🦉</span>
                        </div>
                        <div class="checkpoint-badge unlocked-badge">UNLOCKED</div>
                    </div>

                    <div class="level-card unlocked-card">
                        <div class="level-card-header">
                            <div class="level-card-icon">🦉</div>
                            <div class="level-card-title-group">
                                <h3 class="level-card-title">Find Your Animal</h3>
                                <p class="level-card-subtitle">A few quick choices — no thinking required</p>
                            </div>
                        </div>
                        <div class="level-card-footer">
                            <span class="level-card-time">⚡ Less than 3 min</span>
                            <span class="level-card-status">Ready to play!</span>
                        </div>
                    </div>
                </div>

                <!-- LEVEL 2 - LOCKED (Teased) -->
                <div class="game-map-level level-locked" data-level="2">
                    <div class="level-checkpoint">
                        <div class="checkpoint-circle locked-checkpoint">
                            <span class="checkpoint-icon">🧠</span>
                            <span class="checkpoint-lock">🔒</span>
                        </div>
                        <div class="checkpoint-badge locked-badge">UNLOCK NEXT</div>
                    </div>

                    <div class="level-card locked-card">
                        <div class="level-card-header">
                            <div class="level-card-icon blurred-icon">🧠</div>
                            <div class="level-card-title-group">
                                <h3 class="level-card-title">Brain Superpowers</h3>
                                <p class="level-card-subtitle">Tiny games that reveal what you're naturally good at</p>
                            </div>
                        </div>
                        <div class="level-card-footer">
                            <span class="level-card-hint">🎯 Unlock after Level 1</span>
                        </div>
                    </div>
                </div>

                <!-- LEVEL 3 - LOCKED (Teased) -->
                <div class="game-map-level level-locked" data-level="3">
                    <div class="level-checkpoint">
                        <div class="checkpoint-circle locked-checkpoint">
                            <span class="checkpoint-icon">⚡</span>
                            <span class="checkpoint-lock">🔒</span>
                        </div>
                        <div class="checkpoint-badge locked-badge">LOCKED</div>
                    </div>

                    <div class="level-card locked-card">
                        <div class="level-card-header">
                            <div class="level-card-icon blurred-icon">⚡</div>
                            <div class="level-card-title-group">
                                <h3 class="level-card-title">Focus & Pressure</h3>
                                <p class="level-card-subtitle">See how your brain reacts when it gets hard</p>
                            </div>
                        </div>
                        <div class="level-card-footer">
                            <span class="level-card-hint">🔥 More games unlock as you play</span>
                        </div>
                    </div>
                </div>

                <!-- BOSS LEVEL - HIDDEN (Mystery) -->
                <div class="game-map-level level-boss" data-level="boss">
                    <div class="level-checkpoint">
                        <div class="checkpoint-circle boss-checkpoint">
                            <span class="checkpoint-icon">🏆</span>
                            <span class="checkpoint-lock">🔒</span>
                        </div>
                        <div class="checkpoint-badge boss-badge">BOSS LEVEL</div>
                    </div>

                    <div class="level-card boss-card">
                        <div class="level-card-header">
                            <div class="level-card-icon mystery-icon">🏆</div>
                            <div class="level-card-title-group">
                                <h3 class="level-card-title">Final Reveal</h3>
                                <p class="level-card-subtitle">Your complete learning profile</p>
                            </div>
                        </div>
                        <div class="level-card-footer">
                            <span class="level-card-mystery">✨ Mystery reward awaits...</span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Single CTA -->
            <div class="sneak-peek-cta">
                <a href="#" class="btn-primary-unified pulse-animation play-now-trigger"
                   data-track="sneak_peek_play_now">
                    <span class="btn-icon">🚀</span>
                    <span class="btn-text">Play the First Game</span>
                </a>
                <p class="cta-subtext">Takes less than 3 minutes</p>
            </div>

            <!-- Reassurance Message -->
            <div class="sneak-peek-reassurance">
                <p class="reassurance-text">
                    💡 You don't need to do everything — just start with the first one!
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
                            <img src="${assetPath(src: 'wolf.png')}" alt="Wolf" class="feed-avatar-image" loading="lazy" decoding="async"/>
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
                            <img src="${assetPath(src: 'tiger.png')}" alt="Tiger" class="feed-avatar-image" loading="lazy" decoding="async"/>
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
                            <img src="${assetPath(src: 'owl.png')}" alt="Owl" class="feed-avatar-image" loading="lazy" decoding="async"/>
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



    <!-- Mobile Sticky CTA Bar -->
    <div class="mobile-sticky-cta" id="mobileCTA" style="display: none;">
        <a href="#" class="btn-primary-unified play-now-trigger"
           data-track="mobile_sticky_cta">
            <span class="btn-icon">🚀</span>
            <span class="btn-text">Play Now (3 min)</span>
        </a>
    </div>

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
                <a href="#" class="btn-primary-unified btn-final-play mega-button pulse-animation play-now-trigger"
                   data-track="final_play_now">
                    <span class="mega-icon">🚀</span>
                    <span class="mega-text">Play Now (3 min)</span>
                </a>

                <!-- Quick Reassurance -->
                <p class="final-reassurance">
                    Start playing in 10 seconds ⚡ • No studying needed - just be yourself
                </p>

                <!-- Trust Pills -->
                <div class="trust-pills">
                    <span class="trust-pill">✅ Free forever</span>
                    <span class="trust-pill">🔥 12,847+ played</span>
                </div>
            </div>
        </div>
    </section>

</div>

<!-- Continue Game Modal -->
<div id="continueGameModal" class="continue-modal" style="display: none;">
    <div class="continue-modal-overlay"></div>
    <div class="continue-modal-content">
        <h2 class="continue-modal-title">Welcome Back! 🎮</h2>
        <p class="continue-modal-text">You have an unfinished game. What would you like to do?</p>
        <div class="continue-modal-game-info">
            <span class="continue-game-emoji" id="continueGameEmoji">🦉</span>
            <span class="continue-game-name" id="continueGameName">Spirit Animal Game</span>
        </div>
        <div class="continue-modal-buttons">
            <a href="${createLink(controller: 'personality', action: 'start')}"
               class="btn-continue" id="continueGameBtn">
                <span>▶️</span> Continue Game
            </a>
            <a href="${createLink(controller: 'personality', action: 'start')}"
               class="btn-new-game" id="newGameBtn">
                <span>🎯</span> Start New Game
            </a>
        </div>
        <button class="continue-modal-close" id="closeModalBtn">✕</button>
    </div>
</div>

<!-- Scroll to Top Button -->
<button class="scroll-to-top" id="scrollToTop" title="Back to top">
    <span>↑</span>
</button>

<style>
/* Import Fonts with optimized loading */
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700;800;900&display=swap');

/* Ensure fonts load with fallback */
@font-face {
    font-family: 'Plus Jakarta Sans';
    font-display: swap;
}

@font-face {
    font-family: 'Space Grotesk';
    font-display: swap;
}

@font-face {
    font-family: 'Outfit';
    font-display: swap;
}

/* StreamFit Color Palette - Duolingo-Style Gamified Theme */
:root {
    /* BRAND PALETTE - DUOLINGO-INSPIRED VIBRANT THEME */
    --bg-gradient-top: #A8B5FF;      /* Sky blue at top */
    --bg-gradient-purple: #C5A8FF;   /* Light purple */
    --bg-gradient-lavender: #E8B5FF; /* Lavender purple */
    --bg-gradient-pink: #FFB8E8;     /* Pink purple */
    --bg-gradient-coral: #FFC4B8;    /* Coral pink */
    --bg-gradient-peach: #FFD8A8;    /* Soft peach/yellow */

    --text-dark: #2D2A45;  /* Deep purple-gray for text */
    --text-grey: #7B7896;  /* Medium purple-gray */
    --text-white: #FFFFFF;  /* White text */

    /* PRIMARY COLORS - Duolingo-Style Vibrant Palette */
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
    --pop-green: #58CC02;  /* Duolingo green */
    --pop-orange: #FF9600;  /* Duolingo orange */

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
    font-weight: 800;
    background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
    color: #2D2A45;
    border: 3px solid rgba(255, 255, 255, 0.6);
    box-shadow:
        0 6px 0 #3ABFA8,
        0 8px 16px rgba(95, 227, 208, 0.4),
        inset 0 1px 0 rgba(255, 255, 255, 0.4);
    border-radius: 25px;
    outline: none !important;
    -webkit-tap-highlight-color: transparent !important;
    text-transform: uppercase;
    letter-spacing: 0.02em;
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
    transform: translateY(3px) scale(0.98);  /* Tactile feedback */
    box-shadow:
        0 2px 0 #3ABFA8,
        0 4px 10px rgba(95, 227, 208, 0.3),
        inset 0 1px 0 rgba(255, 255, 255, 0.4);
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

/* --- AMBIENT BACKGROUND - DUOLINGO STYLE --- */
.scenery-layer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    overflow: hidden;
    background: linear-gradient(180deg,
        #A8B5FF 0%,           /* Sky blue at top */
        #C5A8FF 20%,          /* Light purple */
        #E8B5FF 40%,          /* Lavender purple */
        #FFB8E8 60%,          /* Pink purple */
        #FFC4B8 80%,          /* Coral pink */
        #FFD8A8 100%          /* Soft peach/yellow at bottom */
    );
}

.blob {
    position: absolute;
    filter: blur(120px);
    opacity: 0.15;
    animation: float-blob 30s infinite ease-in-out alternate;
    pointer-events: none;
    transform: translateZ(0);
    backface-visibility: hidden;
    will-change: transform;
}

.b-1 {
    top: -20%;
    right: -15%;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(168, 181, 255, 0.4) 0%, transparent 70%);
    border-radius: 50%;
}

.b-2 {
    bottom: -20%;
    left: -15%;
    width: 700px;
    height: 700px;
    background: radial-gradient(circle, rgba(255, 196, 184, 0.4) 0%, transparent 70%);
    border-radius: 50%;
    animation-delay: -10s;
}

.b-3 {
    top: 35%;
    left: 50%;
    width: 500px;
    height: 500px;
    background: radial-gradient(circle, rgba(232, 181, 255, 0.3) 0%, transparent 70%);
    opacity: 0.12;
    border-radius: 50%;
    animation-duration: 25s;
    animation-delay: -5s;
}

@keyframes float-blob {
    0% {
        transform: translate(0, 0) scale(1) rotate(0deg);
    }
    33% {
        transform: translate(40px, -40px) scale(1.15) rotate(120deg);
    }
    66% {
        transform: translate(-30px, 30px) scale(0.9) rotate(240deg);
    }
    100% {
        transform: translate(0, 0) scale(1) rotate(360deg);
    }
}

/* ========================================
   ENHANCED BACKGROUND LAYERS - GAME-LIKE DEPTH
   ======================================== */

.enhanced-background-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    overflow: hidden;
    z-index: -100;
    /* Critical performance optimizations */
    will-change: transform;
    transform: translateZ(0);
    backface-visibility: hidden;
    contain: strict;
}

/* Layer 1: Enhanced Gradient Mesh with Soft Blobs */
.gradient-blobs {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -90;
}

.blob-shape {
    position: absolute;
    border-radius: 50%;
    filter: blur(70px);
    will-change: transform;
    transform: translateZ(0);
    backface-visibility: hidden;
    perspective: 1000px;
}

.blob-blue {
    top: 10%;
    right: 5%;
    width: 400px;
    height: 400px;
    background: radial-gradient(circle, rgba(224, 244, 255, 0.25) 0%, transparent 70%);
    animation: float-blob-slow 45s ease-in-out infinite;
}

.blob-mint {
    bottom: 15%;
    left: 8%;
    width: 450px;
    height: 450px;
    background: radial-gradient(circle, rgba(230, 255, 245, 0.2) 0%, transparent 70%);
    animation: float-blob-slow 50s ease-in-out infinite;
    animation-delay: -15s;
}

.blob-peach {
    top: 40%;
    right: 10%;
    width: 350px;
    height: 350px;
    background: radial-gradient(circle, rgba(255, 230, 213, 0.22) 0%, transparent 70%);
    animation: float-blob-slow 40s ease-in-out infinite;
    animation-delay: -25s;
}

.blob-lavender {
    top: 60%;
    left: 15%;
    width: 380px;
    height: 380px;
    background: radial-gradient(circle, rgba(240, 230, 255, 0.18) 0%, transparent 70%);
    animation: float-blob-slow 55s ease-in-out infinite;
    animation-delay: -35s;
}

@keyframes float-blob-slow {
    0%, 100% {
        transform: translate3d(0, 0, 0) scale(1);
    }
    25% {
        transform: translate3d(30px, -30px, 0) scale(1.1);
    }
    50% {
        transform: translate3d(-20px, 40px, 0) scale(0.95);
    }
    75% {
        transform: translate3d(25px, 20px, 0) scale(1.05);
    }
}

/* Layer 2: Floating Star/Sparkle Decorations */
.star-decorations {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -75;
}

.star {
    position: absolute;
    font-size: 2rem;
    opacity: 0.25;
    filter: drop-shadow(0 2px 4px rgba(255, 225, 123, 0.3));
    will-change: transform;
    animation: float-star 7s ease-in-out infinite;
    transform: translateZ(0);
    backface-visibility: hidden;
}

.star-1 { top: 8%; left: 12%; animation-delay: 0s; }
.star-2 { top: 15%; right: 18%; font-size: 1.8rem; animation-delay: 0.5s; }
.star-3 { top: 25%; left: 8%; font-size: 2.2rem; animation-delay: 1s; }
.star-4 { top: 45%; right: 10%; animation-delay: 1.5s; }
.star-5 { top: 60%; left: 15%; font-size: 1.9rem; animation-delay: 2s; }
.star-6 { top: 75%; right: 12%; animation-delay: 2.5s; }
.star-7 { bottom: 10%; left: 20%; font-size: 2.1rem; animation-delay: 3s; }
.star-8 { bottom: 20%; right: 8%; animation-delay: 3.5s; }

@keyframes float-star {
    0%, 100% {
        transform: translate3d(0, 0, 0) rotate(0deg);
        opacity: 0.25;
    }
    50% {
        transform: translate3d(0, -20px, 0) rotate(180deg);
        opacity: 0.35;
    }
}

/* Layer 3: Floating Educational Icons */
.floating-icons {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -80;
}

.float-icon {
    position: absolute;
    font-size: 2.5rem;
    opacity: 0.2;
    filter: drop-shadow(0 2px 6px rgba(139, 127, 232, 0.2));
    will-change: transform;
    animation: float-icon-vertical 6s ease-in-out infinite;
    transform: translateZ(0);
    backface-visibility: hidden;
}

.icon-1 { top: 12%; left: 5%; font-size: 3rem; animation-delay: 0s; }
.icon-2 { top: 18%; right: 8%; font-size: 2.8rem; animation-delay: 0.7s; }
.icon-3 { top: 30%; left: 10%; animation-delay: 1.4s; }
.icon-4 { top: 38%; right: 6%; font-size: 2.6rem; animation-delay: 2.1s; }
.icon-5 { top: 52%; left: 7%; font-size: 2.9rem; animation-delay: 2.8s; }
.icon-6 { top: 65%; right: 12%; animation-delay: 3.5s; }
.icon-7 { top: 72%; left: 14%; font-size: 2.7rem; animation-delay: 4.2s; }
.icon-8 { bottom: 15%; right: 10%; animation-delay: 4.9s; }
.icon-9 { bottom: 25%; left: 8%; font-size: 2.4rem; animation-delay: 5.6s; }
.icon-10 { bottom: 8%; right: 15%; font-size: 2.8rem; animation-delay: 0.3s; }

@keyframes float-icon-vertical {
    0%, 100% {
        transform: translate3d(0, 0, 0);
        opacity: 0.2;
    }
    50% {
        transform: translate3d(0, -25px, 0);
        opacity: 0.28;
    }
}

/* Layer 4: Character Illustrations in Corners */
.character-corners {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -85;
}

.corner-character {
    position: fixed;
    font-size: 7rem;
    opacity: 0.4;
    filter: drop-shadow(0 4px 12px rgba(139, 127, 232, 0.3));
    will-change: transform;
}

.corner-owl {
    top: 5%;
    left: -2%;
    animation: peek-idle-left 4s ease-in-out infinite;
}

.corner-wolf {
    bottom: 8%;
    right: -2%;
    animation: peek-idle-right 5s ease-in-out infinite;
}

@keyframes peek-idle-left {
    0%, 100% {
        transform: translate3d(0, 0, 0) rotate(-5deg);
    }
    50% {
        transform: translate3d(5px, -8px, 0) rotate(-3deg);
    }
}

@keyframes peek-idle-right {
    0%, 100% {
        transform: translate3d(0, 0, 0) rotate(5deg);
    }
    50% {
        transform: translate3d(-5px, -8px, 0) rotate(3deg);
    }
}

/* Layer 5: Tiny Particle Effects */
.particle-system {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -70;
}

.particle {
    position: absolute;
    width: 3px;
    height: 3px;
    border-radius: 50%;
    opacity: 0;
    will-change: transform, opacity;
    animation: particle-rise 12s linear infinite;
}

.particle:nth-child(odd) {
    background: rgba(255, 255, 255, 0.8);
}

.particle:nth-child(even) {
    background: rgba(255, 217, 61, 0.7);
}

.particle:nth-child(3n) {
    background: rgba(168, 181, 255, 0.6);
}

/* Position particles randomly across bottom */
.p-1 { left: 5%; animation-delay: 0s; }
.p-2 { left: 12%; animation-delay: 1s; }
.p-3 { left: 18%; animation-delay: 2s; }
.p-4 { left: 25%; animation-delay: 3s; }
.p-5 { left: 32%; animation-delay: 4s; }
.p-6 { left: 38%; animation-delay: 5s; }
.p-7 { left: 45%; animation-delay: 6s; }
.p-8 { left: 52%; animation-delay: 7s; }
.p-9 { left: 58%; animation-delay: 8s; }
.p-10 { left: 65%; animation-delay: 9s; }
.p-11 { left: 72%; animation-delay: 10s; }
.p-12 { left: 78%; animation-delay: 11s; }
.p-13 { left: 85%; animation-delay: 0.5s; }
.p-14 { left: 92%; animation-delay: 1.5s; }
.p-15 { left: 8%; animation-delay: 2.5s; }
.p-16 { left: 15%; animation-delay: 3.5s; }
.p-17 { left: 48%; animation-delay: 4.5s; }
.p-18 { left: 55%; animation-delay: 5.5s; }
.p-19 { left: 68%; animation-delay: 6.5s; }
.p-20 { left: 95%; animation-delay: 7.5s; }

@keyframes particle-rise {
    0% {
        bottom: 0;
        opacity: 0;
        transform: translate3d(0, 0, 0);
    }
    10% {
        opacity: 0.5;
    }
    50% {
        opacity: 0.6;
        transform: translate3d(15px, -50vh, 0);
    }
    90% {
        opacity: 0.3;
    }
    100% {
        bottom: 100vh;
        opacity: 0;
        transform: translate3d(-20px, -100vh, 0);
    }
}

/* Mobile Optimization - Reduce decorative elements */
@media (max-width: 768px) {
    /* Significantly reduce blur for better performance on mobile */
    .blob-shape {
        filter: blur(30px);
    }

    .blob-blue,
    .blob-mint,
    .blob-peach,
    .blob-lavender {
        width: 200px;
        height: 200px;
    }

    .star {
        font-size: 1.2rem;
        opacity: 0.15;
    }

    .float-icon {
        font-size: 1.5rem;
        opacity: 0.12;
    }

    /* Hide more decorative elements on mobile */
    .icon-7,
    .icon-8,
    .icon-9,
    .icon-10 {
        display: none;
    }

    .corner-character {
        font-size: 4rem;
        opacity: 0.25;
    }

    /* Reduce particles significantly */
    .particle:nth-child(n+11) {
        display: none;
    }

    /* Simplify blob animations on mobile */
    .blob-shape {
        animation-duration: 60s !important;
    }
}

/* Android-specific optimizations */
@supports (-webkit-appearance: none) {
    @media (max-width: 768px) {
        /* Disable expensive animations on Android */
        .enhanced-background-wrapper {
            will-change: auto;
        }

        .blob-shape,
        .star,
        .float-icon,
        .particle {
            will-change: auto;
            transform: translateZ(0);
            backface-visibility: hidden;
        }

        /* Reduce animation complexity */
        .blob-shape {
            animation-timing-function: linear !important;
        }

        /* Hide particles entirely on Android for better performance */
        .particle-system {
            display: none;
        }

        /* Simplify star animations */
        .star {
            animation-duration: 10s !important;
        }

        /* Reduce floating icon animations */
        .float-icon {
            animation-duration: 8s !important;
        }
    }
}

/* Reduced Motion Support */
@media (prefers-reduced-motion: reduce) {
    .enhanced-background-wrapper * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
    }

    .blob-shape,
    .star,
    .float-icon,
    .corner-character,
    .particle {
        animation: none !important;
        opacity: 0.15 !important;
    }
}

/* Performance optimization for low-end devices */
@media (max-width: 768px) and (max-height: 812px) {
    /* Likely a mobile device - optimize aggressively */
    .enhanced-background-wrapper {
        opacity: 0.7;
    }

    /* Hide half of the decorative elements */
    .star:nth-child(even),
    .float-icon:nth-child(even) {
        display: none;
    }

    /* Reduce blob count */
    .blob-peach,
    .blob-lavender {
        display: none;
    }

    /* Simplify remaining animations */
    @keyframes float-blob-slow {
        0%, 100% {
            transform: translate3d(0, 0, 0) scale(1);
        }
        50% {
            transform: translate3d(15px, -15px, 0) scale(1.05);
        }
    }

    @keyframes float-star {
        0%, 100% {
            transform: translate3d(0, 0, 0);
            opacity: 0.15;
        }
        50% {
            transform: translate3d(0, -10px, 0);
            opacity: 0.2;
        }
    }

    @keyframes float-icon-vertical {
        0%, 100% {
            transform: translate3d(0, 0, 0);
            opacity: 0.12;
        }
        50% {
            transform: translate3d(0, -12px, 0);
            opacity: 0.18;
        }
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
    overflow: hidden;
}

/* Duolingo-Style Floating Decorations */
.particle-container::before {
    content: '⭐';
    position: absolute;
    top: 12%;
    left: 8%;
    font-size: 2.5rem;
    animation: float-particle-1 10s ease-in-out infinite;
    opacity: 0.7;
    filter: drop-shadow(0 4px 8px rgba(255, 225, 123, 0.4));
}

.particle-container::after {
    content: '✨';
    position: absolute;
    top: 20%;
    right: 12%;
    font-size: 2rem;
    animation: float-particle-2 8s ease-in-out infinite;
    opacity: 0.6;
    filter: drop-shadow(0 4px 8px rgba(168, 181, 255, 0.4));
}

/* Additional floating elements using pseudo-elements on hero section */
.hero-section.game-portal::before {
    content: '🌟';
    position: absolute;
    bottom: 15%;
    left: 5%;
    font-size: 2.2rem;
    animation: float-particle-3 12s ease-in-out infinite;
    opacity: 0.5;
    z-index: 0;
}

.hero-section.game-portal::after {
    content: '💫';
    position: absolute;
    bottom: 25%;
    right: 8%;
    font-size: 2rem;
    animation: float-particle-4 9s ease-in-out infinite;
    opacity: 0.6;
    z-index: 0;
}

@keyframes float-particle-1 {
    0%, 100% {
        transform: translateY(0) rotate(0deg) scale(1);
        opacity: 0.7;
    }
    50% {
        transform: translateY(-35px) rotate(180deg) scale(1.1);
        opacity: 0.9;
    }
}

@keyframes float-particle-2 {
    0%, 100% {
        transform: translateY(0) rotate(0deg) scale(1);
        opacity: 0.6;
    }
    50% {
        transform: translateY(-25px) rotate(-180deg) scale(1.15);
        opacity: 0.85;
    }
}

@keyframes float-particle-3 {
    0%, 100% {
        transform: translate(0, 0) rotate(0deg);
        opacity: 0.5;
    }
    33% {
        transform: translate(20px, -30px) rotate(120deg);
        opacity: 0.7;
    }
    66% {
        transform: translate(-15px, -15px) rotate(240deg);
        opacity: 0.6;
    }
}

@keyframes float-particle-4 {
    0%, 100% {
        transform: translate(0, 0) rotate(0deg) scale(1);
        opacity: 0.6;
    }
    50% {
        transform: translate(-25px, -40px) rotate(360deg) scale(1.2);
        opacity: 0.8;
    }
}

/* Duolingo-Style Top Navigation Tabs */
.game-nav-tabs {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 40px;
    padding: 25px 20px 15px;
    background: transparent;
    position: relative;
    z-index: 10;
}

.game-nav-tab {
    font-size: 1rem;
    font-weight: 700;
    color: var(--text-grey);
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: all 0.3s ease;
    padding: 8px 16px;
    border-radius: 12px;
    position: relative;
}

.game-nav-tab:hover {
    color: var(--pop-purple);
    background: rgba(139, 127, 232, 0.1);
}

.game-nav-tab.active {
    color: var(--pop-purple);
}

.game-nav-tab.active::after {
    content: '';
    position: absolute;
    bottom: -8px;
    left: 50%;
    transform: translateX(-50%);
    width: 60%;
    height: 3px;
    background: var(--pop-purple);
    border-radius: 2px;
}

/* 1. HERO GAME PORTAL */
.hero-section.game-portal {
    padding: 40px 0 80px;
    text-align: center;
    position: relative;
    overflow: visible;
    /* Performance optimizations */
    contain: layout style;
    content-visibility: auto;
}

.hero-content {
    max-width: 900px;
    margin: 0 auto;
    position: relative;
}

/* Live Counter - Duolingo Style */
.live-counter {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 3px solid rgba(139, 127, 232, 0.4);
    padding: 12px 28px;
    border-radius: 50px;
    margin-bottom: 30px;
    animation: pulse-glow 2s ease-in-out infinite;
    box-shadow:
        0 4px 12px rgba(139, 127, 232, 0.2),
        0 2px 6px rgba(0, 0, 0, 0.1);
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

/* Game Title - Duolingo Style */
.hero-title.game-title {
    font-size: 3.5rem;
    font-weight: 900;
    color: var(--text-dark);
    margin-bottom: 20px;
    line-height: 1.15;
    letter-spacing: -0.02em;
    text-shadow:
        0 3px 6px rgba(139, 127, 232, 0.15),
        0 1px 2px rgba(0, 0, 0, 0.1);
    position: relative;
}

.hero-subtitle.game-subtitle {
    font-size: 1.5rem;
    color: var(--text-grey);
    margin-bottom: 45px;
    font-weight: 700;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* Character Selection Cards */
.character-selection {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 45px;
    max-width: 850px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    padding: 20px 0;
}

/* Floating decorative elements around characters */
.character-selection::before {
    content: '🌟';
    position: absolute;
    top: -10px;
    left: 5%;
    font-size: 1.8rem;
    animation: twinkle 3s ease-in-out infinite;
    pointer-events: none;
}

.character-selection::after {
    content: '💫';
    position: absolute;
    bottom: -10px;
    right: 5%;
    font-size: 1.8rem;
    animation: twinkle 3s ease-in-out infinite 1.5s;
    pointer-events: none;
}

@keyframes twinkle {
    0%, 100% {
        opacity: 0.4;
        transform: scale(1);
    }
    50% {
        opacity: 1;
        transform: scale(1.2);
    }
}

.character-card {
    background: transparent;
    border: none;
    padding: 0;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    position: relative;
    overflow: visible;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.character-card:hover {
    transform: translateY(-10px) scale(1.05);
}

.character-icon {
    position: relative;
    width: 100px;
    height: 100px;
    margin-bottom: 35px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* Badge Medal Circle */
.character-icon::before {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background: linear-gradient(135deg, #FFE17B 0%, #FFD86D 100%);
    border: 5px solid #FFA500;
    box-shadow:
        0 6px 0 #CC8400,
        0 8px 20px rgba(255, 165, 0, 0.4),
        inset 0 -3px 8px rgba(0, 0, 0, 0.15),
        inset 0 3px 8px rgba(255, 255, 255, 0.4);
    z-index: 1;
}

/* Left Ribbon */
.character-icon::after {
    content: '';
    position: absolute;
    bottom: -25px;
    left: 15px;
    width: 25px;
    height: 45px;
    background: linear-gradient(180deg, #8B7FE8 0%, #7B6FD8 100%);
    clip-path: polygon(0 0, 100% 0, 100% 85%, 50% 70%, 0 85%);
    transform: rotate(-15deg);
    z-index: 0;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.character-image {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    display: block;
    object-fit: cover;
    position: relative;
    z-index: 2;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
}

/* Right Ribbon - using a pseudo element on the card */
.character-card::before {
    content: '';
    position: absolute;
    top: 75px;
    left: 50%;
    margin-left: 20px;
    width: 25px;
    height: 45px;
    background: linear-gradient(180deg, #8B7FE8 0%, #7B6FD8 100%);
    clip-path: polygon(0 0, 100% 0, 100% 85%, 50% 70%, 0 85%);
    transform: rotate(15deg);
    z-index: 0;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.character-card:hover .character-image {
    transform: scale(1.1);
}

.bounce-hover {
    animation: float-gentle 3.5s ease-in-out infinite;
}

@keyframes float-gentle {
    0%, 100% {
        transform: translateY(0) rotate(0deg);
    }
    25% {
        transform: translateY(-8px) rotate(-2deg);
    }
    50% {
        transform: translateY(-12px) rotate(0deg);
    }
    75% {
        transform: translateY(-8px) rotate(2deg);
    }
}

.character-card:nth-child(1) .bounce-hover { animation-delay: 0s; }
.character-card:nth-child(2) .bounce-hover { animation-delay: 0.25s; }
.character-card:nth-child(3) .bounce-hover { animation-delay: 0.5s; }
.character-card:nth-child(4) .bounce-hover { animation-delay: 0.75s; }

.character-name {
    font-size: 1rem;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 4px;
    letter-spacing: -0.01em;
    position: relative;
    z-index: 1;
}

.character-trait {
    font-size: 0.85rem;
    color: var(--text-grey);
    font-weight: 600;
    position: relative;
    z-index: 1;
}

/* Giant Play Now Button - Colorful Gradient Style */
.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    /*padding: 22px 30px;*/
    border-radius: 25px;
    font-weight: 800;
    text-decoration: none;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 4px solid rgba(255, 255, 255, 0.5);
    cursor: pointer;
    font-size: 1.4rem;
    background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
    color: #2D2A45;
    box-shadow:
        0 8px 0 #3ABFA8,
        0 12px 24px rgba(95, 227, 208, 0.4),
        inset 0 2px 0 rgba(255, 255, 255, 0.4);
    position: relative;
    overflow: hidden;
    text-shadow: 0 1px 2px rgba(255, 255, 255, 0.5);
    letter-spacing: 0.02em;
    text-transform: uppercase;
}

.btn::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    transition: left 0.5s ease;
}

.btn:hover::before {
    left: 100%;
}

.btn:hover {
    transform: translateY(-4px) scale(1.02);
    box-shadow:
        0 10px 0 #3ABFA8,
        0 16px 32px rgba(95, 227, 208, 0.5),
        inset 0 2px 0 rgba(255, 255, 255, 0.5),
        0 0 30px rgba(95, 227, 208, 0.3);
    border-color: rgba(255, 255, 255, 0.7);
}

.btn:active {
    transform: translateY(4px) scale(0.98);
    box-shadow:
        0 2px 0 #3ABFA8,
        0 4px 12px rgba(95, 227, 208, 0.3),
        inset 0 2px 0 rgba(255, 255, 255, 0.4);
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
    background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
    color: #2D2A45;
    border: 4px solid rgba(255, 255, 255, 0.5);
    box-shadow:
        0 4px 0 #3ABFA8,
        0 12px 24px rgba(95, 227, 208, 0.4),
        inset 0 2px 0 rgba(255, 255, 255, 0.4);
}

.btn-primary:hover {
    transform: translateY(-4px) scale(1.02);
    box-shadow:
        0 10px 0 #3ABFA8,
        0 16px 32px rgba(95, 227, 208, 0.5),
        inset 0 2px 0 rgba(255, 255, 255, 0.5),
        0 0 30px rgba(95, 227, 208, 0.3);
    border-color: rgba(255, 255, 255, 0.7);
}

.btn-primary:active {
    transform: translateY(4px) scale(0.98);
    box-shadow:
        0 2px 0 #3ABFA8,
        0 4px 12px rgba(95, 227, 208, 0.3),
        inset 0 2px 0 rgba(255, 255, 255, 0.4);
}

/* Play Now Button Specific */
.btn-play-now {
    padding: 22px 60px;
    font-size: 1.5rem;
    margin-bottom: 25px;
    border-radius: 25px;
}

.pulse-animation {
    animation: pulse-glow-cyan 2s ease-in-out infinite;
}

@keyframes pulse-glow-cyan {
    0%, 100% {
        box-shadow:
            0 8px 0 #3ABFA8,
            0 12px 24px rgba(95, 227, 208, 0.4),
            inset 0 2px 0 rgba(255, 255, 255, 0.4);
    }
    50% {
        box-shadow:
            0 8px 0 #3ABFA8,
            0 12px 32px rgba(95, 227, 208, 0.6),
            0 0 40px rgba(95, 227, 208, 0.5),
            inset 0 2px 0 rgba(255, 255, 255, 0.5);
    }
}

.btn-icon {
    font-size: 1.6rem;
}

.btn-text {
    font-weight: 800;
    letter-spacing: 0.5px;
}

/* Duolingo-Style Progress Bar */
.progress-bar-container {
    width: 100%;
    max-width: 400px;
    margin: 30px auto 40px;
    position: relative;
}

.progress-bar-wrapper {
    position: relative;
    height: 32px;
    background: rgba(255, 255, 255, 0.6);
    border-radius: 50px;
    border: 3px solid rgba(139, 127, 232, 0.3);
    overflow: hidden;
    box-shadow:
        inset 0 2px 4px rgba(0, 0, 0, 0.1),
        0 2px 8px rgba(139, 127, 232, 0.15);
}

.progress-bar-fill {
    height: 100%;
    background: linear-gradient(90deg, #8B7FE8 0%, #A89FF3 100%);
    border-radius: 50px;
    transition: width 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
    position: relative;
    box-shadow: 0 0 10px rgba(139, 127, 232, 0.4);
}

.progress-bar-fill::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 50%;
    background: linear-gradient(180deg, rgba(255, 255, 255, 0.3) 0%, transparent 100%);
    border-radius: 50px 50px 0 0;
}

.progress-level-badge {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    background: linear-gradient(180deg, #FF9600 0%, #FF8500 100%);
    color: white;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 800;
    border: 3px solid white;
    box-shadow:
        0 3px 0 #CC7700,
        0 4px 8px rgba(255, 150, 0, 0.4);
    z-index: 2;
    letter-spacing: 0.5px;
}

/* Duolingo-Style Achievement Badges */
.achievement-badges {
    display: flex;
    justify-content: center;
    align-items: flex-end;
    gap: 20px;
    margin: 40px auto;
    max-width: 700px;
    flex-wrap: wrap;
}

.achievement-badge {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    transition: transform 0.3s ease;
}

.achievement-badge:hover {
    transform: translateY(-8px);
}

.badge-medal {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: linear-gradient(135deg, #FFD86D 0%, #FFE17B 100%);
    border: 5px solid #FFA500;
    box-shadow:
        0 6px 0 #CC8400,
        0 8px 16px rgba(255, 165, 0, 0.3);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
    position: relative;
    z-index: 2;
}

.badge-medal::before {
    content: '';
    position: absolute;
    top: -3px;
    left: -3px;
    right: -3px;
    bottom: -3px;
    border-radius: 50%;
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.4) 0%, transparent 50%);
    z-index: -1;
}

.badge-ribbon {
    position: absolute;
    top: 0;
    width: 30px;
    height: 50px;
    background: linear-gradient(180deg, #8B7FE8 0%, #7B6FD8 100%);
    clip-path: polygon(0 0, 100% 0, 100% 85%, 50% 70%, 0 85%);
    z-index: 1;
}

.badge-ribbon.left {
    left: 10px;
    transform: rotate(-15deg);
}

.badge-ribbon.right {
    right: 10px;
    transform: rotate(15deg);
}

.badge-locked {
    opacity: 0.4;
    filter: grayscale(100%);
}

.badge-locked .badge-medal {
    background: linear-gradient(135deg, #D1D5DB 0%, #E5E7EB 100%);
    border-color: #9CA3AF;
    box-shadow:
        0 6px 0 #6B7280,
        0 8px 16px rgba(156, 163, 175, 0.3);
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
   UNIFIED PRIMARY CTA SYSTEM
   ======================================== */

/* UNIFIED PRIMARY CTA - Use everywhere for consistency */
.btn-primary-unified {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
    padding: 22px 50px;
    font-size: 1.4rem;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;

    /* Unified gradient - cyan/teal (most energetic) */
    background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
    color: #2D2A45;

    border: 4px solid rgba(255, 255, 255, 0.6);
    border-radius: 25px;

    box-shadow:
        0 8px 0 #3ABFA8,
        0 12px 24px rgba(95, 227, 208, 0.4),
        inset 0 2px 0 rgba(255, 255, 255, 0.4);

    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    cursor: pointer;
    text-decoration: none;
    position: relative;
    overflow: hidden;
}

.btn-primary-unified::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    transition: left 0.5s ease;
}

.btn-primary-unified:hover::before {
    left: 100%;
}

.btn-primary-unified:hover {
    transform: translateY(-4px) scale(1.02);
    box-shadow:
        0 10px 0 #3ABFA8,
        0 16px 32px rgba(95, 227, 208, 0.5),
        0 0 30px rgba(95, 227, 208, 0.3);
    border-color: rgba(255, 255, 255, 0.7);
}

.btn-primary-unified:active {
    transform: translateY(4px) scale(0.98);
    box-shadow:
        0 2px 0 #3ABFA8,
        0 4px 12px rgba(95, 227, 208, 0.3);
}

.btn-primary-unified:focus,
.btn-primary-unified:active {
    outline: none !important;
    -webkit-tap-highlight-color: transparent !important;
}

/* Pulse animation for primary CTAs */
.btn-primary-unified.pulse-animation {
    animation: pulse-glow-cyan-unified 2s ease-in-out infinite;
}

@keyframes pulse-glow-cyan-unified {
    0%, 100% {
        box-shadow:
            0 8px 0 #3ABFA8,
            0 12px 24px rgba(95, 227, 208, 0.4),
            inset 0 2px 0 rgba(255, 255, 255, 0.4);
    }
    50% {
        box-shadow:
            0 8px 0 #3ABFA8,
            0 12px 32px rgba(95, 227, 208, 0.6),
            0 0 40px rgba(95, 227, 208, 0.5),
            inset 0 2px 0 rgba(255, 255, 255, 0.5);
    }
}

/* ========================================
   2. MINI-GAME DEMO SECTION
   ======================================== */



.section-title {
    font-size: 3rem;
    font-weight: 900;
    color: var(--text-dark);
    margin-bottom: 50px;
    padding-bottom: 20px;
    text-align: center;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
    position: relative;
}

/* Visual separator under section headers */
.section-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 6px;
    background: linear-gradient(90deg, #8B7FE8, #5FE3D0);
    border-radius: 3px;
}

.section-title.game-title {
    background: linear-gradient(135deg, #8B7FE8 0%, #5FE3D0 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    position: relative;
}

.section-subtitle {
    font-size: 1.2rem;
    color: var(--text-grey);
    text-align: center;
    margin-bottom: 40px;
    font-weight: 600;
}

.demo-question-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-radius: 32px;
    padding: 45px;
    max-width: 720px;
    margin: 0 auto;
    box-shadow:
        0 12px 32px rgba(139, 127, 232, 0.15),
        0 6px 16px rgba(0, 0, 0, 0.1),
        0 0 0 1px rgba(139, 127, 232, 0.1);
    border: 4px solid rgba(255, 255, 255, 0.8);
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
    background: linear-gradient(180deg, #FFE17B 0%, #FFD86D 100%);
    color: var(--text-dark);
    padding: 8px 18px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 800;
    border: 2px solid #FFC850;
    box-shadow:
        0 3px 0 #E6B84D,
        0 4px 8px rgba(255, 225, 123, 0.4);
    text-transform: uppercase;
    letter-spacing: 0.5px;
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
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 4px solid rgba(139, 127, 232, 0.3);
    border-radius: 20px;
    padding: 28px;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
    position: relative;
    z-index: 1;
    box-shadow:
        0 4px 12px rgba(139, 127, 232, 0.12),
        0 2px 6px rgba(0, 0, 0, 0.08);
}

.demo-option:hover {
    transform: translateY(-6px) scale(1.05);
    border-color: rgba(95, 227, 208, 0.6);
    background: rgba(255, 255, 255, 1);
    box-shadow:
        0 12px 32px rgba(95, 227, 208, 0.25),
        0 6px 16px rgba(0, 0, 0, 0.12);
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
    border-radius: 50%;
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
    padding: 80px 0 100px;
    background: transparent;
}

/* Section dividers for visual pauses */
.results-showcase-section::before {
    content: '⭐ ⭐ ⭐';
    display: block;
    text-align: center;
    font-size: 1.5rem;
    opacity: 0.3;
    margin-bottom: 40px;
    letter-spacing: 20px;
}

.benefits-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
    max-width: 900px;
    margin: 0 auto;
}

.benefit-card {
    background: rgba(255, 255, 255, 0.4);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-radius: 24px;
    padding: 30px 22px;
    text-align: center;
    box-shadow: var(--shadow-soft);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 2px solid rgba(255, 255, 255, 0.6);
    position: relative;
    overflow: hidden;
}

.benefit-card:hover {
    transform: translateY(-12px) scale(1.05);
    background: rgba(255, 255, 255, 0.6);
    border-color: rgba(95, 227, 208, 0.5);
    box-shadow: var(--shadow-glow-cyan);
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
   4. SNEAK PEEK SECTION - GAME LEVEL PREVIEW
   ======================================== */

.sneak-peek-section {
    padding: 100px 0 120px;
    background: transparent;
    position: relative;
}

/* Section Header */
.sneak-peek-header {
    text-align: center;
    margin-bottom: 60px;
}

.sneak-peek-header .section-subtitle {
    font-size: 1.2rem;
    color: var(--text-grey);
    font-weight: 600;
    margin-top: 10px;
}

/* Game Map Container */
.game-map {
    max-width: 750px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 30px;
    position: relative;
    padding: 20px 0;
}

/* Vertical Progression Line - Centered through checkpoints */
.game-map::before {
    content: '';
    position: absolute;
    left: 42.5px;  /* (90px checkpoint width / 2) - (5px line width / 2) = 42.5px */
    top: 80px;
    bottom: 80px;
    width: 5px;
    background: linear-gradient(180deg,
        #5FE3D0 0%,
        #5FE3D0 25%,
        #D1D5DB 25%,
        #D1D5DB 100%
    );
    border-radius: 3px;
    z-index: 0;
}

/* Individual Game Map Level */
.game-map-level {
    display: flex;
    align-items: flex-start;
    gap: 30px;
    position: relative;
    z-index: 1;
}

/* Checkpoint Circle (Left Side) */
.level-checkpoint {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
    width: 90px;
    flex-shrink: 0;
}

.checkpoint-circle {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

/* Unlocked Checkpoint */
.unlocked-checkpoint {
    background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 100%);
    border: 5px solid rgba(255, 255, 255, 0.8);
    animation: glow-pulse-unlocked 3s infinite;
}

@keyframes glow-pulse-unlocked {
    0%, 100% {
        box-shadow: 0 8px 20px rgba(95, 227, 208, 0.4),
                    0 0 30px rgba(95, 227, 208, 0.3);
    }
    50% {
        box-shadow: 0 8px 30px rgba(95, 227, 208, 0.6),
                    0 0 50px rgba(95, 227, 208, 0.5);
    }
}

/* Locked Checkpoint */
.locked-checkpoint {
    background: linear-gradient(135deg, #D1D5DB 0%, #9CA3AF 100%);
    border: 5px solid rgba(255, 255, 255, 0.6);
    opacity: 0.7;
}

/* Boss Checkpoint */
.boss-checkpoint {
    background: linear-gradient(135deg, #FFD86D 0%, #FFA500 100%);
    border: 5px solid rgba(255, 255, 255, 0.8);
    opacity: 0.5;
    filter: blur(2px);
}

.checkpoint-icon {
    font-size: 3rem;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.2));
}

.checkpoint-lock {
    position: absolute;
    bottom: -5px;
    right: -5px;
    font-size: 1.5rem;
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
}

/* Checkpoint Badges */
.checkpoint-badge {
    font-size: 0.75rem;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 6px 14px;
    border-radius: 20px;
    text-align: center;
}

.unlocked-badge {
    background: var(--pop-cyan);
    color: #2D2A45;
    box-shadow: 0 4px 12px rgba(95, 227, 208, 0.4);
}

.locked-badge {
    background: rgba(209, 213, 219, 0.8);
    color: var(--text-grey);
}

.boss-badge {
    background: linear-gradient(135deg, #FFD86D, #FFA500);
    color: #2D2A45;
    animation: pulse-glow-boss 2s infinite;
}

@keyframes pulse-glow-boss {
    0%, 100% {
        box-shadow: 0 0 10px rgba(255, 165, 0, 0.3);
    }
    50% {
        box-shadow: 0 0 20px rgba(255, 165, 0, 0.6);
    }
}

/* Level Cards (Right Side) */
.level-card {
    flex: 1;
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.88) 100%);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-radius: 24px;
    padding: 24px 28px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 3px solid rgba(255, 255, 255, 0.5);
    position: relative;
    overflow: hidden;
}

/* Unlocked Card */
.unlocked-card {
    border-color: rgba(95, 227, 208, 0.5);
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.98) 0%, rgba(224, 255, 250, 0.9) 100%);
}

.unlocked-card::before {
    content: '✨';
    position: absolute;
    top: -8px;
    right: -8px;
    font-size: 1.8rem;
    animation: twinkle 2s infinite;
    z-index: 10;
}

.unlocked-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 16px 40px rgba(95, 227, 208, 0.3);
    border-color: rgba(95, 227, 208, 0.7);
}

/* Locked Card */
.locked-card {
    opacity: 0.75;
    border-color: rgba(209, 213, 219, 0.5);
}

.locked-card:hover {
    transform: translateY(-4px);
    opacity: 0.85;
}

/* Boss Card */
.boss-card {
    opacity: 0.6;
    border-color: rgba(255, 165, 0, 0.3);
    filter: blur(1px);
}

.boss-card:hover {
    opacity: 0.7;
    filter: blur(0.5px);
}

/* Level Card Header */
.level-card-header {
    display: flex;
    align-items: flex-start;
    gap: 18px;
    margin-bottom: 18px;
}

.level-card-icon {
    font-size: 3.5rem;
    filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    flex-shrink: 0;
}

.blurred-icon {
    filter: grayscale(80%) blur(1px) drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    opacity: 0.6;
}

.mystery-icon {
    filter: grayscale(100%) blur(3px) drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
    opacity: 0.4;
}

.level-card-title-group {
    flex: 1;
}

.level-card-title {
    font-size: 1.4rem;
    font-weight: 800;
    color: var(--text-dark);
    margin-bottom: 8px;
    line-height: 1.2;
}

.level-card-subtitle {
    font-size: 1rem;
    color: var(--text-grey);
    font-weight: 600;
    line-height: 1.5;
}

/* Level Card Footer */
.level-card-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    padding-top: 12px;
    border-top: 2px solid rgba(0, 0, 0, 0.05);
}

.level-card-time {
    font-size: 0.9rem;
    font-weight: 700;
    color: var(--pop-cyan);
}

.level-card-status {
    font-size: 0.85rem;
    font-weight: 700;
    color: var(--pop-purple);
    background: rgba(139, 127, 232, 0.1);
    padding: 6px 14px;
    border-radius: 15px;
}

.level-card-hint {
    font-size: 0.85rem;
    font-weight: 600;
    color: var(--text-grey);
}

.level-card-mystery {
    font-size: 0.85rem;
    font-weight: 700;
    color: var(--pop-yellow);
    font-style: italic;
}

/* Sneak Peek CTA */
.sneak-peek-cta {
    text-align: center;
    margin-top: 60px;
}

.sneak-peek-cta .btn-primary-unified {
    padding: 22px 50px;
    font-size: 1.4rem;
    margin-bottom: 15px;
}

.cta-subtext {
    font-size: 1rem;
    color: var(--text-grey);
    font-weight: 600;
    margin-top: 12px;
}

/* Reassurance Message */
.sneak-peek-reassurance {
    text-align: center;
    margin-top: 40px;
    padding: 20px 30px;
    background: rgba(255, 255, 255, 0.4);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 20px;
    max-width: 650px;
    margin-left: auto;
    margin-right: auto;
    border: 2px solid rgba(255, 255, 255, 0.6);
}

.reassurance-text {
    font-size: 1.05rem;
    color: var(--text-dark);
    font-weight: 600;
    line-height: 1.6;
}

/* ========================================
   5. SOCIAL PROOF SECTION
   ======================================== */

.social-proof-section {
    padding: 100px 0;
    background: transparent;
}

.social-proof-section::before {
    content: '⭐ ⭐ ⭐';
    display: block;
    text-align: center;
    font-size: 1.5rem;
    opacity: 0.3;
    margin-bottom: 40px;
    letter-spacing: 20px;
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
    background: rgba(255, 255, 255, 0.5);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border-radius: 24px;
    padding: 24px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
    border: 2px solid rgba(255, 255, 255, 0.7);
    position: relative;
    overflow: hidden;
}

.feed-card:hover {
    transform: translateY(-10px) scale(1.03);
    background: rgba(255, 255, 255, 0.7);
    border-color: rgba(139, 127, 232, 0.5);
    box-shadow: 0 16px 40px rgba(139, 127, 232, 0.35);
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
    padding: 120px 0;
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
    background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
    color: #2D2A45;
    border: 4px solid rgba(255, 255, 255, 0.6);
    box-shadow:
        0 10px 0 #3ABFA8,
        0 15px 35px rgba(95, 227, 208, 0.5),
        inset 0 2px 0 rgba(255, 255, 255, 0.5);
}

.btn-final-play.mega-button:hover {
    transform: translateY(-4px) scale(1.02);
    box-shadow:
        0 12px 0 #3ABFA8,
        0 18px 40px rgba(95, 227, 208, 0.6),
        inset 0 2px 0 rgba(255, 255, 255, 0.6),
        0 0 35px rgba(95, 227, 208, 0.4);
}

.btn-final-play.mega-button:active {
    transform: translateY(4px) scale(0.98);
    box-shadow:
        0 4px 0 #3ABFA8,
        0 8px 20px rgba(95, 227, 208, 0.4),
        inset 0 2px 0 rgba(255, 255, 255, 0.5);
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
    /* Performance optimizations */
    contain: layout style;
    content-visibility: auto;
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
    /* Performance optimizations */
    contain: layout style;
    content-visibility: auto;
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
    /* Performance optimizations */
    contain: layout style;
    content-visibility: auto;
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
    /* Performance optimizations */
    contain: layout style;
    content-visibility: auto;
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
        padding-bottom: 40px;
    }

    /* ===== MOBILE UX IMPROVEMENTS ===== */

    /* Increase tap target sizes */
    .btn-primary-unified {
        min-height: 56px;
        padding: 18px 40px;
        font-size: 1.2rem;
    }

    .character-card {
        min-height: 56px;
        padding: 12px;
    }

    /* Reduce hero padding */
    .hero-section.game-portal {
        padding: 30px 0 50px;
    }

    /* Reduce section spacing */
    .results-showcase-section {
        padding: 50px 0;
    }

    .sneak-peek-section {
        padding: 50px 0;
    }

    .social-proof-section {
        padding: 50px 0;
    }

    .final-cta-section.game-cta {
        padding: 40px 0;
    }

    /* Reduce hero title size */
    .hero-title.game-title {
        font-size: 2.2rem;
        margin-bottom: 15px;
    }

    .hero-subtitle.game-subtitle {
        font-size: 1.1rem;
        margin-bottom: 30px;
    }

    /* Stack character cards 2x2 */
    .character-selection {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
        margin-bottom: 30px;
    }

    /* Stack benefits 2x2 */
    .benefits-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }

    /* Stack social feed vertically */
    .social-feed {
        grid-template-columns: 1fr;
        gap: 15px;
    }

    /* Reduce section titles */
    .section-title {
        font-size: 2rem;
        margin-bottom: 30px;
    }

    /* Simplify character medals on mobile */
    .character-icon {
        width: 80px;
        height: 80px;
    }

    .character-icon::before {
        border-width: 3px;
    }

    .character-image {
        width: 55px;
        height: 55px;
    }

    /* Hide decorative ribbons on mobile */
    .character-icon::after,
    .character-card::before {
        display: none;
    }

    /* Sneak Peek Mobile Adjustments */
    .game-map::before {
        left: 32.5px;  /* (70px checkpoint width / 2) - (5px line width / 2) = 32.5px */
    }

    .game-map-level {
        gap: 20px;
    }

    .level-checkpoint {
        width: 70px;
    }

    .checkpoint-circle {
        width: 70px;
        height: 70px;
    }

    .checkpoint-icon {
        font-size: 2.2rem;
    }

    .checkpoint-lock {
        font-size: 1.2rem;
    }

    .level-card {
        padding: 18px 20px;
    }

    .level-card-icon {
        font-size: 2.8rem;
    }

    .level-card-title {
        font-size: 1.2rem;
    }

    .level-card-subtitle {
        font-size: 0.9rem;
    }

    .level-card-footer {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
    }

    .sneak-peek-cta .btn-primary-unified {
        padding: 18px 40px;
        font-size: 1.2rem;
    }

    .reassurance-text {
        font-size: 0.95rem;
    }

    /* Adjust scroll-to-top button position on mobile to avoid sticky CTA */
    .scroll-to-top {
        bottom: 90px;
        right: 15px;
        width: 45px;
        height: 45px;
        font-size: 1.3rem;
    }
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
        padding: 20px 0 30px;
    }

    .hero-section.game-portal {
        padding: 20px 0 30px;
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
        gap: 15px;
        margin-bottom: 20px;
        padding: 10px 0;
    }

    .character-card {
        padding: 0;
    }

    .character-icon {
        width: 70px;
        height: 70px;
        margin-bottom: 25px;
    }

    /* Adjust badge size for mobile */
    .character-icon::before {
        border-width: 4px;
        box-shadow:
            0 4px 0 #CC8400,
            0 6px 15px rgba(255, 165, 0, 0.35),
            inset 0 -2px 6px rgba(0, 0, 0, 0.15),
            inset 0 2px 6px rgba(255, 255, 255, 0.4);
    }

    /* Left Ribbon - smaller for mobile */
    .character-icon::after {
        bottom: -20px;
        left: 10px;
        width: 20px;
        height: 35px;
    }

    /* Right Ribbon - smaller for mobile */
    .character-card::before {
        top: 50px;
        margin-left: 15px;
        width: 20px;
        height: 35px;
    }

    .character-image {
        width: 50px;
        height: 50px;
    }

    .character-name {
        font-size: 0.85rem;
        margin-bottom: 3px;
    }

    .character-trait {
        font-size: 0.7rem;
    }

    .btn-play-now {
        padding: 18px 40px;
        font-size: 1.2rem;
        margin-bottom: 25px;
        width: 100%;
        max-width: 100%;
        border-radius: 20px;
        box-shadow:
            0 6px 0 #3ABFA8,
            0 10px 20px rgba(95, 227, 208, 0.4),
            inset 0 2px 0 rgba(255, 255, 255, 0.4);
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

    /* Sneak Peek Section - Mobile Specific */
    .game-map-level {
        gap: 15px;
    }

    .level-checkpoint {
        min-width: 70px;
    }

    .checkpoint-badge {
        font-size: 0.65rem;
        padding: 4px 10px;
    }

    .level-card-header {
        gap: 12px;
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
    // Critical Performance Optimization - Immediate execution
    (function() {
        const isAndroid = /Android/i.test(navigator.userAgent);
        const isLowEndDevice = navigator.hardwareConcurrency && navigator.hardwareConcurrency <= 4;

        // Immediately add performance class before any rendering
        if (isAndroid || isLowEndDevice) {
            document.documentElement.classList.add('android-device', 'performance-mode');
        }

        if (isAndroid || isLowEndDevice) {
            // Add class to body for Android-specific optimizations
            document.documentElement.classList.add('android-device');

            // Create performance-optimized stylesheet
            const style = document.createElement('style');
            style.textContent = `
                /* Android Performance Optimizations */
                .android-device .enhanced-background-wrapper {
                    opacity: 0.5;
                }

                /* Disable expensive blur effects on Android */
                .android-device .blob-shape {
                    filter: blur(20px) !important;
                    opacity: 0.08 !important;
                }

                /* Hide particles on Android */
                .android-device .particle-system,
                .android-device .particle-container {
                    display: none !important;
                }

                /* Reduce decorative elements */
                .android-device .star:nth-child(n+5),
                .android-device .float-icon:nth-child(n+6) {
                    display: none !important;
                }

                /* Simplify character animations */
                .android-device .corner-character {
                    animation: none !important;
                    opacity: 0.2 !important;
                }

                /* Optimize button animations */
                .android-device .pulse-animation {
                    animation: none !important;
                }

                /* Reduce animation complexity */
                .android-device * {
                    animation-duration: 0.3s !important;
                }

                /* Disable transform animations on scroll */
                .android-device .character-card:hover {
                    transform: translateY(-5px) scale(1.02) !important;
                }

                /* Optimize images */
                .android-device img {
                    image-rendering: -webkit-optimize-contrast;
                }

                /* Pause animations when not visible */
                .android-device .paused-animations * {
                    animation-play-state: paused !important;
                }

                /* Critical: Reduce initial render complexity */
                .android-device .enhanced-background-wrapper {
                    visibility: hidden;
                }

                /* Show background after page load */
                .android-device.loaded .enhanced-background-wrapper {
                    visibility: visible;
                    transition: opacity 0.5s ease-in;
                }
            `;
            document.head.appendChild(style);

            // Show background after initial render
            window.addEventListener('load', function() {
                document.documentElement.classList.add('loaded');
            }, { once: true, passive: true });

            // Disable smooth scrolling on Android for better performance
            document.documentElement.style.scrollBehavior = 'auto';

            // Use Intersection Observer to pause animations when not visible
            if ('IntersectionObserver' in window) {
                const observer = new IntersectionObserver(function(entries) {
                    entries.forEach(function(entry) {
                        if (entry.isIntersecting) {
                            entry.target.classList.remove('paused-animations');
                        } else {
                            entry.target.classList.add('paused-animations');
                        }
                    });
                }, {
                    rootMargin: '50px'
                });

                // Observe sections with animations
                setTimeout(function() {
                    const animatedSections = document.querySelectorAll('.enhanced-background-wrapper, .scenery-layer');
                    animatedSections.forEach(function(section) {
                        observer.observe(section);
                    });
                }, 100);
            }
        }
    })();

    // Optimized Scroll Navigation for Discover Section
    // Use requestIdleCallback for non-critical initialization
    function initDiscoverSection() {
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

        // Update dots on scroll with passive listener
        discoverGrid.addEventListener('scroll', updateActiveDot, { passive: true });

        // Initial update
        updateActiveDot();
    }

    // Initialize after page load using requestIdleCallback for better performance
    if ('requestIdleCallback' in window) {
        requestIdleCallback(initDiscoverSection, { timeout: 2000 });
    } else {
        // Fallback for browsers without requestIdleCallback
        setTimeout(initDiscoverSection, 100);
    }

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

    // Demo Question Interaction - Optimized with event delegation
    (function() {
        const demoResult = document.getElementById('demoResult');
        const demoResultIcon = document.getElementById('demoResultIcon');
        const demoResultText = document.getElementById('demoResultText');

        if (!demoResult || !demoResultIcon || !demoResultText) return;

        const resultData = {
            wolf: { image: '${assetPath(src: "wolf.png")}', text: 'Hmm... you might be a Strategic Wolf!' },
            tiger: { image: '${assetPath(src: "tiger.png")}', text: 'Hmm... you might be a Bold Tiger!' },
            owl: { image: '${assetPath(src: "owl.png")}', text: 'Hmm... you might be a Wise Owl!' },
            bee: { image: '${assetPath(src: "bee.png")}', text: 'Hmm... you might be a Disciplined Bee!' }
        };

        // Use event delegation for better performance
        document.addEventListener('click', function(e) {
            const demoOption = e.target.closest('.demo-option');
            if (!demoOption) return;

            const result = demoOption.dataset.result;
            const data = resultData[result];

            if (!data) return;

            // Update result content with image
            demoResultIcon.innerHTML = '<img src="' + data.image + '" alt="' + result + '" class="demo-result-image" loading="lazy" decoding="async" />';
            demoResultText.textContent = data.text;

            // Show result with animation
            demoResult.style.display = 'block';

            // Add confetti effect (simple version)
            createConfetti();
        }, { passive: false });
    })();

    function createConfetti() {
        const isAndroid = /Android/i.test(navigator.userAgent);
        const confettiCount = isAndroid ? 15 : 30; // Reduce confetti on Android
        const colors = ['#FF6B53', '#9F97F3', '#3A7CA5', '#FFD86D'];

        for (let i = 0; i < confettiCount; i++) {
            const confetti = document.createElement('div');
            const randomColor = colors[Math.floor(Math.random() * colors.length)];
            const randomLeft = Math.random() * 100;
            confetti.style.cssText = 'position: fixed; width: 10px; height: 10px; background: ' + randomColor + '; left: ' + randomLeft + '%; top: -10px; opacity: 1; pointer-events: none; z-index: 9999; border-radius: 50%;';
            document.body.appendChild(confetti);

            const duration = Math.random() * 3 + 2;
            const xMovement = (Math.random() - 0.5) * (isAndroid ? 100 : 200); // Reduce movement on Android
            const randomRotation = Math.random() * 360;

            confetti.animate([
                { transform: 'translateY(0) translateX(0) rotate(0deg)', opacity: 1 },
                { transform: 'translateY(100vh) translateX(' + xMovement + 'px) rotate(' + randomRotation + 'deg)', opacity: 0 }
            ], {
                duration: duration * 1000,
                easing: isAndroid ? 'linear' : 'cubic-bezier(0.25, 0.46, 0.45, 0.94)' // Simpler easing on Android
            });

            setTimeout(function() { confetti.remove(); }, duration * 1000);
        }
    }

    // Optimized scroll handler with debouncing and passive listeners
    let scrollTimeout;
    let ticking = false;

    function handleScroll() {
        if (!ticking) {
            window.requestAnimationFrame(function() {
                const heroSection = document.querySelector('.hero-section');
                const mobileCTA = document.getElementById('mobileCTA');
                const scrollToTopBtn = document.getElementById('scrollToTop');
                const scrollY = window.scrollY;

                // Mobile Sticky CTA
                if (heroSection && mobileCTA) {
                    const heroHeight = heroSection.offsetHeight;
                    if (scrollY > heroHeight && window.innerWidth <= 768) {
                        mobileCTA.style.display = 'block';
                    } else {
                        mobileCTA.style.display = 'none';
                    }
                }

                // Scroll to Top Button
                if (scrollToTopBtn) {
                    if (scrollY > 300) {
                        scrollToTopBtn.classList.add('visible');
                    } else {
                        scrollToTopBtn.classList.remove('visible');
                    }
                }

                ticking = false;
            });
            ticking = true;
        }
    }

    // Use passive listener for better scroll performance
    window.addEventListener('scroll', handleScroll, { passive: true });

    // Scroll to Top Button click handler
    const scrollToTopBtn = document.getElementById('scrollToTop');
    if (scrollToTopBtn) {
        scrollToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }

    // Continue Game Modal Logic
    (function() {
        const continueModal = document.getElementById('continueGameModal');
        const closeModalBtn = document.getElementById('closeModalBtn');
        const continueGameBtn = document.getElementById('continueGameBtn');
        const newGameBtn = document.getElementById('newGameBtn');
        const continueGameEmoji = document.getElementById('continueGameEmoji');
        const continueGameName = document.getElementById('continueGameName');

        const testEmojis = {
            'SPIRIT_ANIMAL': '🦉',
            'COGNITIVE_RADAR': '🧠',
            'FOCUS_STAMINA': '⚡',
            'GUESSWORK_QUOTIENT': '🎲',
            'CURIOSITY_COMPASS': '🧭',
            'MODALITY_MAP': '🎨',
            'CHALLENGE_DRIVER': '🏆',
            'WORK_MODE': '🤝',
            'PATTERN_SNAPSHOT': '🧩'
        };

        // Check if user has an unfinished game
        function checkUnfinishedGame() {
            try {
                const savedState = localStorage.getItem('personality_start_state');
                if (!savedState) return null;

                const state = JSON.parse(savedState);

                // Only show if less than 24 hours old
                if (Date.now() - state.timestamp > 86400000) {
                    localStorage.removeItem('personality_start_state');
                    return null;
                }

                // Check if there's a valid session
                if (state.sessionId && state.selectedTest) {
                    return state;
                }

                return null;
            } catch (error) {
                console.error('Error checking unfinished game:', error);
                return null;
            }
        }

        // Handle all Play Now button clicks
        function handlePlayNowClick(e) {
            e.preventDefault();

            const unfinishedGame = checkUnfinishedGame();

            if (unfinishedGame && unfinishedGame.selectedTest) {
                // Show modal with game info
                const testName = unfinishedGame.selectedTest.testName || 'Spirit Animal Game';
                const testId = unfinishedGame.selectedTest.testId || 'SPIRIT_ANIMAL';
                const emoji = testEmojis[testId] || '🎮';

                continueGameEmoji.textContent = emoji;
                continueGameName.textContent = testName;
                continueModal.style.display = 'flex';
            } else {
                // No unfinished game, go directly to start page
                window.location.href = '${createLink(controller: 'personality', action: 'start')}';
            }
        }

        // Attach event listeners to all play now buttons
        const playNowButtons = document.querySelectorAll('#playNowBtn, .play-now-trigger');
        playNowButtons.forEach(function(btn) {
            btn.addEventListener('click', handlePlayNowClick);
        });

        // Handle Continue Game button
        if (continueGameBtn) {
            continueGameBtn.addEventListener('click', function(e) {
                // Let the link work normally - it will restore state from localStorage
            });
        }

        // Handle New Game button
        if (newGameBtn) {
            newGameBtn.addEventListener('click', function(e) {
                e.preventDefault();
                // Clear the saved state
                localStorage.removeItem('personality_start_state');
                // Go to start page
                window.location.href = '${createLink(controller: 'personality', action: 'start')}';
            });
        }

        // Handle Close button
        if (closeModalBtn) {
            closeModalBtn.addEventListener('click', function() {
                continueModal.style.display = 'none';
            });
        }

        // Handle clicking outside modal
        if (continueModal) {
            continueModal.addEventListener('click', function(e) {
                if (e.target === continueModal || e.target.classList.contains('continue-modal-overlay')) {
                    continueModal.style.display = 'none';
                }
            });
        }
    })();
</script>
</body>
</html>


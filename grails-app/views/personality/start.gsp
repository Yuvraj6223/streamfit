<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Choose Your Game - learnerDNA</title>

    <!-- Import Fonts with optimized loading -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <asset:stylesheet src="personality-start.css"/>
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
    <!-- In the HTML body, after existing decorations -->
    <div class="sparkle sparkle-1">✨</div>
    <div class="sparkle sparkle-2">⭐</div>
    <div class="sparkle sparkle-3">💫</div>
    <div class="sparkle sparkle-4">✨</div>

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
</div>

<!-- Ambient Background Layer -->
<div class="scenery-layer" style="pointer-events: none; z-index: -100;">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

<div class="test-page">
    <div class="mobile-container animate-in">
            <!-- Big Game Title at Top (shown during game) -->
            <div id="gameTitle" class="game-title-top hidden">
                <div class="hud-row">
                    <div class="hud-avatar">
                        <div class="game-title-emoji" id="gameTitleEmoji"></div>
                    </div>
                    <div class="hud-stack">
                        <div class="hud-topline">
                            <div class="hud-level" id="hudLevelText">Level</div>
                            <div class="hud-title">
                                <h2 class="game-title-text" id="gameTitleText"></h2>
                            </div>
                        </div>
                        <div class="hud-xp-bar" role="progressbar" aria-label="XP">
                            <div class="hud-xp-fill" id="hudXpFill"></div>
                        </div>
                        <div class="hud-xp-sub" id="hudXpSub">XP</div>
                    </div>
                </div>
            </div>

            <!-- Progress Bar - REMOVED -->
            <div class="progress-container" style="display: none !important; background: transparent !important; backdrop-filter: none !important; -webkit-backdrop-filter: none !important; box-shadow: none !important; border: none !important;">
                <div class="progress-bar">
                    <div class="progress-fill" id="progressBar"></div>
                </div>
                <div class="progress-text">
                    <span id="progressText">Choose Your Game</span>
                </div>
            </div>

            <!-- Step 1: Test Selection (Gender step removed) -->
            <div id="testSelection" class="step-container">
                <h2>Choose Your Game 🎮</h2>
                <p>Pick a game to learn more about yourself:</p>
                <!-- Featured card container -->
                <div id="featuredContainer" class="featured-container" style="margin: 0 auto 24px auto; width: 100%; max-width: 1400px; padding: 0 40px; display:none;"></div>
                <div id="testGrid" class="test-grid">
                    <!-- Tests will be loaded here -->
                </div>
            </div>

            <!-- Game Moment Container (NOT a question screen) -->
            <div id="questionContainer" class="question-container hidden">

                <div class="game-play-area">
                    <div class="game-fixed-zone game-action-zone">
                        <!-- Countdown/Tension Phase -->
                        <div id="countdownContainer" class="countdown-container" style="display: none;">
                            <div class="countdown-bar">
                                <div class="countdown-fill"></div>
                            </div>
                            <div class="countdown-text">Get Ready...</div>
                        </div>

                        <div class="challenge-card" id="challengeCard">
                            <div class="question-number" id="questionNumber"></div>
                            <div class="question-text" id="questionText"></div>
                        </div>
                    </div>

                    <div class="game-options-zone game-choice-zone">
                        <!-- Reaction Options (appear after countdown) -->
                        <div class="options-container" id="optionsContainer">
                            <!-- Action buttons will be dynamically inserted here -->
                        </div>

                        <div class="action-feedback" id="actionFeedback" aria-live="polite"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asset:javascript src="personality-start.js"/>
</body>
</html>


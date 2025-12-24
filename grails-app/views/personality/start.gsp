<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Choose Your Game - StreamFit</title>

    <!-- Import Fonts with optimized loading -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <style>
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
        margin: 0;
        padding: 0;
        min-height: 100vh;
        height: 100vh;
        overflow-x: hidden;
        -webkit-font-smoothing: antialiased;
    }

    /* Prevent scrolling on mobile when in game mode */
    @media (max-width: 768px) {
        body.game-active {
            overflow: hidden;
            position: fixed;
            width: 100%;
            height: 100vh;
        }
    }

    /* Apply Display Font to All Headlines */
    h1, h2, h3, h4, h5, h6 {
        font-family: var(--font-display);
        font-weight: 800;
        letter-spacing: -0.02em;
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

    /* --- LAYOUT --- */
    .test-page {
        max-width: 100%;
        margin: 0;
        padding: 0;
        position: relative;
        z-index: 1;
        min-height: 100vh;
        display: flex;
        align-items: stretch;
        justify-content: center;
        overflow: hidden;
    }

    .mobile-container {
        background: transparent;
        backdrop-filter: none;
        -webkit-backdrop-filter: none;
        border-radius: 0;
        padding: 0;
        box-shadow: none;
        border: none;
        margin: 0;
        width: 100%;
        max-width: 100%;
        position: relative;
        overflow-y: hidden;
        overflow-x: hidden;
        display: flex;
        flex-direction: column;
    }

    .mobile-container::before {
        display: none;
    }

    /* --- PROGRESS BAR - Duolingo Style --- */
    .progress-container {
        position: relative;
        padding: 16px 20px;
        margin: 0;
        z-index: 10;
        background: transparent;
        flex-shrink: 0;
    }

    .progress-bar {
        position: relative;
        height: 32px;
        background: transparent;
        border-radius: 50px;
        border: 3px solid rgba(139, 127, 232, 0.3);
        overflow: hidden;
        box-shadow: none;
    }

    .progress-fill {
        height: 100%;
        background: linear-gradient(90deg, #8B7FE8 0%, #A89FF3 100%);
        border-radius: 50px;
        width: 0%;
        transition: width 0.6s var(--ease-elastic);
        position: relative;
        box-shadow: 0 0 10px rgba(139, 127, 232, 0.4);
    }

    .progress-fill::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 50%;
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.3) 0%, transparent 100%);
        border-radius: 50px 50px 0 0;
    }

    .progress-text {
        text-align: center;
        font-size: 0.9rem;
        font-weight: 800;
        color: var(--text-dark);
        margin-top: 12px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    /* --- STEP CONTAINERS --- */
    .step-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
        display: flex;
        flex-direction: column;
        position: relative;
        z-index: 1;
        padding: 20px 20px 0 20px;
        flex: 1;
        overflow-y: auto;
        min-height: 0;
    }

    .step-container.hidden {
        display: none;
    }

    .step-container h2 {
        font-size: clamp(2rem, 4vw, 3rem);
        font-weight: 900;
        letter-spacing: -0.03em;
        margin: 0 0 20px 0;
        line-height: 1.2;
        color: var(--text-dark);
        text-align: center;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
    }

    .step-container p {
        font-size: 1.2rem;
        color: var(--text-grey);
        line-height: 1.6;
        font-weight: 700;
        margin: 0 0 40px 0;
        text-align: center;
    }

    /* --- TEST GRID - Duolingo Style --- */
    .test-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 24px;
        margin-bottom: 0;
        max-height: none;
        overflow: visible;
    }

    .test-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-radius: 28px;
        padding: 32px 28px;
        border: 4px solid rgba(139, 127, 232, 0.2);
        transition: all 0.4s var(--ease-elastic);
        cursor: pointer;
        box-shadow:
            0 8px 24px rgba(139, 127, 232, 0.12),
            0 4px 12px rgba(0, 0, 0, 0.08);
        height: 100%;
        display: flex;
        flex-direction: column;
        position: relative;
        overflow: hidden;
    }

    .test-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(139, 127, 232, 0.03) 0%, rgba(95, 227, 208, 0.03) 100%);
        pointer-events: none;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .test-card:hover::before {
        opacity: 1;
    }

    .test-card:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow:
            0 16px 40px rgba(139, 127, 232, 0.2),
            0 8px 20px rgba(0, 0, 0, 0.12);
        border-color: rgba(95, 227, 208, 0.5);
    }

    .test-card.selected {
        background: linear-gradient(135deg, rgba(139, 127, 232, 0.15) 0%, rgba(95, 227, 208, 0.15) 100%);
        border-color: var(--pop-cyan);
        box-shadow:
            0 12px 32px rgba(95, 227, 208, 0.3),
            0 6px 16px rgba(0, 0, 0, 0.1),
            0 0 0 2px rgba(95, 227, 208, 0.2);
        transform: translateY(-4px) scale(1.02);
    }

    .test-icon {
        font-size: 5.5rem;
        margin-bottom: 16px;
        text-align: center;
        filter: drop-shadow(0 4px 12px rgba(0, 0, 0, 0.15));
        animation: float-icon-vertical 3s ease-in-out infinite;
        font-family: "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji", sans-serif;
        line-height: 1;
        display: block;
    }

    .test-start-btn {
        margin-top: 20px;
        padding: 16px 32px;
        background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
        color: #2D2A45;
        border: 3px solid rgba(255, 255, 255, 0.6);
        border-radius: 20px;
        font-weight: 800;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-family: inherit;
        width: 100%;
        display: none;
        box-shadow:
            0 6px 0 #3ABFA8,
            0 8px 16px rgba(95, 227, 208, 0.4),
            inset 0 1px 0 rgba(255, 255, 255, 0.4);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        position: relative;
        overflow: hidden;
    }

    .test-start-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
        transition: left 0.5s ease;
    }

    .test-start-btn:hover::before {
        left: 100%;
    }

    .test-card.selected .test-start-btn {
        display: block;
        animation: slideIn 0.4s ease-out;
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .test-start-btn:hover {
        transform: translateY(-3px) scale(1.02);
        box-shadow:
            0 8px 0 #3ABFA8,
            0 12px 24px rgba(95, 227, 208, 0.5),
            inset 0 1px 0 rgba(255, 255, 255, 0.5);
    }

    .test-start-btn:active {
        transform: translateY(2px) scale(0.98);
        box-shadow:
            0 2px 0 #3ABFA8,
            0 4px 8px rgba(95, 227, 208, 0.3),
            inset 0 1px 0 rgba(255, 255, 255, 0.4);
    }

    .test-badge {
        padding: 8px 16px;
        border-radius: 12px;
        font-size: 0.7rem;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
        margin-bottom: 16px;
        width: fit-content;
        border: 2px solid;
    }

    .test-badge.diagnostic {
        background: rgba(139, 127, 232, 0.15);
        color: var(--pop-purple);
        border-color: rgba(139, 127, 232, 0.3);
    }

    .test-badge.exam {
        background: rgba(95, 227, 208, 0.15);
        color: var(--pop-cyan);
        border-color: rgba(95, 227, 208, 0.3);
    }

    .test-badge.career {
        background: rgba(255, 154, 184, 0.15);
        color: var(--pop-coral);
        border-color: rgba(255, 154, 184, 0.3);
    }

    .test-card h3 {
        font-weight: 800;
        color: var(--text-dark);
        margin: 0 0 12px 0;
        font-size: 1.4rem;
        letter-spacing: -0.02em;
        line-height: 1.3;
    }

    .test-card p {
        color: var(--text-grey);
        font-weight: 600;
        line-height: 1.6;
        margin: 0 0 10px 0;
        font-size: 1rem;
    }

    /* --- GAME MOMENT CONTAINER (NOT A QUESTION) --- */
    .question-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
        padding: 20px 20px 0 20px;
        flex: 1;
        overflow-y: hidden;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        gap: 0;
        min-height: 0;
    }

    .question-container.hidden {
        display: none;
    }

    /* Game Moment Screen - Centered, Short Context */
    .question-text {
        font-size: clamp(1.5rem, 4vw, 2.2rem);
        font-weight: 900;
        color: var(--text-dark);
        margin: 0 0 20px 0;
        line-height: 1.25;
        text-align: center;
        letter-spacing: -0.03em;
        text-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        padding: 0 20px;
        flex-shrink: 0;
    }

    /* Countdown/Tension Phase */
    .countdown-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 80px;
        margin: 0 0 20px 0;
        flex-shrink: 0;
    }

    .countdown-bar {
        width: 100%;
        max-width: 400px;
        height: 12px;
        background: rgba(255, 255, 255, 0.4);
        border-radius: 50px;
        overflow: hidden;
        margin-bottom: 24px;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .countdown-fill {
        height: 100%;
        background: linear-gradient(90deg, #FF9AB8 0%, #FFE17B 100%);
        width: 100%;
        animation: countdownPulse 2s ease-in-out forwards;
        box-shadow: 0 0 20px rgba(255, 154, 184, 0.6);
    }

    @keyframes countdownPulse {
        0% { width: 100%; opacity: 1; }
        100% { width: 0%; opacity: 0.5; }
    }

    .countdown-text {
        font-size: 1.2rem;
        font-weight: 700;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 1px;
        animation: pulse 1s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% { opacity: 0.6; transform: scale(1); }
        50% { opacity: 1; transform: scale(1.05); }
    }

    /* Options appear AFTER countdown - Reaction Phase */
    .options-container {
        display: flex;
        flex-direction: column;
        gap: 14px;
        margin: 0 0 16px 0;
        opacity: 0;
        transform: translateY(20px);
        flex: 0 0 auto;
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
        width: 100%;
        padding: 0 20px;
    }

    .options-container.show {
        animation: optionsAppear 0.5s var(--ease-elastic) forwards;
    }

    @keyframes optionsAppear {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Action Buttons - NOT answer buttons */
    .option {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.85) 100%);
        backdrop-filter: blur(10px);
        border: 3px solid rgba(139, 127, 232, 0.3);
        border-radius: 24px;
        padding: 18px 24px;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-weight: 700;
        color: var(--text-dark);
        font-size: 1.1rem;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        min-height: 64px;
        box-shadow: 0 8px 24px rgba(139, 127, 232, 0.15);
        position: relative;
        overflow: hidden;
        flex-shrink: 0;
    }

    .option::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(139, 127, 232, 0.05) 0%, rgba(95, 227, 208, 0.05) 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .option:hover::before {
        opacity: 1;
    }

    .option:hover {
        transform: translateY(-6px) scale(1.02);
        border-color: var(--pop-cyan);
        box-shadow: 0 16px 40px rgba(95, 227, 208, 0.3);
    }

    .option.selected {
        background: linear-gradient(135deg, #58CC02 0%, #6DD604 100%);
        border-color: #58CC02;
        box-shadow: 0 12px 32px rgba(88, 204, 2, 0.4);
        color: white;
        font-weight: 800;
        transform: translateY(-4px) scale(1.02);
        position: relative;
        overflow: hidden;
    }

    .option.selected::after {
        content: none;
        display: none;
    }

    @keyframes autoAdvanceProgress {
        from { width: 0%; }
        to { width: 100%; }
    }

    /* --- HIDE NAVIGATION BUTTONS (NO NEXT/PREVIOUS IN GAME) --- */
    .navigation-buttons {
        display: none !important;
    }

    .btn {
        display: none !important;
    }

    /* Game Progress Indicator - Energy Meter Style */
    .game-progress-meter {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        margin: 0;
        flex-shrink: 0;
    }

    .progress-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        background: rgba(139, 127, 232, 0.2);
        transition: all 0.3s var(--ease-elastic);
    }

    .progress-dot.completed {
        background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 100%);
        box-shadow: 0 0 12px rgba(95, 227, 208, 0.6);
        transform: scale(1.2);
    }

    .progress-dot.current {
        background: linear-gradient(135deg, #FFE17B 0%, #FF9AB8 100%);
        box-shadow: 0 0 16px rgba(255, 225, 123, 0.8);
        transform: scale(1.4);
        animation: currentDotPulse 1.5s ease-in-out infinite;
    }

    @keyframes currentDotPulse {
        0%, 100% { transform: scale(1.4); opacity: 1; }
        50% { transform: scale(1.6); opacity: 0.8; }
    }

    /* --- BIG GAME TITLE AT TOP --- */
    .game-title-top {
        text-align: center;
        padding: 20px 20px 0 20px;
        margin: 0;
        background: transparent;
        border-radius: 0;
        box-shadow: none;
        backdrop-filter: none;
        border: none;
        flex-shrink: 0;
    }

    .game-title-emoji {
        font-size: 6rem;
        margin-bottom: 16px;
        line-height: 1;
        animation: float-gentle 3s ease-in-out infinite;
    }

    @keyframes float-gentle {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-8px); }
    }

    .game-title-text {
        font-size: 4rem;
        font-weight: 900;
        color: #000000;
        margin: 0;
        line-height: 1.1;
    }

    /* --- NAVIGATION ARROWS --- */
    .navigation-progress-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        gap: 8px;
        margin: 0 16px 0 16px;
        padding: 0;
        flex-shrink: 0;
    }

    .nav-arrow {
        display: none !important;
    }

    /* --- TABLET --- */
    @media (max-width: 1024px) {
        .test-page {
            max-width: 100%;
            padding: 0;
            height: 100vh;
        }

        .mobile-container {
            padding: 0;
            height: 100vh;
        }

        .step-container {
            padding: 16px 16px 16px 16px;
        }

        .game-title-top {
            padding: 16px 20px 0 20px;
        }

        .game-title-emoji {
            font-size: 5rem;
        }

        .game-title-text {
            font-size: 3rem;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .options-container {
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        }

        .step-container h2 {
            font-size: 2.2rem;
        }

        .step-container p {
            font-size: 1.1rem;
        }
    }

    /* --- SMALL TABLET --- */
    @media (max-width: 900px) {
        .test-page {
            padding: 0;
            height: 100vh;
        }

        .mobile-container {
            padding: 0;
            height: 100vh;
        }

        .step-container {
            padding: 14px 14px 14px 14px;
        }

        .game-title-top {
            padding: 14px 18px 0 18px;
        }

        .game-title-emoji {
            font-size: 4.5rem;
        }

        .game-title-text {
            font-size: 2.75rem;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        .test-card {
            padding: 24px 20px;
        }

        .test-icon {
            font-size: 3.5rem;
        }

        .step-container h2 {
            font-size: 2rem;
        }

        .step-container p {
            font-size: 1.05rem;
        }
    }

    /* --- MOBILE --- */
    @media (max-width: 768px) {
        body {
            overflow: hidden;
            height: 100vh;
        }

        .test-page {
            padding: 0;
            max-width: 100%;
            height: 100vh;
        }

        .mobile-container {
            padding: 0;
            margin: 0;
            border-radius: 0;
            width: 100%;
            max-width: 100%;
            border-width: 0;
            height: 100vh;
        }

        .step-container {
            padding: 12px 12px 0 12px;
        }

        .progress-container {
            margin: 0;
            padding: 12px 16px;
        }

        .progress-bar {
            height: 20px;
            border-width: 2px;
        }

        .progress-text {
            font-size: 0.8rem;
            margin-top: 8px;
        }

        .step-container h2 {
            font-size: 1.8rem;
            margin-bottom: 16px;
        }

        .step-container p {
            font-size: 1rem;
            margin-bottom: 28px;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .test-card {
            padding: 20px 16px;
            border-radius: 20px;
            border-width: 3px;
        }

        .test-icon {
            font-size: 3.2rem;
            margin-bottom: 12px;
        }

        .test-card h3 {
            font-size: 1.05rem;
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .test-card p {
            font-size: 0.85rem;
            margin-bottom: 6px;
            line-height: 1.5;
        }

        .test-card p:last-of-type {
            font-size: 0.75rem !important;
            margin-bottom: 0;
        }

        .test-badge {
            font-size: 0.65rem;
            padding: 6px 12px;
            margin-bottom: 12px;
        }

        .test-start-btn {
            padding: 12px 20px;
            font-size: 0.9rem;
            margin-top: 12px;
            border-width: 3px;
        }

        /* Big Game Title at Top - Mobile */
        .game-title-top {
            padding: 12px 16px 0 16px;
            margin: 0;
            border-radius: 0;
            background: transparent;
        }

        .game-title-emoji {
            font-size: 3.5rem;
            margin-bottom: 8px;
        }

        .game-title-text {
            font-size: 2rem;
            line-height: 1.1;
            font-weight: 900;
        }

        /* Question Container - Compact for mobile to fit in one screen */
        #questionContainer {
            padding: 12px 16px 0 16px;
            max-height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            overflow-y: auto;
            gap: 0;
        }

        /* Navigation and Progress */
        .navigation-progress-container {
            gap: 12px;
            margin: 0 16px 0 16px;
            padding: 0;
        }

        .question-text {
            font-size: 1.05rem;
            margin: 0 0 16px 0;
            text-align: center;
            padding: 0 8px;
            line-height: 1.3;
        }

        .countdown-container {
            min-height: 60px;
            margin: 0 0 16px 0;
        }

        .countdown-bar {
            max-width: 200px;
            height: 6px;
        }

        .countdown-text {
            font-size: 0.8rem;
        }

        .options-container {
            gap: 12px;
            margin: 0 0 16px 0;
            padding: 0 8px;
        }

        .option {
            padding: 16px 20px;
            font-size: 0.95rem;
            min-height: 58px;
            text-align: center;
            border-width: 2px;
            line-height: 1.3;
        }

        .game-progress-meter {
            margin: 0;
            padding: 0;
        }

        .progress-dot {
            width: 8px;
            height: 8px;
        }

        /* Compact progress bar */
        .progress-container {
            margin: 0;
            padding: 12px 16px;
            background: transparent;
        }

        .progress-bar {
            height: 8px;
            border-width: 2px;
            background: transparent;
        }

        .progress-text {
            font-size: 0.75rem;
            margin-top: 6px;
            font-weight: 700;
        }

        .progress-fill {
            transition: width 0.4s ease-out;
        }
    }

    /* --- EXTRA SMALL MOBILE --- */
    @media (max-width: 480px) {
        body {
            height: 100vh;
            overflow: hidden;
        }

        .test-page {
            padding: 0;
            height: 100vh;
        }

        .mobile-container {
            padding: 0;
            border-radius: 0;
            height: 100vh;
        }

        .step-container {
            padding: 10px 10px 0 10px;
        }

        .step-container h2 {
            font-size: 1.5rem;
        }

        .step-container p {
            font-size: 0.95rem;
        }

        .test-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .test-card {
            padding: 16px 12px;
            border-radius: 18px;
        }

        .test-icon {
            font-size: 2.8rem;
            margin-bottom: 10px;
        }

        .test-card h3 {
            font-size: 0.95rem;
            margin-bottom: 6px;
            line-height: 1.3;
        }

        .test-card p {
            font-size: 0.75rem;
            margin-bottom: 4px;
            line-height: 1.4;
        }

        .test-card p:last-of-type {
            font-size: 0.7rem !important;
        }

        .test-badge {
            font-size: 0.6rem;
            padding: 5px 10px;
            margin-bottom: 8px;
        }

        .test-start-btn {
            padding: 10px 16px;
            font-size: 0.85rem;
            margin-top: 10px;
        }

        /* Extra compact for very small screens */
        .game-title-top {
            padding: 10px 12px 0 12px;
            margin: 0;
            background: transparent;
        }

        .game-title-emoji {
            font-size: 3rem;
            margin-bottom: 8px;
        }

        .game-title-text {
            font-size: 1.75rem;
            font-weight: 900;
        }

        #questionContainer {
            padding: 10px 12px 0 12px;
            gap: 0;
        }

        .question-text {
            font-size: 0.95rem;
            padding: 0 8px;
            margin: 0 0 12px 0;
            line-height: 1.25;
        }

        .countdown-container {
            min-height: 50px;
            margin: 0 0 12px 0;
        }

        .countdown-bar {
            max-width: 180px;
            height: 5px;
        }

        .countdown-text {
            font-size: 0.75rem;
        }

        .options-container {
            gap: 10px;
            padding: 0 8px;
            margin: 0 0 16px 0;
        }

        .option {
            padding: 14px 16px;
            font-size: 0.85rem;
            min-height: 52px;
            line-height: 1.25;
        }

        .game-progress-meter {
            margin: 0;
            padding: 0;
        }

        .progress-dot {
            width: 7px;
            height: 7px;
        }

        .navigation-progress-container {
            padding: 0;
            margin: 0 10px 0 10px;
        }

        .progress-container {
            margin: 0;
            padding: 10px 12px;
            background: transparent;
        }

        .progress-bar {
            height: 4px;
            background: transparent;
        }

        .progress-text {
            font-size: 0.65rem;
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

        /* Simplify blob animations on mobile */
        .blob-shape {
            animation-duration: 60s !important;
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
        .float-icon {
            animation: none !important;
            opacity: 0.15 !important;
        }
    }

    /* UTILS */
    .animate-in {
        opacity: 0;
        animation: reveal 0.8s var(--ease-smooth) forwards;
    }

    @keyframes reveal {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
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
</div>

<!-- Ambient Background Layer -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

<div class="test-page">
    <div class="mobile-container animate-in">
            <!-- Big Game Title at Top (shown during game) -->
            <div id="gameTitle" class="game-title-top hidden">
                <div class="game-title-emoji" id="gameTitleEmoji"></div>
                <h2 class="game-title-text" id="gameTitleText"></h2>
            </div>

            <!-- Progress Bar -->
            <div class="progress-container">
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
                <div id="testGrid" class="test-grid">
                    <!-- Tests will be loaded here -->
                </div>
            </div>

            <!-- Game Moment Container (NOT a question screen) -->
            <div id="questionContainer" class="question-container hidden">

                <!-- Countdown/Tension Phase -->
                <div id="countdownContainer" class="countdown-container" style="display: none;">
                    <div class="countdown-bar">
                        <div class="countdown-fill"></div>
                    </div>
                    <div class="countdown-text">Get Ready...</div>
                </div>

                <!-- Game Moment Text (NOT a question) -->
                <div class="question-text" id="questionText"></div>

                <!-- Reaction Options (appear after countdown) -->
                <div class="options-container" id="optionsContainer">
                    <!-- Action buttons will be dynamically inserted here -->
                </div>

                <!-- Navigation and Progress Container -->
                <div class="navigation-progress-container">
                    <!-- Game Progress Dots (NOT question numbers) -->
                    <div class="game-progress-meter" id="gameProgressMeter">
                        <!-- Progress dots will be dynamically inserted here -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let selectedTest = null;
        let allTests = [];
        let questions = [];
        let currentQuestionIndex = 0;
        let answers = [];
        let sessionId = null;
        let autoAdvanceTimer = null;

        // Fallback tests to show if API is unavailable or returns no data
        const defaultTests = [
            {
                testId: 'SPIRIT_ANIMAL',
                testName: 'Spirit Animal Game',
                testType: 'DIAGNOSTIC',
                description: 'Quick mindset snapshot to find your spirit animal profile.',
                questionCount: 12,
                estimatedMinutes: 3
            }
        ];

        // Save page state to localStorage
        function savePageState() {
            const state = {
                selectedTest: selectedTest,
                sessionId: sessionId,
                currentQuestionIndex: currentQuestionIndex,
                answers: answers,
                questions: questions,
                timestamp: Date.now()
            };
            localStorage.setItem('personality_start_state', JSON.stringify(state));
        }

        // Restore page state from localStorage
        function restorePageState() {
            try {
                const savedState = localStorage.getItem('personality_start_state');
                if (!savedState) return;

                const state = JSON.parse(savedState);

                // Only restore if less than 1 hour old
                if (Date.now() - state.timestamp > 3600000) {
                    localStorage.removeItem('personality_start_state');
                    return;
                }

                // Restore state variables
                if (state.selectedTest) selectedTest = state.selectedTest;
                if (state.sessionId) sessionId = state.sessionId;
                if (state.currentQuestionIndex) currentQuestionIndex = state.currentQuestionIndex;
                if (state.answers) answers = state.answers;
                if (state.questions) questions = state.questions;

                // If we were in a test, restore the test view
                if (sessionId && questions.length > 0) {
                    setTimeout(() => {
                        // Hide test selection
                        document.getElementById('testSelection').classList.add('hidden');
                        document.getElementById('questionContainer').classList.remove('hidden');
                        document.body.classList.add('game-active');

                        // Show game title
                        const testEmojis = {
                            'SPIRIT_ANIMAL': '🎯',
                            'COGNITIVE_RADAR': '🧠',
                            'FOCUS_STAMINA': '⚡',
                            'GUESSWORK_QUOTIENT': '🎲',
                            'CURIOSITY_COMPASS': '🧭',
                            'MODALITY_MAP': '🎨',
                            'CHALLENGE_DRIVER': '🏆',
                            'WORK_MODE': '🤝',
                            'PATTERN_SNAPSHOT': '🧩'
                        };
                        const emoji = testEmojis[selectedTest.testId] || '📝';
                        document.getElementById('gameTitle').classList.remove('hidden');
                        document.getElementById('gameTitleEmoji').textContent = emoji;
                        document.getElementById('gameTitleText').textContent = selectedTest.testName;

                        // Show current question
                        showQuestion(currentQuestionIndex);
                    }, 100);
                }
            } catch (error) {
                console.error('Error restoring page state:', error);
                localStorage.removeItem('personality_start_state');
            }
        }

        // Clear page state from localStorage
        function clearPageState() {
            localStorage.removeItem('personality_start_state');
        }

        // Load tests on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Try to restore state from localStorage
            restorePageState();
            loadTests();
            // Initialize progress bar with game language
            updateProgress(0, 'Choose Your Game');
        });

        // Load all diagnostic tests
        async function loadTests() {
            try {
                const response = await fetch('/api/diagnostic/tests', { headers: { 'Accept': 'application/json' } });
                if (!response.ok) throw new Error('Failed to load tests');

                const data = await response.json();
                allTests = Array.isArray(data) && data.length > 0 ? data : defaultTests;
            } catch (error) {
                console.error('Error loading tests:', error);
                // Use fallback to ensure UI is not empty
                allTests = defaultTests;
            }

            // Sort tests to put SPIRIT_ANIMAL first
            allTests.sort((a, b) => {
                if (a.testId === 'SPIRIT_ANIMAL') return -1;
                if (b.testId === 'SPIRIT_ANIMAL') return 1;
                return 0;
            });

            renderTests();
        }

        // Test emoji mapping
        const testEmojis = {
            'SPIRIT_ANIMAL': '🎯',
            'COGNITIVE_RADAR': '🧠',
            'FOCUS_STAMINA': '⚡',
            'GUESSWORK_QUOTIENT': '🎲',
            'CURIOSITY_COMPASS': '🧭',
            'MODALITY_MAP': '🎨',
            'CHALLENGE_DRIVER': '🏆',
            'WORK_MODE': '🤝',
            'PATTERN_SNAPSHOT': '🧩'
        };

        // Render tests in grid
        function renderTests() {
            const testGrid = document.getElementById('testGrid');
            testGrid.innerHTML = allTests.map(test => {
                const emoji = testEmojis[test.testId] || '📝';
                return '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
                    '<div class="test-icon">' + emoji + '</div>' +
                    '<div class="test-badge ' + ((test.testType || 'DIAGNOSTIC').toString().toLowerCase()) + '">' + (test.testType || 'DIAGNOSTIC') + '</div>' +
                    '<h3>' + test.testName + '</h3>' +
                    '<p>' + (test.description || '') + '</p>' +
                    '<p style="font-size: 0.9rem; color: #999; margin-bottom: 0;">' +
                        test.questionCount + ' questions • ' + test.estimatedMinutes + ' min' +
                    '</p>' +
                    '<button class="test-start-btn" onclick="event.stopPropagation(); startTest()">Start Game →</button>' +
                '</div>';
            }).join('');
        }

        // Select a test
        function selectTest(testId) {
            const testCards = document.querySelectorAll('.test-card');
            testCards.forEach(card => card.classList.remove('selected'));

            const selectedCard = document.querySelector('[data-test-id="' + testId + '"]');
            selectedCard.classList.add('selected');

            selectedTest = allTests.find(t => t.testId === testId);
        }

        // Start the test
        async function startTest() {
            try {
                // Ensure a test is selected; fallback to first available
                if (!selectedTest && allTests && allTests.length > 0) {
                    selectedTest = allTests[0];
                }

                // Start test session
                const response = await fetch('/api/diagnostic/start', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ testId: selectedTest.testId })
                });

                if (!response.ok) throw new Error('Failed to start test');

                const result = await response.json();
                sessionId = result.sessionId;

                // Load questions
                const questionsResponse = await fetch('/api/diagnostic/questions/' + selectedTest.testId);
                if (!questionsResponse.ok) throw new Error('Failed to load questions');

                questions = await questionsResponse.json();
                answers = new Array(questions.length).fill(null);

                // Show game container and lock mobile viewport
                document.getElementById('testSelection').classList.add('hidden');
                document.getElementById('questionContainer').classList.remove('hidden');
                document.body.classList.add('game-active'); // Prevent mobile scrolling
                updateProgress(50, 'Level 1 of ' + questions.length);

                // Show big game title at top
                const emoji = testEmojis[selectedTest.testId] || '📝';
                document.getElementById('gameTitle').classList.remove('hidden');
                document.getElementById('gameTitleEmoji').textContent = emoji;
                document.getElementById('gameTitleText').textContent = selectedTest.testName;

                // Save state
                savePageState();

                // Show first question
                showQuestion(0);
            } catch (error) {
                console.error('Error starting test:', error);
                alert('Failed to start test. Please try again.');
            }
        }

        // Show Game Moment (NOT a question)
        function showQuestion(index) {
            // Clear any existing timer when changing questions
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            currentQuestionIndex = index;
            const question = questions[index];

            // Update progress bar
            const progress = 50 + (((index + 1) / questions.length) * 50);
            updateProgress(progress, 'Level ' + (index + 1) + ' of ' + questions.length);

            // Reset navigation buttons immediately
            updateNavigationButtons();

            // Update game moment text (make it feel like a situation, not a question)
            const questionText = document.getElementById('questionText');
            questionText.textContent = question.questionText;
            questionText.style.opacity = '0';

            // Hide options initially
            const optionsContainer = document.getElementById('optionsContainer');
            optionsContainer.classList.remove('show');
            optionsContainer.innerHTML = '';

            // Disable countdown: hide instantly
            const countdownContainer = document.getElementById('countdownContainer');
            countdownContainer.style.display = 'none';

            // Show question text immediately
            questionText.style.transition = 'opacity 0.3s ease';
            questionText.style.opacity = '1';

            // Render action buttons immediately
            
            // Render action buttons
            question.options.forEach(option => {
                const optionDiv = document.createElement('div');
                optionDiv.className = 'option';
                optionDiv.dataset.value = option.optionValue;

                // Add emoji if option text doesn't have one
                const hasEmoji = /[\u{1F300}-\u{1F9FF}]/u.test(option.optionText);
                optionDiv.textContent = option.optionText;

                // Check if this option was previously selected
                if (answers[index] === option.optionValue) {
                    optionDiv.classList.add('selected');
                }

                optionDiv.addEventListener('click', function() {
                    selectOption(option.optionValue);
                });

                optionsContainer.appendChild(optionDiv);
            });

            // Show options with animation
            optionsContainer.classList.add('show');

            // Update progress dots and navigation buttons
            updateGameProgressDots();
            updateNavigationButtons();
        }

        // Select option - Instant Reaction
        function selectOption(value) {
            // Clear any existing timer
            if (autoAdvanceTimer) {
                clearTimeout(autoAdvanceTimer);
                autoAdvanceTimer = null;
            }

            // Save answer
            answers[currentQuestionIndex] = value;

            // Save state to localStorage
            savePageState();

            // Update UI - remove selected class from all first
            const options = document.querySelectorAll('.option');
            options.forEach(opt => {
                opt.classList.remove('selected');
                // Remove and re-add to restart animation
                void opt.offsetWidth; // Trigger reflow
            });

            // Add selected class to chosen option
            options.forEach(opt => {
                if (opt.dataset.value === value) {
                    opt.classList.add('selected');
                }
            });

            // Update navigation buttons after selection
            updateNavigationButtons();

            // Show green feedback briefly before advancing
            setTimeout(() => {
                if (currentQuestionIndex < questions.length - 1) {
                    showQuestion(currentQuestionIndex + 1);
                } else {
                    submitTest();
                }
            }, 400); // 400ms delay to show green selection
        }

        // Update Game Progress Dots (NOT question numbers)
        function updateGameProgressDots() {
            const progressMeter = document.getElementById('gameProgressMeter');
            if (!progressMeter) return;

            progressMeter.innerHTML = '';

            questions.forEach((q, index) => {
                const dot = document.createElement('div');
                dot.className = 'progress-dot';

                if (index < currentQuestionIndex) {
                    dot.classList.add('completed');
                } else if (index === currentQuestionIndex) {
                    dot.classList.add('current');
                }

                // Make dots clickable to navigate
                dot.addEventListener('click', () => {
                    if (answers[index] !== null) {
                        showQuestion(index);
                        updateNavigationButtons();
                    }
                });

                progressMeter.appendChild(dot);
            });

            // Update navigation buttons
            updateNavigationButtons();
        }

        // Update navigation button visibility
        function updateNavigationButtons() {
            // Previous button removed - no navigation needed
        }

        // Navigate to next question
        

        // Update progress
        function updateProgress(percentage, text) {
            document.getElementById('progressBar').style.width = percentage + '%';
            document.getElementById('progressText').textContent = text;
        }

        // Submit test
        async function submitTest() {
            // Validate all questions answered
            const unanswered = answers.filter(a => a === null).length;
            if (unanswered > 0) {
                alert('Please answer all questions. ' + unanswered + ' question(s) remaining.');
                return;
            }

            updateProgress(100, 'Processing results...');

            try {
                // Prepare answers in the format expected by the API
                const formattedAnswers = questions.map((q, index) => ({
                    questionId: q.questionId,
                    answerValue: answers[index],
                    timeSpent: 0
                }));

                const response = await fetch('/api/diagnostic/submit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        sessionId: sessionId,
                        answers: formattedAnswers
                    })
                });

                if (!response.ok) throw new Error('Failed to submit test');

                const result = await response.json();

                if (result.success) {
                    // Clear saved state before redirecting
                    clearPageState();
                    // Redirect to results page
                    window.location.href = '/diagnostic/result/' + sessionId;
                } else {
                    throw new Error(result.error || 'Failed to submit test');
                }
            } catch (error) {
                console.error('Error submitting test:', error);
                alert('Failed to submit test. Please try again.');

                // Restore UI
                document.getElementById('questionContainer').classList.remove('hidden');
                updateProgress(66, 'Question ' + (currentQuestionIndex + 1) + ' of ' + questions.length);
            }
        }
    </script>
</body>
</html>


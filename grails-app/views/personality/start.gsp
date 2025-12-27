<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Choose Your Game - learnerDNA</title>

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
        z-index: -100; /* keep background behind decorative layers */
        overflow: hidden;
        background: linear-gradient(180deg,
            #A8B5FF 0%,           /* Sky blue at top */
            #C5A8FF 20%,          /* Light purple */
            #E8B5FF 40%,          /* Lavender purple */
            #FFB8E8 60%,          /* Pink purple */
            #FFC4B8 80%,          /* Coral pink */
            #FFD8A8 100%          /* Soft peach/yellow at bottom */
        );
        pointer-events: none; /* safety: never block clicks */
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
        pointer-events: none; /* decorative only */
        overflow: hidden;
        z-index: 0; /* global background layer: above gradient, below content */
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
        pointer-events: none; /* never block interactions */
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
        z-index: 10; /* content above global background */
        min-height: 100vh;
        display: flex;
        align-items: stretch;
        justify-content: center;
        overflow-x: hidden;
        overflow-y: auto;
        padding-bottom: 80px; /* safe bottom spacing for gestures */
        background: transparent; /* remove any white background */
    }

    .mobile-container {
        background: transparent; /* ensure no white background */
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
        overflow-y: visible;
        overflow-x: hidden;
        display: flex;
        flex-direction: column;
        z-index: 10; /* ensure above backgrounds for clickability */
    }

    .mobile-container::before {
        display: none;
    }

    /* --- PROGRESS BAR - REMOVED --- */
    .progress-container {
        display: none !important; /* Completely hidden */
    }

    .progress-bar {
        display: none !important;
    }

    .progress-fill {
        display: none !important;
    }

    .progress-fill::after {
        display: none !important;
    }

    .progress-text {
        display: none !important;
    }

    /* --- STEP CONTAINERS --- */
    .step-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
        display: flex;
        flex-direction: column;
        position: relative;
        z-index: 20; /* ensure above background layers */
        padding: 40px 20px 0 20px; /* add breathable top gap under navbar */
        flex: 1;
        overflow-y: auto;
        min-height: 0;
        background: transparent; /* no white fill */
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

    /* --- TEST GRID - GAME LOBBY MODE CARDS --- */
    .test-grid {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 32px;
        margin-bottom: 12px;
        align-items: stretch;
    }

    /* Mode cards (tall portrait): hero top, divider band, text bottom */
    .test-card {
        position: relative;
        display: grid;
        grid-template-rows: 1fr 56px auto; /* hero | divider | text */
        grid-template-columns: 1fr;
        align-items: end;
        justify-items: center;
        width: 100%;
        min-height: 320px;
        padding: 16px 16px 18px 16px;
        border-radius: 20px;
        border: 0;
        cursor: pointer;
        overflow: hidden;
        color: #fff;
        background: linear-gradient(135deg, #8B7FE8, #FF74C8); /* default gradient */
        box-shadow: 0 18px 40px rgba(20, 12, 62, 0.30);
        transition: transform 0.35s var(--ease-elastic), box-shadow 0.35s var(--ease-elastic), outline-color 0.25s ease;
        isolation: isolate;
        z-index: 10; /* ensure clickable over backgrounds */
    }

    /* Per-card gradient accents using data-test-id */
    .test-card[data-test-id="SPIRIT_ANIMAL"] { background: linear-gradient(135deg, #7B5CFF, #FF64B4); }
    .test-card[data-test-id="COGNITIVE_RADAR"] { background: linear-gradient(135deg, #3A8DFF, #28E7FF); }
    .test-card[data-test-id="FOCUS_STAMINA"] { background: linear-gradient(135deg, #00C2A8, #6DFF8C); }
    .test-card[data-test-id="GUESSWORK_QUOTIENT"] { background: linear-gradient(135deg, #FF8A3D, #FFD24A); }
    .test-card[data-test-id="CURIOSITY_COMPASS"] { background: linear-gradient(135deg, #5C8EFF, #60F3EB); }
    .test-card[data-test-id="MODALITY_MAP"] { background: linear-gradient(135deg, #7E5BFF, #FF86E6); }
    .test-card[data-test-id="CHALLENGE_DRIVER"] { background: linear-gradient(135deg, #FF7043, #FFD54F); }
    .test-card[data-test-id="WORK_MODE"] { background: linear-gradient(135deg, #00BFA6, #76FF03); }
    .test-card[data-test-id="PATTERN_SNAPSHOT"] { background: linear-gradient(135deg, #5E35B1, #00E5FF); }

    .test-card::before {
        content: '';
        position: absolute;
        inset: 0;
        background: radial-gradient(1200px 400px at 80% 30%, rgba(255,255,255,0.18), transparent 50%),
                    radial-gradient(800px 300px at 20% 120%, rgba(255,255,255,0.12), transparent 60%);
        pointer-events: none;
        mix-blend-mode: soft-light;
        opacity: 0.9;
        z-index: 0;
    }

    .test-card:hover {
        transform: translateY(-6px) scale(1.02);
        box-shadow: 0 26px 60px rgba(20, 12, 62, 0.40);
    }

    .test-card:active {
        transform: translateY(0) scale(0.98);
        box-shadow: 0 12px 28px rgba(20, 12, 62, 0.30);
    }

    .test-card.selected {
        outline: 3px solid rgba(255, 255, 255, 0.75);
        transform: translateY(-2px) scale(1.015);
        box-shadow: 0 32px 70px rgba(20, 12, 62, 0.45);
    }

    /* Internal placement in portrait grid */
    .test-card h3, .test-card p { color: #fff; grid-row: 3; grid-column: 1; z-index: 1; text-align: center; }
    .test-start-btn { grid-row: 3; grid-column: 1; justify-self: center; }

    .test-icon {
        grid-row: 1;
        grid-column: 1;
        font-size: 5rem;
        line-height: 1;
        display: flex;
        align-items: flex-end;
        justify-content: center;
        transform: none;
        filter: drop-shadow(0 10px 22px rgba(0,0,0,0.25));
        z-index: 1;
        margin: 0;
        pointer-events: none;
    }

    /* Divider band between hero and text */
    .test-card::after {
        content: '';
        position: absolute;
        left: -10%;
        right: -10%;
        top: 55%;
        height: 56px;
        transform: translateY(-50%);
        background: linear-gradient(90deg, rgba(255,255,255,0.22), rgba(255,255,255,0.10));
        opacity: 0.35;
        filter: blur(6px);
        border-radius: 100px;
        z-index: 0;
    }

    .test-start-btn {
        margin-top: 16px;
        padding: 14px 22px;
        background: #FFD24A;
        color: #3a2e6e;
        border: 0;
        border-radius: 999px;
        font-weight: 900;
        font-size: 0.95rem;
        cursor: pointer;
        transition: transform 0.15s var(--ease-smooth), filter 0.2s ease, background 0.2s ease;
        font-family: inherit;
        width: fit-content;
        display: none;
        box-shadow: 0 8px 0 rgba(180, 134, 0, 0.55), 0 14px 30px rgba(0,0,0,0.25);
        text-transform: none;
        letter-spacing: 0.2px;
        position: relative;
        z-index: 1;
    }

    .test-start-btn:hover { transform: translateY(-2px); filter: brightness(0.97); }
    .test-start-btn:active { transform: translateY(1px) scale(0.98); }

    .test-card.selected .test-start-btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        animation: slideIn 0.35s ease-out;
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



    .test-card h3 {
        font-weight: 900;
        color: rgba(255, 255, 255, 0.98);
        margin: 10px 8px 6px 8px;
        font-size: 1.45rem;
        letter-spacing: -0.02em;
        line-height: 1.2;
        text-align: center;
    }

    .test-card p {
        color: rgba(255, 255, 255, 0.9);
        font-weight: 600;
        line-height: 1.6;
        margin: 0 10px 8px 10px;
        font-size: 0.95rem;
        text-align: center;
    }

    /* Force inline-styled meta line to be light on gradients */
    .test-card p[style] { color: rgba(255, 255, 255, 0.9) !important; }

    /* --- GAME MOMENT CONTAINER (NOT A QUESTION) --- */
    .question-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
        padding: 0 20px 0 20px;
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
        font-size: clamp(1.8 rem, 5vw, 2.8rem);
        font-weight: 900;
        color: var(--text-dark);
        margin: 0 0 30px 0;
        line-height: 1.25;
        text-align: center;
        letter-spacing: -0.03em;
        text-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        padding: 0 20px;
        flex-shrink: 0;
        font-family: "Plus Jakarta Sans";
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
        padding: 22px 28px;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        font-weight: 700;
        color: var(--text-dark);
        font-size: 1.3rem;
        text-align: center;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        min-height: 72px;
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
        margin: 0 0 40px 0;
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
        font-family: "Plus Jakarta Sans";
    }

    /* --- NAVIGATION ARROWS --- */
    .navigation-progress-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-start;
        gap: 8px;
        margin: 0 16px 20px 16px;
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
            grid-template-columns: repeat(3, 1fr);
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
            min-height: 300px;
            grid-template-rows: 1fr 48px auto;
        }

        .test-icon {
            font-size: 2.5rem;
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
            overflow-y: auto;
            overflow-x: hidden;
            min-height: 100vh;
        }

        .test-page {
            padding: 24px 0 0 0; /* breathing space under navbar on mobile */
            max-width: 100%;
            min-height: 100vh;
            overflow-y: auto;
            padding-bottom: 80px;
            background: transparent;
        }

        .mobile-container {
            padding: 0;
            margin: 0;
            border-radius: 0;
            width: 100%;
            max-width: 100%;
            border-width: 0;
            min-height: 100vh;
            overflow-y: visible;
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
            padding: 14px 12px 16px 12px;
            border-radius: 20px;
            border-width: 0;
            min-height: 220px;
            grid-template-columns: 1fr;
            grid-template-rows: 1fr 40px auto;
            align-items: end;
            padding-right: 12px;
        }

        .test-icon {
            position: static;
            font-size: 3rem;
            margin: 0;
            transform: none;
            justify-content: center;
        }

        .test-card h3 {
            font-size: 0.95rem;
            margin-bottom: 6px;
            line-height: 1.25;
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

        .test-start-btn {
            padding: 10px 14px;
            font-size: 0.85rem;
            margin-top: 10px;
            border-width: 0;
            width: auto;
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
            max-height: fit-content;
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
            font-size: 1.4rem;
            margin: 0 0 20px 0;
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
            padding: 18px 22px;
            font-size: 1.1rem;
            min-height: 64px;
            text-align: center;
            border-width: 2px;
            line-height: 1.3;
            font-family: "Plus Jakarta Sans";
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
            min-height: 100vh;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .test-page {
            padding: 0;
            min-height: 100vh;
            overflow-y: auto;
            padding-bottom: 80px;
        }

        .mobile-container {
            padding: 0;
            border-radius: 0;
            min-height: 100vh;
            overflow-y: visible;
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
            padding: 12px 10px 14px 10px;
            border-radius: 18px;
            min-height: 200px;
            grid-template-columns: 1fr;
            grid-template-rows: 1fr 36px auto;
            align-items: end;
            padding-right: 10px;
        }

        .test-icon {
            position: static;
            font-size: 2.6rem;
            margin: 0;
            transform: none;
            justify-content: center;
        }

        .test-card h3 {
            font-size: 0.9rem;
            margin-bottom: 6px;
            line-height: 1.2;
        }

        .test-card p {
            font-size: 0.75rem;
            margin-bottom: 4px;
            line-height: 1.4;
        }

        .test-card p:last-of-type {
            font-size: 0.7rem !important;
        }

        .test-start-btn {
            padding: 8px 12px;
            font-size: 0.8rem;
            margin-top: 8px;
            width: auto;
        }

        /* Extra compact for very small screens */
        .game-title-top {
            padding: 10px 12px 0 12px;
            margin: 0;
            background: transparent;
            margin-bottom: 20px;
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
            font-size: 2rem;
            padding: 0 8px;
            margin: 0 0 16px 0;
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
            padding: 16px 18px;
            font-size: 1rem;
            min-height: 58px;
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
    /* Subtle motion polish: parallax + reactive cards */
    .star-decorations { will-change: transform; }
    .test-card { will-change: transform; transform-style: preserve-3d; }

    /* Hover lift/tilt (desktop only). Keep very subtle. */
    @media (hover: hover) and (pointer: fine) {
        .test-card:hover {
            transform: translateY(-6px) scale(1.01) rotateX(0.5deg) rotateY(-0.5deg);
        }
    }

    /* Micro scroll translation on mobile to feel alive (1-2px). */
    @media (max-width: 768px) {
        .test-card {
            transition: transform 0.25s var(--ease-smooth), box-shadow 0.25s var(--ease-smooth);
        }
    }

    /* Reduced motion: disable extra transforms */
    @media (prefers-reduced-motion: reduce) {
        .star-decorations, .test-card { transition: none !important; transform: none !important; }
        .test-card:hover { transform: none !important; }
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
<div class="scenery-layer" style="pointer-events: none; z-index: -100;">
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

            <!-- Progress Bar - REMOVED -->
            <div class="progress-container" style="display: none;">
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
        // Motion polish: safe parallax for stars + reactive cards.
        (function() {
            const root = document.documentElement;
            const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
            if (prefersReduced) return; // Respect reduced motion

            let ticking = false;
            const starLayer = document.querySelector('.star-decorations');

            // Cache cards once. Use IntersectionObserver to apply micro-translation only when in view (mobile mostly)
            const cards = Array.from(document.querySelectorAll('.test-card'));

            // Parallax factors (very small). Stars move slower than content.
            const STAR_FACTOR = 0.06; // 6% of scroll offset

            // Mobile micro parallax factor for cards
            const CARD_FACTOR = window.innerWidth <= 768 ? 0.02 : 0; // up to ~1-2px depending on scroll

            function onScrollHandler() {
                if (ticking) return;
                window.requestAnimationFrame(applyMotion);
                ticking = true;
            }

            function applyMotion() {
                const y = window.scrollY || window.pageYOffset || 0;

                // Background star parallax (translateY only, GPU-friendly)
                if (starLayer) {
                    const starY = Math.round(y * STAR_FACTOR);
                    starLayer.style.transform = 'translate3d(0,' + starY + 'px,0)';
                }

                // Micro scroll translation for cards on mobile
                if (CARD_FACTOR > 0 && cards.length) {
                    const cardShift = Math.max(-2, Math.min(2, Math.round(y * CARD_FACTOR))); // clamp to [-2, 2] px
                    for (let i = 0; i < cards.length; i++) {
                        const c = cards[i];
                        // Keep existing hover transforms intact by composing translateZ(0) + translateY
                        c.style.transform = 'translate3d(0,' + cardShift + 'px,0)';
                    }
                }

                ticking = false;
            }

            // Lightweight scroll listener (passive)
            window.addEventListener('scroll', onScrollHandler, { passive: true });
            // Initial run
            applyMotion();

            // Cleanup on page hide (optional safety)
            document.addEventListener('visibilitychange', function() {
                if (document.hidden && starLayer) {
                    starLayer.style.transform = 'translate3d(0,0,0)';
                }
            }, { passive: true });
        })();

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

        // Test emoji mapping - using specific icons for each game
        const testEmojis = {
            'SPIRIT_ANIMAL': '🦉',  // Owl - one of the spirit animals
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


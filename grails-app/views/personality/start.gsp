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
        --card-white: #FFFFFF;

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
        background: transparent !important;
        background-color: transparent !important;
        min-height: 100svh;
        overflow-x: hidden;
        -webkit-font-smoothing: antialiased;
    }

    html {
        background: transparent !important;
        background-color: transparent !important;
    }

    .test-page,
    .mobile-container,
    .step-container,
    .question-container,
    .game-play-area,
    .game-action-zone,
    .game-choice-zone {
        background: transparent !important;
        background-color: transparent !important;
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
        min-height: 100svh;
        display: flex;
        align-items: stretch;
        justify-content: center;
        overflow-x: hidden;
        overflow-y: auto;
        padding-top: max(env(safe-area-inset-top), clamp(12px, 2.4svh, 22px));
        padding-bottom: calc(max(env(safe-area-inset-bottom), 0px) + clamp(14px, 2.8svh, 28px));
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
        min-height: 100svh;
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
        padding: clamp(16px, 3.5svh, 32px) 20px 0 20px; /* responsive top gap under navbar */
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

    /* --- TEST GRID - 3x3 GAME GRID --- */
    .test-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 36px;
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 40px;
    }

    /* GAME CARD - Trading Card Style with 3D Effects */
    .test-card {
        position: relative;
        min-height: 420px;
        padding: 0;
        background: linear-gradient(135deg, #ffffff 0%, #f8f8ff 100%);
        border-radius: 20px;
        cursor: pointer;
        transform-style: preserve-3d;
        transition: all 0.4s var(--ease-elastic);
        box-shadow:
                0 10px 30px rgba(0, 0, 0, 0.15),
                inset 0 1px 0 rgba(255, 255, 255, 0.8);
        border: 3px solid rgba(255, 255, 255, 0.5);
        overflow: hidden;
    }

    /* Holographic Foil Effect */
    .test-card::before {
        content: '';
        position: absolute;
        inset: 0;
        background: linear-gradient(
                125deg,
                transparent 0%,
                rgba(255, 255, 255, 0.4) 20%,
                transparent 40%,
                rgba(139, 127, 232, 0.2) 60%,
                transparent 80%
        );
        opacity: 0;
        transition: opacity 0.4s ease;
        pointer-events: none;
        z-index: 5;
    }

    .test-card:hover::before {
        opacity: 1;
        animation: shimmer 2s linear infinite;
    }

    @keyframes shimmer {
        0% {
            transform: translateX(-100%) rotate(45deg);
        }
        100% {
            transform: translateX(200%) rotate(45deg);
        }
    }

    /* Card Border Glow */
    .test-card::after {
        content: '';
        position: absolute;
        inset: -3px;
        background: linear-gradient(45deg,
        #FF6B9D, #C239B3, #8B7FE8, #5FE3D0,
        #FFE17B, #FF9AB8, #C239B3, #8B7FE8
        );
        border-radius: 20px;
        opacity: 0;
        z-index: -1;
        transition: opacity 0.3s ease;
        filter: blur(10px);
        animation: rotate-gradient 3s linear infinite;
        background-size: 200% 200%;
    }

    @keyframes rotate-gradient {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    .test-card:hover::after {
        opacity: 0.6;
    }

    .test-card:hover {
        transform: translateY(-15px) scale(1.05) rotateX(5deg);
        box-shadow:
                0 25px 60px rgba(139, 127, 232, 0.4),
                0 0 40px rgba(139, 127, 232, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 1);
    }

    .test-card:active {
        transform: translateY(-10px) scale(1.02);
    }

    /* Selected State - Epic Glow */
    .test-card.selected {
        transform: translateY(-20px) scale(1.08);
        border-color: #8B7FE8;
        box-shadow:
                0 30px 70px rgba(139, 127, 232, 0.6),
                0 0 60px rgba(139, 127, 232, 0.5),
                inset 0 0 30px rgba(139, 127, 232, 0.2);
        animation: pulse-glow 2s ease-in-out infinite;
    }

    @keyframes pulse-glow {
        0%, 100% {
            box-shadow:
                    0 30px 70px rgba(139, 127, 232, 0.6),
                    0 0 60px rgba(139, 127, 232, 0.5),
                    inset 0 0 30px rgba(139, 127, 232, 0.2);
        }
        50% {
            box-shadow:
                    0 35px 80px rgba(139, 127, 232, 0.8),
                    0 0 80px rgba(139, 127, 232, 0.7),
                    inset 0 0 40px rgba(139, 127, 232, 0.3);
        }
    }


    /* Icon with floating animation */
    .test-icon {
        font-size: 4.5rem;
        filter: drop-shadow(0 8px 16px rgba(0, 0, 0, 0.3));
        animation: float-icon 3s ease-in-out infinite;
        position: relative;
        z-index: 3;
        line-height: 1;
        display: block;
    }

    @keyframes float-icon {
        0%, 100% { transform: translateY(0px) rotate(-5deg); }
        50% { transform: translateY(-10px) rotate(5deg); }
    }

    .test-card:hover .test-icon {
        animation: bounce-icon 0.6s ease-in-out infinite;
    }

    @keyframes bounce-icon {
        0%, 100% { transform: translateY(0px) scale(1); }
        50% { transform: translateY(-15px) scale(1.1); }
    }

    .test-start-btn {
        display: none; /* Hidden by default, shown when selected */
        align-items: center;
        justify-content: center;
        gap: 12px;
        padding: 14px 28px;
        margin-top: 10px;
        position: relative;
        z-index: 10;

        /* Shape & Border */
        border-radius: 25px;
        border: 4px solid rgba(255, 255, 255, 0.5);

        /* Color & Gradient */
        background: linear-gradient(135deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
        color: #2D2A45;

        /* Typography */
        font-family: inherit;
        font-weight: 800;
        font-size: 1.1rem;
        text-transform: uppercase;
        letter-spacing: 0.02em;
        text-shadow: 0 1px 2px rgba(255, 255, 255, 0.5);
        text-decoration: none;

        /* 3D Shadows */
        box-shadow:
                0 6px 0 #3ABFA8,
                0 12px 24px rgba(95, 227, 208, 0.4),
                inset 0 2px 0 rgba(255, 255, 255, 0.4);

        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        overflow: hidden;
    }

    /* Selected State - Reveal Animation */
    .test-card.selected .test-start-btn {
        display: inline-flex;
        animation: pop-in 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
    }

    @keyframes pop-in {
        0% {
            opacity: 0;
            transform: scale(0.5) translateY(20px);
        }
        70% {
            transform: scale(1.1) translateY(-5px);
        }
        100% {
            opacity: 1;
            transform: scale(1) translateY(0);
        }
    }

    /* Hover State - Lift Up */
    .test-start-btn:hover {
        transform: translateY(-4px) scale(1.02);
        filter: brightness(1.02);
        box-shadow:
                0 10px 0 #3ABFA8,
                0 16px 32px rgba(95, 227, 208, 0.5),
                inset 0 2px 0 rgba(255, 255, 255, 0.6);
    }

    /* Active State - Press Down */
    .test-start-btn:active {
        transform: translateY(2px) scale(0.98);
        box-shadow:
                0 2px 0 #3ABFA8,
                0 6px 12px rgba(95, 227, 208, 0.4),
                inset 0 1px 0 rgba(255, 255, 255, 0.4);
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
        font-size: 1.4rem;
        font-weight: 800;
        color: var(--text-dark);
        text-align: center;
        margin-bottom: 10px;
        line-height: 1.2;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    .test-card p {
        font-size: 0.9rem;
        color: var(--text-grey);
        text-align: center;
        line-height: 1.5;
        margin-bottom: 10px;
    }

    .test-card p:last-of-type {
        font-size: 0.85rem;
        color: #A0A0B0;
        font-weight: 600;
        text-align: center;
        padding: 8px 16px;
        background: rgba(139, 127, 232, 0.1);
        border-radius: 20px;
        backdrop-filter: blur(10px);
        margin-top: 10px;
    }

    /* Card Header - Color Band */
    .card-header {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 120px;
        background: linear-gradient(135deg, #8B7FE8 0%, #C239B3 100%);
        clip-path: polygon(0 0, 100% 0, 100% 85%, 0 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 2;
    }

    /* Different colors for each card type */
    .test-card[data-test-id="SPIRIT_ANIMAL"] .card-header {
        background: linear-gradient(135deg, #7B5CFF 0%, #FF64B4 100%);
    }
    .test-card[data-test-id="CHALLENGE_DRIVER"] .card-header {
        background: linear-gradient(135deg, #FF7043 0%, #FFD54F 100%);
    }
    .test-card[data-test-id="COGNITIVE_RADAR"] .card-header {
        background: linear-gradient(135deg, #3A8DFF 0%, #28E7FF 100%);
    }
    .test-card[data-test-id="CURIOSITY_COMPASS"] .card-header {
        background: linear-gradient(135deg, #5C8EFF 0%, #60F3EB 100%);
    }
    .test-card[data-test-id="FOCUS_STAMINA"] .card-header {
        background: linear-gradient(135deg, #00C2A8 0%, #6DFF8C 100%);
    }
    .test-card[data-test-id="GUESSWORK_QUOTIENT"] .card-header {
        background: linear-gradient(135deg, #FF8A3D 0%, #FFD24A 100%);
    }
    .test-card[data-test-id="MODALITY_MAP"] .card-header {
        background: linear-gradient(135deg, #7E5BFF 0%, #FF86E6 100%);
    }
    .test-card[data-test-id="WORK_MODE"] .card-header {
        background: linear-gradient(135deg, #00BFA6 0%, #76FF03 100%);
    }
    .test-card[data-test-id="PATTERN_SNAPSHOT"] .card-header {
        background: linear-gradient(135deg, #5E35B1 0%, #00E5FF 100%);
    }

    /* Card Body */
    .card-body {
        position: absolute;
        top: 110px;
        left: 0;
        right: 0;
        bottom: 0;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-between;
        z-index: 1;
    }

    /* --- GAME MOMENT CONTAINER (NOT A QUESTION) --- */
    .question-container {
        opacity: 1;
        transform: translateY(0);
        transition: all 0.5s var(--ease-smooth);
        padding: 0 20px 0 20px;
        flex: 1;
        min-height: 100svh;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        gap: 0;
    }

    /* Split-screen layout: fixed game zone + flexible scrollable options zone */
    .game-play-area {
        flex: 1 1 auto;
        min-height: 0;
        display: flex;
        flex-direction: column;
        --zone-gap: clamp(10px, 2.0svh, 18px);
        --options-gap: clamp(10px, 1.6svh, 16px);
    }

    .game-play-area.few-options {
        --zone-gap: clamp(14px, 2.4svh, 26px);
        --options-gap: clamp(14px, 2.2svh, 22px);
    }

    .game-play-area.many-options {
        --zone-gap: clamp(8px, 1.4svh, 14px);
        --options-gap: clamp(8px, 1.2svh, 12px);
    }

    .game-fixed-zone {
        flex: 0 0 auto;
        min-height: 0;
        max-height: clamp(260px, 55svh, 560px);
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        align-items: center;
        padding: clamp(10px, 2.2svh, 22px) 0;
        overflow: hidden;
    }

    .game-options-zone {
        flex: 1 1 auto;
        min-height: 0;
        display: flex;
        flex-direction: column;
        align-items: stretch;
        justify-content: flex-start;
        gap: var(--zone-gap);
        padding-top: var(--zone-gap);
        padding-bottom: max(env(safe-area-inset-bottom), 0px);
        overflow-y: auto;
        -webkit-overflow-scrolling: touch;
        overscroll-behavior: contain;
    }

    /* --- COMPACT MODE (SMALL VIEWPORT HEIGHT) --- */
    @media (max-height: 700px) {
        /* CRITICAL SMALL SCREEN FIX - 2x2 GRID FOR 4 OPTIONS */
        @supports selector(:has(*)) {
            /* Exactly 4 options on short screens: 2×2 grid for readability */
            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) {
                display: grid !important;
                grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
                grid-auto-rows: auto !important;
                column-gap: clamp(8px, 2.0vw, 12px) !important;
                row-gap: clamp(8px, 2.0vw, 12px) !important;
                align-items: stretch !important;
                padding: 0 clamp(8px, 2.6vw, 14px) !important;
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option {
                padding: clamp(12px, 1.8svh, 16px) clamp(10px, 3.0vw, 14px) !important;
                min-height: 48px !important;
                font-size: clamp(0.95rem, 3.2vw, 1.1rem) !important;
                align-items: center !important;
                gap: 10px !important;
                text-align: left !important;
                word-break: normal !important;
                overflow-wrap: normal !important;
                hyphens: auto !important;
                display: flex !important;
                justify-content: flex-start !important;
                flex-direction: row !important;
            }

            /* ONE EMOJI ONLY - Proper size for readability */
            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-icon {
                width: 36px !important;
                height: 36px !important;
                border-radius: 14px !important;
                font-size: 1.1rem !important;
                opacity: 0.8 !important;
                box-shadow: 0 6px 16px rgba(139, 127, 232, 0.08) !important;
                flex-shrink: 0 !important;
                margin: 0 !important;
            }

            /* READABLE TEXT - Multi-line if needed */
            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-label {
                white-space: normal !important;
                word-break: normal !important;
                overflow-wrap: normal !important;
                line-height: 1.2 !important;
                display: -webkit-box !important;
                -webkit-box-orient: vertical !important;
                -webkit-line-clamp: 2 !important;
                overflow: hidden !important;
                flex-grow: 1 !important;
                min-width: 0 !important;
                font-size: clamp(0.9rem, 3.0vw, 1.05rem) !important;
                font-weight: 700 !important;
                text-align: left !important;
            }

            /* HIDE SECONDARY TEXT - "Tap to lock in" */
            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-sub {
                display: none !important;
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-copy {
                min-width: 0 !important;
                flex-grow: 1 !important;
                display: flex !important;
                align-items: center !important;
                overflow: hidden !important;
                flex-direction: row !important;
            }

            /* For 5+ options: Horizontal scroll with readable sizing */
            .options-container:has(.option:nth-child(5)) {
                display: flex !important;
                flex-direction: row !important;
                gap: clamp(6px, 1.5vw, 10px) !important;
                padding: 0 clamp(8px, 2.6vw, 14px) !important;
                align-items: stretch !important;
                overflow-x: auto !important;
                -webkit-overflow-scrolling: touch !important;
            }

            .options-container:has(.option:nth-child(5)) .option {
                flex: 0 0 auto !important;
                min-width: clamp(90px, 24vw, 110px) !important;
                max-width: clamp(120px, 32vw, 140px) !important;
                padding: clamp(10px, 1.5svh, 14px) clamp(8px, 2.0vw, 12px) !important;
                min-height: 48px !important;
                font-size: clamp(0.85rem, 2.8vw, 0.95rem) !important;
                align-items: center !important;
                gap: 6px !important;
                text-align: center !important;
                display: flex !important;
                justify-content: center !important;
                flex-direction: column !important;
            }

            .options-container:has(.option:nth-child(5)) .option-icon {
                width: 28px !important;
                height: 28px !important;
                border-radius: 10px !important;
                font-size: 0.9rem !important;
                opacity: 0.8 !important;
                box-shadow: 0 4px 12px rgba(139, 127, 232, 0.06) !important;
                flex-shrink: 0 !important;
                margin: 0 0 3px 0 !important;
            }

            .options-container:has(.option:nth-child(5)) .option-label {
                white-space: nowrap !important;
                line-height: 1.1 !important;
                display: block !important;
                overflow: hidden !important;
                text-overflow: clip !important;
                font-size: clamp(0.8rem, 2.6vw, 0.9rem) !important;
                font-weight: 700 !important;
                text-align: center !important;
            }

            .options-container:has(.option:nth-child(5)) .option-sub {
                display: none !important;
            }

            .options-container:has(.option:nth-child(5)) .option-copy {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                overflow: hidden !important;
                flex-direction: column !important;
            }
        }
        .game-play-area {
            --zone-gap: clamp(6px, 1.2svh, 10px);
            --options-gap: clamp(6px, 1.0svh, 10px);
        }

        .game-fixed-zone {
            max-height: clamp(200px, 48svh, 420px);
            padding: clamp(6px, 1.4svh, 12px) 0;
        }

        .challenge-card {
            padding: clamp(12px, 1.8svh, 18px) clamp(12px, 3.6vw, 18px) clamp(10px, 1.4svh, 14px) clamp(12px, 3.6vw, 18px);
        }

        .challenge-topline {
            margin-bottom: clamp(6px, 1.0svh, 8px);
        }

        .challenge-badge {
            padding: 6px 10px;
            font-size: 0.7rem;
        }

        .challenge-hint {
            font-size: 0.72rem;
        }

        .question-text {
            font-size: clamp(1.05rem, 3.4vw, 1.25rem);
            line-height: 1.22;
            padding: 0 10px;
        }

        .countdown-container {
            min-height: 52px;
            margin: 0 0 clamp(8px, 1.4svh, 12px) 0;
        }

        .game-options-zone {
            padding-top: var(--zone-gap);
            overflow-y: hidden;
            -webkit-overflow-scrolling: auto;
            overscroll-behavior: none;
        }

        .options-container {
            gap: var(--options-gap);
            padding: 0 clamp(8px, 2.6vw, 14px);
        }

        @supports selector(:has(*)) {
            /* OLD GRID RULES REMOVED - Using horizontal row layout above */
        }

        .option {
            padding: clamp(10px, 1.6svh, 14px) clamp(12px, 3.6vw, 16px);
            font-size: clamp(0.98rem, 3.2vw, 1.08rem);
            min-height: 44px;
            line-height: 1.15;
        }

        .option-label {
            font-size: clamp(0.98rem, 3.1vw, 1.05rem);
            line-height: 1.1;
        }

        .option-sub {
            margin-top: 4px;
            font-size: clamp(0.74rem, 2.6vw, 0.82rem);
            line-height: 1.1;
        }
    }

    @media (max-height: 620px) {
        .game-play-area {
            --zone-gap: clamp(5px, 1.0svh, 8px);
            --options-gap: clamp(5px, 0.9svh, 8px);
        }

        .game-fixed-zone {
            max-height: clamp(180px, 44svh, 360px);
        }

        .question-text {
            font-size: clamp(1.0rem, 3.2vw, 1.18rem);
        }

        .option {
            padding: clamp(9px, 1.4svh, 12px) clamp(12px, 3.6vw, 16px);
            min-height: 44px;
        }
    }

    /* --- VERY SMALL SCREENS: HORIZONTAL BARS FOR 4 OPTIONS --- */
    @media (max-height: 580px) {
        @supports selector(:has(*)) {
            /* Exactly 4 options on very short screens: full-width horizontal bars */
            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) {
                display: flex;
                flex-direction: column;
                gap: var(--options-gap);
                padding: 0 clamp(8px, 2.6vw, 14px);
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option {
                padding: clamp(8px, 1.2svh, 10px) clamp(10px, 3.0vw, 14px);
                min-height: 44px;
                font-size: clamp(0.95rem, 3.2vw, 1.05rem);
                align-items: center;
                gap: 10px;
                text-align: left;
                word-break: normal;
                overflow-wrap: normal;
                hyphens: auto;
                width: 100%;
                flex-shrink: 0;
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-icon {
                width: 32px;
                height: 32px;
                border-radius: 12px;
                font-size: 1rem;
                opacity: 0.7;
                box-shadow: 0 4px 12px rgba(139, 127, 232, 0.06);
                flex-shrink: 0;
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-label {
                white-space: nowrap;
                word-break: normal;
                overflow-wrap: normal;
                line-height: 1.15;
                display: block;
                overflow: visible;
                flex-grow: 1;
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-sub {
                display: none;
            }

            .options-container:has(.option:nth-child(4)):not(:has(.option:nth-child(5))) .option-copy {
                min-width: 0;
                flex-grow: 1;
            }
        }
    }

    .game-action-top-spacer,
    .game-action-bottom-spacer {
        flex: 1 1 auto;
        min-height: clamp(10px, 2.2svh, 22px);
    }

    .game-action-bottom-spacer {
        flex: 0.65 1 auto;
        min-height: clamp(6px, 1.6svh, 16px);
    }

    /* Game-first play area framing */
    .game-action-zone {
        flex: 0 0 auto;
        min-height: 0;
        width: 100%;
    }

    .game-choice-zone {
        flex: 1 1 auto;
        min-height: 0;
        width: 100%;
    }

    .question-container.hidden {
        display: none;
    }

    /* Game Moment Screen - Centered, Short Context */
    .question-text {
        font-size: clamp(1.8rem, 5vw, 2.8rem);
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
        gap: var(--options-gap, 16px);
        margin: 0;
        opacity: 1; /* Always visible by default */
        transform: translateY(0); /* No transform by default */
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

    /* Fallback: Ensure options are always visible */
    .options-container:not(.show) {
        opacity: 1 !important;
        transform: translateY(0) !important;
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

    .progress-dot {
        position: relative;
    }

    .progress-dot::after {
        content: '';
        position: absolute;
        inset: -10px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(139, 127, 232, 0.15) 0%, transparent 70%);
        opacity: 0;
        transition: opacity 0.3s ease;
        pointer-events: none;
    }

    .progress-dot.completed::after {
        background: radial-gradient(circle, rgba(95, 227, 208, 0.3) 0%, transparent 70%);
        opacity: 0.9;
    }

    .progress-dot.current::after {
        background: radial-gradient(circle, rgba(255, 225, 123, 0.3) 0%, transparent 70%);
        opacity: 1;
        animation: dotAura 1.5s ease-in-out infinite;
    }

    @keyframes dotAura {
        0%, 100% { transform: scale(0.9); opacity: 0.8; }
        50% { transform: scale(1.05); opacity: 1; }
    }

    @keyframes currentDotPulse {
        0%, 100% { transform: scale(1.4); opacity: 1; }
        50% { transform: scale(1.6); opacity: 0.8; }
    }

    /* --- BIG GAME TITLE AT TOP --- */
    .game-title-top {
        position: sticky;
        top: 0;
        z-index: 30;
        text-align: center;
        padding: 10px 14px; /* slightly smaller height */
        margin: 0 auto 22px auto; /* breathing room below HUD */
        background: rgba(255, 255, 255, 0.46); /* softer, lighter */
        border-radius: 22px;
        box-shadow: var(--shadow-soft);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border: 2px solid rgba(139, 127, 232, 0.18);
        flex-shrink: 0;
        max-width: 760px;
    }

    .hud-row {
        display: grid;
        grid-template-columns: auto 1fr;
        gap: 12px;
        align-items: center;
        max-width: 680px;
        margin: 0 auto;
    }

    .hud-avatar {
        width: 44px;
        height: 44px;
        border-radius: 16px;
        display: grid;
        place-items: center;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.85) 0%, rgba(255, 255, 255, 0.6) 100%);
        border: 2px solid rgba(139, 127, 232, 0.18);
        box-shadow: 0 8px 20px rgba(139, 127, 232, 0.10);
    }

    .hud-stack {
        display: flex;
        flex-direction: column;
        gap: 8px;
        min-width: 0;
    }

    .hud-topline {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
    }

    .hud-level {
        font-size: 0.9rem;
        font-weight: 900;
        color: var(--text-dark);
        text-transform: uppercase;
        letter-spacing: 0.08em;
        white-space: nowrap;
    }

    .hud-title {
        font-size: 0.95rem;
        font-weight: 900;
        color: var(--text-dark);
        text-align: right;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .hud-xp-bar {
        height: 10px;
        width: 100%;
        border-radius: 999px;
        background: rgba(255, 255, 255, 0.4);
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .hud-xp-fill {
        height: 100%;
        width: 35%;
        background: linear-gradient(90deg, #5FE3D0 0%, #7FDBDA 50%, #A0E7E5 100%);
        border-radius: 999px;
        box-shadow: 0 0 20px rgba(95, 227, 208, 0.3);
        transition: width 0.4s var(--ease-smooth);
    }

    .hud-xp-sub {
        font-size: 0.75rem;
        font-weight: 800;
        color: var(--text-grey);
        text-align: left;
        letter-spacing: 0.04em;
        text-transform: uppercase;
    }

    .game-title-emoji {
        font-size: 1.6rem;
        margin-bottom: 0;
        line-height: 1;
        animation: float-gentle 3s ease-in-out infinite;
    }

    @keyframes float-gentle {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-8px); }
    }

    .game-title-text {
        font-size: 1rem;
        font-weight: 900;
        color: var(--text-dark);
        margin: 0;
        line-height: 1.1;
        font-family: "Plus Jakarta Sans";
    }

    .challenge-card {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.85) 0%, rgba(255, 255, 255, 0.6) 100%);
        border-radius: 26px;
        border: 3px solid rgba(139, 127, 232, 0.25);
        box-shadow:
            0 14px 28px -14px rgba(45, 42, 69, 0.22),
            0 10px 22px -16px rgba(139, 127, 232, 0.28),
            inset 0 1px 0 rgba(255, 255, 255, 0.75);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        padding: clamp(18px, 2.6svh, 26px) clamp(16px, 4.2vw, 22px) clamp(14px, 2.2svh, 20px) clamp(16px, 4.2vw, 22px);
        margin: 0 auto 0 auto; /* spacing handled by zones for cleaner rhythm */
        max-width: 720px;
        width: 100%;
        position: relative;
        overflow: hidden;
        transform: translateZ(0);
        transition: transform 200ms ease-out, box-shadow 200ms ease-out;
    }

    .challenge-card:active {
        transform: translateY(1px) scale(0.995);
        box-shadow:
            0 10px 20px -14px rgba(45, 42, 69, 0.2),
            0 8px 18px -16px rgba(139, 127, 232, 0.26),
            inset 0 1px 0 rgba(255, 255, 255, 0.7);
    }

    .challenge-card::before {
        content: '';
        position: absolute;
        inset: 0;
        background: linear-gradient(135deg, rgba(139, 127, 232, 0.05) 0%, rgba(95, 227, 208, 0.05) 100%);
        opacity: 1;
        pointer-events: none;
    }

    .challenge-topline {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        position: relative;
        z-index: 2;
        margin-bottom: 10px;
    }

    .challenge-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 7px 12px;
        border-radius: 999px;
        font-size: 0.75rem;
        font-weight: 900;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        color: var(--text-dark);
        background: rgba(255, 255, 255, 0.6);
        border: 2px solid rgba(139, 127, 232, 0.25);
        box-shadow: 0 8px 24px rgba(139, 127, 232, 0.15);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
    }

    .challenge-hint {
        font-size: 0.8rem;
        font-weight: 800;
        color: var(--text-grey);
        text-transform: uppercase;
        letter-spacing: 0.08em;
        white-space: nowrap;
    }

    .challenge-card .question-text {
        position: relative;
        z-index: 2;
        margin: 0;
        padding: 0 6px 6px 6px;
    }

    .option {
        text-align: left;
        justify-content: flex-start;
        gap: 14px;
        padding: 18px 20px;
        transition: transform 200ms ease-out, box-shadow 200ms ease-out, border-color 200ms ease-out, filter 200ms ease-out;
        box-shadow:
            0 12px 22px -16px rgba(45, 42, 69, 0.18),
            0 10px 22px -18px rgba(139, 127, 232, 0.22),
            inset 0 1px 0 rgba(255, 255, 255, 0.65);
    }

    .option:active {
        transform: translateY(-2px) scale(0.995);
        box-shadow:
            0 10px 18px -16px rgba(45, 42, 69, 0.16),
            0 8px 18px -18px rgba(139, 127, 232, 0.2),
            inset 0 1px 0 rgba(255, 255, 255, 0.55);
    }

    .option-icon {
        width: 44px;
        height: 44px;
        border-radius: 18px;
        display: grid;
        place-items: center;
        font-size: 1.4rem;
        flex: 0 0 auto;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.85) 0%, rgba(255, 255, 255, 0.6) 100%);
        border: 2px solid rgba(139, 127, 232, 0.25);
        box-shadow: 0 8px 24px rgba(139, 127, 232, 0.15);
    }

    .option-label {
        display: block;
        font-size: 1.15rem;
        font-weight: 900;
        color: var(--text-dark);
        line-height: 1.2;
    }

    .option-copy {
        display: block;
        min-width: 0;
    }

    .option-sub {
        display: block;
        margin-top: 6px;
        font-size: 0.85rem;
        font-weight: 800;
        color: var(--text-grey);
        line-height: 1.2;
    }

    .option.selected .option-label,
    .option.selected .option-sub {
        color: var(--text-white);
        text-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    }

    .option.selected .option-icon {
        background: rgba(255, 255, 255, 0.25);
        border-color: rgba(255, 255, 255, 0.5);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
    }

    .option.just-selected {
        animation: optionPop 0.4s var(--ease-elastic);
    }

    @keyframes optionPop {
        0% { transform: translateY(-2px) scale(1.01); }
        60% { transform: translateY(-10px) scale(1.03); }
        100% { transform: translateY(-4px) scale(1.02); }
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
            max-width: 100%;
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
            gap: 16px;
            padding: 0 12px;
        }
        .card-header {
            height: 100px;
        }

        .card-body {
            top: 90px;
            padding: 16px;
        }

        .test-card {
            padding: 20px 16px;
            border-radius: 16px;
            min-height: 240px;
        }

        .test-card:hover {
            transform: translateY(-10px) scale(1.03);
        }

        .test-icon {
            font-size: 3.5rem;
        }

        .test-card h3 {
            font-size: 1.1rem;
        }

        .test-card p {
            font-size: 0.85rem;
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
            padding: 12px 12px;
            margin: 0 12px 12px 12px;
            border-radius: 22px;
            background: rgba(255, 255, 255, 0.6);
            border: 2px solid rgba(139, 127, 232, 0.25);
            box-shadow: var(--shadow-soft);
        }

        .hud-row {
            max-width: 680px;
        }

        .game-title-emoji {
            font-size: 1.5rem;
            margin-bottom: 0;
        }

        .game-title-text {
            font-size: 0.95rem;
            line-height: 1.1;
            font-weight: 900;
        }

        /* Question Container - Keep viewport-based flow (avoid fit-content on tall phones) */
        #questionContainer {
            padding: 12px 16px 0 16px;
            flex: 1;
            min-height: 0;
            overflow-y: hidden;
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
            min-height: 100svh;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .test-page {
            padding: 0;
            min-height: 100svh;
            overflow-y: auto;
            padding-bottom: 80px;
        }

        .mobile-container {
            padding: 0;
            border-radius: 0;
            min-height: 100svh;
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
            padding: 0 10px;
        }

        .test-card {
            padding: 16px 12px;
            border-radius: 14px;
            min-height: 220px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
        }

        .test-icon {
            font-size: 3rem;
            margin-bottom: 10px;
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
            padding: 10px 10px;
            margin: 0 10px 10px 10px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 22px;
            border: 2px solid rgba(139, 127, 232, 0.25);
            box-shadow: var(--shadow-soft);
        }

        .game-title-emoji {
            font-size: 1.4rem;
            margin-bottom: 0;
        }

        .game-title-text {
            font-size: 0.9rem;
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
    .sparkle {
        position: absolute;
        font-size: 1.5rem;
        opacity: 0;
        animation: sparkle 3s ease-in-out infinite;
    }

    .sparkle-1 { top: 15%; left: 25%; animation-delay: 0s; }
    .sparkle-2 { top: 45%; right: 20%; animation-delay: 1s; }
    .sparkle-3 { bottom: 30%; left: 35%; animation-delay: 2s; }
    .sparkle-4 { top: 70%; right: 30%; animation-delay: 1.5s; }

    @keyframes sparkle {
        0%, 100% { opacity: 0; transform: scale(0.5) rotate(0deg); }
        50% { opacity: 0.3; transform: scale(1) rotate(180deg); }
    }
    @media (min-width: 1024px) {
        .test-icon {
            font-size: 5.5rem;
        }

        .test-card h3 {
            font-size: 1.5rem;
        }

        .test-card p {
            font-size: 1rem;
        }
    }
    @media (max-width: 768px) {
        .test-grid {
            grid-template-columns: repeat(2, minmax(160px, 1fr));
            gap: 14px;
            padding: 0 12px;
        }

        .test-card {
            min-height: 240px;
            padding: 14px 12px;
            border-radius: 16px;
        }

        .card-body {
            justify-content: flex-start;
            gap: 10px;
        }

        .test-icon {
            font-size: 2.6rem;
        }

        .test-card h3 {
            font-size: 1rem;
            line-height: 1.2;
        }

        .test-card p {
            font-size: 0.8rem;
            line-height: 1.4;
        }
    }
    /* --- MOBILE LAYOUT FIX --- */
    @media (max-width: 768px) {
        /* 1. Make the card a Flex container so it grows vertically */
        .test-card {
            display: flex !important;
            flex-direction: column !important;
            height: auto !important; /* Auto height to fit content */
            min-height: 240px;
            padding: 0 !important;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        /* 2. Header sits naturally at the top */
        .card-header {
            position: relative !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100px !important;
            flex-shrink: 0; /* Prevent header from shrinking */
            border-radius: 16px 16px 0 0;
        }

        /* 3. Body sits naturally below header (No absolute positioning) */
        .card-body {
            position: relative !important;
            top: auto !important;
            bottom: auto !important;
            left: auto !important;
            right: auto !important;
            padding: 15px 20px 20px 20px !important;
            height: auto !important;

            /* Flex setup to center content */
            display: flex !important;
            flex-direction: column !important;
            align-items: center;

            /* Pull body up slightly to tuck under the angled header (optional) */
            margin-top: -15px;
            background: transparent;
            z-index: 5;
        }

        /* 4. Button is HIDDEN by default */
        .test-start-btn {
            display: none;
            width: 100% !important;
            margin-top: 15px;
            padding: 12px;
            animation: none; /* Reset desktop animations */
        }

        /* 5. Button appears ONLY when card has 'selected' class */
        .test-card.selected .test-start-btn {
            display: block !important; /* Make it take up space */
            animation: expandIn 0.3s ease-out forwards;
        }

        /* Simple animation for the button appearing */
        @keyframes expandIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    }

    /* Featured full-width card wrapper (uses existing card styles) */
    .featured-container .test-card {
        grid-column: 1 / -1;
        width: 100%;
        min-height: 420px;
    }

    .featured-badges {
        position: absolute;
        top: 10px;
        left: 10px;
        right: 10px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        z-index: 6;
        pointer-events: none;
        padding: 0 6px;
    }

    .badge-subtle {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 10px;
        border-radius: 14px;
        font-size: 0.8rem;
        font-weight: 800;
        color: var(--text-dark);
        background: rgba(255,255,255,0.6);
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        backdrop-filter: blur(6px);
        -webkit-backdrop-filter: blur(6px);
        pointer-events: auto; /* allow clicks through container if needed */
    }

    .live-indicator {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 6px 10px;
        border-radius: 14px;
        font-size: 0.8rem;
        font-weight: 800;
        color: var(--text-dark);
        background: rgba(255,255,255,0.6);
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        backdrop-filter: blur(6px);
        -webkit-backdrop-filter: blur(6px);
    }

    .live-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: var(--pop-green);
        box-shadow: 0 0 0 2px rgba(88,204,2,0.25);
        display: inline-block;
    }

    .player-count {
        margin-top: 8px;
        font-size: 0.85rem;
        font-weight: 700;
        color: var(--text-grey);
        text-align: center;
    }

    @media (max-width: 768px) {
        .featured-container { padding: 0 12px !important; }
        .featured-container .test-card { min-height: 260px; }
        .featured-badges { top: 6px; left: 6px; right: 6px; }
        .badge-subtle, .live-indicator { font-size: 0.72rem; padding: 5px 8px; }
        .player-count { font-size: 0.8rem; }
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
                            <div class="challenge-topline">
                                <div class="challenge-badge">LEVEL EVENT</div>
                                <div class="challenge-hint" id="challengeHint">Choose an action</div>
                            </div>
                            <div class="question-text" id="questionText"></div>
                        </div>
                    </div>

                    <div class="game-options-zone game-choice-zone">
                        <!-- Reaction Options (appear after countdown) -->
                        <div class="options-container" id="optionsContainer">
                            <!-- Action buttons will be dynamically inserted here -->
                        </div>

                        <div class="action-feedback" id="actionFeedback" aria-live="polite"></div>

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

        const actionCardIcons = ['⚡','🛡️','🎯','✨','💡','🚀','🧠','🏆'];

        function escapeHtml(str) {
            return String(str)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/\"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        // Featured game key (can be changed later easily)
        const featuredGame = 'SPIRIT_ANIMAL';

        // Fallback tests to show if API is unavailable or returns no data
        const defaultTests = [
            {
                testId: 'SPIRIT_ANIMAL',
                testName: 'Spirit Animal Game',
                testType: 'DIAGNOSTIC',
                description: 'Quick mindset snapshot to find your spirit animal profile.',
                questionCount: 12,
                estimatedMinutes: 3
            },
            { testId: 'COGNITIVE_RADAR', testName: 'Cognitive Radar', testType: 'DIAGNOSTIC', description: 'See how you scan and process information.', questionCount: 10, estimatedMinutes: 3 },
            { testId: 'FOCUS_STAMINA', testName: 'Focus Stamina', testType: 'DIAGNOSTIC', description: 'Measure attention bursts over time.', questionCount: 8, estimatedMinutes: 2 },
            { testId: 'GUESSWORK_QUOTIENT', testName: 'Guesswork Quotient', testType: 'DIAGNOSTIC', description: 'Gut vs. data decisions under pressure.', questionCount: 9, estimatedMinutes: 3 },
            { testId: 'CURIOSITY_COMPASS', testName: 'Curiosity Compass', testType: 'DIAGNOSTIC', description: 'Where your curiosity naturally leads.', questionCount: 7, estimatedMinutes: 2 },
            { testId: 'MODALITY_MAP', testName: 'Modality Map', testType: 'DIAGNOSTIC', description: 'Your preferred learning inputs.', questionCount: 6, estimatedMinutes: 2 },
            { testId: 'CHALLENGE_DRIVER', testName: 'Challenge Driver', testType: 'DIAGNOSTIC', description: 'What pushes you to start and finish.', questionCount: 8, estimatedMinutes: 3 },
            { testId: 'WORK_MODE', testName: 'Work Mode', testType: 'DIAGNOSTIC', description: 'Solo vs. collaborative tendencies.', questionCount: 6, estimatedMinutes: 2 },
            { testId: 'PATTERN_SNAPSHOT', testName: 'Pattern Snapshot', testType: 'DIAGNOSTIC', description: 'How you spot patterns quickly.', questionCount: 7, estimatedMinutes: 2 }
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

            // Initialize fake live player count animation
            initLivePlayers();
        });

        // Load all diagnostic tests
        async function loadTests() {
            try {
                const response = await fetch('/api/result/tests', { headers: { 'Accept': 'application/json' } });
                if (!response.ok) throw new Error('Failed to load tests');

                const data = await response.json();
                allTests = Array.isArray(data) && data.length > 0 ? data : defaultTests;
            } catch (error) {
                console.error('Error loading tests:', error);
                // Use fallback to ensure UI is not empty
                allTests = defaultTests;
            }

            // Ensure featured game exists in list; if not add fallback
            const hasFeatured = allTests.some(t => t.testId === featuredGame);
            if (!hasFeatured) {
                const fallback = defaultTests.find(t => t.testId === featuredGame);
                if (fallback) allTests.unshift(fallback);
            }

            // Non-destructive order for non-featured; remove featured for grid
            const featured = allTests.find(t => t.testId === featuredGame);
            const rest = allTests.filter(t => t.testId !== featuredGame);

            renderFeatured(featured);
            renderTests(rest);
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

        function renderFeatured(test) {
            const container = document.getElementById('featuredContainer');
            if (!test || !container) { container.style.display = 'none'; return; }
            const emoji = testEmojis[test.testId] || '📝';
            container.style.display = 'block';
            container.innerHTML = (
                '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
                    '<div class="featured-badges">' +
                        '<span class="badge-subtle">🔥 Most Played</span>' +
                        '<span class="live-indicator"><span class="live-dot"></span> Live now</span>' +
                    '</div>' +
                    '<div class="card-header">' +
                        '<div class="test-icon">' + emoji + '</div>' +
                    '</div>' +
                    '<div class="card-body">' +
                        '<h3>' + test.testName + '</h3>' +
                        '<p style="color: #7B7896; flex-grow: 1; display: flex; align-items: center; text-align:center;">' + (test.description || '') + '</p>' +
                        '<p class="player-count" id="livePlayerCount">👥 1,237 players playing right now</p>' +
                        '<button class="test-start-btn" onclick="event.stopPropagation(); startTest()">Start Game →</button>' +
                    '</div>' +
                '</div>'
            );
        }

        function renderTests(tests) {
            const testGrid = document.getElementById('testGrid');
            const list = Array.isArray(tests) ? tests : allTests;
            testGrid.innerHTML = list.map(test => {
                const emoji = testEmojis[test.testId] || '📝';
                return '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
                    '<div class="card-header">' +
                    '<div class="test-icon">' + emoji + '</div>' +
                    '</div>' +
                    '<div class="card-body">' +
                    '<h3>' + test.testName + '</h3>' +
                    '<p style="color: #7B7896; flex-grow: 1; display: flex; align-items: center;">' + (test.description || '') + '</p>' +
                    '<p style="font-size: 0.85rem; color: #A0A0B0; margin-top: 10px;">' +
                    test.questionCount + ' questions • ' + test.estimatedMinutes + ' min' +
                    '</p>' +
                    '<button class="test-start-btn" onclick="event.stopPropagation(); startTest()">Start Game →</button>' +
                    '</div>' +
                    '</div>';
            }).join('');
        }
        // Select a test
        function selectTest(testId) {
            const testCards = document.querySelectorAll('.test-card');
            testCards.forEach(card => card.classList.remove('selected'));

            const selectedCard = document.querySelector('[data-test-id="' + testId + '"]');
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }

            selectedTest = allTests.find(t => t.testId === testId);

            // Save state when test is selected
            savePageState();
        }
        // Start the test
        async function startTest() {
            try {
                // Ensure a test is selected; fallback to first available
                if (!selectedTest && allTests && allTests.length > 0) {
                    selectedTest = allTests[0];
                }

                // Start test session
                const response = await fetch('/api/result/start', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ testId: selectedTest.testId })
                });

                if (!response.ok) throw new Error('Failed to start test');

                const result = await response.json();
                sessionId = result.sessionId;

                // Load questions
                const questionsResponse = await fetch('/api/result/questions/' + selectedTest.testId);
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
            
            // DEBUG: Log question data
            console.log('DEBUG: Question data:', question);
            console.log('DEBUG: Options count:', question.options ? question.options.length : 0);
            console.log('DEBUG: Test ID:', selectedTest ? selectedTest.testId : 'unknown');
            
            // Render action buttons
            if (question.options && question.options.length > 0) {
                question.options.forEach((option, optionIndex) => {
                    console.log('DEBUG: Rendering option', optionIndex, option);
                    const optionDiv = document.createElement('div');
                    optionDiv.className = 'option';
                    optionDiv.dataset.value = option.optionValue;

                    // Add emoji if option text doesn't have one
                    const rawText = String(option.optionText || '');
                    const textWithoutEmoji = rawText
                        .replace(/[\u{1F300}-\u{1FAFF}]/gu, '')
                        .replace(/\s{2,}/g, ' ')
                        .trim();
                    const safeText = escapeHtml(textWithoutEmoji);
                    const icon = actionCardIcons[optionIndex % actionCardIcons.length];
                    optionDiv.innerHTML = (
                        '<span class="option-icon">' + icon + '</span>' +
                        '<span class="option-copy">' +
                            '<span class="option-label">' + safeText + '</span>' +
                            '<span class="option-sub">Tap to lock in</span>' +
                        '</span>'
                    );

                    // Check if this option was previously selected
                    if (answers[index] === option.optionValue) {
                        optionDiv.classList.add('selected');
                    }

                    optionDiv.addEventListener('click', function() {
                        selectOption(option.optionValue);
                    });

                    optionsContainer.appendChild(optionDiv);
                });
            } else {
                console.error('DEBUG: No options found in question data for test:', selectedTest?.testId);
                
                // Create appropriate options based on the game type
                let gameOptions = [];
                
                if (selectedTest && selectedTest.testId === 'FOCUS_STAMINA') {
                    // Focus Power Game specific options
                    gameOptions = [
                        { optionValue: 'FOCUS_DEEP', optionText: 'Focus Deep' },
                        { optionValue: 'TAKE_BREAK', optionText: 'Take Break' },
                        { optionValue: 'SWITCH_TASK', optionText: 'Switch Task' },
                        { optionValue: 'MINDFUL_PAUSE', optionText: 'Mindful Pause' }
                    ];
                } else {
                    // Generic fallback options for other games
                    gameOptions = [
                        { optionValue: 'option_1', optionText: 'Option 1' },
                        { optionValue: 'option_2', optionText: 'Option 2' },
                        { optionValue: 'option_3', optionText: 'Option 3' },
                        { optionValue: 'option_4', optionText: 'Option 4' }
                    ];
                }
                
                console.log('DEBUG: Using game-specific options:', gameOptions);
                
                gameOptions.forEach((option, optionIndex) => {
                    const optionDiv = document.createElement('div');
                    optionDiv.className = 'option';
                    optionDiv.dataset.value = option.optionValue;
                    
                    const icon = actionCardIcons[optionIndex % actionCardIcons.length];
                    optionDiv.innerHTML = (
                        '<span class="option-icon">' + icon + '</span>' +
                        '<span class="option-copy">' +
                            '<span class="option-label">' + option.optionText + '</span>' +
                            '<span class="option-sub">Tap to lock in</span>' +
                        '</span>'
                    );
                    
                    optionDiv.addEventListener('click', function() {
                        selectOption(option.optionValue);
                    });
                    
                    optionsContainer.appendChild(optionDiv);
                });
            }

            // Show options with animation
            optionsContainer.classList.add('show');

            // Adjust layout density based on rendered option count (UI-only)
            applyOptionLayoutDensity();

            // Update progress dots and navigation buttons
            updateGameProgressDots();
            updateNavigationButtons();
        }

        function applyOptionLayoutDensity() {
            const playArea = document.querySelector('#questionContainer .game-play-area');
            const optionsContainer = document.getElementById('optionsContainer');
            if (!playArea || !optionsContainer) return;

            const optionCount = optionsContainer.children ? optionsContainer.children.length : 0;
            playArea.classList.remove('few-options', 'many-options');

            if (optionCount >= 3) {
                playArea.classList.add('many-options');
            } else {
                playArea.classList.add('few-options');
            }
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
                    opt.classList.add('just-selected');
                    setTimeout(() => {
                        opt.classList.remove('just-selected');
                    }, 450);
                }
            });

            const feedback = document.getElementById('actionFeedback');
            if (feedback) {
                const messages = ['Locked in!', 'Nice move!', 'Great choice!', 'Action confirmed!'];
                feedback.textContent = messages[Math.floor(Math.random() * messages.length)];
                feedback.classList.add('show');
                setTimeout(() => {
                    feedback.classList.remove('show');
                }, 650);
            }

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

            const hudFill = document.getElementById('hudXpFill');
            if (hudFill) hudFill.style.width = percentage + '%';

            const hudLevel = document.getElementById('hudLevelText');
            if (hudLevel) hudLevel.textContent = text;

            const hudSub = document.getElementById('hudXpSub');
            if (hudSub) hudSub.textContent = 'XP ' + Math.round(percentage) + '/100';
        }

        // Submit test - OPTIMIZED for speed
        async function submitTest() {
            // Validate all questions answered
            const unanswered = answers.filter(a => a === null).length;
            if (unanswered > 0) {
                alert('Please answer all questions. ' + unanswered + ' question(s) remaining.');
                return;
            }

            // Show immediate loading state
            updateProgress(100, 'Analyzing your answers...');
            showLoadingOverlay();

            try {
                // Prepare answers in the format expected by the API
                const formattedAnswers = questions.map((q, index) => ({
                    questionId: q.questionId,
                    answerValue: answers[index],
                    timeSpent: 0
                }));

                // Add timeout to prevent hanging
                const controller = new AbortController();
                const timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout

                const response = await fetch('/api/result/submit', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        sessionId: sessionId,
                        answers: formattedAnswers
                    }),
                    signal: controller.signal
                });

                clearTimeout(timeoutId);

                if (!response.ok) throw new Error('Failed to submit test');

                const result = await response.json();

                if (result.success) {
                    // Clear saved state before redirecting
                    clearPageState();
                    
                    // IMMEDIATE redirect with loading state maintained
                    window.location.href = '/result/' + sessionId;
                } else {
                    throw new Error(result.error || 'Failed to submit test');
                }
            } catch (error) {
                clearTimeout(timeoutId);
                console.error('Error submitting test:', error);
                
                // Hide loading and show error
                hideLoadingOverlay();
                
                if (error.name === 'AbortError') {
                    alert('Request timed out. Please check your connection and try again.');
                } else {
                    alert('Failed to submit test. Please try again.');
                }

                // Restore UI
                document.getElementById('questionContainer').classList.remove('hidden');
                updateProgress(66, 'Question ' + (currentQuestionIndex + 1) + ' of ' + questions.length);
            }
        }

        // Fast loading overlay
        function showLoadingOverlay() {
            const overlay = document.createElement('div');
            overlay.id = 'loading-overlay';
            overlay.innerHTML = `
                <div style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
                           background: rgba(139, 127, 232, 0.95); z-index: 9999; 
                           display: flex; align-items: center; justify-content: center;
                           backdrop-filter: blur(10px);">
                    <div style="text-align: center; color: white;">
                        <div style="font-size: 3rem; margin-bottom: 20px; animation: spin 1s linear infinite;">⚡</div>
                        <h2 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 10px;">Analyzing Your DNA</h2>
                        <p style="font-size: 1rem; opacity: 0.9;">Calculating your learning profile...</p>
                    </div>
                </div>
                <style>
                    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
                </style>
            `;
            document.body.appendChild(overlay);
        }

        function hideLoadingOverlay() {
            const overlay = document.getElementById('loading-overlay');
            if (overlay) overlay.remove();
        }
        function initLivePlayers() {
            const elId = 'livePlayerCount';
            let base = 1237; // starting near mid-range
            const min = 1000;
            const maxDelta = 20;
            const minDelta = 5;
            function tick() {
                const el = document.getElementById(elId);
                if (!el) return; // not on selection screen
                // Randomly go up or down without big jumps
                const sign = Math.random() < 0.55 ? 1 : -1;
                const delta = Math.floor(Math.random() * (maxDelta - minDelta + 1)) + minDelta;
                base = Math.max(min, base + sign * delta);
                el.textContent = '👥 ' + base.toLocaleString() + ' players playing right now';
            }
            // Vary interval a bit for realism
            setInterval(tick, 2500 + Math.floor(Math.random() * 1500));
            // Initial
            setTimeout(tick, 600);
        }

        // Add 3D parallax effect on mouse move (desktop only)
        if (window.innerWidth > 768) {
            document.addEventListener('DOMContentLoaded', function() {
                setTimeout(function() {
                    document.querySelectorAll('.test-card').forEach(card => {
                        card.addEventListener('mousemove', (e) => {
                            const rect = card.getBoundingClientRect();
                            const x = e.clientX - rect.left;
                            const y = e.clientY - rect.top;

                            const centerX = rect.width / 2;
                            const centerY = rect.height / 2;

                            const rotateX = (y - centerY) / 10;
                            const rotateY = (centerX - x) / 10;

                            card.style.transform = `translateY(-15px) scale(1.05) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
                        });

                        card.addEventListener('mouseleave', () => {
                            card.style.transform = '';
                        });
                    });
                }, 100);
            });
        }
    </script>
</body>
</html>


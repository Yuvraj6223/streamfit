<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Learning DNA | Cognitive Space</title>
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

        /* --- CHANGE THESE LINES --- */
        min-width: 320px;     /* Stop shrinking below 320px */
        overflow-x: auto;     /* Enable scrollbar if screen is too narrow */
        /* -------------------------- */

        -webkit-font-smoothing: antialiased;
    }

    /* --- 1. AMBIENT BACKGROUND --- */
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
    .b-1 { top: -10%; right: -5%; width: 600px; height: 600px; background: var(--pop-purple); border-radius: 40% 60% 70% 30%; }
    .b-2 { bottom: -10%; left: -10%; width: 700px; height: 700px; background: var(--pop-teal); border-radius: 60% 40% 30% 70%; animation-delay: -5s; }
    .b-3 { top: 40%; left: 40%; width: 400px; height: 400px; background: var(--pop-coral); opacity: 0.3; border-radius: 30% 70%; animation-duration: 18s; }

    @keyframes float-blob {
        0% { transform: translate(0, 0) rotate(0deg); }
        100% { transform: translate(40px, 40px) rotate(10deg); }
    }

    /* --- 2. LAYOUT --- */
    .dashboard-container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 24px 24px 40px 24px;
    }

    /* --- FLOATING NAVBAR --- */
    .navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 40px;

        /* Glass/Clay Pill Look */
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        padding: 12px 16px 12px 24px;
        border-radius: 100px;
        box-shadow: 0 10px 40px -10px rgba(0,0,0,0.05);
        border: 1px solid rgba(255,255,255,0.6);
        transition: all 0.3s var(--ease-smooth);
    }

    /* Slight compression on scroll could be added via JS, but CSS default is clean */

    .nav-logo {
        font-weight: 800;
        font-size: 1.4rem;
        color: var(--text-dark);
        text-decoration: none;
        letter-spacing: -0.03em;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .logo-icon svg {
        width: 32px;
        height: 32px;
        /* Animation for logo */
        animation: pulse-logo 3s infinite ease-in-out;
    }

    @keyframes pulse-logo {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }

    .nav-btn-primary {
        background: var(--text-dark);
        color: white;
        padding: 12px 24px;
        border-radius: 100px;
        font-weight: 700;
        font-size: 0.9rem;
        border: none;
        cursor: pointer;
        transition: all 0.3s var(--ease-elastic);
        text-decoration: none;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        font-family: inherit;
        white-space: nowrap;
    }

    .nav-btn-primary:hover {
        transform: translateY(-2px) scale(1.02);
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        background: #2D2A3D;
    }

    /* HEADER */
    .dashboard-header {
        display: flex; justify-content: space-between; align-items: flex-end;
        margin-bottom: 50px;
        padding: 0 12px; /* Align visual text with pill edges */
    }
    .header-content h1 {
        font-size: clamp(2.5rem, 5vw, 4rem);
        font-weight: 800;
        letter-spacing: -0.03em;
        margin: 0;
        line-height: 1;
        color: var(--text-dark);
    }
    .header-content p {
        font-size: 1.1rem;
        color: var(--text-grey);
        margin: 12px 0 0 0;
        font-weight: 600;
    }
    .date-pill {
        background: white;
        padding: 12px 24px;
        border-radius: 100px;
        font-weight: 700;
        color: var(--text-dark);
        box-shadow: var(--shadow-soft);
        display: flex; align-items: center; gap: 10px;
        font-size: 0.9rem;
    }

    /* --- 3. BENTO GRID (4 Column Return) --- */
    .bento-grid {
        display: grid;
        /* Back to 4 columns to accommodate the big 2x2 Hero */
        grid-template-columns: repeat(4, 1fr);
        grid-template-rows: repeat(2, minmax(220px, auto));
        gap: 24px;
        margin-bottom: 60px;
    }

    .clay-card {
        background: var(--card-base);
        border-radius: 32px;
        padding: 32px;
        box-shadow: var(--shadow-soft);
        position: relative;
        overflow: hidden;
        transition: transform 0.3s var(--ease-elastic), box-shadow 0.3s ease;
        display: flex; flex-direction: column; justify-content: space-between;
        border: 1px solid rgba(255,255,255,0.5);
    }
    .clay-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-float);
    }

    /* HERO CARD (Now Applied to Level) */
    .card-hero {
        grid-column: span 2; grid-row: span 2;
        background: var(--pop-cream); /* Warm hero background */
        border: none;
    }

    /* The Abstract Art Decoration */
    .hero-illustration {
        position: absolute; right: -30px; bottom: -30px;
        width: 250px; height: 250px; pointer-events: none;
    }
    .art-circle { position: absolute; border-radius: 50%; }
    .ac-1 { width: 150px; height: 150px; background: var(--pop-coral); right: 40px; bottom: 60px; }
    .ac-2 { width: 100px; height: 100px; background: var(--text-dark); right: 120px; bottom: 30px; z-index: 2; }
    .ac-3 { width: 60px; height: 60px; background: var(--pop-yellow); right: 20px; bottom: 40px; z-index: 3; border: 4px solid var(--pop-cream); }

    .hero-value {
        font-size: clamp(5rem, 8vw, 7rem);
        font-weight: 800;
        line-height: 0.9;
        margin: 20px 0;
        letter-spacing: -0.05em;
        color: var(--text-dark);
        position: relative; z-index: 5;
    }

    /* STAT CARDS (Quests & XP) */
    .stat-icon-bubble {
        width: 56px; height: 56px; border-radius: 20px;
        display: flex; align-items: center; justify-content: center;
        margin-bottom: 16px; font-size: 24px;
    }
    .bubble-teal { background: rgba(115, 210, 222, 0.15); color: #2A9BA8; }
    .bubble-yellow { background: rgba(255, 216, 109, 0.2); color: #D4A628; }
    .bubble-purple { background: rgba(159, 151, 243, 0.15); color: var(--pop-purple); }

    .stat-val { font-size: 2.5rem; font-weight: 800; color: var(--text-dark); letter-spacing: -0.03em; line-height: 1; }
    .stat-lbl { color: var(--text-grey); font-weight: 600; font-size: 0.95rem; margin-top: 8px; }

    /* PROGRESS CARD (Now Span 2 to sit next to Hero) */
    .card-progress { grid-column: span 2; }

    .progress-rail {
        height: 16px; background: #F0F0F3; border-radius: 100px;
        overflow: hidden; position: relative; margin-top: 16px;
    }
    .progress-bar {
        height: 100%; background: linear-gradient(90deg, var(--pop-teal), var(--pop-purple));
        border-radius: 100px; width: 0%; transition: width 1.5s var(--ease-smooth);
    }

    /* --- 4. TABS & RESULTS --- */
    .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
    .section-title { font-size: 1.5rem; font-weight: 800; color: var(--text-dark); letter-spacing: -0.02em; }

    .tabs-pill {
        background: white;
        padding: 6px;
        border-radius: 100px;
        box-shadow: var(--shadow-soft);
        display: flex;
        gap: 4px;

        /* --- NEW RESPONSIVE RULES --- */
        max-width: 100%;       /* Ensure it never exceeds the screen width */
        overflow-x: auto;      /* Enable horizontal scrolling if it's too wide */
        white-space: nowrap;   /* Keep buttons in a single line */
        scrollbar-width: none; /* Hide scrollbar for Firefox */
        -ms-overflow-style: none; /* Hide scrollbar for IE/Edge */
        box-sizing: border-box; /* Include padding in the width calculation */
    }

    /* Hide Webkit scrollbar (Chrome/Safari) */
    .tabs-pill::-webkit-scrollbar {
        display: none;
    }
    .tab-btn {
        border: none; background: transparent; padding: 10px 24px; border-radius: 100px;
        color: var(--text-grey); font-weight: 700; cursor: pointer; transition: all 0.3s;
        font-size: 0.9rem; font-family: inherit;
    }
    .tab-btn.active { background: var(--text-dark); color: white; }

    .results-grid {
        display: flex;       /* Changed from grid to flex */
        flex-wrap: wrap;     /* Allows items to wrap to next line */
        gap: 20px;
    }

    .result-card {
        /* NEW: This makes cards grow to fill space.
           Sets a minimum width of ~280px but stretches if there's room. */
        flex: 1 1 280px;

        /* Existing styles stay the same */
        background: white;
        border-radius: 28px;
        padding: 24px;
        border: 1px solid #F0F0F5;
        transition: all 0.3s var(--ease-smooth);
        cursor: pointer;
        box-shadow: var(--shadow-soft);
    }
    .result-card:hover { transform: translateY(-5px); border-color: var(--pop-purple); }

    .tag {
        padding: 6px 14px; border-radius: 12px; font-size: 0.75rem;
        font-weight: 800;
        text-transform: uppercase; letter-spacing: 0.05em; display: inline-block; margin-bottom: 16px;
    }
    .tag-diag { background: rgba(159, 151, 243, 0.1); color: var(--pop-purple); }
    .tag-drill { background: rgba(255, 216, 109, 0.2); color: #B48D15; }
    .tag-assess { background: rgba(115, 210, 222, 0.15); color: #2A9BA8; }

    .tag {
        padding: 6px 14px; border-radius: 12px; font-size: 0.75rem; font-weight: 800;
        text-transform: uppercase; letter-spacing: 0.05em; display: inline-block; margin-bottom: 16px;
    }
    .tag-diag { background: rgba(159, 151, 243, 0.1); color: var(--pop-purple); }
    .tag-drill { background: rgba(255, 216, 109, 0.2); color: #B48D15; }
    .tag-assess { background: rgba(115, 210, 222, 0.15); color: #2A9BA8; }

    /* --- 5. NEW PROUDFUL BADGES --- */
    .bottom-split { display: grid; grid-template-columns: 1.5fr 1fr; gap: 40px; margin-top: 60px; }

    /* Around line 416 */
    .badge-grid-wrapper {
        display: grid;
        /* Update this to auto-fit as well */
        grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
        gap: 16px;
    }

    .badge-card {
        border-radius: 24px;
        padding: 24px 12px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        position: relative;
        overflow: hidden;
        transition: all 0.4s var(--ease-elastic);
        cursor: default;
        border: 2px solid white;
    }

    .badge-card:hover {
        transform: translateY(-8px) scale(1.05);
        z-index: 10;
    }

    /* --- RARITY THEMES --- */

    /* COMMON: Clean & Fresh */
    .b-common {
        background: linear-gradient(135deg, #F0FAFC 0%, #D8F3F6 100%);
        box-shadow: 0 10px 20px -5px rgba(115, 210, 222, 0.3);
    }
    .b-common .b-icon-bg { background: rgba(255,255,255,0.6); color: #2A9BA8; box-shadow: inset 0 2px 4px rgba(42, 155, 168, 0.1); }
    .b-common .b-rarity { color: #2A9BA8; background: rgba(255,255,255,0.6); }

    /* RARE: Mystical */
    .b-rare {
        background: linear-gradient(135deg, #F4F3FF 0%, #E5E2FF 100%);
        box-shadow: 0 10px 20px -5px rgba(159, 151, 243, 0.4);
    }
    .b-rare .b-icon-bg { background: rgba(255,255,255,0.6); color: var(--pop-purple); box-shadow: inset 0 2px 4px rgba(159, 151, 243, 0.15); }
    .b-rare .b-rarity { color: var(--pop-purple); background: rgba(255,255,255,0.6); }

    /* EPIC: Proudful Gold */
    .b-epic {
        background: linear-gradient(135deg, #FFF9EB 0%, #FFF0C2 100%);
        box-shadow: 0 15px 30px -8px rgba(255, 216, 109, 0.6);
        border-color: #FFFDF5;
    }
    /* Shine Animation */
    .b-epic::after {
        content: ''; position: absolute; top: -100%; left: -100%; width: 300%; height: 300%;
        background: linear-gradient(45deg, transparent, rgba(255,255,255,0.6), transparent);
        transform: rotate(45deg); animation: shine 4s infinite; pointer-events: none;
    }
    @keyframes shine {
        0% { transform: translateX(-100%) rotate(45deg); }
        20% { transform: translateX(100%) rotate(45deg); }
        100% { transform: translateX(100%) rotate(45deg); }
    }

    .b-epic .b-icon-bg { background: rgba(255, 255, 255, 0.7); color: #D4A628; box-shadow: inset 0 2px 4px rgba(212, 166, 40, 0.2); }
    .b-epic .b-rarity { color: #B48D15; background: rgba(255,255,255,0.9); font-weight: 800; border: 1px solid rgba(212, 166, 40, 0.1); }

    .b-icon-bg {
        width: 64px; height: 64px; border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        margin-bottom: 16px; font-size: 1.8rem;
        position: relative; z-index: 2;
    }

    .b-title {
        font-weight: 800; font-size: 0.95rem; color: var(--text-dark);
        margin-bottom: 8px; line-height: 1.2; position: relative; z-index: 2;
    }

    .b-rarity {
        font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.1em;
        padding: 4px 12px; border-radius: 100px; font-weight: 700; position: relative; z-index: 2;
    }

    .ach-item {
        display: flex; align-items: center; gap: 16px; padding: 20px;
        background: white; border-radius: 24px; margin-bottom: 16px;
        box-shadow: var(--shadow-soft);
        min-width: 0;
    }

    .ach-item > div:nth-child(2) {
        min-width: 0;
    }

    /* --- FOOTER STYLES --- */
    .dashboard-footer {
        margin-top: 80px;
        background: rgba(255, 255, 255, 0.5);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-radius: 32px;
        padding: 60px;
        border: 1px solid rgba(255,255,255,0.6);
        box-shadow: var(--shadow-soft);
        position: relative;
        overflow: hidden;
        display: grid;
        grid-template-columns: 1.5fr 1fr 1fr 1fr;
        gap: 40px;
        align-items: start;
    }

    .footer-brand h2 {
        font-size: 1.5rem;
        font-weight: 800;
        color: var(--text-dark);
        margin: 0 0 16px 0;
        letter-spacing: -0.03em;
    }

    .footer-brand p {
        color: var(--text-grey);
        line-height: 1.6;
        font-size: 0.95rem;
        max-width: 280px;
        margin: 0 0 24px 0;
    }

    .social-row {
        display: flex;
        gap: 12px;
    }

    .social-btn {
        width: 40px;
        height: 40px;
        border-radius: 12px;
        background: white;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--text-dark);
        transition: all 0.2s;
        border: 1px solid rgba(0,0,0,0.05);
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0,0,0,0.02);
        text-decoration: none;
    }

    .social-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        color: var(--pop-purple);
    }

    .footer-col h3 {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: var(--text-grey);
        font-weight: 700;
        margin: 0 0 20px 0;
    }

    .footer-link-list {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .footer-link-list a {
        text-decoration: none;
        color: var(--text-dark);
        font-weight: 500;
        font-size: 0.95rem;
        transition: color 0.2s;
        opacity: 0.8;
    }

    .footer-link-list a:hover {
        color: var(--pop-purple);
        opacity: 1;
    }

    .footer-bottom {
        grid-column: 1 / -1;
        margin-top: 40px;
        padding-top: 24px;
        border-top: 1px solid rgba(0,0,0,0.05);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
        color: var(--text-grey);
        font-size: 0.85rem;
        font-weight: 600;
    }

    .footer-links {
        display: flex;
        gap: 20px;
    }

    .footer-links a {
        color: var(--text-grey);
        text-decoration: none;
        transition: color 0.2s;
    }

    .footer-links a:hover {
        color: var(--pop-purple);
    }

    /* --- MOBILE & TABLET --- */
    @media (max-width: 900px) {
        .bento-grid { grid-template-columns: repeat(2, 1fr); }
        /* Tablet: Level takes full width of grid (or 1x1 if we want density, but hero usually full) */
        .card-hero { grid-column: span 2; }
        .card-progress { grid-column: span 2; }
        .bottom-split { grid-template-columns: 1fr; }
    }
    @media (max-width: 480px) {
        .dashboard-container { padding: 30px 16px; }

        /* Nav Stack */
        .navbar {
            top: 10px;
            padding: 10px 12px 10px 16px;
        }
        .nav-logo { font-size: 1.2rem; gap: 8px; }
        .logo-icon svg { width: 24px; height: 24px; }
        .nav-btn-primary { padding: 10px 16px; font-size: 0.8rem; }

        .bento-grid { grid-template-columns: 1fr 1fr; gap: 16px; }
        /* Mobile: Level takes full width */
        .card-hero { grid-column: span 2; }
        /* Quests and XP share row */
        .stat-icon-bubble { width: 40px; height: 40px; font-size: 20px; margin-bottom: 12px; }
        .stat-val { font-size: 2rem; }
        .card-progress { grid-column: span 2; padding: 24px; }

        /* Responsive Header & Filters */
        .section-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 16px;
        }
        .tabs-pill {
            width: 100%;
            overflow-x: auto;
            padding-bottom: 4px; /* Space for scrollbar */
            white-space: nowrap;
            justify-content: flex-start;
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        .tabs-pill::-webkit-scrollbar { display: none; }
        .tab-btn { flex-shrink: 0; }

        /* Responsive Results Grid */
        .results-grid {
            grid-template-columns: 1fr;
        }

        /* On mobile, use auto-fill grid for cards so they wrap nicely in 2 columns usually */
        .badge-grid-wrapper {
            grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
        }
        .ach-item {
            padding: 16px;
        }

        /* Footer Mobile */
        .dashboard-footer {
            padding: 32px;
            margin-top: 40px;
            grid-template-columns: 1fr;
            gap: 32px;
        }
        .footer-bottom {
            flex-direction: column;
            gap: 12px;
            align-items: center;
            text-align: center;
        }
        .footer-links {
            justify-content: center;
        }
    }

    /* UTILS */
    .animate-in { opacity: 0; animation: reveal 0.8s var(--ease-smooth) forwards; }
    @keyframes reveal { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    .d-1 { animation-delay: 0.1s; } .d-2 { animation-delay: 0.2s; } .d-3 { animation-delay: 0.3s; } .d-4 { animation-delay: 0.4s; }
    </style>
</head>
<body>

<!-- ATMOSPHERE -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

<div class="dashboard-container">

    <!-- NAVIGATION (STICKY PILL) -->
    <nav class="navbar animate-in">
        <a href="#" class="nav-logo">
            <div class="logo-icon">
                <!-- Custom DNA-Brain Helix Icon -->
                <svg viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 28C12 28 8 24 8 20C8 13.3726 13.3726 8 20 8C26.6274 8 32 13.3726 32 20C32 26.6274 26.6274 32 20 32" stroke="#FF8F7D" stroke-width="4" stroke-linecap="round"/>
                    <path d="M28 12C28 12 32 16 32 20C32 26.6274 26.6274 32 20 32C13.3726 32 8 26.6274 8 20C8 13.3726 13.3726 8 20 8" stroke="#9F97F3" stroke-width="4" stroke-linecap="round" stroke-dasharray="4 4"/>
                    <circle cx="20" cy="20" r="4" fill="#1A1825"/>
                </svg>
            </div>
            learnerdna
        </a>
        <button class="nav-btn-primary">Get my clarity now</button>
    </nav>

    <!-- HEADER -->
    <div class="dashboard-header animate-in">
        <div class="header-content">
            <h1 id="welcome-text">Learning DNA</h1>
            <p>Cognitive Space Active</p>
        </div>
        <div class="date-pill" id="date-widget">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
            <span id="date-text"></span>
        </div>
    </div>

    <!-- BENTO GRID -->
    <div class="bento-grid">

        <!-- 1. LEVEL (NOW THE HERO) -->
        <div class="clay-card card-hero animate-in d-1">
            <div style="z-index: 10;">
                <div style="font-weight: 700; opacity: 0.6; text-transform:uppercase; letter-spacing:0.1em; font-size:0.8rem;">Current Level</div>
                <div class="hero-value"><span id="stat-level">0</span></div>

                <!-- Badge for Level -->
                <div style="background: var(--text-dark); color:white; padding: 10px 24px; border-radius: 100px; display: inline-flex; align-items: center; gap: 8px; font-weight: 700; font-size: 0.9rem; margin-top: 10px;">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" stroke="none"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" style="fill:#FFD86D;"></polygon></svg>
                    Scholar Status
                </div>
            </div>

            <!-- Abstract Art Decoration -->
            <div class="hero-illustration">
                <div class="art-circle ac-1"></div>
                <div class="art-circle ac-2"></div>
                <div class="art-circle ac-3"></div>
            </div>
        </div>

        <!-- 2. QUESTS -->
        <div class="clay-card animate-in d-2">
            <div>
                <div class="stat-icon-bubble bubble-teal" id="icon-tests"></div>
                <div class="stat-val" id="stat-tests">0</div>
                <div class="stat-lbl">Quests</div>
            </div>
        </div>

        <!-- 3. XP -->
        <div class="clay-card animate-in d-3">
            <div>
                <div class="stat-icon-bubble bubble-yellow" id="icon-points"></div>
                <div class="stat-val" id="stat-points">0</div>
                <div class="stat-lbl">Lifetime XP</div>
            </div>
        </div>

        <!-- 4. PROGRESS (Span 2 to fill space next to Hero) -->
        <div class="clay-card card-progress animate-in d-4" style="justify-content: center;">
            <div>
                <div style="display:flex; justify-content:space-between; align-items:flex-end;">
                    <div>
                        <div style="color: var(--text-grey); font-size: 0.8rem; font-weight: 700; text-transform:uppercase; letter-spacing:0.05em;">Next Milestone</div>
                        <div style="color: var(--text-dark); font-size: 1.5rem; font-weight: 800; margin-top:4px;">
                            <span id="points-to-next">100</span> XP Left
                        </div>
                    </div>
                    <div style="width: 40px; height: 40px; background: var(--text-dark); border-radius: 50%; display:flex; align-items:center; justify-content:center; color:white;">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </div>
                </div>
                <div class="progress-rail">
                    <div class="progress-bar" id="level-progress"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- TABS & RESULTS -->
    <div class="animate-in d-3">
        <div class="section-header">
            <div class="section-title">Latest Results</div>
            <div class="tabs-pill" id="test-filters">
                <button class="tab-btn active" onclick="filterTests('all', this)">All</button>
                <button class="tab-btn" onclick="filterTests('diagnostic', this)">Diagnostics</button>
                <button class="tab-btn" onclick="filterTests('drill', this)">Drills</button>
                <button class="tab-btn" onclick="filterTests('assessment', this)">Assessments</button>
            </div>
        </div>

        <div class="results-grid" id="test-results">
            <!-- JS Injection -->
        </div>
    </div>

    <!-- FOOTER SPLIT -->
    <div class="bottom-split animate-in d-4">

        <!-- BADGES -->
        <div>
            <div class="section-header">
                <div class="section-title">Badges <span id="badge-count" style="background:#E5E5EA; padding:2px 10px; border-radius:20px; font-size:0.8em; margin-left:10px;">0</span></div>
            </div>
            <div class="badge-grid-wrapper" id="badges-grid">
                <!-- JS Injection -->
            </div>
        </div>

        <!-- ACHIEVEMENTS -->
        <div>
            <div class="section-header">
                <div class="section-title">Recent Unlocks</div>
            </div>
            <div id="achievements-list">
                <!-- JS Injection -->
            </div>
        </div>

    </div>

    <!-- FOOTER -->
    <footer class="dashboard-footer animate-in d-4">
        <!-- Brand Col -->
        <div class="footer-brand">
            <h2>StreamFit</h2>
            <p>Unlock your cognitive potential with adaptive learning paths designed for your unique brain.</p>
            <div class="social-row">
                <a href="#" class="social-btn" aria-label="Twitter">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>
                </a>
                <a href="#" class="social-btn" aria-label="LinkedIn">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg>
                </a>
                <a href="#" class="social-btn" aria-label="Instagram">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg>
                </a>
            </div>
        </div>

        <!-- Links Col 1 -->
        <div class="footer-col">
            <h3>STREAMFIT</h3>
            <ul class="footer-link-list">
                <li><a href="/">Home</a></li>
                <li><a href="/personality/start">Take the Test</a></li>
                <li><a href="/personality/types">Learning Animals</a></li>
            </ul>
        </div>

        <!-- Links Col 2 -->
        <div class="footer-col">
            <h3>LEGAL</h3>
            <ul class="footer-link-list">
                <li><a href="/privacy">Privacy Policy</a></li>
                <li><a href="/terms">Terms of Service</a></li>
            </ul>
        </div>

        <!-- Links Col 3 -->
        <div class="footer-col">
            <h3>SUPPORT</h3>
            <ul class="footer-link-list">
                <li><a href="/faq">FAQ</a></li>
                <li><a href="/contact">Contact Us</a></li>
                <li><a href="/about">About StreamFit</a></li>
            </ul>
        </div>

        <div class="footer-bottom">
            <div>© 2025 StreamFit. All rights reserved.</div>
            <div class="footer-links">
                <a href="/terms">Terms</a>
                <a href="/privacy">Privacy</a>
                <a href="/contact">Contact</a>
            </div>
        </div>
    </footer>

</div>

<script>
    // --- DATA LOGIC ---
    const svgLib = {
        brain: `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.5 2A2.5 2.5 0 0 1 12 4.5v15a2.5 2.5 0 0 1-4.96.44 2.5 2.5 0 0 1-2.96-3.08 3 3 0 0 1-.34-5.58 2.5 2.5 0 0 1 1.32-4.24 2.5 2.5 0 0 1 1.98-3A2.5 2.5 0 0 1 9.5 2Z"></path><path d="M14.5 2A2.5 2.5 0 0 0 12 4.5v15a2.5 2.5 0 0 0 4.96.44 2.5 2.5 0 0 0 2.96-3.08 3 3 0 0 0 .34-5.58 2.5 2.5 0 0 0-1.32-4.24 2.5 2.5 0 0 0-1.98-3A2.5 2.5 0 0 0 14.5 2Z"></path></svg>`,
        lightning: `<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>`,
        clipboard: `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg>`,
        target: `<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>`,
        diamond: `<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 3h12l4 6-10 13L2 9z"></path></svg>`,
        star: `<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>`,
        rocket: `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4.5 16.5c-1.5 1.26-2 5-2 5s3.74-.5 5-2c.71-.84.7-2.13-.09-2.91a2.18 2.18 0 0 0-2.91-.09z"></path><path d="m12 15-3-3a22 22 0 0 1 2-3.95A12.88 12.88 0 0 1 22 2c0 2.72-.78 7.5-6 11a22.35 22.35 0 0 1-4 2z"></path></svg>`,
        book: `<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path></svg>`,
        calendar: `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>`,
        flame: `<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" stroke="none"><path d="M12 2c0 4.97-9 6.66-9 14a9 9 0 1 0 18 0c0-6.18-5.63-10.27-9-14z" style="fill:#FF7A59;"></path></svg>`
    };

    let allTests = [];

    function getTagClass(type) {
        if (type.includes('Diagnostic')) return 'tag-diag';
        if (type.includes('Drill')) return 'tag-drill';
        return 'tag-assess';
    }

    function getIcon(name) {
        name = name.toLowerCase();
        if (name.includes('brain') || name.includes('focus')) return svgLib.brain;
        if (name.includes('quick') || name.includes('drill')) return svgLib.lightning;
        if (name.includes('rocket') || name.includes('blast')) return svgLib.rocket;
        if (name.includes('scholar')) return svgLib.book;
        return svgLib.clipboard;
    }

    async function init() {
        // Date
        const now = new Date();
        const dateStr = now.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });
        document.getElementById('date-text').textContent = dateStr;

        try {
            const response = await fetch('/api/dashboard/data');
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            const data = await response.json();

            if (!data.success) {
                throw new Error(data.error || 'Failed to load dashboard data.');
            }
            
            allTests = data.testResults;

            // Render Header
            const hour = now.getHours();
            const greeting = hour < 12 ? 'Good morning' : hour < 18 ? 'Good afternoon' : 'Good evening';
            document.getElementById('welcome-text').textContent = greeting + ', ' + data.user.name;

            // Render Stats
            document.getElementById('stat-level').textContent = data.stats.currentLevel;

            document.getElementById('icon-tests').innerHTML = svgLib.target;
            document.getElementById('stat-tests').textContent = data.stats.totalTestsCompleted;

            document.getElementById('icon-points').innerHTML = svgLib.diamond;
            document.getElementById('stat-points').textContent = data.stats.totalPoints.toLocaleString();

            // Progress Bar Animation
            document.getElementById('points-to-next').textContent = data.stats.pointsToNextLevel;
            setTimeout(() => {
                // Assuming 1000 points per level for this calculation.
                // You might need a more robust way to get the points for the *start* of the current level.
                const levelStartPoints = (data.stats.currentLevel -1) * 1000;
                const pointsIntoLevel = data.stats.totalPoints - levelStartPoints;
                const pointsForNextLevel = data.stats.pointsToNextLevel + pointsIntoLevel;
                const pct = pointsForNextLevel > 0 ? (pointsIntoLevel / pointsForNextLevel) * 100 : 0;
                document.getElementById('level-progress').style.width = pct + '%';
            }, 500);

            // Render Lists
            renderTests(allTests);
            renderBadges(data.badges);
            renderAchievements(data.achievements);

        } catch (error) {
            console.error('Error initializing dashboard:', error);
            // Render an error state in the UI
            const container = document.querySelector('.dashboard-container');
            container.innerHTML = '<div style="text-align:center; padding: 80px; color: #D9534F; font-weight: 500; background: white; border-radius: 20px;">' +
                '<h2>Oops! Something went wrong.</h2>' +
                '<p>We couldn\'t load your dashboard data. Please try again later.</p>' +
                '<p style="font-size: 0.8em; color: #666; margin-top: 20px;">Error: ' + error.message + '</p>' +
            '</div>';
        }
    }

    function filterTests(type, btn) {
        document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const filtered = type === 'all'
            ? allTests
            : allTests.filter(t => t.testType.toLowerCase().includes(type));

        const grid = document.getElementById('test-results');
        grid.style.opacity = '0';
        grid.style.transform = 'translateY(10px)';

        setTimeout(() => {
            renderTests(filtered);
            grid.style.transition = 'all 0.4s ease';
            grid.style.opacity = '1';
            grid.style.transform = 'translateY(0)';
        }, 200);
    }

    function renderTests(list) {
        const container = document.getElementById('test-results');
        if(!list || list.length === 0) {
            container.innerHTML = '<div style="grid-column:1/-1; text-align:center; padding:60px; color:#9CA3AF; font-weight:500;">No activities found</div>';
            return;
        }

        container.innerHTML = list.map((t, i) => {
            const resultTitle = t.resultTitle || (t.status === 'COMPLETED' ? 'Result available' : 'In Progress...');
            const statusText = t.status === 'COMPLETED' ? 'Completed' : 'In Progress';
            const tagClass = getTagClass(t.testType);
            const testType = t.testType || 'Test';
            const testName = t.testName || 'Unnamed Test';

            let dateInfo = '';
            if (t.status === 'COMPLETED' && t.completedAt) {
                const completedDate = new Date(t.completedAt).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
                dateInfo = '<span>' + completedDate + '</span>';
            } else if (t.startedAt) {
                const startedDate = new Date(t.startedAt).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
                dateInfo = '<span>Started: ' + startedDate + '</span>';
            }

            const animationDelay = (i * 0.1) + 's';

            return '<div class="result-card" style="animation: reveal 0.6s var(--ease-smooth) forwards ' + animationDelay + '; opacity:0; transform:translateY(20px);">' +
                '<div class="tag ' + tagClass + '">' + testType + '</div>' +
                '<div style="font-weight:800; color:var(--text-dark); margin-bottom:4px; font-size:1.1rem; letter-spacing:-0.02em;">' + testName + '</div>' +
                '<div style="color:var(--text-grey); font-size:0.95rem; font-weight:600;">' + resultTitle + '</div>' +
                '<div style="margin-top:20px; padding-top:12px; border-top:1px solid #F3F4F6; font-size:0.8rem; color:#9CA3AF; display:flex; justify-content:space-between; font-weight:600;">' +
                dateInfo +
                '<span>' + statusText + '</span>' +
                '</div>' +
                '</div>';
        }).join('');
    }

    // --- NEW BADGE RENDERER ---
    function renderBadges(list) {
        const badgeCount = document.getElementById('badge-count');
        const badgesGrid = document.getElementById('badges-grid');

        if (!list || list.length === 0) {
            badgeCount.textContent = '0';
            badgesGrid.innerHTML = '<div style="grid-column: 1/-1; text-align:center; padding:40px; color:#9CA3AF;">No badges earned yet</div>';
            return;
        }

        badgeCount.textContent = list.length;
        badgesGrid.innerHTML = list.map(b => {
            let rarityClass = 'b-common';
            if(b.rarity === 'Rare') rarityClass = 'b-rare';
            if(b.rarity === 'Epic') rarityClass = 'b-epic';

            const icon = getIcon(b.badgeName);
            const badgeName = b.badgeName || 'Unknown Badge';
            const rarity = b.rarity || 'Common';

            return '<div class="badge-card ' + rarityClass + '">' +
                '<div class="b-icon-bg">' + icon + '</div>' +
                '<div class="b-title">' + badgeName + '</div>' +
                '<div class="b-rarity">' + rarity + '</div>' +
                '</div>';
        }).join('');
    }

    function renderAchievements(list) {
        const achievementsList = document.getElementById('achievements-list');

        if (!list || list.length === 0) {
            achievementsList.innerHTML = '<div style="text-align:center; padding:40px; color:#9CA3AF;">No recent unlocks</div>';
            return;
        }

        achievementsList.innerHTML = list.map(a => {
            const icon = getIcon(a.achievementTitle);
            const title = a.achievementTitle || 'Achievement';
            const description = a.achievementDescription || '';
            const points = a.pointsAwarded || 0;

            return '<div class="ach-item">' +
                '<div style="width:48px; height:48px; background:rgba(255, 143, 125, 0.15); color:var(--pop-coral); border-radius:14px; display:flex; align-items:center; justify-content:center;">' +
                icon +
                '</div>' +
                '<div style="flex:1;">' +
                '<div style="font-weight:700; font-size:1rem; color:var(--text-dark);">' + title + '</div>' +
                '<div style="font-size:0.85rem; color:var(--text-grey); font-weight:600;">' + description + '</div>' +
                '</div>' +
                '<div style="font-weight:800; color:var(--pop-purple); background:rgba(159, 151, 243, 0.1); padding:6px 12px; border-radius:10px; font-size:0.85rem;">' +
                '+' + points +
                '</div>' +
                '</div>';
        }).join('');
    }

    document.addEventListener('DOMContentLoaded', init);
</script>
</body>
</html>
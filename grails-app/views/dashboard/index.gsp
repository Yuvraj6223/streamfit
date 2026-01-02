<!DOCTYPE html>
<html lang="en-IN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title><g:message code="page.title" default="My Learning DNA | LearnerDNA"/></title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
            href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
            rel="stylesheet">
    <style>
    /* */
    :root {
        --game-bg-top: #E0DEFF;
        --game-bg-bottom: #FFD6C9;
        --pop-purple: #8B7FE8;
        --pop-yellow: #FFD166;
        --text-dark: #2D2A4A;
        --text-grey: #6E6B80;
        --mint-green: #4ECDC4;
        --font-display: 'Plus Jakarta Sans', 'Outfit', sans-serif;
        --pure-white: #FFFFFF;
        --soft-cream: #FFF8F0;
        --light-blue-bg: #E8F4F8;
        --charcoal-teal: #2B5F7E;
        --ease-out: cubic-bezier(0.34, 1.56, 0.64, 1);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: var(--font-display);
        background: linear-gradient(180deg,
        #9C86FF 0%,
        #C7A3EB 45%,
        #FFB085 100%);
        min-height: 100vh;
        background-attachment: fixed;
        color: var(--text-dark);
        -webkit-font-smoothing: antialiased;
        padding-bottom: 20px;
    }

    /* NAVIGATION */
    .main-nav {
        background: rgba(255, 255, 255, 0.5);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        position: sticky;
        top: 0;
        z-index: 1000;
        border-radius: 0 0 20px 20px;
        border: 1px solid rgba(255, 255, 255, 0.6);
        border-top: none;
        box-shadow: 0 12px 30px -10px rgba(28, 26, 40, 0.04);
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 6px 14px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .nav-logo img {
        height: 32px; /* Smaller logo on mobile */
        width: auto;
        transition: height 0.3s ease;
    }

    @media (min-width: 768px) {
        .nav-logo img {
            height: 40px;
        }
    }

    /* Container - Mobile First: tighter margins */
    .glass-console {
        width: 94%;
        max-width: 1100px;
        margin: 12px auto 30px auto; /* Reduced margin */
        background: transparent;
        position: relative;
        overflow: visible;
        flex-grow: 1;
    }

    @media (min-width: 768px) {
        .glass-console {
            margin: 20px auto 40px auto;
        }
    }

    .console-header {
        padding: 12px 4px;
        position: relative;
        z-index: 2;
    }

    .welcome-text {
        font-size: 1.4rem; /* Mobile Size */
        font-weight: 800;
        color: #2D2A4A;
        line-height: 1.2;
    }

    @media (min-width: 768px) {
        .welcome-text {
            font-size: 1.8rem;
        }
    }

    /* UX Improvement #2: Active Header Status */
    .sub-text {
        color: var(--text-dark);
        font-weight: 600;
        background: rgba(255, 255, 255, 0.5);
        display: inline-block;
        padding: 8px 16px;
        border-radius: 20px;
        margin-top: 12px;
        border: 1px solid rgba(255, 255, 255, 0.6);
        font-size: 0.85rem;
        line-height: 1.4;
        max-width: 100%;
    }

    .unlock-link {
        color: var(--charcoal-teal);
        font-weight: 800;
        text-decoration: none;
        margin-left: 4px;
        border-bottom: 2px solid var(--pop-purple);
        transition: all 0.2s ease;
        white-space: nowrap; /* Keep link text together */
    }

    .unlock-link:hover {
        color: var(--pop-purple);
        background: #fff;
        padding: 0 4px;
    }

    /* --- DASHBOARD GRID LAYOUT --- */
    .dashboard-grid {
        display: grid;
        gap: 16px; /* Slightly tighter gap on mobile */
        margin-bottom: 20px;
        position: relative;
        z-index: 2;
        grid-template-columns: 1fr;
    }

    @media (min-width: 768px) {
        .dashboard-grid {
            gap: 20px;
        }
    }

    /* --- COMMON PANEL STYLES --- */
    .glass-panel {
        background: rgba(255, 255, 255, 0.30);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.6);
        border-radius: 20px; /* Smaller radius on mobile */
        padding: 20px 16px; /* Less padding on mobile */
        margin: 0;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
        transition: transform 0.3s var(--ease-out);
    }

    @media (min-width: 768px) {
        .glass-panel {
            border-radius: 24px;
            padding: 24px 20px;
        }
    }

    @media (hover: hover) {
        .glass-panel:hover {
            transform: translateY(-2px);
        }
    }

    .panel-label {
        font-size: 0.75rem;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        color: var(--text-grey);
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
    }

    /* --- 1. IDENTITY CARD --- */
    .area-identity {
        grid-area: auto; /* Default stack behavior */
    }

    .identity-core {
        align-items: center;
        text-align: center;
    }

    /* Animations */
    @keyframes float {
        0% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
        100% { transform: translateY(0px); }
    }

    @keyframes spin { 100% { transform: rotate(360deg); } }
    @keyframes spin-rev { 100% { transform: rotate(-360deg); } }

    .animal-avatar-container {
        width: 120px;
        height: 120px;
        background: #FFD166;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 16px;
        border: 5px solid #FFF8F0;
        box-shadow: 0 8px 24px rgba(255, 209, 102, 0.4);
        position: relative;
        animation: float 4s ease-in-out infinite;
        overflow: hidden;
    }

    .avatar-img {
        width: 111%;
        height: auto;
        object-fit: contain;
    }

    .animal-title {
        font-size: 1.5rem; /* Mobile */
        font-weight: 800;
        color: #3B2F5F;
        margin-bottom: 6px;
    }

    @media (min-width: 768px) {
        .animal-title {
            font-size: 1.65rem;
        }
    }

    .animal-archetype {
        font-size: 0.9rem;
        letter-spacing: 0.4px;
        font-weight: 600;
        color: #E0A800;
        margin-bottom: 8px;
    }

    .archetype-desc {
        font-size: 0.9rem; /* Increased readability */
        color: #555;
        font-weight: 500;
        margin-bottom: 24px;
        max-width: 90%;
        margin-left: auto;
        margin-right: auto;
        line-height: 1.5;
    }

    .avatar-wrapper-float {
        position: relative;
        width: 160px;
        height: 160px;
        margin: 0 auto 16px auto;
        display: flex;
        justify-content: center;
        align-items: center;
        animation: float 4s ease-in-out infinite;
    }

    .animal-avatar-container {
        animation: none !important;
        margin: 0 !important;
        z-index: 5;
    }

    .core-ring {
        position: absolute;
        border-radius: 50%;
        pointer-events: none;
    }

    .cr-1 {
        width: 80%;
        height: 80%;
        border: 2px dashed rgba(139, 127, 232, 0.3);
        animation: spin 12s linear infinite;
    }

    .cr-2 {
        width: 95%;
        height: 95%;
        border-top: 4px solid #E0A800;
        border-bottom: 4px solid #8B7FE8;
        border-left: 4px solid transparent;
        border-right: 4px solid transparent;
        animation: spin-rev 8s linear infinite;
    }

    .cr-3 {
        width: 105%;
        height: 105%;
        border: 1px solid rgba(255, 255, 255, 0.4);
        opacity: 0.6;
        animation: spin 20s linear infinite;
    }

    .progress-mini {
        width: 100%;
        text-align: left;
        max-width: 300px;
    }

    .prog-label {
        font-size: 0.75rem;
        font-weight: 700;
        color: var(--text-grey);
        margin-bottom: 6px;
        display: flex;
        justify-content: space-between;
    }

    .prog-track {
        height: 8px;
        background: rgba(0, 0, 0, 0.06);
        border-radius: 10px;
        overflow: hidden;
    }

    .prog-fill {
        height: 100%;
        background: var(--pop-purple);
        border-radius: 10px;
        width: 0%;
        transition: width 1s ease;
    }

    /* --- 2. COGNITIVE RADAR --- */
    .area-radar {
        grid-area: auto;
        height: 100%;
    }

    /* Side by Side Grid for Radar */
    .radar-content-wrapper {
        display: grid;
        gap: 24px;
        align-items: center;
        height: 100%;
        grid-template-columns: 1fr; /* Mobile default: Stacked */
    }

    @media (min-width: 768px) {
        .radar-content-wrapper {
            grid-template-columns: 1fr 1fr; /* Side-by-side on tablet/desktop */
        }
    }

    .radar-chart-container {
        position: relative;
        padding-bottom: 32px;
        overflow: hidden;
    }

    .radar-badge {
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
    }

    @media (min-width: 768px) {
        .radar-chart-container {
            height: 300px; /* Restore height for Desktop */
            overflow: hidden;
        }
    }

    /* UX Improvement #3: Synthesis Badge */
    .radar-badge {
        margin-top: 10px;
        background: linear-gradient(90deg, #E0DEFF, #FFF);
        color: var(--pop-purple);
        font-size: 0.75rem;
        font-weight: 800;
        padding: 6px 12px;
        width: 260px;
        border-radius: 12px;
        border: 1px solid #fff;
        box-shadow: 0 4px 10px rgba(139, 127, 232, 0.15);
    }

    .radar-bars {
        display: flex;
        flex-direction: column;
        gap: 16px;
        justify-content: center;
        width: 100%;
    }

    .skill-row {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .skill-icon {
        width: 32px;
        height: 32px;
        border-radius: 8px;
        background: var(--light-blue-bg);
        color: var(--text-dark);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .skill-data {
        flex: 1;
    }

    .sd-head {
        display: flex;
        justify-content: space-between;
        align-items: baseline; /* Better alignment for mixed font sizes */
        font-size: 0.8rem;
        font-weight: 700;
        margin-bottom: 6px;
        color: var(--text-dark);
    }

    /* Micro-adjustment: Visual hierarchy for tiers */
    .sd-head small {
        font-size: 0.9em;
        font-weight: 500;
        color: var(--text-grey);
        margin-left: 4px;
    }

    .sd-track {
        height: 6px;
        background: rgba(0, 0, 0, 0.05);
        border-radius: 10px;
        overflow: hidden;
    }

    .sd-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--pop-purple), #E0B65C);
        border-radius: 10px;
        width: 0%;
        transition: width 1.5s ease;
    }

    /* --- 3. TRAIT TOKENS --- */
    .area-traits {
        grid-area: auto;
        height: 100%;
    }

    /* Grid for Traits */
    .traits-grid {
        display: grid;
        gap: 12px;
        align-content: center;
        height: 100%;
        grid-template-columns: 1fr; /* Mobile default: 1 Col */
    }

    @media (min-width: 480px) {
        /* Small Tablet / Large Phone Landscape */
        .traits-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (min-width: 1024px) {
        /* Desktop - maybe stick to 2x2 */
        .traits-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    .trait-token {
        background: rgba(255, 255, 255, 0.9);
        border-left: 3px solid var(--pop-purple);
        border-radius: 16px;
        padding: 16px 12px;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        transition: 0.2s;
        justify-content: center;
        height: 100%;
    }

    .trait-token:hover {
        border-color: var(--pop-purple);
        transform: translateY(-2px);
    }

    .tt-label {
        font-size: 0.65rem;
        font-weight: 600;
        color: var(--text-grey);
        text-transform: uppercase;
        margin-bottom: 4px;
    }

    .tt-val {
        font-size: 0.9rem;
        font-weight: 700;
        color: var(--text-dark);
    }

    .tt-desc {
        font-size: 0.75rem;
        color: var(--text-grey);
        margin-top: 8px;
        line-height: 1.35;
        font-weight: 500;
        max-width: 100%;
    }

    /* --- STREAMS --- */
    .results-deck {
        grid-column: 1 / -1;
        background: rgba(255, 255, 255, 0.35);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.6);
        border-radius: 24px;
        padding: 24px 20px;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.05);
    }

    /* Stream Suggestions Responsive Logic */
    .cards-scroller {
        display: grid;
        gap: 16px;
        grid-template-columns: 1fr; /* Mobile: 1 Col */
    }

    @media (min-width: 650px) {
        .cards-scroller {
            grid-template-columns: repeat(2, 1fr); /* Tablet: 2 Cols */
        }
    }

    @media (min-width: 1000px) {
        .cards-scroller {
            grid-template-columns: repeat(3, 1fr); /* Desktop: 3 Cols */
        }
    }

    .stream-card {
        background: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        position: relative;
        overflow: hidden;
        transition: 0.3s;
    }

    @media (hover: hover) {
        .stream-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 16px 30px rgba(0, 0, 0, 0.08);
        }
    }

    /* UX Improvement #1: Hero Card Distinction */
    .stream-card.hero-card {
        background: #ffffff;
        border: 2px solid var(--pop-purple);
        transform: scale(1.00); /* No scale on mobile to save space */
        box-shadow: 0 12px 40px rgba(139, 127, 232, 0.15);
        z-index: 2;
    }

    @media (min-width: 768px) {
        .stream-card.hero-card {
            transform: scale(1.02); /* Restore scale on larger screens */
        }
    }

    .stream-card.hero-card:hover {
        transform: scale(1.03) translateY(-4px);
        border-color: var(--text-dark);
    }

    /* Standard card hover for non-hero cards */
    .stream-card:not(.hero-card):hover {
        border-color: rgba(0, 0, 0, 0.1);
        background: #FAFAFC;
    }

    .sc-match-tag {
        position: absolute;
        top: 12px;
        right: 12px;
        font-size: 0.65rem;
        font-weight: 700;
        padding: 4px 10px;
        border-radius: 100px;
        background: #F0F0F2;
        color: var(--text-grey);
        letter-spacing: 0.3px;
    }

    /* Specific emphasis for the best match tag */
    .sc-match-tag.best {
        background: var(--mint-green);
        color: #fff;
        /* White text for better contrast on mint */
        box-shadow: 0 2px 8px rgba(78, 205, 196, 0.4);
    }

    .sc-icon {
        width: 44px;
        height: 44px;
        border-radius: 12px;
        background: var(--soft-cream);
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 16px;
        font-size: 1.2rem;
    }

    .sc-title {
        font-size: 1.1rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 6px;
    }

    .sc-desc {
        font-size: 0.85rem;
        color: var(--text-grey);
        line-height: 1.45;
    }

    .sc-action {
        margin-top: 16px;
        padding-top: 12px;
        border-top: 1px solid #F5F5F7;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .btn-text {
        font-size: 0.8rem;
        font-weight: 700;
        color: #4ECDC4;
        text-decoration: none;
    }

    /* --- NEXT STEPS --- */
    .area-next {
        grid-area: auto;
    }

    /* Next Steps Responsive */
    .next-steps-list {
        display: grid;
        gap: 16px;
        grid-template-columns: 1fr; /* Mobile: 1 Col */
    }

    @media (min-width: 900px) {
        .next-steps-list {
            grid-template-columns: repeat(3, 1fr); /* Desktop: 3 Cols */
        }
    }

    /* Primary Action - "Do This Now" */
    .ns-item.primary {
        background: linear-gradient(135deg, var(--pop-purple), #6A5FC1);
        color: #fff;
        padding: 24px;
        border-radius: 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        position: relative;
        box-shadow: 0 10px 25px rgba(139, 127, 232, 0.3);
        border: 2px solid rgba(255, 255, 255, 0.2);
        transition: transform 0.2s, box-shadow 0.2s;
        cursor: pointer;
        text-decoration: none;
        height: 100%;
    }

    .ns-item.primary:hover {
        transform: translateY(-4px);
        box-shadow: 0 15px 35px rgba(139, 127, 232, 0.4);
    }

    .ns-tag {
        background: #FFD166;
        color: #2D2A4A;
        font-size: 0.65rem;
        font-weight: 800;
        text-transform: uppercase;
        padding: 4px 10px;
        border-radius: 20px;
        position: absolute;
        top: 16px;
        right: 16px;
        letter-spacing: 0.5px;
    }

    .ns-item.primary h4 {
        font-size: 1.2rem;
        font-weight: 700;
        margin-bottom: 8px;
        font-family: var(--font-display);
    }

    .ns-item.primary p {
        font-size: 0.9rem;
        opacity: 0.9;
        line-height: 1.4;
        margin-bottom: 0;
        max-width: 85%;
    }

    /* Secondary Actions - "Explore Later" */
    .ns-item.secondary {
        background: rgba(255, 255, 255, 0.5);
        border: 1px solid rgba(255, 255, 255, 0.6);
        padding: 20px;
        border-radius: 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        transition: background 0.2s, transform 0.2s;
        cursor: pointer;
        text-decoration: none;
        height: 100%;
    }

    .ns-item.secondary:hover {
        background: #fff;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }

    .ns-item.secondary h4 {
        font-size: 0.95rem;
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 6px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .ns-item.secondary p {
        font-size: 0.8rem;
        color: var(--text-grey);
        line-height: 1.4;
    }

    /* FOOTER - MOBILE FIRST OVERHAUL */
    .main-footer {
        margin-top: 60px;
        background: rgba(255, 255, 255, 0.5);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-radius: 24px;
        padding: 40px 24px;
        border: 1px solid rgba(255, 255, 255, 0.6);
        box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.05), 0 12px 30px -10px rgba(28, 26, 40, 0.04);
        position: relative;
        overflow: hidden;
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
        display: grid;
        gap: 32px;
        align-items: start;
        grid-template-columns: 1fr; /* Default Mobile: Stacked */
    }

    @media (min-width: 600px) {
        .main-footer {
            grid-template-columns: 1fr 1fr; /* Tablet: 2 Col */
        }
    }

    @media (min-width: 1024px) {
        .main-footer {
            margin-top: 80px;
            padding: 60px;
            border-radius: 32px;
            grid-template-columns: 1.5fr 1fr 1fr 1fr; /* Desktop: 4 Col */
            gap: 40px;
        }
    }

    .footer-brand h2 {
        font-family: var(--font-display);
        font-weight: 800;
        letter-spacing: -0.02em;
        font-size: 1.6rem;
        color: var(--text-dark);
    }

    .social-row {
        display: flex;
        gap: 16px;
        align-items: center;
    }

    .social-btn {
        color: #000000;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.2s ease;
    }

    @media (hover: hover) {
        .social-btn:hover {
            transform: translateY(-2px);
            color: var(--pop-purple, #9F97F3);
        }
    }

    .footer-col h3 {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: var(--text-grey, #8E8C9A);
        font-weight: 700;
        margin: 0 0 20px 0;
    }

    .footer-tagline {
        font-family: var(--font-display);
        color: var(--pop-purple);
        font-size: 0.95rem;
        font-weight: 700;
        letter-spacing: 0.5px;
        text-transform: uppercase;
        font-style: normal;
        margin: -4px 0 20px 2px;
        opacity: 1;
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
        color: var(--text-dark, #1A1825);
        font-weight: 500;
        font-size: 0.95rem;
        transition: color 0.2s;
        opacity: 0.8;
    }

    .footer-link-list a:hover {
        color: var(--pop-purple, #9F97F3);
        opacity: 1;
    }

    .footer-bottom {
        grid-column: 1 / -1;
        margin-top: 20px;
        padding-top: 24px;
        border-top: 1px solid rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column; /* Stacked on Mobile */
        align-items: center;
        gap: 16px;
        color: var(--text-grey, #8E8C9A);
        font-size: 0.85rem;
        font-weight: 600;
        text-align: center;
    }

    @media (min-width: 600px) {
        .footer-bottom {
            flex-direction: row; /* Row on Tablet+ */
            justify-content: space-between;
            margin-top: 40px;
        }
    }

    .footer-links {
        display: flex;
        gap: 20px;
    }

    .footer-links a {
        color: var(--text-grey, #8E8C9A);
        text-decoration: none;
        transition: color 0.2s;
    }

    .footer-links a:hover {
        color: var(--pop-purple, #9F97F3);
    }
    </style>
</head>

<body>

<nav class="main-nav">
    <div class="nav-container">
        <g:link uri="/" class="nav-logo">
            <asset:image src="logo1.png" alt="LearnerDNA - Free Student Aptitude Test" onerror="this.src='https://placehold.co/150x40?text=LearnerDNA'" />
        </g:link>
    </div>
</nav>

<div class="glass-console">

    <header class="console-header anim-pop">
        <div class="welcome-text">Hello, ${userName ?: 'Alex'} 👋</div>
        <div class="sub-text">
            ⚠️ 15% Hidden. <a href="#" class="unlock-link">Reveal Data.</a>
        </div>
    </header>

    <div class="dashboard-grid">

        <div class="glass-panel identity-core anim-pop d-2 area-identity">
            <div class="avatar-wrapper-float">
                <div class="core-ring cr-1"></div>
                <div class="core-ring cr-2"></div>
                <div class="core-ring cr-3"></div>
                <div class="animal-avatar-container">
                    <asset:image src="wolf.png" alt="${archetypeTitle ?: 'Strategic Wolf'}" class="avatar-img" onerror="this.src='https://placehold.co/120x120?text=Wolf'"/>
                </div>
            </div>
            <div class="animal-title">${archetypeTitle ?: 'The Strategic Wolf'}</div>
            <div class="animal-archetype">"${archetypeSubtitle ?: 'The Hunter'}"</div>
            <div class="archetype-desc">${userDescription ?: 'Alex, your unique cognitive signature prioritizes structural visualization over verbal processing.'}</div>

            <div class="progress-mini">
                <div class="prog-label">
                    <span>Profile Completion</span>
                    <span>7/9 Tests</span>
                </div>
                <div class="prog-track">
                    <div class="prog-fill" style="width: 78%"></div>
                </div>
                <div style="font-size:0.7rem; color:var(--text-grey); margin-top:8px; text-align:center;">
                    Next: <g:link controller="test" action="guessworkQuotient" style="color:var(--charcoal-teal); font-weight:700; text-decoration:none;">Guesswork Quotient</g:link>
                </div>
            </div>
        </div>

        <div class="glass-panel anim-pop d-1 area-traits">
            <div class="panel-label">
                <span>Key Traits</span>
            </div>
            <div class="traits-grid">
                <div class="trait-token">
                    <div class="tt-label">🧠 Curiosity</div>
                    <div class="tt-val" id="trait-curiosity">${traitCuriosity ?: 'Theorist'}</div>
                    <div class="tt-desc">You crave logical frameworks and structural understanding over intuition.
                    </div>
                </div>
                <div class="trait-token">
                    <div class="tt-label">👁️ Learning Mode</div>
                    <div class="tt-val" id="trait-mode">${traitMode ?: 'Visual'}</div>
                    <div class="tt-desc">Spatial diagrams and color-coding accelerate your information recall.</div>
                </div>
                <div class="trait-token">
                    <div class="tt-label">⚡ Driver</div>
                    <div class="tt-val" id="trait-driver">${traitDriver ?: 'Challenge'}</div>
                    <div class="tt-desc">Complex, high-stakes problems trigger your deepest engagement.</div>
                </div>
                <div class="trait-token">
                    <div class="tt-label">👤 Work Style</div>
                    <div class="tt-val" id="trait-work">${traitWork ?: 'Soloist'}</div>
                    <div class="tt-desc">Uninterrupted, autonomous focus yields your highest quality output.</div>
                </div>
            </div>
        </div>

        <div class="glass-panel anim-pop d-3 area-radar">
            <div class="panel-label">Cognitive Radar</div>

            <div class="radar-content-wrapper">
                <div class="radar-chart-container">
                    <canvas id="radarChart"></canvas>
                    <div class="radar-badge">Rare Pattern: Spatial + Logic Dominance</div>
                </div>

                <div class="radar-bars">
                    <div class="skill-row">
                        <div class="skill-icon">🧩</div>
                        <div class="skill-data">
                            <div class="sd-head"><span>Logic</span> <span>88% <small>(Advanced)</small></span></div>
                            <div class="sd-track">
                                <div class="sd-fill" style="width: 88%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="skill-row">
                        <div class="skill-icon">🗣️</div>
                        <div class="skill-data">
                            <div class="sd-head"><span>Verbal</span> <span>65% <small>(Steady)</small></span></div>
                            <div class="sd-track">
                                <div class="sd-fill" style="width: 65%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="skill-row">
                        <div class="skill-icon">📐</div>
                        <div class="skill-data">
                            <div class="sd-head"><span>Spatial</span> <span>92% <small>(Elite)</small></span></div>
                            <div class="sd-track">
                                <div class="sd-fill" style="width: 92%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="skill-row">
                        <div class="skill-icon">⚡</div>
                        <div class="skill-data">
                            <div class="sd-head"><span>Speed</span> <span>74% <small>(Strong)</small></span></div>
                            <div class="sd-track">
                                <div class="sd-fill" style="width: 74%"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="results-deck anim-pop d-3">
            <div class="panel-label">learnerDNA Suggestions (Top 3)</div>
            <div class="cards-scroller" id="stream-cards">

                <div class="stream-card hero-card">
                    <div class="sc-match-tag best">94% Match • Best Fit</div>
                    <div>
                        <div class="sc-icon">🏗️</div>
                        <div class="sc-title">Engineering</div>
                        <div class="sc-desc">Your elite Logic and Spatial reasoning capabilities align powerfully
                        with the structural demands of this field.</div>
                    </div>
                    <div class="sc-action">
                        <span style="font-size:0.7rem; color:var(--text-dark); font-weight: 600;">Outcome: Secure Your Future</span>
                    </div>
                </div>

                <div class="stream-card">
                    <div class="sc-match-tag">88% Match • Creative Pivot</div>
                    <div>
                        <div class="sc-icon">🧬</div>
                        <div class="sc-title">Architecture</div>
                        <div class="sc-desc">A robust alternative. Leans heavily on your Visual strengths but
                        utilizes less raw Logic than Engineering.</div>
                    </div>
                    <div class="sc-action">
                        <span style="font-size:0.7rem; color:var(--text-grey);">Outcome: Express Your Vision</span>
                        <g:link controller="career" action="path" id="architecture" class="btn-text" style="color:var(--text-grey);">Explore Path →</g:link>
                    </div>
                </div>

                <div class="stream-card">
                    <div class="sc-match-tag">76% Match • Strategic Reach</div>
                    <div>
                        <div class="sc-icon">💻</div>
                        <div class="sc-title">Comp. Science</div>
                        <div class="sc-desc">A viable high-growth trajectory. Note: Success here requires specific
                        training to boost your Focus stamina.</div>
                    </div>
                    <div class="sc-action">
                        <span style="font-size:0.7rem; color:var(--text-grey);">Outcome: Reach Goals Faster</span>
                        <g:link controller="career" action="path" id="cs" class="btn-text" style="color:var(--text-grey);">Explore Path →</g:link>
                    </div>
                </div>

            </div>
        </div>

        <div class="glass-panel area-next anim-pop d-3">
            <div class="panel-label">Your Next Steps</div>
            <div class="next-steps-list">

                <g:link controller="test" action="guessworkQuotient" class="ns-item primary">
                    <span class="ns-tag">Start Here</span>
                    <h4>Calibrate Decisions</h4>
                    <p>Take the 2-minute Guesswork Quotient test to complete your profile.</p>
                </g:link>

                <g:link controller="career" action="details" id="engineering" class="ns-item secondary">
                    <h4>Explore Engineering</h4>
                    <p>See how your logic score maps to this career path.</p>
                </g:link>

                <g:link controller="training" action="spatialDrill" class="ns-item secondary">
                    <h4>Train Spatial Skills</h4>
                    <p>Start a quick 5-minute drill to boost your stats.</p>
                </g:link>

            </div>
        </div>

    </div>

    <div style="text-align: center; margin-top: 40px; margin-bottom: 10px; color: var(--text-dark); opacity: 0.8; font-weight: 600; font-size: 1.1rem; font-family: var(--font-display);"
         class="anim-pop d-3">
        Your potential is mapped. Trust your unique strengths.
    </div>

</div>

<footer class="main-footer">
    <div class="footer-brand">
        <h2>LearnerDNA</h2>
        <p class="footer-tagline">Know Your Game.</p>
        <div class="social-row">
            <g:link uri="#" class="social-btn" aria-label="Twitter">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                     stroke-linecap="round" stroke-linejoin="round">
                    <path
                            d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z">
                    </path>
                </svg>
            </g:link>
            <g:link uri="#" class="social-btn" aria-label="LinkedIn">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                     stroke-linecap="round" stroke-linejoin="round">
                    <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path>
                    <rect x="2" y="9" width="4" height="12"></rect>
                    <circle cx="4" cy="4" r="2"></circle>
                </svg>
            </g:link>
            <g:link uri="#" class="social-btn" aria-label="Instagram">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                     stroke-linecap="round" stroke-linejoin="round">
                    <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                    <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                    <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                </svg>
            </g:link>
        </div>
    </div>

    <div class="footer-col">
        <h3>LearnerDNA</h3>
        <ul class="footer-link-list">
            <li><g:link uri="/">Home</g:link></li>
            <li><g:link controller="personality" action="start">Take the Test</g:link></li>
        </ul>
    </div>

    <div class="footer-col">
        <h3>SUPPORT</h3>
        <ul class="footer-link-list">
            <li><g:link uri="/faq">FAQ</g:link></li>
            <li><g:link uri="/contact">Contact Us</g:link></li>
            <li><g:link uri="/about">About learnerDNA</g:link></li>
        </ul>
    </div>

    <div class="footer-bottom">
        <div>© <g:formatDate format="yyyy" date="${new Date()}"/> LearnerDNA. All rights reserved.</div>
        <div class="footer-links">
            <g:link uri="/terms">Terms</g:link>
            <g:link uri="/privacy">Privacy</g:link>
            <g:link uri="/contact">Contact</g:link>
        </div>
    </div>
</footer>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Animate progress bars on load
        setTimeout(() => {
            document.querySelectorAll('.sd-fill').forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => bar.style.width = width, 100);
            });

            const mainProg = document.querySelector('.prog-fill');
            const mainW = mainProg.style.width;
            mainProg.style.width = '0%';
            setTimeout(() => mainProg.style.width = mainW, 300);
        }, 500);

        // --- RENDER RADAR CHART ---
        const ctx = document.getElementById('radarChart').getContext('2d');

        // Create Gradient
        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, 'rgba(139, 127, 232, 0.6)'); // Purple
        gradient.addColorStop(1, 'rgba(78, 205, 196, 0.4)');  // Teal

        // Stats Data
        // TODO: Inject data via GSP. Example: data: ${radarDataList ?: [88, 65, 92, 74, 60]}
        const data = {
            labels: ['Logic', 'Verbal', 'Spatial', 'Speed', 'Focus'],
            datasets: [{
                label: 'Cognitive Profile',
                data: [88, 65, 92, 74, 60],
                backgroundColor: gradient, // Use Gradient Fill
                borderColor: '#6C52D9',
                borderWidth: 3,
                pointBackgroundColor: '#fff',
                pointBorderColor: '#8B7FE8',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
            }]
        };

        const config = {
            type: 'radar',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: 10
                },
                scales: {
                    r: {
                        angleLines: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)',
                            circular: true
                        },
                        pointLabels: {
                            font: {
                                family: "'Plus Jakarta Sans', sans-serif",
                                size: 11,
                                weight: '700'
                            },
                            color: '#2D2A4A',
                            padding: 10
                        },
                        suggestedMin: 0,
                        suggestedMax: 100,
                        ticks: {
                            display: false,
                            backdropColor: 'transparent'
                        }
                    }
                },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: 'rgba(45, 42, 74, 0.95)',
                        padding: 12,
                        cornerRadius: 12,
                        titleFont: { size: 14, weight: 'bold' },
                        bodyFont: { size: 14 },
                        displayColors: false
                    }
                },
                animation: {
                    duration: 2000,
                    easing: 'easeOutQuart'
                }
            }
        };

        new Chart(ctx, config);
    });
</script>
</body>

</html>

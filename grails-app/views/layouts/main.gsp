<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover, minimum-scale=1.0, maximum-scale=5.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- Critical Performance Optimizations for Android -->
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <meta name="force-rendering" content="webkit">

    <!-- SEO Meta Tags -->
    <title><g:layoutTitle default="Free Student Aptitude Test India | Discover Your Learning DNA | LearnerDNA"/></title>
    <meta name="description" content="${pageDescription ?: 'Discover your learning style, cognitive strengths & ideal career stream. Free aptitude test for students aged 14-20. No signup required. 10,000+ students tested.'}">
    <meta name="keywords" content="${pageKeywords ?: 'student aptitude test, learning style test, career guidance, stream selection, cognitive assessment, free aptitude test India'}">
    <meta name="author" content="LearnerDNA">
    <meta name="robots" content="${pageRobots ?: 'index, follow'}">

    <!-- Geographic Targeting -->
    <meta name="geo.region" content="IN">
    <meta name="geo.placename" content="India">

    <!-- Canonical URL -->
    <g:set var="canonicalUrl" value="${pageCanonical ?: (request.scheme + '://' + request.serverName + request.forwardURI)}" />
    <link rel="canonical" href="${canonicalUrl}">

    <!-- Alternate Language Versions -->
    <link rel="alternate" hreflang="en-IN" href="${canonicalUrl}">
    <link rel="alternate" hreflang="en" href="${canonicalUrl}">
    <link rel="alternate" hreflang="x-default" href="${canonicalUrl}">

    <!-- Open Graph Meta Tags -->
    <meta property="og:type" content="${pageType ?: 'website'}">
    <meta property="og:site_name" content="LearnerDNA">
    <meta property="og:title" content="${pageTitle ?: 'LearnerDNA - Discover Your Learning DNA'}">
    <meta property="og:description" content="${pageDescription ?: 'Free aptitude test for students. Discover your learning style and ideal career stream in 20 minutes.'}">
    <meta property="og:url" content="${canonicalUrl}">
    <meta property="og:locale" content="en_IN">
    <meta property="og:image" content="${pageImage ?: (request.scheme + '://' + request.serverName + assetPath(src: 'logo1.png'))}">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="630">

    <!-- Twitter Card Meta Tags -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="${pageTitle ?: 'LearnerDNA - Discover Your Learning DNA'}">
    <meta name="twitter:description" content="${pageDescription ?: 'Free aptitude test for students. Discover your learning style and ideal career stream.'}">
    <meta name="twitter:image" content="${pageImage ?: (request.scheme + '://' + request.serverName + assetPath(src: 'logo1.png'))}">

    <!-- Mobile Optimization -->
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <meta name="apple-mobile-web-app-title" content="LearnerDNA">
    <meta name="theme-color" content="#3A7CA5">

    <!-- Preconnect for Performance -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="dns-prefetch" href="https://fonts.googleapis.com">
    <link rel="dns-prefetch" href="https://fonts.gstatic.com">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Critical CSS inline for faster rendering -->
    <style>
        /* Critical above-the-fold styles */
        body { margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif; }
        .main-nav { position: sticky; top: 0; z-index: 1000; background: rgba(255, 255, 255, 0.5); }
        img { max-width: 100%; height: auto; }
    </style>

    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="personality-test.css"/>
    <asset:stylesheet src="mobile.css"/>
    <asset:javascript src="application.js"/>
    <asset:javascript src="mobile-enhancements.js"/>
    <asset:javascript src="mobile-share.js"/>
    <asset:javascript src="dynamic-nav.js"/>
    <asset:javascript src="auth.js"/>
    <!-- Load CSS with media attribute for non-blocking -->
    <asset:stylesheet src="application.css" media="all"/>
    <asset:stylesheet src="personality-test.css" media="all"/>
    <asset:stylesheet src="mobile.css" media="all"/>

    <!-- Defer non-critical JavaScript -->
    <asset:javascript src="application.js" defer="true"/>
    <asset:javascript src="mobile-enhancements.js" defer="true"/>
    <asset:javascript src="mobile-share.js" defer="true"/>

    <g:layoutHead/>

    <!-- Structured Data (JSON-LD) -->
    <g:if test="${structuredData}">
        <script type="application/ld+json">
            ${raw(structuredData)}
        </script>
    </g:if>
    <g:else>
        <!-- Default Organization Schema -->
        <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "EducationalOrganization",
            "name": "LearnerDNA",
            "alternateName": "StreamFit",
            "url": "${request.scheme}://${request.serverName}",
            "logo": "${request.scheme}://${request.serverName}${assetPath(src: 'logo1.png')}",
            "description": "India's leading student diagnostic platform for learning style assessment and career guidance",
            "address": {
                "@type": "PostalAddress",
                "addressCountry": "IN"
            }
        }
        </script>
    </g:else>

    <style>
    /* StreamFit Color Palette */
    :root {
        --deep-night-blue: #2B5F7E;
        --ocean-blue: #3A7CA5;
        --soft-teal-blue: #4A9BB5;
        --sky-blue: #A8DADC;

        --pure-white: #FFFFFF;
        --soft-cream: #FFF8F0;
        --light-blue-bg: #E8F4F8;

        --charcoal-teal: #2B5F7E;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Arial, sans-serif;
        background: linear-gradient(
                180deg,
                var(--light-blue-bg) 0%,
                var(--pure-white) 30%,
                var(--soft-cream) 100%
        );
        min-height: 100vh;
        /* Performance optimizations */
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-rendering: optimizeSpeed;
    }

    /* Critical performance optimizations for all elements */
    * {
        /* Prevent layout thrashing */
        -webkit-tap-highlight-color: transparent;
    }

    /* Optimize images globally */
    img {
        content-visibility: auto;
        image-rendering: -webkit-optimize-contrast;
    }

    /* NAVIGATION - MATCHING FOOTER GLASSMORPHISM STYLE */
    .main-nav {
        /* Same frosted glass effect as footer */
        background: rgba(255, 255, 255, 0.5);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);

        position: sticky;
        top: 0;
        z-index: 1000;

        /* Rounded bottom edges like footer corners */
        border-radius: 0 0 32px 32px;

        /* Same border style as footer */
        border: 1px solid rgba(255, 255, 255, 0.6);
        border-top: none;

        /* Same soft shadow as footer */
        box-shadow: 0 12px 30px -10px rgba(28, 26, 40, 0.04);

        /* Smooth fade in/fade out transition */
        transition: opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1),
                    transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);

        /* Subtle overflow handling like footer */
        position: relative;
        overflow: visible;

        /* Will be controlled by JavaScript */
        opacity: 1;
        pointer-events: auto;
    }

    /* Hidden state for nav (when CTA is visible) */
    .main-nav[aria-hidden="true"] {
        opacity: 0;
        pointer-events: none;
        transform: translateY(-10px);
    }

    /* Respect user's motion preferences */
    @media (prefers-reduced-motion: reduce) {
        .main-nav {
            transition: opacity 0.2s ease;
        }

        .main-nav[aria-hidden="true"] {
            transform: none;
        }

        /* Performance optimizations */
        contain: layout style;
        will-change: opacity;
        transform: translateZ(0);
        backface-visibility: hidden;
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 12px 32px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 20px;
    }

    .nav-logo {
        text-decoration: none;
        display: flex;
        align-items: center;
        transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    }

    .nav-logo img {
        height: 50px;
        width: auto;
        transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        filter: drop-shadow(0 2px 4px rgba(139, 127, 232, 0.1));
    }

    .nav-logo:hover {
        transform: scale(1.03);
    }

    .nav-logo img:hover {
        transform: scale(1.05) rotate(-2deg);
    }

    /* GAME-STYLE CTA BUTTON */
    .nav-cta-wrapper {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .btn {
        padding: 8px 16px;
        border-radius: 12px;
        border: none;
        font-weight: 700;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        font-size: 0.85rem;
        position: relative;
    }

    .btn-primary {
        /* Playful gradient matching page theme */
        background: linear-gradient(135deg, #8B7FE8 0%, #A89FF3 50%, #C4B5FD 100%);
        color: #FFFFFF;

        /* Pill-shaped for game feel */
        border-radius: 999px;

        /* Soft glow effect */
        box-shadow:
            0 4px 0 #7B6FD8,
            0 6px 16px rgba(139, 127, 232, 0.35),
            inset 0 1px 0 rgba(255, 255, 255, 0.3);

        /* Slightly larger for emphasis */
        font-size: 0.9rem;
        font-weight: 800;
        padding: 10px 20px;

        /* Prevent text selection */
        user-select: none;
        -webkit-user-select: none;
    }

    .btn-primary:hover {
        transform: translateY(-2px) scale(1.02);
        box-shadow:
            0 6px 0 #7B6FD8,
            0 8px 24px rgba(139, 127, 232, 0.45),
            inset 0 1px 0 rgba(255, 255, 255, 0.4);
    }

    .btn-primary:active {
        transform: translateY(2px) scale(0.98);
        box-shadow:
            0 2px 0 #7B6FD8,
            0 4px 12px rgba(139, 127, 232, 0.3),
            inset 0 1px 0 rgba(255, 255, 255, 0.3);
    }


    /* ✅ FIXED NAV CTA (KEY CHANGE) */
    /* Update around Line 1056 in main.gsp */
    .nav-cta {
        white-space: nowrap;

        /* OVERRIDE: Make the nav button smaller than hero buttons */
        padding: 8px 18px !important;
        font-size: 0.85rem !important;

        /* Optional: reduce the border radius slightly to match the smaller size */
        border-radius: 20px;
    }

    .footer-brand p {
        color: var(--text-grey, #8E8C9A);
        line-height: 1.6;
        font-size: 0.95rem;
        max-width: 280px;
        margin: 0 0 24px 0;
    }

    .social-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        color: var(--pop-purple, #9F97F3);
    }

    /* RESPONSIVE - MOBILE GAME HUD */
    @media (max-width: 768px) {
        .main-nav {
            /* Keep same frosted glass on mobile */
            background: rgba(255, 255, 255, 0.5);
            border-radius: 0 0 24px 24px;
        }

        .nav-container {
            padding: 8px 16px;
        }

        .nav-logo img {
            height: 45px;
        }

        .btn-primary {
            font-size: 0.7rem;
            padding: 6px 12px;
            box-shadow:
                0 2px 0 #7B6FD8,
                0 4px 12px rgba(139, 127, 232, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-1px) scale(1.01);
            box-shadow:
                0 3px 0 #7B6FD8,
                0 5px 16px rgba(139, 127, 232, 0.4),
                inset 0 1px 0 rgba(255, 255, 255, 0.4);
        }

        .btn-primary:active {
            transform: translateY(1px) scale(0.99);
        }

        .nav-helper-text {
            font-size: 0.6rem;
        }

        /* Footer Mobile */
        .main-footer {
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

    @media (max-width: 480px) {
        .main-nav {
            border-radius: 0 0 20px 20px;
        }

        .nav-container {
            padding: 6px 14px;
        }

        .nav-logo img {
            height: 40px;
            width: 130px;
        }

        .btn-primary {
            font-size: 0.65rem;
            padding: 5px 10px;
        }
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

    <script>
    // Performance-optimized nav scroll behavior
    (function() {
        let ticking = false;
        let lastScroll = 0;

        function updateNav() {
            const nav = document.querySelector('.main-nav');
            if (!nav) return;

            const currentScroll = window.pageYOffset;

            // Slightly reduce opacity when scrolling down (keeps focus on content)
            if (currentScroll > 100) {
                nav.style.opacity = '0.95';
            } else {
                nav.style.opacity = '1';
            }

            lastScroll = currentScroll;
            ticking = false;
        }

        function requestTick() {
            if (!ticking) {
                window.requestAnimationFrame(updateNav);
                ticking = true;
            }
        }

        // Use passive listener for better scroll performance
        window.addEventListener('scroll', requestTick, { passive: true });
    })();
    </script>

    <style>
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
    <style>
    </style>
</head>

<body class="${pageBodyClass ?: ''}">

<!-- NAV - GAME HUD OVERLAY -->
<nav class="main-nav">
    <div class="nav-container">
        <a href="${createLink(uri: '/')}" class="nav-logo">
            <img src="${assetPath(src: 'logo1.png')}" alt="LearnerDNA - Free Student Aptitude Test" width="120" height="120"/>
        </a>

        <style>
            .nav-menu-wrapper {
                position: relative;
            }

            .nav-menu-button {
                background: transparent;
                border: none;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: transform 0.2s ease;
            }

            .nav-menu-button:hover {
                transform: scale(1.1);
            }

            .nav-menu-button svg {
                width: 20px;
                height: 20px;
                stroke: var(--deep-night-blue);
            }

            .nav-menu-button svg line {
                transition: transform 0.3s ease, opacity 0.3s ease;
                transform-origin: center;
            }

            .nav-menu-button.is-active svg line:nth-child(1) {
                opacity: 0;
            }
            .nav-menu-button.is-active svg line:nth-child(2) {
                transform: translateY(6px) rotate(45deg);
            }
            .nav-menu-button.is-active svg line:nth-child(3) {
                transform: translateY(-6px) rotate(-45deg);
            }

            .nav-menu-panel {
                display: none;
                position: absolute;
                top: calc(100% + 10px);
                right: 0;
                background: white;
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                border-radius: 16px;
                border: 1px solid rgba(255, 255, 255, 0.6);
                box-shadow: 0 12px 30px -10px rgba(28, 26, 40, 0.1);
                width: 200px;
                padding: 8px;
                z-index: 1100;
                overflow: hidden;
            }

            .nav-menu-panel.is-open {
                display: block;
            }

            .nav-menu-panel a {
                display: block;
                padding: 12px 16px;
                text-decoration: none;
                color: var(--deep-night-blue);
                font-weight: 600;
                border-radius: 12px;
                transition: background 0.2s ease, color 0.2s ease;
            }

            .nav-menu-panel a:hover {
                background-color: var(--sky-blue);
                color: #fff;
            }
            
            .nav-menu-panel hr {
                border: none;
                border-top: 1px solid rgba(0, 0, 0, 0.08);
                margin: 8px 0;
            }

            /* Logic for showing/hiding menu items */
            .nav-menu-panel .nav-menu-loggedin,
            .nav-menu-panel .nav-menu-anonymous {
                display: none;
            }

            .nav-menu-panel.is-anonymous .nav-menu-anonymous {
                display: block;
            }

            .nav-menu-panel.is-loggedin .nav-menu-loggedin {
                display: block;
            }

            #newNavLogoutBtn {
                color: #D9534F; /* A reddish color for sign out */
            }
            #newNavLogoutBtn:hover {
                background-color: #D9534F;
                color: #fff;
            }
        </style>
        <div class="nav-menu-wrapper">
            <button class="nav-menu-button" id="navMenuBtn" aria-label="Open navigation menu">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="3" y1="12" x2="21" y2="12"></line>
                    <line x1="3" y1="6" x2="21" y2="6"></line>
                    <line x1="3" y1="18" x2="21" y2="18"></line>
                </svg>
            </button>
            <div class="nav-menu-panel" id="navMenuPanel">
                <div class="nav-menu-anonymous">
                    <a href="#" id="nav-signin-btn">Sign In</a>
                </div>
                <div class="nav-menu-loggedin">
                    <a href="${createLink(controller: 'dashboard', action: 'index')}">Dashboard</a>
                    <hr>
                    <a href="#" id="newNavLogoutBtn">Sign Out</a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- AUTH MODAL -->
<div id="auth-modal" class="auth-modal">
    <div class="auth-modal-content">
        <button class="auth-close-btn" id="auth-close-btn">×</button>
        <div id="signup-form-container">
            <g:render template="/auth/signupForm"/>
        </div>
        <div id="login-form-container" style="display:none">
            <g:render template="/auth/loginForm"/>
        </div>
    </div>
</div>

<!-- MAIN CONTENT -->
<g:layoutBody/>

<!-- FOOTER -->
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
            <g:link uri="https://www.instagram.com/streamfit_1?igsh=MTF3ajJoZDRuOXpzdw==" class="social-btn" aria-label="Instagram">
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
            <li><g:link uri="/about">About learnerDNA</g:link></li>
        </ul>
    </div>

    <div class="footer-bottom">
        <div>© <g:formatDate format="yyyy" date="${new Date()}"/> LearnerDNA. All rights reserved.</div>
        <div class="footer-links">
            <g:link uri="/terms">Terms</g:link>
            <g:link uri="/privacy">Privacy</g:link>
        </div>
    </div>
</footer>

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

<script>
    // New Navigation Menu Logic
    (function() {
        document.addEventListener('DOMContentLoaded', function() {
            const menuButton = document.getElementById('navMenuBtn');
            const menuPanel = document.getElementById('navMenuPanel');
            const logoutButton = document.getElementById('newNavLogoutBtn');

            if (!menuButton || !menuPanel) return;

            // Toggle menu visibility
            menuButton.addEventListener('click', function(e) {
                e.stopPropagation(); // Prevent the document click listener from closing it immediately
                menuPanel.classList.toggle('is-open');
                menuButton.classList.toggle('is-active');
            });

            // Close menu if clicking outside
            document.addEventListener('click', function(e) {
                if (menuPanel.classList.contains('is-open') && !menuPanel.contains(e.target) && e.target !== menuButton) {
                    menuPanel.classList.remove('is-open');
                    menuButton.classList.remove('is-active');
                }
            });

            // Check login state and set menu variant
            try {
                // Re-uses the same token key as auth.js
                const token = localStorage.getItem('streamfit_accessToken');
                if (token) {
                    menuPanel.classList.add('is-loggedin');
                } else {
                    menuPanel.classList.add('is-anonymous');
                }
            } catch (e) {
                console.error("Could not access localStorage.", e);
                menuPanel.classList.add('is-anonymous');
            }


            // Wire up logout button
            if (logoutButton) {
                logoutButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    // Call the globally available logout function from auth.js
                    if (window.authManager && typeof window.authManager.logout === 'function') {
                        window.authManager.logout();
                    } else {
                        console.error('authManager.logout() function not found.');
                        // Fallback in case the global function isn't there
                        localStorage.removeItem('streamfit_accessToken');
                        localStorage.removeItem('streamfit_refreshToken');
                        window.location.href = '/';
                    }
                });
            }
        });
    })();
</script>

<script>
    (function() {
        // Wait for DOM to be ready
        function initContinueGameModal() {
            const navStartPlaying = document.getElementById('navStartPlaying');
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

            // Handle play button clicks
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

            // Attach to nav button
            if (navStartPlaying) {
                navStartPlaying.addEventListener('click', handlePlayNowClick);
            }

            // Attach to ALL play now buttons on the page (for index.gsp)
            const playNowButtons = document.querySelectorAll('.play-now-trigger, #playNowBtn');
            console.log('Found', playNowButtons.length, 'play now buttons'); // Debug
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
        }

        // Initialize when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', initContinueGameModal);
        } else {
            // DOM already loaded
            initContinueGameModal();
        }
    })();
</script>

</body>
</html>

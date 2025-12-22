<!DOCTYPE html>
<html lang="en-IN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

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

    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="personality-test.css"/>
    <asset:stylesheet src="mobile.css"/>
    <asset:javascript src="application.js"/>
    <asset:javascript src="mobile-enhancements.js"/>
    <asset:javascript src="mobile-share.js"/>

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
    }

    /* NAVIGATION */
    .main-nav {
        background: var(--pure-white);
        position: sticky;
        top: 0;
        z-index: 1000;
        border-bottom: 2px solid var(--sky-blue);
        box-shadow: 0 2px 12px rgba(168, 218, 220, 0.2);
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 8px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .nav-logo {
        text-decoration: none;
        display: flex;
        align-items: center;
    }

    .nav-logo img {
        height: 120px;
        width: auto;
        transition: transform 0.3s ease;
    }

    .nav-logo img:hover {
        transform: scale(1.05);
    }

    /* BUTTON SYSTEM */
    .btn {
        padding: 8px 16px;
        border-radius: 12px;
        border: none;
        font-weight: 700;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
        font-size: 0.85rem;
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--ocean-blue), var(--soft-teal-blue));
        color: var(--pure-white);
        border-radius: 50px;
        box-shadow: 0 4px 12px rgba(43, 95, 126, 0.25);
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(43, 95, 126, 0.35);
    }

    /* ✅ FIXED NAV CTA (KEY CHANGE) */
    .nav-cta {
        font-size: 0.75rem;
        padding: 6px 14px;        /* overrides .btn */
        font-weight: 600;
        white-space: nowrap;
        border-radius: 999px;
    }

    /* FOOTER */
    .main-footer {
        margin-top: 80px;
        background: rgba(255, 255, 255, 0.5);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-radius: 32px;
        padding: 60px;
        border: 1px solid rgba(255,255,255,0.6);
        box-shadow: 0 12px 30px -10px rgba(28, 26, 40, 0.04);
        position: relative;
        overflow: hidden;
        max-width: 1200px;
        margin-left: auto;
        margin-right: auto;
        display: grid;
        grid-template-columns: 1.5fr 1fr 1fr 1fr;
        gap: 40px;
        align-items: start;
    }

    .footer-brand h2 {
        font-size: 1.5rem;
        font-weight: 800;
        color: var(--text-dark, #1A1825);
        margin: 0 0 16px 0;
        letter-spacing: -0.03em;
    }

    .footer-brand p {
        color: var(--text-grey, #8E8C9A);
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
        color: var(--text-dark, #1A1825);
        transition: all 0.2s;
        border: 1px solid rgba(0,0,0,0.05);
        cursor: pointer;
        box-shadow: 0 2px 5px rgba(0,0,0,0.02);
        text-decoration: none;
    }

    .social-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        color: var(--pop-purple, #9F97F3);
    }

    .footer-col h3 {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: var(--text-grey, #8E8C9A);
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
        margin-top: 40px;
        padding-top: 24px;
        border-top: 1px solid rgba(0,0,0,0.05);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
        color: var(--text-grey, #8E8C9A);
        font-size: 0.85rem;
        font-weight: 600;
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

    /* RESPONSIVE */
    @media (max-width: 768px) {
        .nav-logo img {
            height: 90px;
        }

        .nav-cta {
            font-size: 0.7rem;
            padding: 6px 12px;
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
        .nav-container {
            padding: 6px 12px;
        }

        .nav-logo img {
            height: 75px;
        }

        .nav-cta {
            font-size: 0.65rem;
            padding: 5px 10px;
        }
    }
    </style>
</head>

<body>

<!-- NAV -->
<nav class="main-nav">
    <div class="nav-container">
        <a href="${createLink(uri: '/')}" class="nav-logo">
            <img src="${assetPath(src: 'logo1.png')}" alt="LearnerDNA - Free Student Aptitude Test" width="120" height="120"/>
        </a>

        <a href="${createLink(controller: 'personality', action: 'start')}"
           class="btn btn-primary nav-cta">
            Get Clarity →
        </a>
    </div>
</nav>

<!-- MAIN CONTENT -->
<g:layoutBody/>

<!-- FOOTER -->
<footer class="main-footer">
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
            <li><a href="${createLink(uri: '/')}">Home</a></li>
            <li><a href="${createLink(controller: 'personality', action: 'start')}">Take the Test</a></li>
            <li><a href="${createLink(controller: 'personality', action: 'types')}">Learning Animals</a></li>
        </ul>
    </div>

    <!-- Links Col 2 -->
    <div class="footer-col">
        <h3>LEGAL</h3>
        <ul class="footer-link-list">
            <li><a href="${createLink(uri: '/privacy')}">Privacy Policy</a></li>
            <li><a href="${createLink(uri: '/terms')}">Terms of Service</a></li>
        </ul>
    </div>

    <!-- Links Col 3 -->
    <div class="footer-col">
        <h3>SUPPORT</h3>
        <ul class="footer-link-list">
            <li><a href="${createLink(uri: '/faq')}">FAQ</a></li>
            <li><a href="${createLink(uri: '/contact')}">Contact Us</a></li>
            <li><a href="${createLink(uri: '/about')}">About learnerDNA</a></li>
        </ul>
    </div>

    <div class="footer-bottom">
        <div>© 2025 StreamFit. All rights reserved.</div>
        <div class="footer-links">
            <a href="${createLink(uri: '/terms')}">Terms</a>
            <a href="${createLink(uri: '/privacy')}">Privacy</a>
            <a href="${createLink(uri: '/contact')}">Contact</a>
        </div>
    </div>
</footer>

</body>
</html>


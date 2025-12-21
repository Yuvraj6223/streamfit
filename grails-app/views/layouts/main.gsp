<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:layoutTitle default="StreamFit - Discover Your Mental Fitness Journey"/></title>

    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="personality-test.css"/>
    <asset:javascript src="application.js"/>

    <g:layoutHead/>

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
        padding: 16px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .nav-logo {
        font-size: 1.8rem;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        gap: 6px;
    }

    .nav-logo .stream {
        color: var(--soft-teal-blue);
    }

    .nav-logo .fit {
        color: var(--ocean-blue);
    }

    /* BUTTON SYSTEM */
    .btn {
        padding: 12px 24px;
        border-radius: 12px;
        border: none;
        font-weight: 700;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
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
        background: var(--pure-white);
        padding: 50px 0 30px;
        border-top: 2px solid var(--sky-blue);
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .footer-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 40px;
        margin-bottom: 40px;
    }

    .footer-section h3 {
        color: var(--ocean-blue);
        font-weight: 800;
        margin-bottom: 18px;
    }

    .footer-section ul {
        list-style: none;
    }

    .footer-section li {
        margin-bottom: 12px;
    }

    .footer-section a {
        color: var(--charcoal-teal);
        text-decoration: none;
        font-weight: 500;
    }

    .footer-bottom {
        border-top: 2px solid var(--sky-blue);
        padding-top: 24px;
        text-align: center;
        color: var(--charcoal-teal);
        font-size: 0.9rem;
    }

    /* RESPONSIVE */
    @media (max-width: 768px) {
        .nav-logo {
            font-size: 1.2rem;
        }

        .nav-cta {
            font-size: 0.7rem;
            padding: 6px 12px;
        }
    }

    @media (max-width: 480px) {
        .nav-container {
            padding: 8px 12px;
        }

        .nav-logo {
            font-size: 1.1rem;
        }
    }
    </style>
</head>

<body>

<!-- NAV -->
<nav class="main-nav">
    <div class="nav-container">
        <a href="${createLink(uri: '/')}" class="nav-logo">
            <span class="stream">Stream</span><span class="fit">Fit</span>
        </a>

        <a href="${createLink(controller: 'personality', action: 'start')}"
           class="btn btn-primary nav-cta">
            Get My Clarity Now →
        </a>
    </div>
</nav>

<!-- MAIN CONTENT -->
<g:layoutBody/>

<!-- FOOTER -->
<footer class="main-footer">
    <div class="footer-content">
        <div class="footer-grid">
            <div class="footer-section">
                <h3>StreamFit</h3>
                <ul>
                    <li><a href="${createLink(uri: '/')}">Home</a></li>
                    <li><a href="${createLink(controller: 'personality', action: 'start')}">Take the Test</a></li>
                    <li><a href="${createLink(controller: 'personality', action: 'types')}">Learning Animals</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Support</h3>
                <ul>
                    <li><a href="${createLink(uri: '/faq')}">FAQ</a></li>
                    <li><a href="${createLink(uri: '/contact')}">Contact Us</a></li>
                    <li><a href="${createLink(uri: '/about')}">About StreamFit</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Legal</h3>
                <ul>
                    <li><a href="${createLink(uri: '/privacy')}">Privacy Policy</a></li>
                    <li><a href="${createLink(uri: '/terms')}">Terms of Service</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Connect</h3>
                <ul>
                    <li><a href="#">Instagram</a></li>
                    <li><a href="#">Twitter</a></li>
                    <li><a href="#">YouTube</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p style="font-weight:700; color:var(--ocean-blue)">©2025 StreamFit</p>
            <p style="margin-top:8px">Find the right stream based on how you actually think.</p>
            <p style="margin-top:6px; color:var(--soft-teal-blue)">
                100% Free • No Signup Required • 10,000+ Students Helped
            </p>
        </div>
    </div>
</footer>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Your Exam Style 🧬 | learnerDNA</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
    :root {
        --theme-primary: #8B7FE8;
        --theme-secondary: #5FE3D0;
        --theme-bg: #F4F7FA;
        --text-dark: #1a1a2e;
        --text-grey: #64748b;
        --ease-out: cubic-bezier(0.2, 0.8, 0.2, 1);

        /* Auth colors */
        --pop-coral: #FF8F7D;
        --pop-purple: #9F97F3;
    }

    /* Theme Variants */
    .theme-wolf { --theme-primary: #14B8A6; --theme-secondary: #ccfbf1; --theme-bg: #f0fdfa; }
    .theme-owl { --theme-primary: #6366F1; --theme-secondary: #e0e7ff; --theme-bg: #eef2ff; }
    .theme-bee { --theme-primary: #F59E0B; --theme-secondary: #fef3c7; --theme-bg: #fffbeb; }
    .theme-tiger { --theme-primary: #EF4444; --theme-secondary: #fee2e2; --theme-bg: #fef2f2; }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        -webkit-tap-highlight-color: transparent;
    }

    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        color: var(--text-dark);
        background: var(--theme-bg);
        min-height: 100vh;
        overflow-x: hidden;
        transition: background 0.8s ease;
        line-height: 1.4;
    }

    /* Animated Scenery */
    .scenery-layer { position: fixed; inset: 0; z-index: -1; overflow: hidden; }
    .blob {
        position: absolute; filter: blur(80px); opacity: 0.4;
        border-radius: 50%;
        animation: blobFloat 10s infinite ease-in-out;
    }
    .b-1 { top: -10%; right: -15%; width: 80vw; height: 80vw; background: var(--theme-primary); }
    .b-2 { bottom: -10%; left: -15%; width: 80vw; height: 80vw; background: var(--theme-secondary); animation-delay: -5s; }

    @keyframes blobFloat {
        0%, 100% { transform: translate(0, 0) scale(1); }
        50% { transform: translate(30px, -20px) scale(1.05); }
    }

    /* Scroll to Top Button */
    .scroll-to-top {
        position: fixed;
        bottom: 100px;
        right: 20px;
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, var(--theme-primary) 0%, var(--theme-secondary) 100%);
        color: white;
        border: none;
        border-radius: 50%;
        font-size: 1.5rem;
        cursor: pointer;
        box-shadow: 0 4px 16px rgba(139, 127, 232, 0.3);
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
        box-shadow: 0 6px 24px rgba(139, 127, 232, 0.4);
    }

    .scroll-to-top:active {
        transform: translateY(-2px);
    }

    /* Main Container */
    .results-container {
        width: 100%;
        max-width: 500px;
        margin: 0 auto;
        padding: 16px 16px 80px;
        display: none;
        opacity: 0;
        transition: opacity 0.6s ease-out;
    }
    .results-container.visible {
        display: block;
        opacity: 1;
    }

    /* Cards & UI Elements */
    .main-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 1);
        border-radius: 32px;
        box-shadow: 0 25px 50px -12px rgba(0,0,0,0.1);
        position: relative;
        overflow: hidden;
        transform: translateY(20px);
        transition: transform 0.8s var(--ease-out);
    }
    .visible .main-card { transform: translateY(0); }

    .header-section {
        padding: 40px 24px 20px;
        text-align: center;
    }

    .progress-pill {
        display: inline-flex; align-items: center; gap: 8px;
        background: rgba(0,0,0,0.05); padding: 8px 16px; border-radius: 100px;
        font-size: 0.75rem; font-weight: 800; color: var(--text-grey);
        margin-bottom: 24px;
    }

    .animal-emoji {
        font-size: clamp(4rem, 15vw, 5.5rem);
        display: block;
        margin: -10px auto 10px;
        filter: drop-shadow(0 15px 25px rgba(0,0,0,0.1));
        transition: transform 1.2s cubic-bezier(0.34, 1.56, 0.64, 1);
        transform: scale(0) rotate(-45deg);
    }
    .visible .animal-emoji { transform: scale(1) rotate(0); }

    .result-title {
        font-size: clamp(2rem, 8vw, 2.6rem);
        font-weight: 900;
        line-height: 1;
        margin-bottom: 8px;
        letter-spacing: -1px;
    }

    .result-tagline {
        font-size: 1.1rem; font-weight: 700; color: var(--theme-primary); margin-bottom: 16px;
    }

    .result-desc {
        font-size: 1rem; color: var(--text-grey); font-weight: 500;
        padding: 0 10px;
    }

    /* Stats Strip */
    .stats-strip {
        display: grid; grid-template-columns: 1fr 1fr;
        background: rgba(0,0,0,0.02);
        border-block: 1px solid rgba(0,0,0,0.05);
    }
    .stat-box { padding: 20px 10px; text-align: center; }
    .stat-box:first-child { border-right: 1px solid rgba(0,0,0,0.05); }
    .stat-label { font-size: 0.7rem; text-transform: uppercase; font-weight: 800; color: var(--text-grey); letter-spacing: 1px; }
    .stat-value { font-size: 1.25rem; font-weight: 900; color: var(--text-dark); margin-top: 4px; }

    /* Superpowers Section */
    .content-body { padding: 30px 24px; }
    .power-row { margin-bottom: 20px; }
    .power-header { display: flex; justify-content: space-between; font-size: 0.85rem; font-weight: 800; margin-bottom: 8px; }
    .power-track { height: 12px; background: rgba(0,0,0,0.06); border-radius: 10px; overflow: hidden; }
    .power-fill {
        height: 100%;
        background: linear-gradient(90deg, var(--theme-primary), var(--theme-secondary));
        width: 0%;
        border-radius: 10px;
        transition: width 1.5s var(--ease-out) 0.5s;
    }

    .micro-reward {
        display: flex; align-items: center; gap: 12px;
        background: white; border: 2px solid var(--theme-primary);
        padding: 16px; border-radius: 20px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.03);
    }

    /* Locked Vault Peak */
    .locked-vault {
        background: #0f172a;
        padding: 60px 24px 40px;
        color: white;
        text-align: center;
        position: relative;
    }
    .locked-vault::before {
        content: ''; position: absolute; top: -25px; left: 0; right: 0; height: 50px;
        background: #0f172a; transform: skewY(-3deg);
    }

    .lock-portal {
        width: 80px; height: 80px; background: rgba(255,255,255,0.1); border-radius: 50%;
        display: inline-flex; align-items: center; justify-content: center;
        font-size: 2.2rem; margin-bottom: 25px; border: 2px solid rgba(255,255,255,0.2);
        animation: vaultBreath 3s infinite ease-in-out;
    }

    @keyframes vaultBreath { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.1); } }

    .loss-frame { font-size: 1.3rem; font-weight: 800; line-height: 1.3; margin-bottom: 12px; }
    .social-proof { font-size: 0.9rem; color: #94a3b8; margin-bottom: 30px; }

    /* Buttons */
    .btn-primary {
        display: flex; align-items: center; justify-content: center; gap: 12px;
        width: 100%; padding: 22px;
        background: var(--theme-primary); color: white;
        border: none; border-radius: 24px;
        font-size: 1.1rem; font-weight: 900;
        box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        cursor: pointer; transition: transform 0.2s;
    }
    .btn-primary:active { transform: scale(0.96); }

    .btn-outline {
        display: block; width: 100%; padding: 18px; margin-top: 15px;
        background: rgba(255,255,255,0.05); color: #cbd5e1;
        border: 1px solid rgba(255,255,255,0.15); border-radius: 20px;
        text-decoration: none; font-weight: 700; font-size: 0.95rem;
        text-align: center;
    }

    /* Dashboard button styles */
    .btn-dashboard {
        background: linear-gradient(135deg, var(--theme-primary) 0%, var(--theme-secondary) 100%) !important;
        box-shadow: 0 15px 30px rgba(0,0,0,0.3) !important;
    }

    /* Modal Overlay */
    .reward-modal {
        position: fixed; inset: 0; background: rgba(15, 23, 42, 0.9);
        backdrop-filter: blur(12px); z-index: 10000;
        display: flex; align-items: center; justify-content: center; padding: 20px;
        transition: opacity 0.4s ease;
    }
    .reward-content {
        background: white; border-radius: 36px; padding: 48px 32px;
        width: 100%; max-width: 400px; text-align: center;
        animation: modalPop 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    @keyframes modalPop { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }

    .modal-emoji { font-size: 4.5rem; display: block; margin-bottom: 20px; animation: vaultBreath 3s infinite; }

    .reward-title {
        font-size: 2.2rem;
        font-weight: 900;
        margin-bottom: 20px;
        color: var(--text-dark);
        letter-spacing: -0.02em;
    }

    .reward-badges {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin: 32px 0;
        flex-wrap: wrap;
    }

    .badge-item {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, white 100%);
        border-radius: 20px;
        padding: 20px;
        min-width: 110px;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        border: 2px solid rgba(139, 127, 232, 0.2);
    }

    .badge-item:hover {
        transform: translateY(-5px) scale(1.05);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }

    .badge-emoji {
        font-size: 3rem;
        margin-bottom: 12px;
        filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
    }

    .badge-name {
        font-size: 0.9rem;
        color: var(--text-grey);
        font-weight: 800;
    }

    .level-up {
        background: linear-gradient(135deg, #FFE17B 0%, #FFEB99 100%);
        border-radius: 20px;
        padding: 24px;
        margin: 24px 0;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        border: 3px solid rgba(255, 255, 255, 0.6);
    }

    .level-up-text {
        font-size: 1.6rem;
        font-weight: 900;
        color: var(--text-dark);
        letter-spacing: -0.01em;
    }

    .continue-btn {
        background: linear-gradient(135deg, var(--theme-primary) 0%, var(--theme-secondary) 100%);
        color: white;
        border: 3px solid rgba(255, 255, 255, 0.4);
        padding: 20px 48px;
        border-radius: 100px;
        font-size: 1.1rem;
        font-weight: 800;
        cursor: pointer;
        margin-top: 24px;
        transition: all 0.3s ease;
        box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        font-family: inherit;
        text-transform: uppercase;
        letter-spacing: 0.02em;
    }

    .continue-btn:hover {
        transform: translateY(-3px) scale(1.05);
    }

    .continue-btn:active {
        transform: translateY(-1px) scale(1.02);
    }

    .reveal-anim {
        opacity: 0;
        transform: translateY(20px);
        transition: opacity 0.8s ease, transform 0.8s var(--ease-out);
    }
    .visible .reveal-anim {
        opacity: 1;
        transform: translateY(0);
    }

    /* Share Results Section */
    .share-section {
        margin: 30px 0;
        padding: 0;
    }

    .share-card {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 24px;
        padding: 32px 24px;
        text-align: center;
        border: 2px solid rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(10px);
    }

    .share-title {
        font-size: 1.4rem;
        font-weight: 900;
        margin-bottom: 8px;
        color: white;
        letter-spacing: -0.02em;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }

    .share-description {
        font-size: 0.95rem;
        color: #cbd5e1;
        margin-bottom: 24px;
        font-weight: 600;
    }

    .share-buttons {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
        gap: 12px;
    }

    .share-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        padding: 16px 20px;
        border-radius: 16px;
        font-size: 0.95rem;
        font-weight: 800;
        cursor: pointer;
        border: 2px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s ease;
        text-decoration: none;
        backdrop-filter: blur(5px);
    }

    .share-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        border-color: rgba(255, 255, 255, 0.4);
    }

    .share-btn:active {
        transform: translateY(-1px);
    }

    .share-btn.twitter {
        background: linear-gradient(135deg, #1DA1F2 0%, #0d8bd9 100%);
        color: white;
    }

    .share-btn.whatsapp {
        background: linear-gradient(135deg, #25D366 0%, #1ea952 100%);
        color: white;
    }

    .share-btn.linkedin {
        background: linear-gradient(135deg, #0077B5 0%, #005885 100%);
        color: white;
    }

    .share-btn.copy {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.2) 0%, rgba(255, 255, 255, 0.1) 100%);
        color: white;
    }

    .share-btn .emoji {
        font-size: 1.3rem;
        filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
    }

    canvas#confetti-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 11000; }

    /* ========== AUTH MODAL STYLES ========== */
    .auth-modal {
        position: fixed;
        inset: 0;
        background: rgba(15, 23, 42, 0.92);
        backdrop-filter: blur(12px);
        z-index: 10001;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 20px;
        opacity: 0;
        transition: opacity 0.4s ease;
    }

    .auth-modal.active {
        display: flex;
        opacity: 1;
    }

    .auth-modal-content {
        background: white;
        border-radius: 28px;
        padding: 48px 40px;
        width: 100%;
        max-width: 440px;
        box-shadow: 0 20px 40px -12px rgba(159, 151, 243, 0.2);
        border: 1px solid rgba(255,255,255,0.6);
        animation: authModalPop 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
        max-height: 90vh;
        overflow-y: auto;
    }

    @keyframes authModalPop {
        from { transform: scale(0.9) translateY(20px); opacity: 0; }
        to { transform: scale(1) translateY(0); opacity: 1; }
    }

    .auth-close-btn {
        position: absolute;
        top: 20px;
        right: 20px;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: rgba(0,0,0,0.05);
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.4rem;
        color: var(--text-grey);
        transition: all 0.2s ease;
    }

    .auth-close-btn:hover {
        background: rgba(0,0,0,0.1);
        transform: scale(1.1);
    }

    .auth-header {
        text-align: center;
        margin-bottom: 32px;
    }

    .auth-header h2 {
        font-size: 2.3rem;
        font-weight: 800;
        margin-bottom: 8px;
        color: var(--text-dark);
    }

    .auth-header p {
        color: var(--text-grey);
        font-weight: 600;
        font-size: 1rem;
    }

    .auth-form-group {
        margin-bottom: 22px;
    }

    .auth-form-label {
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 6px;
        display: block;
        font-size: 0.95rem;
    }

    .auth-form-input {
        width: 100%;
        padding: 15px;
        border-radius: 14px;
        border: 2px solid #eee;
        font-size: 1rem;
        transition: all 0.3s ease;
        font-family: inherit;
    }

    .auth-form-input:focus {
        outline: none;
        border-color: var(--pop-purple);
        box-shadow: 0 0 0 4px rgba(159,151,243,0.2);
    }

    .auth-submit-btn {
        width: 100%;
        padding: 18px;
        border-radius: 100px;
        border: none;
        background: linear-gradient(135deg, var(--pop-purple), var(--pop-coral));
        color: white;
        font-size: 1.05rem;
        font-weight: 800;
        cursor: pointer;
        box-shadow: 0 20px 40px -12px rgba(159,151,243,0.45);
        transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        font-family: inherit;
    }

    .auth-submit-btn:hover {
        transform: translateY(-4px) scale(1.03);
        box-shadow: 0 25px 50px -12px rgba(159,151,243,0.55);
    }

    .auth-submit-btn:active {
        transform: translateY(-2px) scale(1.01);
    }

    .auth-footer {
        text-align: center;
        margin-top: 24px;
        color: var(--text-grey);
        font-size: 0.95rem;
    }

    .auth-footer a {
        color: var(--pop-purple);
        font-weight: 700;
        text-decoration: none;
        cursor: pointer;
    }

    .auth-footer a:hover {
        text-decoration: underline;
    }

    .auth-error-message,
    .auth-success-message {
        padding: 12px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: none;
        font-size: 0.9rem;
        font-weight: 600;
    }

    .auth-error-message {
        background: #FEF3C7;
        color: #92400E;
        border: 1px solid #FCD34D;
    }

    .auth-success-message {
        background: #ECFDF5;
        color: #065F46;
        border: 1px solid #A7F3D0;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .results-container {
            padding: 16px 16px 100px;
        }

        .btn-primary, .btn-outline, .btn-dashboard {
            padding: 20px;
            font-size: 1rem;
        }

        .share-buttons {
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .share-btn {
            padding: 14px 16px;
            font-size: 0.9rem;
        }

        .share-btn .emoji {
            font-size: 1.1rem;
        }

        .share-card {
            padding: 28px 20px;
        }

        .share-title {
            font-size: 1.2rem;
        }

        .share-description {
            font-size: 0.9rem;
        }

        .auth-modal-content {
            padding: 36px 24px;
            max-width: 95%;
        }

        .auth-header h2 {
            font-size: 2rem;
        }
    }

    /* Accessibility: Reduced Motion */
    @media (prefers-reduced-motion: reduce) {
        *,
        *::before,
        *::after {
            animation-duration: 0.01ms !important;
            animation-iteration-count: 1 !important;
            transition-duration: 0.01ms !important;
            scroll-behavior: auto !important;
        }
    }
    </style>
</head>
<body class="theme-wolf">

<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
</div>
<canvas id="confetti-canvas"></canvas>

<!-- Scroll to Top Button -->
<button class="scroll-to-top" id="scrollToTop" onclick="window.scrollTo({top: 0, behavior: 'smooth'})">
    ↑
</button>

<!-- Initial Entry Modal - Reward Modal -->
<div id="reward-modal" class="reward-modal">
    <div class="reward-content">
        <span class="modal-emoji" id="reward-emoji">🎉</span>
        <h2 class="reward-title" id="reward-title-modal">Test Completed!</h2>

        <div id="level-up-container"></div>

        <div class="reward-badges" id="reward-badges"></div>

        <div id="achievements-container"></div>

        <button class="continue-btn" id="continue-btn-reward" type="button">
            See Your Results →
        </button>
    </div>
</div>

<!-- Auth Modal (Signup/Login) -->
<div id="auth-modal" class="auth-modal">
    <div class="auth-modal-content">
        <button class="auth-close-btn" id="auth-close-btn">×</button>

        <!-- Signup Form -->
        <div id="signup-form-container" style="display: none;">
            <div class="auth-header">
                <h2>You're Close</h2>
                <p>Create your account to view your complete Dashboard</p>
            </div>

            <div class="auth-error-message" id="signup-error-message"></div>
            <div class="auth-success-message" id="signup-success-message"></div>

            <form id="signup-form">
                <div class="auth-form-group">
                    <label class="auth-form-label" for="signup-name">Full Name</label>
                    <input type="text" id="signup-name" class="auth-form-input" placeholder="Rahul Sharma" required>
                </div>

                <div class="auth-form-group">
                    <label class="auth-form-label" for="signup-email">Email Address</label>
                    <input type="email" id="signup-email" class="auth-form-input" placeholder="your@email.com" required>
                </div>

                <div class="auth-form-group">
                    <label class="auth-form-label" for="signup-age">Age (Optional)</label>
                    <input type="number" id="signup-age" class="auth-form-input" placeholder="18" min="1" max="120">
                </div>

                <button type="submit" class="auth-submit-btn">
                    Create Account
                </button>
            </form>

            <div class="auth-footer">
                Already have an account? <a id="switch-to-login-link">Login</a>
            </div>
        </div>

        <!-- Login Form -->
        <div id="login-form-container" style="display: none;">
            <div class="auth-header">
                <h2>Welcome Back</h2>
                <p>Login to view your Dashboard</p>
            </div>

            <div class="auth-error-message" id="login-error-message"></div>
            <div class="auth-success-message" id="login-success-message"></div>

            <form id="login-form">
                <div class="auth-form-group">
                    <label class="auth-form-label" for="login-email">Email Address</label>
                    <input type="email" id="login-email" class="auth-form-input" placeholder="your@email.com" required>
                </div>

                <div class="auth-form-group">
                    <label class="auth-form-label" for="login-name">Name (Optional)</label>
                    <input type="text" id="login-name" class="auth-form-input" placeholder="Your Name">
                </div>

                <button type="submit" class="auth-submit-btn">
                    Login
                </button>
            </form>

            <div class="auth-footer">
                Don't have an account? <a id="switch-to-signup-link">Sign up</a>
            </div>
        </div>
    </div>
</div>

<!-- Results UI -->
<div class="results-container" id="results-content">
    <div class="main-card">

        <div class="header-section reveal-anim" style="transition-delay: 0.1s;">
            <div class="progress-pill">
                <span style="width: 8px; height: 8px; background: var(--theme-primary); border-radius: 50%;"></span>
                <span>Persona Revealed</span>
            </div>
            <span style="font-size: 0.7rem; font-weight: 900; letter-spacing: 3px; color: var(--text-grey); display: block; margin-bottom: 10px;">EXAM ARCHETYPE</span>
            <div id="animal-emoji" class="animal-emoji">🐺</div>
            <h1 id="result-title" class="result-title">The Strategic Wolf</h1>
            <p id="result-tagline" class="result-tagline">"The Hunter"</p>
            <p id="result-summary" class="result-desc">You usually know the answer before finishing the steps.</p>
        </div>

        <div class="stats-strip reveal-anim" style="transition-delay: 0.3s;">
            <div class="stat-box">
                <div class="stat-label">Core Strength</div>
                <div id="stat-strength" class="stat-value">High Speed</div>
            </div>
            <div class="stat-box">
                <div class="stat-label">Logic Type</div>
                <div id="stat-style" class="stat-value">Intuitive</div>
            </div>
        </div>

        <div class="content-body">
            <div class="power-section reveal-anim" style="transition-delay: 0.5s;">
                <div class="power-row">
                    <div class="power-header"><span id="p1-label">Gut Instinct</span></div>
                    <div class="power-track"><div id="p1-bar" class="power-fill"></div></div>
                </div>
                <div class="power-row">
                    <div class="power-header"><span id="p2-label">Carefulness</span></div>
                    <div class="power-track"><div id="p2-bar" class="power-fill"></div></div>
                </div>
            </div>

            <div class="micro-reward reveal-anim" style="transition-delay: 0.7s;">
                <span style="font-size: 1.5rem;">🏆</span>
                <span id="reward-badge" style="font-weight: 800; font-size: 0.95rem;">You find shortcuts others miss</span>
            </div>
        </div>

        <div class="locked-vault reveal-anim" style="transition-delay: 0.9s;">
            <div class="lock-portal">🔒</div>
            <h3 id="loss-frame" class="loss-frame">Wait. You haven't seen the part that explains why you doubt yourself.</h3>
            <p class="social-proof" id="tribe-text">Most top scorers unlock the full report to secure their edge.</p>

            <button class="btn-primary btn-dashboard" id="open-dashboard-modal" style="margin-top: 30px;">
                📊 View Your Complete Dashboard
            </button>
            <a href="${createLink(controller: 'personality', action: 'start')}" class="btn-outline" id="btn-next">Take next test (to know more about yourself)</a>

            <!-- Share Results Section -->
            <div class="share-section">
                <div class="share-card">
                    <div class="share-title">
                        <span class="emoji">✨</span>
                        Share Your Results
                    </div>
                    <p class="share-description">
                        Show your friends what type of learner you are!
                    </p>

                    <div class="share-buttons">
                        <button class="share-btn twitter" onclick="shareOnTwitter()">
                            <span class="emoji">🐦</span>
                            <span>Twitter</span>
                        </button>
                        <button class="share-btn whatsapp" onclick="shareOnWhatsApp()">
                            <span class="emoji">💬</span>
                            <span>WhatsApp</span>
                        </button>
                        <button class="share-btn linkedin" onclick="shareOnLinkedIn()">
                            <span class="emoji">💼</span>
                            <span>LinkedIn</span>
                        </button>
                        <button class="share-btn copy" onclick="copyToClipboard()">
                            <span class="emoji">📋</span>
                            <span>Copy Link</span>
                        </button>
                    </div>
                </div>
            </div>

            <p style="margin-top: 30px; font-size: 0.85rem; opacity: 0.6; font-weight: 600;">Want to see your detailed Skill Map?</p>
        </div>

    </div>
</div>

<script type="text/javascript">
    // Server-side result data injected from Grails controller
    var resultData = ${raw((result as grails.converters.JSON).toString())};

    console.log('Result data loaded:', resultData);

    // ANIMAL REPORTS - Default data structure (can be overridden by server data)
    const ANIMAL_REPORTS = {
        wolf: {
            theme: 'theme-wolf', emoji: '🐺', title: 'The Strategic Wolf', tagline: '"The Hunter"',
            summary: 'You usually know the answer before finishing the steps.',
            strength: 'High Speed', style: 'Intuitive',
            loss: 'Wait. You haven\'t seen the part that explains why you change the right answer after doubting yourself.',
            social: '94% of Wolves unlock their full report to stop second-guessing.',
            reward: 'You find shortcuts others miss',
            next: 'Take next test (to know more about yourself)',
            powers: [{l:'Gut Instinct', v:92}, {l:'Carefulness', v:85}]
        },
        owl: {
            theme: 'theme-owl', emoji: '🦉', title: 'The Wise Owl', tagline: '"The Strategist"',
            summary: 'You master complex topics by breaking them into logical patterns.',
            strength: 'Deep Precision', style: 'Analytical',
            loss: 'Wait. You\'re missing the data on why you run out of time on the last 3 questions.',
            social: 'Top Owls use the full report to master their time management.',
            reward: 'You spot errors before they happen',
            next: 'Take next test (to know more about yourself)',
            powers: [{l:'Logic Accuracy', v:96}, {l:'Focus Stamina', v:88}]
        },
        bee: {
            theme: 'theme-bee', emoji: '🐝', title: 'The Steady Bee', tagline: '"The Architect"',
            summary: 'You build success through consistent, methodical systems.',
            strength: 'Endurance', style: 'Methodical',
            loss: 'Wait. You don\'t have the strategy for when a question breaks your routine.',
            social: 'Most Bees unlock this to build an "unbreakable" test strategy.',
            reward: 'You stay calm when others panic',
            next: 'Take next test (to know more about yourself)',
            powers: [{l:'Work Ethic', v:98}, {l:'Planning', v:94}]
        },
        tiger: {
            theme: 'theme-tiger', emoji: '🐯', title: 'The Bold Tiger', tagline: '"The Sprinter"',
            summary: 'You thrive under pressure and accelerate as the clock winds down.',
            strength: 'High Intensity', style: 'Competitive',
            loss: 'Wait. You haven\'t seen how to maintain your peak without making "rush" mistakes.',
            social: 'Tigers use this report to turn their speed into consistent scores.',
            reward: 'Pure speed is your natural edge',
            next: 'Take next test (to know more about yourself)',
            powers: [{l:'Blitz Speed', v:95}, {l:'Confidence', v:91}]
        }
    };

    /* ===============================
   AUTH MESSAGE HANDLER (FINAL)
================================ */

    function clearAuthMessages() {
        [
            'signup-error-message',
            'signup-success-message',
            'login-error-message',
            'login-success-message'
        ].forEach(id => {
            const el = document.getElementById(id);
            if (el) {
                el.style.display = 'none';
                el.textContent = '';
            }
        });
    }

    function showAuthMessage(type, status, message) {
        const el = document.getElementById(`${type}-${status}-message`);
        if (!el) return;

        el.textContent = message;
        el.style.display = 'block';
    }


    // ========== AUTH MODAL FUNCTIONS ==========
    function openAuthModal(mode) {
        const modal = document.getElementById('auth-modal');
        const signupContainer = document.getElementById('signup-form-container');
        const loginContainer = document.getElementById('login-form-container');

        // Clear any previous messages
        clearAuthMessages();

        if (mode === 'signup') {
            signupContainer.style.display = 'block';
            loginContainer.style.display = 'none';
        } else {
            signupContainer.style.display = 'none';
            loginContainer.style.display = 'block';
        }

        modal.classList.add('active');
        document.body.style.overflow = 'hidden'; // Prevent background scrolling
    }

    function closeAuthModal() {
        const modal = document.getElementById('auth-modal');
        modal.classList.remove('active');
        document.body.style.overflow = ''; // Restore scrolling

        // Clear forms
        document.getElementById('signup-form').reset();
        document.getElementById('login-form').reset();
        clearAuthMessages();
    }

    function switchToSignup() {
        openAuthModal('signup');
    }

    function switchToLogin() {
        openAuthModal('login');
    }


    // Close modal when clicking outside
    document.getElementById('auth-modal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeAuthModal();
        }
    });

    // Handle Signup Form Submit
    document.getElementById('signup-form').addEventListener('submit', async function(e) {
        e.preventDefault();
        clearAuthMessages();

        const name = document.getElementById('signup-name').value;
        const email = document.getElementById('signup-email').value;
        const age = document.getElementById('signup-age').value;

        try {
            const response = await fetch('/api/signup', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name, email, age })
            });

            const data = await response.json();

            if (data.success) {
                showAuthMessage('signup', 'success', 'Account created successfully!');
                setTimeout(() => {
                    window.location.href = '/dashboard';
                }, 1500);
            } else {
                showAuthMessage('signup', 'error', data.message || 'Signup failed. Please try again.');
            }
        } catch (error) {
            showAuthMessage('signup', 'error', 'An error occurred. Please try again.');
        }
    });

    // Handle Login Form Submit
    document.getElementById('login-form').addEventListener('submit', async function(e) {
        e.preventDefault();
        clearAuthMessages();

        const email = document.getElementById('login-email').value;
        const name = document.getElementById('login-name').value;

        try {
            const response = await fetch('/api/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email, name })
            });

            const data = await response.json();

            if (data.success) {
                showAuthMessage('login', 'success', 'Login successful!');
                setTimeout(() => {
                    window.location.href = '/dashboard';
                }, 1500);
            } else {
                showAuthMessage('login', 'error', data.message || 'Login failed. Please try again.');
            }
        } catch (error) {
            showAuthMessage('login', 'error', 'An error occurred. Please try again.');
        }
    });

    // Display rewards in the modal
    function displayRewards(rewards) {
        if (!rewards) return;

        // Show level up if applicable
        if (rewards.leveledUp) {
            document.getElementById('level-up-container').innerHTML =
                '<div class="level-up">' +
                '<div class="level-up-text">🎊 Level Up! You' + String.fromCharCode(39) + 're now Level ' + rewards.newLevel + '!</div>' +
                '</div>';
        }

        // Show badges
        if (rewards.badges && rewards.badges.length > 0) {
            var badgesHtml = rewards.badges.map(function(badge) {
                return '<div class="badge-item">' +
                    '<div class="badge-emoji">' + badge.emoji + '</div>' +
                    '<div class="badge-name">' + badge.badgeName + '</div>' +
                    '</div>';
            }).join('');
            document.getElementById('reward-badges').innerHTML = badgesHtml;
        }

        // Show achievements
        if (rewards.achievements && rewards.achievements.length > 0) {
            var achievementsHtml = '<div style="margin-top: 20px;">' +
                '<h3 style="margin-bottom: 15px; color: var(--text-dark);">🏆 New Achievements!</h3>';

            rewards.achievements.forEach(function(ach) {
                achievementsHtml += '<div style="background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 10px 0;">' +
                    '<div style="font-size: 2rem;">' + ach.emoji + '</div>' +
                    '<div style="font-weight: 600; margin-top: 5px;">' + ach.achievementTitle + '</div>' +
                    '<div style="color: #666; font-size: 0.9rem;">' + ach.achievementDescription + '</div>' +
                    '</div>';
            });

            achievementsHtml += '</div>';
            document.getElementById('achievements-container').innerHTML = achievementsHtml;
        }
    }

    // Populate results from server data
    function populateResults() {
        if (!resultData) {
            console.error('No result data available');
            document.getElementById('result-title').textContent = 'Error Loading Results';
            document.getElementById('result-summary').textContent = 'Unable to load test results';
            return;
        }

        if (!resultData.success) {
            console.error('Result failed:', resultData.error);
            document.getElementById('result-title').textContent = 'Error Loading Results';
            document.getElementById('result-summary').textContent = resultData.error || 'Unable to load test results';
            return;
        }

        // Use server data if available, otherwise fall back to ANIMAL_REPORTS
        var data;

        // Check if server provided complete result data
        if (resultData.emoji && resultData.resultTitle) {
            data = {
                emoji: resultData.emoji || '🎯',
                title: resultData.resultTitle || 'Your Results',
                tagline: resultData.resultSummary || '',
                summary: resultData.profile || '',
                strength: resultData.strengths || '',
                style: resultData.aiRoadmap || '',
                loss: resultData.traps || 'Unlock to see potential challenges',
                social: resultData.bestMatches || '',
                reward: resultData.strengths || 'Great job!',
                next: 'Take next test (to know more about yourself)',
                powers: [
                    {l: 'Core Strength', v: 85},
                    {l: 'Learning Style', v: 90}
                ],
                theme: 'theme-wolf'
            };
        } else {
            // Fallback to determining from URL or local storage
            const urlParams = new URLSearchParams(window.location.search);
            const urlResult = urlParams.get('animal');
            const storedResult = localStorage.getItem('exam_animal_result');
            const keys = Object.keys(ANIMAL_REPORTS);
            const randomResult = keys[Math.floor(Math.random() * keys.length)];
            let resultKey = (urlResult && ANIMAL_REPORTS[urlResult]) ? urlResult : (storedResult || randomResult);
            data = ANIMAL_REPORTS[resultKey];
        }

        // Update theme
        document.body.className = data.theme || 'theme-wolf';

        // Update DOM with result data
        document.getElementById('animal-emoji').innerText = data.emoji || '🎯';
        document.getElementById('result-title').innerText = data.title || 'Your Results';
        document.getElementById('result-tagline').innerText = data.tagline || '';
        document.getElementById('result-summary').innerText = data.summary || '';
        document.getElementById('stat-strength').innerText = data.strength || 'High Speed';
        document.getElementById('stat-style').innerText = data.style || 'Intuitive';
        document.getElementById('loss-frame').innerText = data.loss || 'Unlock to see more details';
        document.getElementById('tribe-text').innerText = data.social || 'Join others who unlocked their full potential';
        document.getElementById('reward-badge').innerText = data.reward || 'Great job!';
        document.getElementById('btn-next').innerText = data.next || 'Take next test';

        if (data.powers && data.powers.length >= 2) {
            document.getElementById('p1-label').innerText = data.powers[0].l;
            document.getElementById('p2-label').innerText = data.powers[1].l;

            // Animate power bars
            setTimeout(() => {
                document.getElementById('p1-bar').style.width = data.powers[0].v + '%';
                document.getElementById('p2-bar').style.width = data.powers[1].v + '%';
            }, 600);
        }

        console.log('Results populated successfully');
    }

    // Show results (hide modal, show content)
    function revealResults() {
        const modal = document.getElementById('reward-modal');
        const results = document.getElementById('results-content');

        modal.style.opacity = '0';
        setTimeout(() => {
            modal.style.display = 'none';
            results.classList.add('visible');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }, 400);

        fireConfetti();
    }

    // Confetti animation
    function fireConfetti() {
        const canvas = document.getElementById('confetti-canvas');
        if (!canvas) return;
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const particles = [];
        const colors = ['#8B7FE8', '#5FE3D0', '#FFB4D6', '#F59E0B'];

        for(let i=0; i<100; i++) {
            particles.push({
                x: Math.random() * canvas.width,
                y: -20,
                r: Math.random() * 6 + 2,
                d: Math.random() * 20 + 10,
                color: colors[Math.floor(Math.random() * colors.length)],
                tilt: Math.floor(Math.random() * 10) - 10,
                tiltAngleIncremental: (Math.random() * 0.07) + 0.05,
                tiltAngle: 0
            });
        }

        let frame = 0;
        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            particles.forEach((p, i) => {
                p.tiltAngle += p.tiltAngleIncremental;
                p.y += (Math.cos(p.d) + 3 + p.r / 2) / 2;
                p.tilt = Math.sin(p.tiltAngle) * 15;

                ctx.beginPath();
                ctx.lineWidth = p.r;
                ctx.strokeStyle = p.color;
                ctx.moveTo(p.x + p.tilt + p.r / 2, p.y);
                ctx.lineTo(p.x + p.tilt, p.y + p.tilt + p.r / 2);
                ctx.stroke();

                if (p.y > canvas.height) {
                    particles[i].y = -20;
                    particles[i].x = Math.random() * canvas.width;
                }
            });
            frame++;
            if(frame < 250) requestAnimationFrame(draw);
            else ctx.clearRect(0, 0, canvas.width, canvas.height);
        }
        draw();
    }

    // Share functionality
    function shareOnTwitter() {
        const text = encodeURIComponent('I just discovered my learning style! Find out yours at learnerDNA 🧬');
        const url = encodeURIComponent(window.location.href);
        window.open(`https://twitter.com/intent/tweet?text=${text}&url=${url}`, '_blank', 'width=550,height=420');
    }

    function shareOnWhatsApp() {
        const text = encodeURIComponent('I just discovered my learning style on learnerDNA! Check it out: ' + window.location.href);
        window.open(`https://wa.me/?text=${text}`, '_blank');
    }

    function shareOnLinkedIn() {
        const url = encodeURIComponent(window.location.href);
        window.open(`https://www.linkedin.com/sharing/share-offsite/?url=${url}`, '_blank', 'width=550,height=420');
    }

    function copyToClipboard() {
        const url = window.location.href;

        // Try modern clipboard API first
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(url).then(function() {
                showCopyNotification();
            }).catch(function(err) {
                fallbackCopyToClipboard(url);
            });
        } else {
            fallbackCopyToClipboard(url);
        }
    }

    function fallbackCopyToClipboard(text) {
        const textArea = document.createElement("textarea");
        textArea.value = text;
        textArea.style.position = "fixed";
        textArea.style.left = "-999999px";
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();

        try {
            document.execCommand('copy');
            showCopyNotification();
        } catch (err) {
            alert('Failed to copy link. Please copy manually: ' + text);
        }

        document.body.removeChild(textArea);
    }

    function showCopyNotification() {
        const btn = document.querySelector('.share-btn.copy');
        const originalText = btn.innerHTML;
        btn.innerHTML = '<span class="emoji">✓</span><span>Copied!</span>';
        btn.style.background = 'linear-gradient(135deg, #10b981 0%, #059669 100%)';

        setTimeout(() => {
            btn.innerHTML = originalText;
            btn.style.background = 'linear-gradient(135deg, rgba(255, 255, 255, 0.2) 0%, rgba(255, 255, 255, 0.1) 100%)';
        }, 2000);
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        console.log('DOM Content Loaded');
        console.log('Result data:', resultData);

        // Populate results first
        populateResults();

        // Attach event listener to dashboard button
        const dashboardBtn = document.getElementById('open-dashboard-modal');
        if (dashboardBtn) {
            dashboardBtn.addEventListener('click', function(e) {
                e.preventDefault();
                console.log('Opening auth modal');
                openAuthModal('signup');
            });
        }

        // Attach event listeners to auth modal buttons
        const closeBtn = document.getElementById('auth-close-btn');
        if (closeBtn) {
            closeBtn.addEventListener('click', function(e) {
                e.preventDefault();
                closeAuthModal();
            });
        }

        const switchToLoginLink = document.getElementById('switch-to-login-link');
        if (switchToLoginLink) {
            switchToLoginLink.addEventListener('click', function(e) {
                e.preventDefault();
                switchToLogin();
            });
        }

        const switchToSignupLink = document.getElementById('switch-to-signup-link');
        if (switchToSignupLink) {
            switchToSignupLink.addEventListener('click', function(e) {
                e.preventDefault();
                switchToSignup();
            });
        }

        // Display rewards if available from server
        if (resultData && resultData.rewards) {
            displayRewards(resultData.rewards);
        }

        // Setup continue button
        const continueBtn = document.getElementById('continue-btn-reward');
        if (continueBtn) {
            continueBtn.addEventListener('click', function(e) {
                e.preventDefault();
                revealResults();
            });
        }

        // Auto-reveal after short delay (or keep modal if you want manual click)
        // Uncomment below to auto-skip modal:
        /*
        setTimeout(function() {
            revealResults();
        }, 100);
        */

        // Scroll to Top Button Functionality
        const scrollToTopBtn = document.getElementById('scrollToTop');
        if (scrollToTopBtn) {
            window.addEventListener('scroll', function() {
                if (window.pageYOffset > 300) {
                    scrollToTopBtn.classList.add('visible');
                } else {
                    scrollToTopBtn.classList.remove('visible');
                }
            });
        }
    });

    // Resize handler for canvas
    window.addEventListener('resize', () => {
        const canvas = document.getElementById('confetti-canvas');
        if(canvas) {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        }
    });
</script>
</body>
</html>
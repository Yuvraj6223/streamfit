<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Test Results - StreamFit</title>
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
        overflow-x: hidden;
        -webkit-font-smoothing: antialiased;
    }

    /* --- AMBIENT BACKGROUND --- */
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
    .b-1 { top: -10%; right: -5%; width: 600px; height: 600px;
        background: var(--pop-purple); border-radius: 40% 60% 70% 30%; }
    .b-2 { bottom: -10%; left: -10%; width: 700px;
        height: 700px; background: var(--pop-teal); border-radius: 60% 40% 30% 70%; animation-delay: -5s; }
    .b-3 { top: 40%;
        left: 40%; width: 400px; height: 400px; background: var(--pop-coral); opacity: 0.3; border-radius: 30% 70%; animation-duration: 18s;
    }

    @keyframes float-blob {
        0% { transform: translate(0, 0) rotate(0deg); }
        100% { transform: translate(40px, 40px) rotate(10deg); }
    }

    .results-container {
        max-width: 900px;
        margin: 0 auto;
        padding: 40px 24px;
        position: relative;
        z-index: 1;
    }

    /* --- REWARD MODAL --- */
    .reward-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(26, 24, 37, 0.85);
        backdrop-filter: blur(10px);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        animation: fadeIn 0.3s var(--ease-smooth);
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .reward-content {
        background: var(--card-base);
        border-radius: 32px;
        padding: 60px 50px;
        max-width: 550px;
        text-align: center;
        animation: scaleIn 0.5s var(--ease-elastic);
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.5);
        pointer-events: auto;
        position: relative;
        z-index: 10000;
    }

    @keyframes scaleIn {
        from {
            transform: scale(0.8);
            opacity: 0;
        }
        to {
            transform: scale(1);
            opacity: 1;
        }
    }

    .reward-emoji {
        font-size: 6rem;
        margin-bottom: 24px;
        animation: bounce 1s ease infinite;
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-20px); }
    }

    .reward-title {
        font-size: 2.2rem;
        font-weight: 800;
        margin-bottom: 20px;
        color: var(--text-dark);
        letter-spacing: -0.02em;
    }

    .reward-points {
        font-size: 3.5rem;
        font-weight: 800;
        background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 24px;
    }

    .reward-badges {
        display: flex;
        justify-content: center;
        gap: 20px;
        margin: 32px 0;
        flex-wrap: wrap;
    }

    .badge-item {
        background: linear-gradient(135deg, var(--pop-cream) 0%, white 100%);
        border-radius: 20px;
        padding: 20px;
        min-width: 110px;
        box-shadow: var(--shadow-soft);
        transition: all 0.3s var(--ease-elastic);
    }

    .badge-item:hover {
        transform: translateY(-5px) scale(1.05);
        box-shadow: var(--shadow-float);
    }

    .badge-emoji {
        font-size: 3rem;
        margin-bottom: 12px;
    }

    .badge-name {
        font-size: 0.9rem;
        color: var(--text-grey);
        font-weight: 700;
    }

    .level-up {
        background: linear-gradient(135deg, var(--pop-yellow) 0%, #FFE89D 100%);
        border-radius: 20px;
        padding: 24px;
        margin: 24px 0;
        box-shadow: var(--shadow-float);
    }

    .level-up-text {
        font-size: 1.6rem;
        font-weight: 800;
        color: var(--text-dark);
        letter-spacing: -0.01em;
    }

    .continue-btn {
        background: var(--text-dark);
        color: white;
        border: none;
        padding: 18px 48px;
        border-radius: 100px;
        font-size: 1.1rem;
        font-weight: 700;
        cursor: pointer;
        margin-top: 24px;
        transition: all 0.3s var(--ease-elastic);
        box-shadow: var(--shadow-float);
        font-family: inherit;
        position: relative;
        z-index: 10;
    }

    .continue-btn:hover {
        transform: translateY(-3px) scale(1.05);
        box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.4);
    }

    .continue-btn:active {
        transform: translateY(-1px) scale(1.02);
    }

        /* --- RESULTS CARD --- */
        .result-card {
            background: var(--card-base);
            border-radius: 32px;
            padding: 50px 40px;
            margin-bottom: 40px;
            box-shadow: var(--shadow-float);
            border: 1px solid rgba(255,255,255,0.5);
        }

        .result-header {
            text-align: center;
            margin-bottom: 40px;
        }

        /* Mobile: Screenshot-friendly result header */
        @media (max-width: 768px) {
            .result-header {
                background: linear-gradient(135deg, #9F97F3 0%, #73D2DE 100%);
                padding: 40px 24px;
                border-radius: 16px;
                margin: -24px -24px 32px;
                color: white;
            }

            .result-emoji {
                filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.1));
            }

            .result-title {
                color: white !important;
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .result-summary {
                color: rgba(255, 255, 255, 0.95) !important;
            }
        }

        .result-emoji {
            font-size: 5rem;
            margin-bottom: 24px;
            animation: float-blob 3s infinite ease-in-out alternate;
        }

        .result-title {
            font-size: clamp(2rem, 5vw, 3rem);
            font-weight: 800;
            margin-bottom: 20px;
            color: var(--text-dark);
            letter-spacing: -0.03em;
            line-height: 1.2;
        }

        .result-summary {
            font-size: 1.25rem;
            color: var(--text-grey);
            line-height: 1.7;
            font-weight: 600;
        }

        .result-section {
            margin: 40px 0;
            padding: 32px;
            background: linear-gradient(135deg, var(--pop-cream) 0%, white 100%);
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,0.5);
            transition: all 0.3s var(--ease-elastic);
        }

        .result-section:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-soft);
        }

        .result-section h3 {
            font-size: 1.6rem;
            margin-bottom: 20px;
            color: var(--text-dark);
            font-weight: 800;
            letter-spacing: -0.02em;
        }

        .result-section p {
            font-size: 1.1rem;
            color: var(--text-grey);
            line-height: 1.8;
            font-weight: 500;
            margin: 0;
        }

        .score-breakdown {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 24px 0;
        }

        .score-item {
            background: white;
            border-radius: 20px;
            padding: 24px;
            text-align: center;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s var(--ease-elastic);
        }

        .score-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-float);
        }

        .score-label {
            font-size: 0.9rem;
            color: var(--text-grey);
            margin-bottom: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .score-value {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            margin-top: 40px;
        }

        .btn {
            flex: 1;
            padding: 18px 32px;
            border-radius: 100px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: all 0.3s var(--ease-elastic);
            font-family: inherit;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--text-dark);
            color: white;
            box-shadow: var(--shadow-float);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.4);
        }

        .btn-secondary {
            background: white;
            color: var(--text-dark);
            border: 2px solid #F0F0F5;
            box-shadow: var(--shadow-soft);
        }

        .btn-secondary:hover {
            transform: translateY(-3px);
            border-color: var(--pop-purple);
            box-shadow: var(--shadow-float);
        }

        .btn-success {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            box-shadow: var(--shadow-float);
        }

        .btn-success:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 25px 50px -12px rgba(76, 175, 80, 0.4);
        }

        .btn-outline {
            background: transparent;
            color: var(--text-dark);
            border: 2px solid var(--text-dark);
        }

        .btn-outline:hover {
            background: var(--text-dark);
            color: white;
            transform: translateY(-3px);
        }

        .btn-large {
            padding: 22px 48px;
            font-size: 1.2rem;
        }

        /* Dashboard button - extra large and prominent */
        .btn-dashboard {
            padding: 28px 60px !important;
            font-size: 1.4rem !important;
            font-weight: 800 !important;
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%) !important;
            color: white !important;
            box-shadow: 0 30px 60px -15px rgba(159, 151, 243, 0.5) !important;
            border: none !important;
            flex: 2 !important; /* Make it twice as wide as other buttons */
        }

        .btn-dashboard:hover {
            transform: translateY(-5px) scale(1.05) !important;
            box-shadow: 0 35px 70px -15px rgba(159, 151, 243, 0.6) !important;
        }

        /* --- PREMIUM SECTION --- */
        .premium-section {
            margin: 50px 0;
        }

        .premium-card {
            background: linear-gradient(135deg, var(--pop-cream) 0%, white 100%);
            border-radius: 32px;
            padding: 60px 50px;
            text-align: center;
            box-shadow: var(--shadow-float);
            border: 2px solid var(--pop-purple);
            position: relative;
            overflow: hidden;
        }

        .premium-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(159, 151, 243, 0.1) 0%, transparent 70%);
            animation: float-blob 15s infinite ease-in-out alternate;
        }

        .premium-icon {
            font-size: 4rem;
            margin-bottom: 24px;
            animation: float-blob 3s infinite ease-in-out alternate;
        }

        .premium-title {
            font-size: clamp(1.8rem, 4vw, 2.5rem);
            font-weight: 800;
            margin-bottom: 20px;
            color: var(--text-dark);
            letter-spacing: -0.02em;
            position: relative;
            z-index: 1;
        }

        .premium-description {
            font-size: 1.2rem;
            color: var(--text-grey);
            margin-bottom: 40px;
            line-height: 1.7;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            position: relative;
            z-index: 1;
        }

        .premium-features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
            margin: 40px 0;
            position: relative;
            z-index: 1;
        }

        .premium-feature {
            background: white;
            border-radius: 20px;
            padding: 28px;
            text-align: left;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s var(--ease-elastic);
            border: 1px solid rgba(255,255,255,0.5);
        }

        .premium-feature:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-float);
        }

        .feature-icon {
            font-size: 2.5rem;
            display: block;
            margin-bottom: 16px;
        }

        .feature-content h3 {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .feature-content p {
            font-size: 1rem;
            color: var(--text-grey);
            line-height: 1.6;
            margin: 0;
        }

        .premium-actions {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-top: 40px;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .btn-premium {
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
            color: white;
            padding: 22px 60px;
            border-radius: 100px;
            font-size: 1.3rem;
            font-weight: 800;
            text-decoration: none;
            display: inline-block;
            box-shadow: var(--shadow-float);
            transition: all 0.3s var(--ease-elastic);
            border: none;
        }

        .btn-premium:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 30px 60px -15px rgba(159, 151, 243, 0.5);
        }

        /* --- AUTH MODAL --- */
        .auth-modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .auth-modal-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(26, 24, 37, 0.8);
            backdrop-filter: blur(10px);
        }

        .auth-modal-content {
            position: relative;
            background: var(--card-base);
            border-radius: 32px;
            padding: 50px 40px;
            max-width: 500px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 30px 60px -15px rgba(159, 151, 243, 0.5);
            animation: modalSlideIn 0.4s var(--ease-smooth);
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

        .auth-modal-close {
            position: absolute;
            top: 20px;
            right: 20px;
            background: transparent;
            border: none;
            font-size: 2rem;
            color: var(--text-grey);
            cursor: pointer;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: all 0.3s var(--ease-elastic);
        }

        .auth-modal-close:hover {
            background: var(--pop-cream);
            color: var(--text-dark);
            transform: rotate(90deg);
        }

        .auth-modal-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .auth-modal-header h2 {
            font-size: 2rem;
            font-weight: 800;
            margin-bottom: 12px;
            color: var(--text-dark);
        }

        .auth-modal-header p {
            font-size: 1.1rem;
            color: var(--text-grey);
            margin: 0;
        }

        .google-signin-section {
            margin-bottom: 24px;
        }

        .google-signin-btn {
            width: 100%;
            padding: 16px 24px;
            background: white;
            border: 2px solid #E0E0E0;
            border-radius: 100px;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-dark);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            transition: all 0.3s var(--ease-elastic);
            font-family: inherit;
        }

        .google-signin-btn:hover {
            border-color: var(--pop-purple);
            transform: translateY(-2px);
            box-shadow: var(--shadow-soft);
        }

        .auth-divider {
            text-align: center;
            margin: 24px 0;
            position: relative;
        }

        .auth-divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #E0E0E0;
        }

        .auth-divider span {
            position: relative;
            background: var(--card-base);
            padding: 0 16px;
            color: var(--text-grey);
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 8px;
        }

        .form-input {
            width: 100%;
            padding: 14px 20px;
            border: 2px solid #E0E0E0;
            border-radius: 16px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s var(--ease-elastic);
            background: var(--bg-warm);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--pop-purple);
            background: white;
        }

        .submit-btn {
            width: 100%;
            padding: 16px 32px;
            background: linear-gradient(135deg, var(--pop-purple) 0%, var(--pop-teal) 100%);
            color: white;
            border: none;
            border-radius: 100px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s var(--ease-elastic);
            font-family: inherit;
            margin-top: 8px;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 20px 40px -12px rgba(159, 151, 243, 0.4);
        }

        .submit-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .error-message {
            background: #FFE5E5;
            color: #D32F2F;
            padding: 12px 20px;
            border-radius: 12px;
            margin-bottom: 16px;
            font-size: 0.95rem;
            font-weight: 600;
        }

        .success-message {
            background: #E8F5E9;
            color: #388E3C;
            padding: 12px 20px;
            border-radius: 12px;
            margin-bottom: 16px;
            font-size: 0.95rem;
            font-weight: 600;
        }

        .auth-modal-footer {
            text-align: center;
            margin-top: 24px;
            font-size: 0.95rem;
            color: var(--text-grey);
        }

        .auth-modal-footer a {
            color: var(--pop-purple);
            text-decoration: none;
            font-weight: 600;
        }

        .auth-modal-footer a:hover {
            text-decoration: underline;
        }

        /* --- ANIMATIONS --- */
        @keyframes reveal {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-in {
            opacity: 0;
            animation: reveal 0.8s var(--ease-smooth) forwards;
        }

        /* --- RESPONSIVE --- */
        @media (max-width: 768px) {
            .results-container {
                padding: 40px 20px;
            }

            .reward-content {
                padding: 50px 35px;
                max-width: 95%;
            }

            .reward-emoji {
                font-size: 7rem;
            }

            .reward-title {
                font-size: 2.8rem;
            }

            .reward-points {
                font-size: 4rem;
            }

            .badge-emoji {
                font-size: 3.5rem;
            }

            .badge-name {
                font-size: 1.1rem;
            }

            .continue-btn {
                padding: 22px 56px;
                font-size: 1.3rem;
            }

            .result-card {
                padding: 50px 30px;
            }

            .result-emoji {
                font-size: 6rem;
            }

            .result-title {
                font-size: 2.8rem;
            }

            .result-summary {
                font-size: 1.4rem;
            }

            .result-section {
                padding: 30px;
                margin: 30px 0;
            }

            .result-section h3 {
                font-size: 1.8rem;
            }

            .result-section p {
                font-size: 1.3rem;
                line-height: 2;
            }

            .action-buttons {
                position: sticky;
                bottom: 0;
                background: var(--bg-warm);
                padding: 16px;
                padding-bottom: max(16px, env(safe-area-inset-bottom));
                margin: 0 -24px;
                box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.08);
                z-index: 50;
                flex-direction: column;
                gap: 12px;
            }

            .btn {
                width: 100%;
                padding: 18px 32px;
                font-size: 1.1rem;
                min-height: 56px;
                font-weight: 700;
                border-radius: 12px;
                transition: all 0.2s ease;
            }

            .btn:active {
                transform: scale(0.97);
            }

            .btn-dashboard {
                padding: 32px 70px !important;
                font-size: 1.6rem !important;
            }

            .premium-card {
                padding: 50px 30px;
            }

            .premium-icon {
                font-size: 5rem;
            }

            .premium-title {
                font-size: 2.5rem;
            }

            .premium-description {
                font-size: 1.4rem;
            }

            .premium-features {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .premium-feature {
                padding: 30px;
            }

            .feature-icon {
                font-size: 3rem;
            }

            .feature-content h3 {
                font-size: 1.5rem;
            }

            .feature-content p {
                font-size: 1.2rem;
            }

            .btn-premium {
                padding: 26px 70px;
                font-size: 1.5rem;
            }

            .score-item {
                padding: 28px;
            }

            .score-label {
                font-size: 1.1rem;
            }

            .score-value {
                font-size: 3rem;
            }
        }
    </style>
</head>
<body>

<!-- Ambient Background -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

    <!-- Reward Modal (shown first) -->
    <div id="reward-modal" class="reward-modal">
        <div class="reward-content">
            <div class="reward-emoji">🎉</div>
            <div class="reward-title">Test Completed!</div>
            <div class="reward-points" id="reward-points">+50 Points</div>
            
            <div id="level-up-container"></div>
            
            <div class="reward-badges" id="reward-badges"></div>
            
            <div id="achievements-container"></div>
            
            <button class="continue-btn" id="continue-btn-reward" type="button" onclick="document.getElementById('reward-modal').style.display='none';document.getElementById('results-content').style.display='block';window.scrollTo({top:0,behavior:'smooth'});">
                See Your Results →
            </button>
        </div>
    </div>
    
    <!-- Results Content (hidden initially) -->
    <div class="results-container" id="results-content" style="display: none;">
        <div class="result-card">
            <div class="result-header">
                <div class="result-emoji" id="result-emoji">🦉</div>
                <div class="result-title" id="result-title">Loading...</div>
                <div class="result-summary" id="result-summary"></div>
            </div>
            
            <div class="result-section">
                <h3>📊 About You</h3>
                <p id="result-profile"></p>
            </div>

            <div class="result-section">
                <h3>💪 What You're Good At</h3>
                <p id="result-strengths"></p>
            </div>

            <div class="result-section" id="traps-section">
                <h3>⚠️ Things to Watch Out For</h3>
                <p id="result-traps"></p>
            </div>

            <div class="result-section">
                <h3>🎯 How We'll Help You</h3>
                <p id="result-roadmap"></p>
            </div>

            <div class="result-section" id="matches-section">
                <h3>🎓 Good Fit For You</h3>
                <p id="result-matches"></p>
            </div>

            <!-- Premium Features Section - UI Only (Login coming soon) -->
            <div class="premium-section">
                <div class="premium-card">
                    <div class="premium-icon">🎁</div>
                    <h2 class="premium-title">Unlock Your Full Potential</h2>
                    <p class="premium-description">
                        Access detailed reports, personalized recommendations,
                        and exclusive pre-booking opportunities!
                    </p>

                    <div class="premium-features">
                        <div class="premium-feature">
                            <span class="feature-icon">📊</span>
                            <div class="feature-content">
                                <h3>Detailed Reports</h3>
                                <p>Get comprehensive analysis of your test results</p>
                            </div>
                        </div>
                        <div class="premium-feature">
                            <span class="feature-icon">💼</span>
                            <div class="feature-content">
                                <h3>Career Insights</h3>
                                <p>Discover careers that match your profile</p>
                            </div>
                        </div>
                        <div class="premium-feature">
                            <span class="feature-icon">🎯</span>
                            <div class="feature-content">
                                <h3>Pre-booking Access</h3>
                                <p>Reserve your spot for exclusive events and workshops</p>
                            </div>
                        </div>
                        <div class="premium-feature">
                            <span class="feature-icon">📈</span>
                            <div class="feature-content">
                                <h3>Track Progress</h3>
                                <p>Monitor your growth and development over time</p>
                            </div>
                        </div>
                    </div>

                    <div class="premium-actions">
                        <button class="btn btn-premium btn-large" style="opacity: 0.6; cursor: not-allowed;" disabled>
                            🚀 Account Creation Coming Soon
                        </button>
                    </div>
                </div>
            </div>

            <div class="action-buttons">
                <!-- Main Dashboard Button - Extra Large and Prominent -->
                <button class="btn btn-dashboard" onclick="window.location.href='/dashboard'">
                    📊 View Your Complete Dashboard
                </button>

                <a href="/personality/types" class="btn btn-secondary" style="text-decoration: none;">
                    🎮 Play Another Game
                </a>
            </div>
        </div>
    </div>

    <!-- Login/Signup Modal removed - functionality coming soon -->

    <script type="text/javascript">
    var resultData = ${raw((result as grails.converters.JSON).toString())};

    console.log('Result data loaded:', resultData);

    // Populate results immediately on page load
    function populateResults() {
        if (!resultData) {
            console.error('No result data available');
            // Show error message
            document.getElementById('result-title').textContent = 'Error Loading Results';
            document.getElementById('result-summary').textContent = 'Unable to load test results';
            return;
        }

        if (!resultData.success) {
            console.error('Result failed:', resultData.error);
            // Show error message
            document.getElementById('result-title').textContent = 'Error Loading Results';
            document.getElementById('result-summary').textContent = resultData.error || 'Unable to load test results';
            return;
        }

        // Populate all result fields
        document.getElementById('result-emoji').textContent = resultData.emoji || '🎯';
        document.getElementById('result-title').textContent = resultData.resultTitle || 'Your Results';
        document.getElementById('result-summary').textContent = resultData.resultSummary || '';

        // Profile section
        var profileText = resultData.profile || '';
        if (profileText) {
            document.getElementById('result-profile').textContent = profileText;
        } else {
            document.getElementById('result-profile').textContent = 'No profile information available.';
        }

        // Strengths section
        var strengthsText = resultData.strengths || '';
        if (strengthsText) {
            document.getElementById('result-strengths').textContent = strengthsText;
        } else {
            document.getElementById('result-strengths').textContent = 'No strengths information available.';
        }

        // Traps section
        var trapsText = resultData.traps || '';
        if (trapsText) {
            document.getElementById('result-traps').textContent = trapsText;
        } else {
            var trapsSection = document.getElementById('traps-section');
            if (trapsSection) trapsSection.style.display = 'none';
        }

        // AI Roadmap section
        var roadmapText = resultData.aiRoadmap || '';
        if (roadmapText) {
            document.getElementById('result-roadmap').textContent = roadmapText;
        } else {
            document.getElementById('result-roadmap').textContent = 'No roadmap available yet.';
        }

        // Best Matches section
        var matchesText = resultData.bestMatches || '';
        if (matchesText) {
            document.getElementById('result-matches').textContent = matchesText;
        } else {
            var matchesSection = document.getElementById('matches-section');
            if (matchesSection) matchesSection.style.display = 'none';
        }

        console.log('Results populated successfully');
    }

        function displayRewards(rewards) {
            if (!rewards) return;
            
            // Update points
            document.getElementById('reward-points').textContent = '+' + rewards.points + ' Points';

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
                    '<h3 style="margin-bottom: 15px;">🏆 New Achievements!</h3>';

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

        // Auth Modal Functions - Disabled (functionality coming soon)
        function showLoginModal(purpose) {
            // Login functionality disabled for now
            console.log('Login functionality coming soon');
        }

        function closeAuthModal() {
            // No-op
        }

        function switchToSignup() {
            // Redirect to signup page (UI only)
            window.location.href = '/signup';
        }

        function signInWithGoogle() {
            // Google Sign-In coming soon
            alert('Google Sign-In will be implemented soon.');
        }

        // Simple function to show results
        function showResults() {
            const rewardModal = document.getElementById('reward-modal');
            const resultsContent = document.getElementById('results-content');

            if (rewardModal) {
                rewardModal.style.display = 'none';
            }

            if (resultsContent) {
                resultsContent.style.display = 'block';
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        }

        // Populate results and setup event handlers on page load
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM Content Loaded');
            console.log('Result data type:', typeof resultData);
            console.log('Result data:', resultData);

            // Populate results first
            populateResults();

            // Auto-skip reward modal and show results directly
            // (Reward system will be implemented later)
            setTimeout(function() {
                const rewardModal = document.getElementById('reward-modal');
                const resultsContent = document.getElementById('results-content');

                if (rewardModal) {
                    rewardModal.style.display = 'none';
                    console.log('Reward modal hidden');
                }
                if (resultsContent) {
                    resultsContent.style.display = 'block';
                    console.log('Results content shown');
                }

                console.log('Results displayed automatically');
            }, 100);

            // Attach event listener to the continue button (in case user sees it)
            const continueBtn = document.getElementById('continue-btn-reward');
            if (continueBtn) {
                console.log('Continue button found!');
                continueBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Button clicked!');
                    showResults();
                });
            }

            // Login form handler removed - functionality coming soon
        });
    </script>
</body>
</html>


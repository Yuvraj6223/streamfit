<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <title>Your Exam Style 🧬 | learnerDNA</title>
    <link href="https://fonts.googleapis.com/css2?family=Fredoka:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        -webkit-tap-highlight-color: transparent;
    }

    html {
        overflow-x: hidden;
        overflow-y: auto;
        width: 100%;
        max-width: 100vw;
        -webkit-text-size-adjust: 100%;
        position: relative;
    }

    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        min-height: 100vh;
        overflow-x: hidden;
        overflow-y: auto;
        line-height: 1.4;
        position: relative;
        touch-action: pan-y;
        width: 100%;
        max-width: 100vw;
        height: auto;
    }

    .animated-background {
        position: fixed;
        inset: 0;
        background: linear-gradient(135deg, #ddd6fe 0%, #e0e7ff 50%, #a8e0e0 100%);
        z-index: -2;
        opacity: 0;
        animation: bgFadeIn 1s ease-out forwards;
    }

    @keyframes bgFadeIn {
        to { opacity: 1; }
    }

    .glitter {
        position: fixed;
        width: 4px;
        height: 4px;
        background: white;
        border-radius: 50%;
        pointer-events: none;
        z-index: -1;
        box-shadow: 0 0 6px 2px rgba(255, 255, 255, 0.8);
        animation: glitterShine 2s ease-in-out infinite;
    }

    @keyframes glitterShine {
        0%, 100% { opacity: 0; transform: scale(0); }
        50% { opacity: 1; transform: scale(1.5); }
    }

    .glitter.gold { background: #FFD700; }
    .glitter.silver { background: #E8E8E8; }
    .glitter.cyan { background: #00FFFF; }
    .glitter.pink { background: #FF69B4; }

    .particle {
        position: fixed;
        pointer-events: none;
        z-index: -1;
        opacity: 0;
        animation: particleFadeIn 0.8s ease-out forwards, floatParticle 8s infinite ease-in-out;
    }

    @keyframes particleFadeIn {
        to { opacity: 0.8; }
    }

    @keyframes floatParticle {
        0%, 100% { transform: translate(0, 0) rotate(0deg); }
        50% { transform: translate(-15px, -60px) rotate(180deg); }
    }

    .results-container {
        width: 100%;
        max-width: 580px;
        padding: 60px 16px 80px;
        margin: 0 auto;
        position: relative;
        z-index: 1;
        transition: opacity 0.5s ease;
        display: none;
        opacity: 0;
        overflow-x: hidden;
    }

    .results-container.visible {
        display: block;
        opacity: 1;
    }

    .persona-badge {
        position: absolute;
        top: 10px;
        left: 10px;
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, #FFA726 0%, #FFD54F 100%);
        border-radius: 50%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        font-family: 'Fredoka', sans-serif;
        font-weight: 700;
        font-size: 0.6rem;
        color: white;
        text-transform: uppercase;
        text-align: center;
        line-height: 1.2;
        box-shadow: 0 8px 20px rgba(255, 167, 38, 0.4);
        border: 3px solid white;
        transform: scale(0) rotate(-180deg);
        animation: badgeSpin 1s cubic-bezier(0.34, 1.56, 0.64, 1) 1.5s forwards;
        z-index: 10;
    }

    @keyframes badgeSpin {
        to { transform: scale(1) rotate(0deg); }
    }

    .persona-badge::after {
        content: '';
        position: absolute;
        bottom: -18px;
        left: 50%;
        transform: translateX(-50%);
        width: 0;
        height: 0;
        border-style: solid;
        border-width: 18px 18px 0 18px;
        border-color: #FF6F00 transparent transparent transparent;
    }

    .game-title {
        font-family: 'Fredoka', sans-serif;
        font-size: clamp(1.5rem, 8vw, 2.8rem);
        font-weight: 700;
        text-align: center;
        margin: 0 0 8px;
        padding: 0 90px;
        color: #FFD54F;
        text-shadow: 3px 3px 0px #6B3C8F, -2px -2px 0px #8B5CB3, 0 4px 12px rgba(0, 0, 0, 0.3);
        letter-spacing: 1px;
        animation: titleBounceIn 1s cubic-bezier(0.34, 1.56, 0.64, 1) 1s forwards;
        opacity: 0;
        word-break: break-word;
    }

    @keyframes titleBounceIn {
        0% { opacity: 0; transform: scale(0.3) translateY(-80px); }
        70% { opacity: 1; transform: scale(1.1) translateY(0px); }
        100% { opacity: 1; transform: scale(1) translateY(0); }
    }

    .subtitle-ribbon {
        background: linear-gradient(135deg, #4FC3F7 0%, #29B6F6 100%);
        padding: 8px 24px;
        margin: 0 auto 20px;
        border-radius: 8px;
        font-family: 'Fredoka', sans-serif;
        font-size: clamp(0.9rem, 4vw, 1.1rem);
        font-weight: 700;
        color: white;
        text-align: center;
        box-shadow: 0 6px 16px rgba(79, 195, 247, 0.3);
        animation: ribbonExpand 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) 1.5s forwards;
        opacity: 0;
        width: fit-content;
        max-width: 90%;
    }

    @keyframes ribbonExpand {
        0% { transform: scaleX(0); opacity: 0; }
        100% { transform: scaleX(1); opacity: 1; }
    }

    .character-section {
        position: relative;
        width: 100%;
        max-width: 300px;
        margin: 0 auto 25px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .character-container {
        position: relative;
        width: clamp(180px, 55vw, 250px);
        height: clamp(180px, 55vw, 250px);
        animation: characterFlyIn 1.5s cubic-bezier(0.34, 1.56, 0.64, 1) 0.2s forwards;
        opacity: 0;
        margin-bottom: 10px;
    }

    @keyframes characterFlyIn {
        0% { opacity: 0; transform: translateY(-200px) rotate(-180deg) scale(0.3); }
        60% { opacity: 1; transform: translateY(15px) rotate(5deg) scale(1.1); }
        100% { opacity: 1; transform: translateY(0) rotate(0deg) scale(1); }
    }

    .character-emoji, .graphic-wrapper {
        font-size: clamp(100px, 30vw, 160px);
        display: block;
        text-align: center;
        filter: drop-shadow(0 15px 30px rgba(0, 0, 0, 0.2));
        animation: characterFloat 4s ease-in-out infinite;
    }

    .graphic-wrapper svg { width: 100%; height: 100%; }

    @keyframes characterFloat {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-12px); }
    }

    .graduation-cap, .overlay-icon {
        position: absolute;
        top: -15px;
        left: 50%;
        transform: translateX(-50%);
        font-size: clamp(40px, 12vw, 70px);
        z-index: 2;
        animation: capWiggle 2s ease-in-out infinite;
    }

    @keyframes capWiggle {
        0%, 100% { transform: translateX(-50%) rotate(-8deg); }
        50% { transform: translateX(-50%) rotate(8deg); }
    }

    .wing-sparkle-static {
        position: absolute;
        font-size: clamp(16px, 5vw, 24px);
        z-index: 5;
        opacity: 0;
        filter: drop-shadow(0 0 6px rgba(255, 255, 255, 0.8));
        animation: sparkleStaticAppear 0.8s ease-out forwards, sparkleGlow 2s ease-in-out infinite;
    }

    @keyframes sparkleStaticAppear {
        to { opacity: 1; }
    }

    @keyframes sparkleGlow {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.2); }
    }

    .speech-bubble {
        position: relative;
        background: white;
        padding: 12px 16px;
        border-radius: 16px;
        font-family: 'Fredoka', sans-serif;
        font-size: clamp(0.8rem, 3vw, 1rem);
        font-weight: 600;
        color: #5D4037;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        animation: bubblePop 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) 2s forwards;
        opacity: 0;
        transform: scale(0);
        margin: 0 auto;
        width: 90%;
        max-width: 280px;
        text-align: center;
    }

    .speech-bubble::before {
        content: '';
        position: absolute;
        left: 50%;
        top: -12px;
        transform: translateX(-50%);
        border-style: solid;
        border-width: 0 10px 12px 10px;
        border-color: transparent transparent white transparent;
    }

    @keyframes bubblePop {
        to { opacity: 1; transform: scale(1); }
    }

    .stats-container {
        display: flex;
        flex-direction: column;
        gap: 12px;
        margin-bottom: 25px;
    }

    .stat-pill {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(8px);
        border-radius: 40px;
        display: flex;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        border: 2px solid white;
        overflow: hidden;
        animation: fadeInUp 0.6s ease-out forwards;
        opacity: 0;
        transform: translateY(40px);
    }

    .stat-pill:nth-child(1) { animation-delay: 2.5s; }
    .stat-pill:nth-child(2) { animation-delay: 2.7s; }

    @keyframes fadeInUp {
        to { opacity: 1; transform: translateY(0); }
    }

    .stat-icon-box {
        min-width: 60px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
    }

    .stat-content {
        padding: 10px 16px;
        flex: 1;
        color: white;
    }

    .stat-label {
        font-size: 0.75rem;
        font-weight: 700;
        opacity: 0.9;
    }

    .stat-value {
        font-family: 'Fredoka', sans-serif;
        font-size: 1rem;
        font-weight: 700;
    }

    .powers-section {
        display: flex;
        flex-direction: column;
        gap: 16px;
        margin-bottom: 25px;
    }

    .power-bar-wrapper {
        opacity: 0;
        transform: translateY(40px);
        animation: powerBarSlide 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
    }

    .power-bar-wrapper:nth-child(1) { animation-delay: 3.2s; }
    .power-bar-wrapper:nth-child(2) { animation-delay: 3.4s; }

    @keyframes powerBarSlide {
        to { opacity: 1; transform: translateY(0); }
    }

    .power-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background: rgba(139, 127, 200, 0.4);
        padding: 8px 12px;
        border-radius: 16px;
        color: white;
        font-weight: 700;
        font-size: 0.85rem;
    }

    .power-bar-track {
        height: 32px;
        background: #4A3B6F;
        border-radius: 16px;
        overflow: hidden;
        border: 2px solid rgba(255,255,255,0.3);
        position: relative;
    }

    .power-bar-fill {
        height: 100%;
        width: 0%;
        transition: width 1.8s cubic-bezier(0.34, 1.56, 0.64, 1);
        position: relative;
    }

    .battery-icon {
        position: absolute;
        right: 8px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.2rem;
    }

    .insight-badge {
        background: linear-gradient(135deg, #FF9800, #FFD54F);
        padding: 16px 24px;
        border-radius: 40px;
        display: flex;
        align-items: center;
        gap: 12px;
        box-shadow: 0 10px 25px rgba(255, 152, 0, 0.4);
        border: 3px solid rgba(255,255,255,0.6);
        margin-bottom: 20px;
        animation: badgePop 0.8s cubic-bezier(0.34, 1.56, 0.64, 1) 4s forwards;
        opacity: 0;
        transform: scale(0.5);
    }

    @keyframes badgePop {
        to { transform: scale(1); opacity: 1; }
    }

    .action-btn {
        background: linear-gradient(135deg, #66BB6A, #81C784);
        padding: 16px;
        border-radius: 40px;
        color: white;
        text-align: center;
        text-decoration: none;
        font-family: 'Fredoka', sans-serif;
        font-weight: 700;
        display: block;
        width: 100%;
        margin-bottom: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        opacity: 0;
        animation: fadeInUp 0.6s ease-out 5s forwards;
        transition: transform 0.2s;
        border: none;
        cursor: pointer;
        font-size: 0.95rem;
    }

    .action-btn.dashboard-btn {
        background: linear-gradient(135deg, #6366F1, #8B7FE8);
        animation-delay: 4.8s;
    }

    .action-btn:active {
        transform: scale(0.95);
    }

    .share-buttons-row {
        display: flex;
        gap: 18px;
        justify-content: center;
        margin-bottom: 10px;
        flex-wrap: wrap;
    }

    .share-btn-large {
        width: 56px;
        height: 56px;
        border-radius: 50%;
        border: 2px solid white;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 24px;
        cursor: pointer;
        transition: transform 0.2s, opacity 0.2s;
        opacity: 0;
        transform: scale(0);
        animation: shareIconPop 0.5s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
        box-shadow: 0 2px 10px rgba(0,0,0,0.15);
    }

    .share-btn-large:nth-child(1) { animation-delay: 5.4s; }
    .share-btn-large:nth-child(2) { animation-delay: 5.6s; }
    .share-btn-large:nth-child(3) { animation-delay: 5.8s; }
    .share-btn-large:nth-child(4) { animation-delay: 6s; }
    .share-btn-large:nth-child(5) { animation-delay: 6.2s; }

    @keyframes shareIconPop {
        to { opacity: 1; transform: scale(1); }
    }

    .share-btn-large:active {
        transform: scale(0.9);
    }

    .share-labels {
        display: flex;
        justify-content: center;
        gap: 18px;
        font-size: 0.75rem;
        font-weight: 700;
        color: #5D4037;
        margin-bottom: 30px;
        opacity: 0;
        animation: fadeInUp 0.6s ease-out 6.4s forwards;
        flex-wrap: wrap;
    }

    .share-labels span {
        width: 56px;
        text-align: center;
    }

    canvas#confetti-canvas {
        position: fixed;
        inset: 0;
        pointer-events: none;
        z-index: 100;
        transition: opacity 1s ease-out;
        display: none;
    }

    .scroll-to-top {
        position: fixed;
        bottom: 80px;
        right: 16px;
        width: 48px;
        height: 48px;
        background: #6366F1;
        color: white;
        border: none;
        border-radius: 50%;
        font-size: 1.4rem;
        cursor: pointer;
        opacity: 0;
        visibility: hidden;
        transition: 0.3s;
        z-index: 999;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
    }

    .scroll-to-top.visible {
        opacity: 1;
        visibility: visible;
    }

    .reward-modal {
        position: fixed;
        inset: 0;
        background: rgba(15, 23, 42, 0.9);
        backdrop-filter: blur(10px);
        z-index: 10000;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 16px;
        overflow-x: hidden;
        overflow-y: auto;
    }

    .reward-modal.active {
        display: flex;
    }

    .reward-content {
        background: white;
        border-radius: 28px;
        padding: 36px 24px;
        width: 100%;
        max-width: 380px;
        text-align: center;
        animation: modalPop 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
        overflow-x: hidden;
        box-sizing: border-box;
    }

    @keyframes modalPop {
        from { transform: scale(0.8); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }

    .modal-emoji {
        font-size: 4rem;
        display: block;
        margin-bottom: 16px;
    }

    .reward-title {
        font-size: 2rem;
        font-weight: 900;
        margin-bottom: 16px;
        color: #1a1a2e;
    }

    .reward-badges {
        display: flex;
        justify-content: center;
        gap: 16px;
        margin: 24px 0;
        flex-wrap: wrap;
    }

    .badge-item {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, white 100%);
        border-radius: 16px;
        padding: 16px;
        min-width: 100px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        border: 2px solid rgba(139, 127, 232, 0.2);
    }

    .badge-emoji {
        font-size: 2.5rem;
        margin-bottom: 10px;
    }

    .badge-name {
        font-size: 0.85rem;
        color: #64748b;
        font-weight: 800;
    }

    .level-up {
        background: linear-gradient(135deg, #FFE17B 0%, #FFEB99 100%);
        border-radius: 16px;
        padding: 20px;
        margin: 20px 0;
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        border: 3px solid rgba(255, 255, 255, 0.6);
    }

    .level-up-text {
        font-size: 1.4rem;
        font-weight: 900;
        color: #1a1a2e;
    }

    .continue-btn {
        background: linear-gradient(135deg, #6366F1 0%, #8B7FE8 100%);
        color: white;
        border: 2px solid rgba(255, 255, 255, 0.4);
        padding: 16px 40px;
        border-radius: 80px;
        font-size: 1rem;
        font-weight: 800;
        cursor: pointer;
        margin-top: 20px;
        transition: all 0.3s ease;
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        font-family: inherit;
        text-transform: uppercase;
    }

    .continue-btn:active {
        transform: scale(0.95);
    }

    .auth-modal {
        position: fixed;
        inset: 0;
        background: radial-gradient(circle at top, rgba(159,151,243,.35), rgba(15,23,42,.95));
        backdrop-filter: blur(12px);
        z-index: 10001;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 16px;
        overflow-x: hidden;
        overflow-y: auto;
    }

    .auth-modal.active {
        display: flex;
        animation: fadeInModal 0.4s ease;
    }

    @keyframes fadeInModal {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .auth-modal-content {
        background: linear-gradient(180deg, #FFFFFF 0%, #F8F4FF 50%, #FFF4F0 100%);
        border-radius: 24px;
        padding: 32px 24px;
        width: 100%;
        max-width: 400px;
        position: relative;
        box-shadow: 0 20px 40px rgba(0,0,0,.3);
        animation: popInModal 0.6s cubic-bezier(.34,1.56,.64,1);
        border: 2px solid rgba(159,151,243,.2);
        overflow-x: hidden;
        box-sizing: border-box;
    }

    @keyframes popInModal {
        from { transform: scale(.85) translateY(20px); opacity: 0; }
        to { transform: scale(1) translateY(0); opacity: 1; }
    }

    .auth-close-btn {
        position: absolute;
        top: 12px;
        right: 12px;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        border: 2px solid rgba(0,0,0,.08);
        background: linear-gradient(135deg, #FFE8E8, #FFF);
        font-size: 1.2rem;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.2s ease;
        color: #64748b;
    }

    .auth-close-btn:active {
        transform: scale(0.9);
    }

    .auth-header {
        text-align: center;
        margin-bottom: 24px;
        position: relative;
    }

    .auth-header::before {
        content: '✨';
        position: absolute;
        top: -12px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 1.8rem;
    }

    .auth-header h2 {
        font-size: 1.8rem;
        font-weight: 900;
        background: linear-gradient(135deg, #1a1a2e 0%, #6366F1 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 6px;
    }

    .auth-header p {
        font-size: 0.9rem;
        color: #64748b;
        font-weight: 600;
    }

    .auth-form-group {
        margin-bottom: 16px;
        position: relative;
    }

    .auth-form-label {
        display: block;
        font-size: 0.8rem;
        font-weight: 800;
        margin-bottom: 6px;
        color: #1a1a2e;
        text-transform: uppercase;
    }

    .auth-form-input {
        width: 100%;
        padding: 14px 14px 14px 44px;
        border-radius: 14px;
        border: 2px solid #E8E4FF;
        background: white;
        font-size: 0.95rem;
        font-weight: 600;
        color: #1a1a2e;
        transition: all 0.3s ease;
        font-family: 'Plus Jakarta Sans', sans-serif;
    }

    .auth-form-input::placeholder {
        color: #94a3b8;
        font-weight: 500;
    }

    .auth-form-input:focus {
        border-color: #9F97F3;
        outline: none;
        box-shadow: 0 0 0 3px rgba(159,151,243,.15);
        transform: translateY(-2px);
    }

    .input-icon {
        position: absolute;
        left: 14px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.2rem;
        pointer-events: none;
        z-index: 1;
    }

    .auth-submit-btn {
        width: 100%;
        padding: 16px;
        border-radius: 80px;
        background: linear-gradient(135deg, #9F97F3 0%, #FF8F7D 100%);
        color: white;
        font-weight: 900;
        font-size: 1rem;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 10px 20px rgba(159,151,243,.35);
        text-transform: uppercase;
    }

    .auth-submit-btn:active {
        transform: scale(0.95);
    }

    .auth-footer {
        text-align: center;
        margin-top: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        color: #64748b;
    }

    .auth-footer a {
        color: #9F97F3;
        font-weight: 800;
        cursor: pointer;
        text-decoration: none;
    }

    .auth-message {
        padding: 12px 16px;
        border-radius: 12px;
        font-weight: 700;
        font-size: 0.85rem;
        margin-bottom: 14px;
        text-align: center;
        display: none;
    }

    .auth-message.success {
        background: linear-gradient(135deg, #D4FFEA, #B4F8D8);
        color: #065f46;
        border: 2px solid #6EE7B7;
    }

    .auth-message.error {
        background: linear-gradient(135deg, #FFEAEA, #FFD4D4);
        color: #991b1b;
        border: 2px solid #FCA5A5;
    }

    @media (max-width: 480px) {
        .results-container {
            padding: 50px 12px 70px;
        }

        .persona-badge {
            width: 60px;
            height: 60px;
            font-size: 0.55rem;
            top: 8px;
            left: 8px;
        }

        .game-title {
            font-size: clamp(1.3rem, 7vw, 2rem);
            padding: 0 75px;
        }

        .subtitle-ribbon {
            font-size: 0.85rem;
            padding: 6px 20px;
        }

        .stat-icon-box {
            min-width: 56px;
            font-size: 1.6rem;
        }

        .stat-content {
            padding: 10px 14px;
        }

        .stat-label {
            font-size: 0.7rem;
        }

        .stat-value {
            font-size: 0.9rem;
        }

        .power-header {
            font-size: 0.8rem;
            padding: 6px 10px;
        }

        .power-bar-track {
            height: 28px;
        }

        .insight-badge {
            padding: 14px 20px;
            font-size: 0.9rem;
        }

        .action-btn {
            padding: 14px;
            font-size: 0.9rem;
        }

        .share-btn-large {
            width: 52px;
            height: 52px;
            font-size: 1.2rem;
        }

        .share-labels {
            font-size: 0.7rem;
            gap: 18px;
        }

        .share-labels span {
            width: 52px;
        }

        .scroll-to-top {
            bottom: 70px;
            right: 12px;
            width: 44px;
            height: 44px;
        }
    }

    @media (min-width: 481px) and (max-width: 768px) {
        .results-container {
            padding: 55px 16px 75px;
        }
    }

    @media (prefers-reduced-motion: reduce) {
        *,
        *::before,
        *::after {
            animation-duration: 0.01ms !important;
            animation-iteration-count: 1 !important;
            transition-duration: 0.01ms !important;
        }
    }
    </style>
</head>
<body>

<div class="animated-background"></div>
<canvas id="confetti-canvas"></canvas>

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

<div class="results-container" id="mainContainer">
</div>

<button class="scroll-to-top" id="scrollToTop">↑</button>

<script type="text/javascript">
    var resultData = ${raw((result as grails.converters.JSON).toString())};

    var ALL_PERSONAS = {
        wolf: {
            id: 'wolf', gameType: 'spirit-animal', title: "THE STRATEGIC WOLF", subtitle: "The Hunter", emoji: "🐺",
            speech: "You sense the right move before others.",
            stats: [
                { icon: "🧭", label: "Core Strength:", value: "Strategic Intuition", bg: "#78909C", contentBg: "linear-gradient(135deg, #FF9800, #FFB74D)" },
                { icon: "🎯", label: "Logic Type:", value: "Elimination-Based", bg: "#EF5350", contentBg: "linear-gradient(135deg, #26A69A, #4DB6AC)" }
            ],
            powers: [
                { name: "Decision Accuracy", val: 82, color: "linear-gradient(90deg, #29B6F6, #42A5F5)" },
                { name: "Reaction Speed", val: 91, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "⚡", text: "INSIGHT: You excel at narrowing options quickly." }
        },
        owl: {
            id: 'owl', gameType: 'spirit-animal', title: "THE WISE OWL", subtitle: "The Strategist", emoji: "🦉",
            speech: "You have a gift for seeing the unseen!",
            stats: [
                { icon: "🔍", label: "Core Strength:", value: "Deep Precision", bg: "#42A5F5", contentBg: "linear-gradient(135deg, #FF9800, #FFB74D)" },
                { icon: "🧠", label: "Logic Type:", value: "Analytical", bg: "#9C27B0", contentBg: "linear-gradient(135deg, #26A69A, #4DB6AC)" }
            ],
            powers: [
                { name: "Logic Accuracy", val: 96, color: "linear-gradient(90deg, #29B6F6, #42A5F5)" },
                { name: "Focus Stamina", val: 88, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "👁️", text: "INSIGHT: You spot errors before they happen." }
        },
        bee: {
            id: 'bee', gameType: 'spirit-animal', title: "THE DISCIPLINED BEE", subtitle: "The Architect", emoji: "🐝",
            speech: "You build success one step at a time.",
            stats: [
                { icon: "🧱", label: "Core Strength:", value: "Structured Consistency", bg: "#FFCA28", contentBg: "linear-gradient(135deg, #FF9800, #FFB74D)" },
                { icon: "📊", label: "Logic Type:", value: "Process-Oriented", bg: "#26A69A", contentBg: "linear-gradient(135deg, #26A69A, #4DB6AC)" }
            ],
            powers: [
                { name: "Process Discipline", val: 93, color: "linear-gradient(90deg, #29B6F6, #42A5F5)" },
                { name: "Mental Endurance", val: 89, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "🍯", text: "INSIGHT: You thrive when routines are in place." }
        },
        tiger: {
            id: 'tiger', gameType: 'spirit-animal', title: "THE BOLD TIGER", subtitle: "The Sprinter", emoji: "🐯",
            speech: "You perform best under pressure!",
            stats: [
                { icon: "🚀", label: "Core Strength:", value: "Speed & Confidence", bg: "#FF7043", contentBg: "linear-gradient(135deg, #FF9800, #FFB74D)" },
                { icon: "🔥", label: "Logic Type:", value: "Rapid Execution", bg: "#F44336", contentBg: "linear-gradient(135deg, #26A69A, #4DB6AC)" }
            ],
            powers: [
                { name: "Response Speed", val: 97, color: "linear-gradient(90deg, #29B6F6, #42A5F5)" },
                { name: "Error Control", val: 73, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "⏱️", text: "INSIGHT: You trust your sharp instincts." }
        },
        'logic-builder': {
            id: 'logic-builder', gameType: 'brain-power', title: "THE LOGIC BUILDER", subtitle: "You think step by step", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><polygon points="120,40 160,60 120,80 80,60" fill="#00E5FF" stroke="#00E5FF" stroke-width="2"/><polygon points="80,60 120,80 120,120 80,100" fill="#7B6FD8" stroke="#7B6FD8"/><polygon points="120,80 160,60 160,100 120,120" fill="#FFB74D" stroke="#FFB74D"/></svg>',
            speech: "You enjoy problems that have clear answers.",
            stats: [
                { icon: "⚙️", label: "Core Strength:", value: "Structured Reasoning", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "🧠", label: "Thinking Style:", value: "Logical Sequencing", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Logical Thinking", val: 82, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" },
                { name: "Accuracy", val: 78, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "🧠", text: "INSIGHT: You prefer factual structures." }
        },
        // COGNITIVE_RADAR personas
        'analytical-diamond': {
            id: 'analytical-diamond', gameType: 'cognitive-radar', title: "THE ANALYTICAL DIAMOND", subtitle: "STEM Brain Power", emoji: "💎",
            speech: "You see the world in systems and structures!",
            stats: [
                { icon: "🔬", label: "Core Strength:", value: "Systematic Thinking", bg: "#5C6BC0", contentBg: "linear-gradient(135deg, #7986CB, #5C6BC0)" },
                { icon: "🧮", label: "Best For:", value: "Math/Physics/Coding", bg: "#42A5F5", contentBg: "linear-gradient(135deg, #64B5F6, #42A5F5)" }
            ],
            powers: [
                { name: "Logical Reasoning", val: 94, color: "linear-gradient(90deg, #5C6BC0, #7986CB)" },
                { name: "Pattern Analysis", val: 88, color: "linear-gradient(90deg, #42A5F5, #64B5F6)" }
            ],
            insight: { icon: "💎", text: "INSIGHT: Complex problems energize you." }
        },
        'verbal-virtuoso': {
            id: 'verbal-virtuoso', gameType: 'cognitive-radar', title: "THE VERBAL VIRTUOSO", subtitle: "Master of Words", emoji: "✍️",
            speech: "Words are your superpower!",
            stats: [
                { icon: "📚", label: "Core Strength:", value: "Communication", bg: "#7E57C2", contentBg: "linear-gradient(135deg, #9575CD, #7E57C2)" },
                { icon: "⚖️", label: "Best For:", value: "Law/Humanities", bg: "#26A69A", contentBg: "linear-gradient(135deg, #4DB6AC, #26A69A)" }
            ],
            powers: [
                { name: "Reading Speed", val: 96, color: "linear-gradient(90deg, #7E57C2, #9575CD)" },
                { name: "Comprehension", val: 92, color: "linear-gradient(90deg, #26A69A, #4DB6AC)" }
            ],
            insight: { icon: "✍️", text: "INSIGHT: Language is your canvas." }
        },
        'precise-processor': {
            id: 'precise-processor', gameType: 'cognitive-radar', title: "THE PRECISE PROCESSOR", subtitle: "Speed + Accuracy", emoji: "⚡",
            speech: "You process information at lightning speed!",
            stats: [
                { icon: "🎯", label: "Core Strength:", value: "Quick Processing", bg: "#FF7043", contentBg: "linear-gradient(135deg, #FF8A65, #FF7043)" },
                { icon: "🧠", label: "Best For:", value: "Fast-Paced Tasks", bg: "#66BB6A", contentBg: "linear-gradient(135deg, #81C784, #66BB6A)" }
            ],
            powers: [
                { name: "Processing Speed", val: 97, color: "linear-gradient(90deg, #FF7043, #FF8A65)" },
                { name: "Accuracy Rate", val: 85, color: "linear-gradient(90deg, #66BB6A, #81C784)" }
            ],
            insight: { icon: "⚡", text: "INSIGHT: Speed is your advantage." }
        },
        'visual-visionary': {
            id: 'visual-visionary', gameType: 'cognitive-radar', title: "THE VISUAL VISIONARY", subtitle: "Sees the Big Picture", emoji: "🎨",
            speech: "You think in images and patterns!",
            stats: [
                { icon: "🖼️", label: "Core Strength:", value: "Spatial Thinking", bg: "#EC407A", contentBg: "linear-gradient(135deg, #F48FB1, #EC407A)" },
                { icon: "🎯", label: "Best For:", value: "Design/Architecture", bg: "#AB47BC", contentBg: "linear-gradient(135deg, #CE93D8, #AB47BC)" }
            ],
            powers: [
                { name: "Visualization", val: 95, color: "linear-gradient(90deg, #EC407A, #F48FB1)" },
                { name: "Spatial Memory", val: 90, color: "linear-gradient(90deg, #AB47BC, #CE93D8)" }
            ],
            insight: { icon: "🎨", text: "INSIGHT: You see what others miss." }
        },
        'curious-thinker': {
            id: 'curious-thinker', gameType: 'curiosity', title: "THE CURIOUS THINKER", subtitle: "You love asking 'why'",
            emoji: "😊", showLightbulb: true, speech: "You learn best when it feels interesting.",
            stats: [
                { icon: "🔍", label: "Core Strength:", value: "Deep Curiosity", bg: "#8B7FE8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "🧠", label: "Thinking Style:", value: "Question-Based Learning", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Idea Exploration", val: 85, color: "linear-gradient(90deg, #FFB74D, #FFA726)" },
                { name: "Understanding", val: 92, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" }
            ],
            insight: { icon: "💡", text: "INSIGHT: Curiosity fuels your engine." }
        },
        // CURIOSITY_COMPASS personas
        'theorist': {
            id: 'theorist', gameType: 'curiosity', title: "THE THEORIST", subtitle: "Deep Thinker", emoji: "🔬",
            speech: "You love understanding the 'why' behind everything!",
            stats: [
                { icon: "📖", label: "Core Strength:", value: "Theoretical Analysis", bg: "#5E35B1", contentBg: "linear-gradient(135deg, #7E57C2, #5E35B1)" },
                { icon: "🧪", label: "Learning Style:", value: "Concept-First", bg: "#3949AB", contentBg: "linear-gradient(135deg, #5C6BC0, #3949AB)" }
            ],
            powers: [
                { name: "Deep Understanding", val: 96, color: "linear-gradient(90deg, #5E35B1, #7E57C2)" },
                { name: "Abstract Thinking", val: 91, color: "linear-gradient(90deg, #3949AB, #5C6BC0)" }
            ],
            insight: { icon: "🔬", text: "INSIGHT: You question to understand." }
        },
        'builder': {
            id: 'builder', gameType: 'curiosity', title: "THE BUILDER", subtitle: "Hands-On Creator", emoji: "🛠️",
            speech: "You learn best by building and doing!",
            stats: [
                { icon: "🏗️", label: "Core Strength:", value: "Practical Application", bg: "#FF6F00", contentBg: "linear-gradient(135deg, #FF8F00, #FF6F00)" },
                { icon: "⚙️", label: "Learning Style:", value: "Learn by Doing", bg: "#F57C00", contentBg: "linear-gradient(135deg, #FF9800, #F57C00)" }
            ],
            powers: [
                { name: "Practical Skills", val: 94, color: "linear-gradient(90deg, #FF6F00, #FF8F00)" },
                { name: "Project Completion", val: 89, color: "linear-gradient(90deg, #F57C00, #FF9800)" }
            ],
            insight: { icon: "🛠️", text: "INSIGHT: You make ideas real." }
        },
        'empath': {
            id: 'empath', gameType: 'curiosity', title: "THE EMPATH", subtitle: "People Person", emoji: "💝",
            speech: "You connect deeply with people and stories!",
            stats: [
                { icon: "🤝", label: "Core Strength:", value: "Emotional Intelligence", bg: "#E91E63", contentBg: "linear-gradient(135deg, #F06292, #E91E63)" },
                { icon: "👥", label: "Learning Style:", value: "Social Learning", bg: "#AD1457", contentBg: "linear-gradient(135deg, #D81B60, #AD1457)" }
            ],
            powers: [
                { name: "Understanding Others", val: 97, color: "linear-gradient(90deg, #E91E63, #F06292)" },
                { name: "Collaboration", val: 92, color: "linear-gradient(90deg, #AD1457, #D81B60)" }
            ],
            insight: { icon: "💝", text: "INSIGHT: You learn through connection." }
        },
        'challenger': {
            id: 'challenger', gameType: 'curiosity', title: "THE CHALLENGER", subtitle: "Bold Questioner", emoji: "🔥",
            speech: "You push boundaries and question everything!",
            stats: [
                { icon: "💪", label: "Core Strength:", value: "Critical Thinking", bg: "#D32F2F", contentBg: "linear-gradient(135deg, #E57373, #D32F2F)" },
                { icon: "🎯", label: "Learning Style:", value: "Challenge-Driven", bg: "#C62828", contentBg: "linear-gradient(135deg, #EF5350, #C62828)" }
            ],
            powers: [
                { name: "Problem Solving", val: 95, color: "linear-gradient(90deg, #D32F2F, #E57373)" },
                { name: "Resilience", val: 88, color: "linear-gradient(90deg, #C62828, #EF5350)" }
            ],
            insight: { icon: "🔥", text: "INSIGHT: You thrive on tough challenges." }
        },
        'focus-finisher': {
            id: 'focus-finisher', gameType: 'focus-power', title: "THE FOCUS FINISHER", subtitle: "You stay on task till the end", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><circle cx="120" cy="120" r="95" fill="none" stroke="#9CFF57" stroke-width="8" opacity="0.6"/><circle cx="120" cy="120" r="75" fill="none" stroke="#4FC3F7" stroke-width="8"/><circle cx="120" cy="120" r="18" fill="#4FC3F7"/></svg>',
            speech: "You perform best with clear goals.",
            stats: [
                { icon: "🎯", label: "Core Strength:", value: "Concentration", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "👀", label: "Thinking Style:", value: "Sustained Attention", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Focus Stamina", val: 93, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" },
                { name: "Completion", val: 89, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "🎯", text: "INSIGHT: You thrive on single targets." }
        },
        // FOCUS_STAMINA personas
        'marathoner': {
            id: 'marathoner', gameType: 'focus-stamina', title: "THE MARATHONER", subtitle: "Endurance Champion", emoji: "🏃",
            speech: "You maintain focus for the long haul!",
            stats: [
                { icon: "⏱️", label: "Core Strength:", value: "Sustained Focus", bg: "#43A047", contentBg: "linear-gradient(135deg, #66BB6A, #43A047)" },
                { icon: "💪", label: "Work Style:", value: "Long Sessions", bg: "#388E3C", contentBg: "linear-gradient(135deg, #4CAF50, #388E3C)" }
            ],
            powers: [
                { name: "Focus Duration", val: 97, color: "linear-gradient(90deg, #43A047, #66BB6A)" },
                { name: "Mental Stamina", val: 94, color: "linear-gradient(90deg, #388E3C, #4CAF50)" }
            ],
            insight: { icon: "🏃", text: "INSIGHT: You excel in lengthy tasks." }
        },
        'sprinter': {
            id: 'sprinter', gameType: 'focus-stamina', title: "THE SPRINTER", subtitle: "Quick Burst Energy", emoji: "⚡",
            speech: "You work best in short, intense bursts!",
            stats: [
                { icon: "🔥", label: "Core Strength:", value: "Explosive Focus", bg: "#FF5722", contentBg: "linear-gradient(135deg, #FF7043, #FF5722)" },
                { icon: "⏰", label: "Work Style:", value: "Short Bursts", bg: "#F4511E", contentBg: "linear-gradient(135deg, #FF6E40, #F4511E)" }
            ],
            powers: [
                { name: "Intensity", val: 96, color: "linear-gradient(90deg, #FF5722, #FF7043)" },
                { name: "Quick Results", val: 91, color: "linear-gradient(90deg, #F4511E, #FF6E40)" }
            ],
            insight: { icon: "⚡", text: "INSIGHT: Short tasks suit you best." }
        },
        'safe-player': {
            id: 'safe-player', gameType: 'focus-stamina', title: "THE SAFE PLAYER", subtitle: "Careful & Steady", emoji: "🛡️",
            speech: "You take calculated risks and steady progress!",
            stats: [
                { icon: "🎯", label: "Core Strength:", value: "Consistency", bg: "#1976D2", contentBg: "linear-gradient(135deg, #2196F3, #1976D2)" },
                { icon: "📊", label: "Work Style:", value: "Measured Approach", bg: "#1565C0", contentBg: "linear-gradient(135deg, #1E88E5, #1565C0)" }
            ],
            powers: [
                { name: "Reliability", val: 93, color: "linear-gradient(90deg, #1976D2, #2196F3)" },
                { name: "Risk Management", val: 89, color: "linear-gradient(90deg, #1565C0, #1E88E5)" }
            ],
            insight: { icon: "🛡️", text: "INSIGHT: Steady wins the race." }
        },
        'quitter': {
            id: 'quitter', gameType: 'focus-stamina', title: "THE QUICK STARTER", subtitle: "Great Initiator", emoji: "🚀",
            speech: "You're amazing at starting new things!",
            stats: [
                { icon: "✨", label: "Core Strength:", value: "Initiative", bg: "#9C27B0", contentBg: "linear-gradient(135deg, #BA68C8, #9C27B0)" },
                { icon: "🌟", label: "Work Style:", value: "Fresh Beginnings", bg: "#7B1FA2", contentBg: "linear-gradient(135deg, #AB47BC, #7B1FA2)" }
            ],
            powers: [
                { name: "Starting Energy", val: 95, color: "linear-gradient(90deg, #9C27B0, #BA68C8)" },
                { name: "Variety Seeking", val: 87, color: "linear-gradient(90deg, #7B1FA2, #AB47BC)" }
            ],
            insight: { icon: "🚀", text: "INSIGHT: Keep tasks short and varied." }
        },
        'decision-maker': {
            id: 'decision-maker', gameType: 'smart-guess', title: "FAST DECISION MAKER", subtitle: "You act with confidence", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><circle cx="120" cy="120" r="75" fill="#7B6FD8" stroke="#29B6F6" stroke-width="3"/><line x1="120" y1="120" x2="155" y2="90" stroke="#FFB74D" stroke-width="6" stroke-linecap="round"/><circle cx="120" cy="120" r="8" fill="#FFD54F"/></svg>',
            speech: "You trust your sharp instincts.",
            stats: [
                { icon: "💨", label: "Core Strength:", value: "Quick Judgement", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "🧠", label: "Thinking Style:", value: "Rapid Execution", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Response Speed", val: 91, color: "linear-gradient(90deg, #42A5F5, #29B6F6)" },
                { name: "Risk Awareness", val: 73, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "⚡", text: "INSIGHT: You make sharp moves rapidly." }
        },
        // GUESSWORK_QUOTIENT personas
        'balanced-strategist': {
            id: 'balanced-strategist', gameType: 'guesswork', title: "THE BALANCED STRATEGIST", subtitle: "Calibrated Mind", emoji: "⚖️",
            speech: "Your confidence matches your abilities perfectly!",
            stats: [
                { icon: "🎯", label: "Core Strength:", value: "Self-Awareness", bg: "#00897B", contentBg: "linear-gradient(135deg, #26A69A, #00897B)" },
                { icon: "🧠", label: "Decision Style:", value: "Calibrated", bg: "#00796B", contentBg: "linear-gradient(135deg, #009688, #00796B)" }
            ],
            powers: [
                { name: "Self-Calibration", val: 96, color: "linear-gradient(90deg, #00897B, #26A69A)" },
                { name: "Accuracy", val: 92, color: "linear-gradient(90deg, #00796B, #009688)" }
            ],
            insight: { icon: "⚖️", text: "INSIGHT: Trust your judgment." }
        },
        'high-roller': {
            id: 'high-roller', gameType: 'guesswork', title: "THE HIGH ROLLER", subtitle: "Bold Risk Taker", emoji: "🎰",
            speech: "You bet big on your abilities!",
            stats: [
                { icon: "🔥", label: "Core Strength:", value: "Confidence", bg: "#FF6D00", contentBg: "linear-gradient(135deg, #FF9100, #FF6D00)" },
                { icon: "🎲", label: "Decision Style:", value: "Bold Moves", bg: "#E65100", contentBg: "linear-gradient(135deg, #FF6D00, #E65100)" }
            ],
            powers: [
                { name: "Confidence Level", val: 98, color: "linear-gradient(90deg, #FF6D00, #FF9100)" },
                { name: "Bold Decisions", val: 85, color: "linear-gradient(90deg, #E65100, #FF6D00)" }
            ],
            insight: { icon: "🎰", text: "INSIGHT: Sometimes slow down a bit." }
        },
        'under-estimator': {
            id: 'under-estimator', gameType: 'guesswork', title: "THE HUMBLE ACHIEVER", subtitle: "Hidden Talent", emoji: "💎",
            speech: "You're better than you think you are!",
            stats: [
                { icon: "🌟", label: "Core Strength:", value: "True Abilities", bg: "#7B1FA2", contentBg: "linear-gradient(135deg, #9C27B0, #7B1FA2)" },
                { icon: "📈", label: "Decision Style:", value: "Cautious", bg: "#6A1B9A", contentBg: "linear-gradient(135deg, #8E24AA, #6A1B9A)" }
            ],
            powers: [
                { name: "Actual Performance", val: 94, color: "linear-gradient(90deg, #7B1FA2, #9C27B0)" },
                { name: "Untapped Potential", val: 88, color: "linear-gradient(90deg, #6A1B9A, #8E24AA)" }
            ],
            insight: { icon: "💎", text: "INSIGHT: Believe in yourself more!" }
        },
        'hesitant-searcher': {
            id: 'hesitant-searcher', gameType: 'guesswork', title: "THE CAREFUL SEARCHER", subtitle: "Thorough Thinker", emoji: "🔍",
            speech: "You think carefully before deciding!",
            stats: [
                { icon: "🧐", label: "Core Strength:", value: "Thoroughness", bg: "#455A64", contentBg: "linear-gradient(135deg, #607D8B, #455A64)" },
                { icon: "📚", label: "Decision Style:", value: "Research-Based", bg: "#37474F", contentBg: "linear-gradient(135deg, #546E7A, #37474F)" }
            ],
            powers: [
                { name: "Careful Analysis", val: 91, color: "linear-gradient(90deg, #455A64, #607D8B)" },
                { name: "Knowledge Seeking", val: 87, color: "linear-gradient(90deg, #37474F, #546E7A)" }
            ],
            insight: { icon: "🔍", text: "INSIGHT: Trust your research." }
        },
        'adaptive-learner': {
            id: 'adaptive-learner', gameType: 'learning-style', title: "THE ADAPTIVE LEARNER", subtitle: "You adjust and learn fast", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><text x="120" y="140" font-size="80" text-anchor="middle">🧠</text><circle cx="170" cy="70" r="20" fill="#4FC3F7"/><circle cx="70" cy="170" r="18" fill="#7B6FD8"/></svg>',
            speech: "You grow faster when things change.",
            stats: [
                { icon: "🎗️", label: "Core Strength:", value: "Flexibility", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "🦎", label: "Thinking Style:", value: "Adaptive Learning", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Learning Speed", val: 88, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" },
                { name: "Change Handling", val: 91, color: "linear-gradient(90deg, #FFB74D, #FFA726)" }
            ],
            insight: { icon: "📈", text: "INSIGHT: You master new topics easily." }
        },
        // MODALITY_MAP personas
        'visual-learner': {
            id: 'visual-learner', gameType: 'modality', title: "THE VISUAL LEARNER", subtitle: "Sees to Understand", emoji: "👁️",
            speech: "You learn best when you can see it!",
            stats: [
                { icon: "🖼️", label: "Core Strength:", value: "Visual Processing", bg: "#1976D2", contentBg: "linear-gradient(135deg, #2196F3, #1976D2)" },
                { icon: "📊", label: "Best Method:", value: "Diagrams & Charts", bg: "#1565C0", contentBg: "linear-gradient(135deg, #1E88E5, #1565C0)" }
            ],
            powers: [
                { name: "Visual Memory", val: 96, color: "linear-gradient(90deg, #1976D2, #2196F3)" },
                { name: "Pattern Recognition", val: 93, color: "linear-gradient(90deg, #1565C0, #1E88E5)" }
            ],
            insight: { icon: "👁️", text: "INSIGHT: Use diagrams and videos." }
        },
        'auditory-learner': {
            id: 'auditory-learner', gameType: 'modality', title: "THE AUDITORY LEARNER", subtitle: "Listens to Learn", emoji: "🎧",
            speech: "You absorb information by listening!",
            stats: [
                { icon: "🎵", label: "Core Strength:", value: "Audio Processing", bg: "#7B1FA2", contentBg: "linear-gradient(135deg, #9C27B0, #7B1FA2)" },
                { icon: "🗣️", label: "Best Method:", value: "Lectures & Discussion", bg: "#6A1B9A", contentBg: "linear-gradient(135deg, #8E24AA, #6A1B9A)" }
            ],
            powers: [
                { name: "Listening Skills", val: 97, color: "linear-gradient(90deg, #7B1FA2, #9C27B0)" },
                { name: "Verbal Memory", val: 91, color: "linear-gradient(90deg, #6A1B9A, #8E24AA)" }
            ],
            insight: { icon: "🎧", text: "INSIGHT: Use audiobooks and podcasts." }
        },
        'kinesthetic-learner': {
            id: 'kinesthetic-learner', gameType: 'modality', title: "THE KINESTHETIC LEARNER", subtitle: "Learns by Doing", emoji: "🤲",
            speech: "Hands-on experience is your best teacher!",
            stats: [
                { icon: "🛠️", label: "Core Strength:", value: "Tactile Learning", bg: "#2E7D32", contentBg: "linear-gradient(135deg, #43A047, #2E7D32)" },
                { icon: "🎯", label: "Best Method:", value: "Practice & Experiments", bg: "#1B5E20", contentBg: "linear-gradient(135deg, #388E3C, #1B5E20)" }
            ],
            powers: [
                { name: "Physical Memory", val: 95, color: "linear-gradient(90deg, #2E7D32, #43A047)" },
                { name: "Skill Acquisition", val: 92, color: "linear-gradient(90deg, #1B5E20, #388E3C)" }
            ],
            insight: { icon: "🤲", text: "INSIGHT: Practice makes permanent." }
        },
        'conceptual-learner': {
            id: 'conceptual-learner', gameType: 'modality', title: "THE CONCEPTUAL LEARNER", subtitle: "Thinks in Ideas", emoji: "💭",
            speech: "You understand through abstract concepts!",
            stats: [
                { icon: "🧩", label: "Core Strength:", value: "Abstract Thinking", bg: "#5D4037", contentBg: "linear-gradient(135deg, #795548, #5D4037)" },
                { icon: "🔗", label: "Best Method:", value: "Connections & Theory", bg: "#4E342E", contentBg: "linear-gradient(135deg, #6D4C41, #4E342E)" }
            ],
            powers: [
                { name: "Conceptual Understanding", val: 94, color: "linear-gradient(90deg, #5D4037, #795548)" },
                { name: "Theory Building", val: 90, color: "linear-gradient(90deg, #4E342E, #6D4C41)" }
            ],
            insight: { icon: "💭", text: "INSIGHT: Connect ideas to learn." }
        },
        'detail-detective': {
            id: 'detail-detective', gameType: 'pattern-rush', title: "THE DETAIL DETECTIVE", subtitle: "You notice the small things", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><circle cx="105" cy="105" r="70" fill="none" stroke="#7B6FD8" stroke-width="8"/><line x1="160" y1="160" x2="200" y2="200" stroke="#FFD54F" stroke-width="12" stroke-linecap="round"/></svg>',
            speech: "You catch what others miss.",
            stats: [
                { icon: "👁️", label: "Core Strength:", value: "Detail Spotting", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "🔍", label: "Thinking Style:", value: "Observation", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Attention", val: 95, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" },
                { name: "Pattern Recognition", val: 90, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "👁️", text: "INSIGHT: You ensure high accuracy." }
        },
        // PATTERN_SNAPSHOT personas (VISUAL uses visual-learner)
        'verbal-pattern': {
            id: 'verbal-pattern', gameType: 'pattern', title: "THE VERBAL PATTERN MASTER", subtitle: "Word Pattern Expert", emoji: "📝",
            speech: "You see patterns in words and language!",
            stats: [
                { icon: "📚", label: "Core Strength:", value: "Verbal Patterns", bg: "#5E35B1", contentBg: "linear-gradient(135deg, #7E57C2, #5E35B1)" },
                { icon: "🔤", label: "Pattern Type:", value: "Language-Based", bg: "#512DA8", contentBg: "linear-gradient(135deg, #673AB7, #512DA8)" }
            ],
            powers: [
                { name: "Word Recognition", val: 95, color: "linear-gradient(90deg, #5E35B1, #7E57C2)" },
                { name: "Linguistic Patterns", val: 91, color: "linear-gradient(90deg, #512DA8, #673AB7)" }
            ],
            insight: { icon: "📝", text: "INSIGHT: You decode text effortlessly." }
        },
        'numeric-pattern': {
            id: 'numeric-pattern', gameType: 'pattern', title: "THE NUMERIC PATTERN MASTER", subtitle: "Number Pattern Expert", emoji: "🔢",
            speech: "You spot numerical patterns instantly!",
            stats: [
                { icon: "🧮", label: "Core Strength:", value: "Numeric Patterns", bg: "#0288D1", contentBg: "linear-gradient(135deg, #03A9F4, #0288D1)" },
                { icon: "📊", label: "Pattern Type:", value: "Number-Based", bg: "#0277BD", contentBg: "linear-gradient(135deg, #0288D1, #0277BD)" }
            ],
            powers: [
                { name: "Number Recognition", val: 96, color: "linear-gradient(90deg, #0288D1, #03A9F4)" },
                { name: "Mathematical Patterns", val: 93, color: "linear-gradient(90deg, #0277BD, #0288D1)" }
            ],
            insight: { icon: "🔢", text: "INSIGHT: Numbers speak to you." }
        },
        'strategic-planner': {
            id: 'strategic-planner', gameType: 'work-style', title: "THE STRATEGIC PLANNER", subtitle: "You think before you act", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><circle cx="120" cy="120" r="28" fill="#9B8FE8"/><line x1="120" y1="50" x2="120" y2="90" stroke="#4FC3F7" stroke-width="4"/><circle cx="120" cy="50" r="18" fill="#4FC3F7"/></svg>',
            speech: "You like having a clear plan.",
            stats: [
                { icon: "🗺️", label: "Core Strength:", value: "Planning Action", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "🕐", label: "Thinking Style:", value: "Long-Term Thinking", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Planning Skill", val: 92, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" },
                { name: "Control", val: 85, color: "linear-gradient(90deg, #FFD54F, #FFB74D)" }
            ],
            insight: { icon: "🧠", text: "INSIGHT: Strategy is your asset." }
        },
        'creative-connector': {
            id: 'creative-connector', gameType: 'personality', title: "CREATIVE CONNECTOR", subtitle: "You link ideas uniquely", isSVG: true,
            graphic: '<svg viewBox="0 0 240 240"><circle cx="120" cy="120" r="25" fill="#FFD54F"/><path d="M 120 95 Q 80 70, 60 70" stroke="#4FC3F7" stroke-width="5" fill="none"/><path d="M 120 95 Q 160 70, 180 70" stroke="#7B6FD8" stroke-width="5" fill="none"/></svg>',
            speech: "You see connections others miss.",
            stats: [
                { icon: "🧠", label: "Core Strength:", value: "Creative Thinking", bg: "#7B6FD8", contentBg: "linear-gradient(135deg, #A89FE8, #9888D8)" },
                { icon: "💡", label: "Thinking Style:", value: "Idea Association", bg: "#68A8F8", contentBg: "linear-gradient(135deg, #78B8F8, #68A8E8)" }
            ],
            powers: [
                { name: "Original Thinking", val: 87, color: "linear-gradient(90deg, #4FC3F7, #29B6F6)" },
                { name: "Imagination", val: 94, color: "linear-gradient(90deg, #FF69B4, #FFB4D6)" }
            ],
            insight: { icon: "🔗", text: "INSIGHT: Lateral thinking is your gift." }
        },
        // WORK_MODE personas
        'structured-soloist': {
            id: 'structured-soloist', gameType: 'work-mode', title: "THE STRUCTURED SOLOIST", subtitle: "Independent Organizer", emoji: "🎯",
            speech: "You work best alone with a clear plan!",
            stats: [
                { icon: "📋", label: "Core Strength:", value: "Self-Discipline", bg: "#455A64", contentBg: "linear-gradient(135deg, #607D8B, #455A64)" },
                { icon: "👤", label: "Work Style:", value: "Independent & Organized", bg: "#37474F", contentBg: "linear-gradient(135deg, #546E7A, #37474F)" }
            ],
            powers: [
                { name: "Focus", val: 95, color: "linear-gradient(90deg, #455A64, #607D8B)" },
                { name: "Organization", val: 93, color: "linear-gradient(90deg, #37474F, #546E7A)" }
            ],
            insight: { icon: "🎯", text: "INSIGHT: Solo time boosts your productivity." }
        },
        'structured-collaborator': {
            id: 'structured-collaborator', gameType: 'work-mode', title: "THE STRUCTURED COLLABORATOR", subtitle: "Team Organizer", emoji: "👥",
            speech: "You thrive in organized team settings!",
            stats: [
                { icon: "🤝", label: "Core Strength:", value: "Team Coordination", bg: "#1976D2", contentBg: "linear-gradient(135deg, #2196F3, #1976D2)" },
                { icon: "📊", label: "Work Style:", value: "Collaborative & Organized", bg: "#1565C0", contentBg: "linear-gradient(135deg, #1E88E5, #1565C0)" }
            ],
            powers: [
                { name: "Teamwork", val: 94, color: "linear-gradient(90deg, #1976D2, #2196F3)" },
                { name: "Planning", val: 91, color: "linear-gradient(90deg, #1565C0, #1E88E5)" }
            ],
            insight: { icon: "👥", text: "INSIGHT: Structured teams amplify you." }
        },
        'freeform-explorer': {
            id: 'freeform-explorer', gameType: 'work-mode', title: "THE FREEFORM EXPLORER", subtitle: "Flexible Collaborator", emoji: "🌊",
            speech: "You love flexible team environments!",
            stats: [
                { icon: "🎨", label: "Core Strength:", value: "Adaptability", bg: "#00897B", contentBg: "linear-gradient(135deg, #26A69A, #00897B)" },
                { icon: "👥", label: "Work Style:", value: "Flexible & Social", bg: "#00796B", contentBg: "linear-gradient(135deg, #009688, #00796B)" }
            ],
            powers: [
                { name: "Flexibility", val: 96, color: "linear-gradient(90deg, #00897B, #26A69A)" },
                { name: "Collaboration", val: 92, color: "linear-gradient(90deg, #00796B, #009688)" }
            ],
            insight: { icon: "🌊", text: "INSIGHT: Go with the flow." }
        },
        'chaotic-creative': {
            id: 'chaotic-creative', gameType: 'work-mode', title: "THE CHAOTIC CREATIVE", subtitle: "Free Spirit", emoji: "🎪",
            speech: "You make magic from chaos!",
            stats: [
                { icon: "✨", label: "Core Strength:", value: "Creative Freedom", bg: "#E91E63", contentBg: "linear-gradient(135deg, #F06292, #E91E63)" },
                { icon: "🎭", label: "Work Style:", value: "Spontaneous & Solo", bg: "#C2185B", contentBg: "linear-gradient(135deg, #EC407A, #C2185B)" }
            ],
            powers: [
                { name: "Creativity", val: 98, color: "linear-gradient(90deg, #E91E63, #F06292)" },
                { name: "Innovation", val: 94, color: "linear-gradient(90deg, #C2185B, #EC407A)" }
            ],
            insight: { icon: "🎪", text: "INSIGHT: Embrace your spontaneity." }
        },
        // PERSONALITY personas
        'extrovert': {
            id: 'extrovert', gameType: 'personality', title: "THE SOCIAL BUTTERFLY", subtitle: "Energy from People", emoji: "🦋",
            speech: "You gain energy from social interactions!",
            stats: [
                { icon: "🗣️", label: "Core Strength:", value: "Social Energy", bg: "#FF6F00", contentBg: "linear-gradient(135deg, #FF8F00, #FF6F00)" },
                { icon: "🌟", label: "Personality:", value: "Outgoing & Expressive", bg: "#F57C00", contentBg: "linear-gradient(135deg, #FF9800, #F57C00)" }
            ],
            powers: [
                { name: "Social Skills", val: 96, color: "linear-gradient(90deg, #FF6F00, #FF8F00)" },
                { name: "Enthusiasm", val: 94, color: "linear-gradient(90deg, #F57C00, #FF9800)" }
            ],
            insight: { icon: "🦋", text: "INSIGHT: People energize you." }
        },
        'introvert': {
            id: 'introvert', gameType: 'personality', title: "THE DEEP THINKER", subtitle: "Inner Energy", emoji: "🌙",
            speech: "You recharge through quiet reflection!",
            stats: [
                { icon: "🧘", label: "Core Strength:", value: "Deep Focus", bg: "#5C6BC0", contentBg: "linear-gradient(135deg, #7986CB, #5C6BC0)" },
                { icon: "💭", label: "Personality:", value: "Thoughtful & Reflective", bg: "#3F51B5", contentBg: "linear-gradient(135deg, #5C6BC0, #3F51B5)" }
            ],
            powers: [
                { name: "Deep Thinking", val: 97, color: "linear-gradient(90deg, #5C6BC0, #7986CB)" },
                { name: "Focus", val: 95, color: "linear-gradient(90deg, #3F51B5, #5C6BC0)" }
            ],
            insight: { icon: "🌙", text: "INSIGHT: Solitude is your superpower." }
        }
    };

    var isLowPerfDevice = /Android|webOS|Opera Mini/i.test(navigator.userAgent) || window.innerWidth < 400 || (navigator.hardwareConcurrency && navigator.hardwareConcurrency < 4);

    function getPersonaData() {
        console.log('=== PERSONA SELECTION DEBUG ===');
        console.log('Full resultData:', resultData);

        if (resultData && resultData.results) {
            var results = resultData.results;
            console.log('Results object:', results);

            // ✅ FIX: Your backend structure is results.SPIRIT_ANIMAL directly (not nested in gameResults)
            var gameKeys = Object.keys(results);
            console.log('Game keys found:', gameKeys);

            if (gameKeys.length > 0) {
                var lastGame = gameKeys[gameKeys.length - 1];
                var gameData = results[lastGame];
                console.log('Last game:', lastGame);
                console.log('Game data:', gameData);

                // Read resultType directly from the game data
                if (gameData && gameData.resultType) {
                    var resultType = gameData.resultType;
                    console.log('Result type:', resultType);

                    // Map to persona key
                    var personaKey = mapResultTypeToPersonaKey(lastGame, resultType);
                    console.log('Mapped to persona key:', personaKey);

                    if (personaKey && ALL_PERSONAS[personaKey]) {
                        console.log('✅ SUCCESS: Found persona:', personaKey);
                        return ALL_PERSONAS[personaKey];
                    } else {
                        console.log('❌ Persona key not found in ALL_PERSONAS:', personaKey);
                        console.log('Available personas:', Object.keys(ALL_PERSONAS));
                        // Use game-type-based fallback
                        var gameTypeDefaults = {
                            'COGNITIVE_RADAR': 'analytical-diamond',
                            'CURIOSITY_COMPASS': 'theorist',
                            'FOCUS_STAMINA': 'marathoner',
                            'GUESSWORK_QUOTIENT': 'balanced-strategist',
                            'MODALITY_MAP': 'visual-learner',
                            'PATTERN_SNAPSHOT': 'detail-detective',
                            'SPIRIT_ANIMAL': 'owl',
                            'WORK_MODE': 'structured-soloist',
                            'PERSONALITY': 'extrovert'
                        };
                        var fallbackKey = gameTypeDefaults[lastGame];
                        if (fallbackKey && ALL_PERSONAS[fallbackKey]) {
                            console.log('⚠️ Using game-type fallback:', fallbackKey);
                            return ALL_PERSONAS[fallbackKey];
                        }
                    }
                } else {
                    console.log('❌ No resultType found in game data');
                }
            } else {
                console.log('❌ No games found in results');
            }
        } else {
            console.log('❌ resultData.results not found');
        }

        console.log('⚠️ Using default persona (analytical-diamond) - check data flow!');
        return ALL_PERSONAS['analytical-diamond']; // Default to a game-neutral persona
    }

    // ✅ FIXED: Maps database resultType to persona key for ALL games
    function mapResultTypeToPersonaKey(gameType, resultType) {
        console.log('🔍 Mapping:', gameType, '→', resultType);

        // Complete mapping of all game result types to persona keys
        var resultTypeToPersona = {
            // SPIRIT_ANIMAL results
            'BOLD_TIGER': 'tiger',
            'WISE_OWL': 'owl',
            'DISCIPLINED_BEE': 'bee',
            'STRATEGIC_WOLF': 'wolf',
            // COGNITIVE_RADAR results
            'ANALYTICAL_DIAMOND': 'analytical-diamond',
            'VERBAL_VIRTUOSO': 'verbal-virtuoso',
            'PRECISE_PROCESSOR': 'precise-processor',
            'VISUAL_VISIONARY': 'visual-visionary',
            // COGNITIVE_RADAR fallback results (COGNITIVE_LOGIC, etc.)
            'COGNITIVE_LOGIC': 'analytical-diamond',
            'COGNITIVE_VERBAL': 'verbal-virtuoso',
            'COGNITIVE_SPATIAL': 'visual-visionary',
            'COGNITIVE_SPEED': 'precise-processor',
            // CURIOSITY_COMPASS results
            'THEORIST': 'theorist',
            'BUILDER': 'builder',
            'EMPATH': 'empath',
            'CHALLENGER': 'challenger',
            // FOCUS_STAMINA results
            'MARATHONER': 'marathoner',
            'SPRINTER': 'sprinter',
            'SAFE_PLAYER': 'safe-player',
            'QUITTER': 'quitter',
            // GUESSWORK_QUOTIENT results
            'BALANCED_STRATEGIST': 'balanced-strategist',
            'HIGH_ROLLER': 'high-roller',
            'UNDER_ESTIMATOR': 'under-estimator',
            'HESITANT_SEARCHER': 'hesitant-searcher',
            // MODALITY_MAP results
            'VISUAL': 'visual-learner',
            'AUDITORY': 'auditory-learner',
            'KINESTHETIC': 'kinesthetic-learner',
            'CONCEPTUAL': 'conceptual-learner',
            // PATTERN_SNAPSHOT results
            'VERBAL': 'verbal-pattern',
            'NUMERIC': 'numeric-pattern',
            // WORK_MODE results
            'STRUCTURED_SOLOIST': 'structured-soloist',
            'STRUCTURED_COLLABORATOR': 'structured-collaborator',
            'FREEFORM_EXPLORER': 'freeform-explorer',
            'CHAOTIC_CREATIVE': 'chaotic-creative',
            // PERSONALITY results
            'EXTROVERT': 'extrovert',
            'INTROVERT': 'introvert'
        };

        // Check direct mapping first
        if (resultTypeToPersona[resultType]) {
            return resultTypeToPersona[resultType];
        }

        // Game-type-based fallback (ensures game-specific persona, not owl)
        var gameTypeDefaults = {
            'COGNITIVE_RADAR': 'analytical-diamond',
            'CURIOSITY_COMPASS': 'theorist',
            'FOCUS_STAMINA': 'marathoner',
            'GUESSWORK_QUOTIENT': 'balanced-strategist',
            'MODALITY_MAP': 'visual-learner',
            'PATTERN_SNAPSHOT': 'detail-detective',
            'SPIRIT_ANIMAL': 'owl',
            'WORK_MODE': 'structured-soloist',
            'PERSONALITY': 'extrovert'
        };

        console.log('⚠️ Using game-type default for:', gameType);
        return gameTypeDefaults[gameType] || null;
    }

    function renderPersona(p) {
        var container = document.getElementById('mainContainer');
        var charHTML = p.isSVG ? '<div class="graphic-wrapper">' + p.graphic + '</div>' :
            (p.showLightbulb ? '<div class="overlay-icon">💡</div>' : '<div class="graduation-cap">🎓</div>') + '<div class="character-emoji">' + p.emoji + '</div>';

        container.innerHTML = '<div class="persona-badge">PERSONA<br>REVEALED!</div>' +
            '<h1 class="game-title">' + p.title + '</h1>' +
            '<div class="subtitle-ribbon">' + p.subtitle + '</div>' +
            '<div class="character-section">' +
            '<div class="character-container" id="char-box">' + charHTML +
            '<div class="wing-sparkle-static" style="left:15px; top:70px; animation-delay: 2.3s, 2.3s;">✨</div>' +
            '<div class="wing-sparkle-static" style="left:30px; top:110px; animation-delay: 2.5s, 2.5s;">⭐</div>' +
            '<div class="wing-sparkle-static" style="right:15px; top:70px; animation-delay: 2.4s, 2.4s;">✨</div>' +
            '<div class="wing-sparkle-static" style="right:30px; top:110px; animation-delay: 2.6s, 2.6s;">⭐</div>' +
            '</div>' +
            '<div class="speech-bubble">' + p.speech + '</div>' +
            '</div>' +
            '<div class="stats-container">' + p.stats.map(function(s) { return '<div class="stat-pill"><div class="stat-icon-box" style="background: ' + s.bg + '">' + s.icon + '</div>' +
                '<div class="stat-content" style="background: ' + s.contentBg + '"><div class="stat-label">' + s.label + '</div>' +
                '<div class="stat-value">' + s.value + '</div></div></div>'; }).join('') + '</div>' +
            '<div class="powers-section">' + p.powers.map(function(pow, i) { return '<div class="power-bar-wrapper"><div class="power-header"><span>' + pow.name + '</span>' +
                '<span style="font-size:1.1rem">⚡</span></div><div class="power-bar-track">' +
                '<div class="power-bar-fill" id="bar-' + i + '" style="background: ' + pow.color + '"></div>' +
                '<div class="battery-icon">🔋</div></div></div>'; }).join('') + '</div>' +
            '<div class="insight-badge"><div style="font-size: 2.2rem">' + p.insight.icon + '</div>' +
            '<div style="font-family: \'Fredoka\', sans-serif; font-weight: 700; color: white; font-size: 0.95rem;">' + p.insight.text + '</div></div>' +
            '<div class="action-buttons">' +
            '<button id="open-dashboard-modal" class="action-btn dashboard-btn"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin-right:8px"><path d="M3 3v18h18" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><path d="M7 14l4-4 3 3 5-5" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg> View Dashboard</button>' +
            '<a href="${createLink(controller: 'personality', action: 'start')}" class="action-btn"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin-right:8px"><circle cx="12" cy="12" r="8" stroke="currentColor" stroke-width="2"/><circle cx="12" cy="12" r="4" stroke="currentColor" stroke-width="2"/><circle cx="12" cy="12" r="1.5" fill="currentColor"/></svg> Take Next Test</a></div>' +
            '<div class="share-section-title" style="text-align:center; font-family:Fredoka,sans-serif; font-weight:700; font-size:1.1rem; color:#5D4037; margin:20px 0 15px; opacity:0; animation:fadeInUp 0.6s ease-out 5.2s forwards;">SHARE YOUR RESULTS!</div>' +
            '<div class="share-buttons-row">' +
            '<div class="share-btn-large" style="background: #1DA1F2" onclick="shareOnTwitter()" title="Share on Twitter"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"/></svg></div>' +
            '<div class="share-btn-large" style="background: #25D366" onclick="shareOnWhatsApp()" title="Share on WhatsApp"><svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M20.52 3.48A11.77 11.77 0 0 0 12.02 0C5.39.04.08 5.35.08 12c0 2.11.55 4.14 1.59 5.95L0 24l6.2-1.62A11.9 11.9 0 0 0 12 24c6.63 0 12-5.37 12-12 0-3.2-1.25-6.21-3.48-8.52zM12 22a9.9 9.9 0 0 1-5.04-1.39l-.36-.21-3.68.96.98-3.58-.24-.37A9.91 9.91 0 1 1 12 22zm5.43-7.45c-.3-.15-1.78-.88-2.06-.97-.28-.1-.48-.15-.69.15-.2.3-.79.97-.97 1.17-.18.2-.36.22-.66.07-.3-.15-1.27-.47-2.42-1.5-.89-.79-1.49-1.76-1.67-2.06-.17-.3-.02-.46.13-.61.13-.13.3-.33.45-.5.15-.17.2-.29.3-.49.1-.2.05-.37-.02-.52-.07-.15-.69-1.65-.95-2.26-.25-.6-.5-.52-.69-.53h-.59c-.2 0-.52..07-.79.37s-1.04 1.02-1.04 2.49 1.07 2.89 1.22 3.09c.15.2 2.1 3.2 5.1 4.49.71.31 1.26.5 1.69.64.71.23 1.36.2 1.87.12.57-.08 1.78-.73 2.03-1.44.25-.71.25-1.32.17-1.44-.08-.12-.27-.2-.57-.35z"/></svg></div>' +
            '<div class="share-btn-large" style="background: #E1306C" onclick="shareOnInstagram()" title="Share on Instagram"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg></div>' +
            '<div class="share-btn-large" style="background: #0077B5" onclick="shareOnLinkedIn()" title="Share on LinkedIn"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></div>' +
            '<div class="share-btn-large" style="background: #6c5ce7" onclick="copyToClipboard()" title="Copy link to clipboard"><svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="10" height="12" rx="2"></rect><rect x="5" y="5" width="10" height="12" rx="2"></rect></svg></div></div>' +
            '<div class="share-labels"><span>Twitter</span><span>WhatsApp</span><span>Instagram</span><span>LinkedIn</span><span>Copy</span></div>';

        setTimeout(function() {
            p.powers.forEach(function(pow, i) {
                var el = document.getElementById('bar-' + i);
                if(el) el.style.width = pow.val + '%';
            });
        }, 3500);
        fireConfetti();
    }

    function displayRewards(r) {
        var hasRewards = false;

        if (r && r.leveledUp) {
            document.getElementById('level-up-container').innerHTML = '<div class="level-up"><div class="level-up-text">🎊 Level Up! You\'re now Level ' + r.newLevel + '!</div></div>';
            hasRewards = true;
        }

        if (r && r.badges && r.badges.length) {
            document.getElementById('reward-badges').innerHTML = r.badges.map(function(b) { return '<div class="badge-item"><div class="badge-emoji">' + b.emoji + '</div><div class="badge-name">' + b.badgeName + '</div></div>'; }).join('');
            hasRewards = true;
        }

        if (r && r.achievements && r.achievements.length) {
            var html = '<div style="margin-top: 20px;"><h3 style="margin-bottom: 15px; color: #1a1a2e;">🏆 New Achievements!</h3>';
            r.achievements.forEach(function(a) { html += '<div style="background: #f8f9fa; border-radius: 8px; padding: 15px; margin: 10px 0;"><div style="font-size: 2rem;">' + a.emoji + '</div><div style="font-weight: 600; margin-top: 5px;">' + a.achievementTitle + '</div><div style="color: #666; font-size: 0.9rem;">' + a.achievementDescription + '</div></div>'; });
            document.getElementById('achievements-container').innerHTML = html + '</div>';
            hasRewards = true;
        }

        if (hasRewards) {
            document.getElementById('reward-modal').classList.add('active');
            document.body.style.overflow = 'hidden';
        } else {
            revealResults();
        }
    }

    function revealResults() {
        var modal = document.getElementById('reward-modal');
        modal.style.opacity = '0';
        setTimeout(function() {
            modal.classList.remove('active');
            modal.style.display = 'none';
            modal.style.opacity = '1';
            document.body.style.overflow = '';
            document.body.style.overflowX = 'hidden';
            document.body.style.overflowY = 'auto';
            document.documentElement.style.overflowX = 'hidden';
            document.documentElement.style.overflowY = 'auto';
            document.getElementById('mainContainer').classList.add('visible');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }, 400);
        createBackgroundGlitter();
        createFloatingParticles();
        renderPersona(getPersonaData());
    }

    function createBackgroundGlitter() {
        var colors = ['', 'gold', 'silver', 'cyan', 'pink'];
        var interval = isLowPerfDevice ? 400 : 200;
        setInterval(function() {
            for (var i = 0; i < (isLowPerfDevice ? 2 : 4); i++) {
                var g = document.createElement('div');
                g.className = 'glitter ' + colors[Math.floor(Math.random() * colors.length)];
                g.style.left = (Math.random() * 100) + '%';
                g.style.top = (Math.random() * 100) + '%';
                document.body.appendChild(g);
                setTimeout(function(elem) { return function() { elem.remove(); }; }(g), 2500);
            }
        }, interval);
    }

    function createFloatingParticles() {
        var particles = [
            { t: 'emoji', c: '⭐', s: '24px' }, { t: 'emoji', c: '✨', s: '20px' },
            { t: 'circle', c: '#FFB8E8', s: '40px' }, { t: 'circle', c: '#5FE3D0', s: '38px' }
        ];
        particles.slice(0, isLowPerfDevice ? 4 : 8).forEach(function(p) {
            var el = document.createElement('div');
            el.className = 'particle';
            el.style.animationDelay = (1 + Math.random()) + 's';
            if (p.t === 'emoji') { el.textContent = p.c; el.style.fontSize = p.s; }
            else { el.style.width = el.style.height = p.s; el.style.borderRadius = '50%'; el.style.background = 'radial-gradient(circle, ' + p.c + ', transparent)'; el.style.opacity = '0.7'; }
            el.style.left = (Math.random() * 100) + '%';
            el.style.top = (Math.random() * 100) + '%';
            document.body.appendChild(el);
        });
    }

    function fireConfetti() {
        var canvas = document.getElementById('confetti-canvas');
        if (!canvas) return;
        var ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        canvas.style.display = 'block';
        canvas.style.opacity = '1';

        var parts = [];
        var colors = ['#8B7FE8', '#5FE3D0', '#FFB4D6', '#FFD86D'];
        for(var i = 0; i < (isLowPerfDevice ? 80 : 150); i++) {
            parts.push({ x: Math.random() * canvas.width, y: -30, r: Math.random() * 8 + 3, d: Math.random() * 20 + 10,
                color: colors[Math.floor(Math.random() * colors.length)], tilt: Math.floor(Math.random() * 12) - 12,
                tiltAngleIncremental: (Math.random() * 0.08) + 0.04, tiltAngle: 0
            });
        }
        var frame = 0;
        var maxFrames = isLowPerfDevice ? 200 : 300;

        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            parts.forEach(function(p, i) {
                p.tiltAngle += p.tiltAngleIncremental;
                p.y += (Math.cos(p.d) + 3 + p.r / 2) / 2;
                p.tilt = Math.sin(p.tiltAngle) * 15;
                ctx.beginPath();
                ctx.lineWidth = p.r;
                ctx.strokeStyle = p.color;
                ctx.moveTo(p.x + p.tilt + p.r / 2, p.y);
                ctx.lineTo(p.x + p.tilt, p.y + p.tilt + p.r / 2);
                ctx.stroke();
                if (p.y > canvas.height) { parts[i].y = -30; parts[i].x = Math.random() * canvas.width; }
            });

            frame++;
            if(frame < maxFrames) {
                requestAnimationFrame(draw);
            } else {
                canvas.style.opacity = '0';
                setTimeout(function() {
                    canvas.style.display = 'none';
                    canvas.style.pointerEvents = 'none';
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                }, 1000);
            }
        }
        draw();
    }

    function shareOnTwitter() { window.open('https://twitter.com/intent/tweet?text=' + encodeURIComponent('I discovered my learning style! 🧬') + '&url=' + encodeURIComponent(location.href), '_blank'); }
    function shareOnWhatsApp() {
        var text = encodeURIComponent('Check out learnerDNA: ' + location.href);
        if (/Android|iPhone|iPad|iPod/i.test(navigator.userAgent)) {
            window.location.href = 'whatsapp://send?text=' + text;
        } else {
            window.open('https://wa.me/?text=' + text, '_blank');
        }
    }
    function shareOnInstagram() {
        // Instagram doesn't support direct sharing, so we'll open the Instagram app or web
        if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) {
            window.location.href = 'instagram://library?AssetPath=' + encodeURIComponent(location.href);
        } else if (/Android/i.test(navigator.userAgent)) {
            window.location.href = 'intent://share?text=' + encodeURIComponent('Check out my learning style! ') + encodeURIComponent(location.href) + '#Intent;package=com.instagram.android;scheme=https;end';
        } else {
            window.open('https://www.instagram.com/', '_blank');
        }
    }
    function shareOnLinkedIn() { window.open('https://www.linkedin.com/sharing/share-offsite/?url=' + encodeURIComponent(location.href), '_blank'); }
    function copyToClipboard() {
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(location.href).then(function() { alert('✅ Link copied!'); }).catch(function() { fallbackCopy(); });
        } else {
            fallbackCopy();
        }
    }
    function fallbackCopy() {
        var t = document.createElement('textarea');
        t.value = location.href;
        t.style.position = 'fixed';
        t.style.left = '-9999px';
        document.body.appendChild(t);
        t.select();
        try { document.execCommand('copy'); alert('✅ Link copied!'); } catch(e) { prompt('Copy this link:', location.href); }
        document.body.removeChild(t);
    }

    function clearAuthMessages() {
        ['signup-error-message', 'signup-success-message', 'login-error-message', 'login-success-message'].forEach(function(id) {
            var el = document.getElementById(id);
            if (el) { el.style.display = 'none'; el.textContent = ''; }
        });
    }

    function showAuthMessage(type, status, msg) {
        var el = document.getElementById(type + '-' + status + '-message');
        if (el) { el.textContent = msg; el.style.display = 'block'; }
    }

    function openAuthModal(mode) {
        var m = document.getElementById('auth-modal');
        var s = document.getElementById('signup-form-container');
        var l = document.getElementById('login-form-container');
        clearAuthMessages();
        if (mode === 'signup') { s.style.display = 'block'; l.style.display = 'none'; }
        else { s.style.display = 'none'; l.style.display = 'block'; }
        m.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeAuthModal() {
        document.getElementById('auth-modal').classList.remove('active');
        document.body.style.overflow = '';
        clearAuthMessages();
    }

    document.getElementById('scrollToTop').addEventListener('click', function() { window.scrollTo({top: 0, behavior: 'smooth'}); });
    window.addEventListener('scroll', function() {
        var btn = document.getElementById('scrollToTop');
        if (window.pageYOffset > 300) btn.classList.add('visible');
        else btn.classList.remove('visible');
    }, { passive: true });

    var continueBtn = document.getElementById('continue-btn-reward');
    if (continueBtn) {
        continueBtn.addEventListener('click', function(e) {
            e.preventDefault();
            revealResults();
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.body.style.overflow = '';
        document.body.style.overflowX = 'hidden';
        document.body.style.overflowY = 'auto';
        document.documentElement.style.overflowX = 'hidden';
        document.documentElement.style.overflowY = 'auto';

        var canvas = document.getElementById('confetti-canvas');
        if (canvas) {
            canvas.style.display = 'none';
            canvas.style.opacity = '0';
        }

        if (resultData && resultData.rewards) {
            displayRewards(resultData.rewards);
        } else {
            revealResults();
        }

        var closeBtn = document.getElementById('auth-close-btn');
        if (closeBtn) closeBtn.addEventListener('click', function(e) { e.preventDefault(); closeAuthModal(); });

        document.body.addEventListener('click', function(e) {
            if (e.target.id === 'open-dashboard-modal' || e.target.closest('#open-dashboard-modal')) {
                e.preventDefault();
                // If user is already logged in, go to dashboard. Otherwise, show auth modal.
                if (window.authManager && window.authManager.isLoggedIn()) {
                    window.location.href = '/dashboard';
                } else {
                    openAuthModal('signup');
                }
            }
            if (e.target.id === 'switch-to-login-link' || e.target.closest('#switch-to-login-link')) {
                e.preventDefault();
                openAuthModal('login');
            }
            if (e.target.id === 'switch-to-signup-link' || e.target.closest('#switch-to-signup-link')) {
                e.preventDefault();
                openAuthModal('signup');
            }
        });

        document.getElementById('auth-modal').addEventListener('click', function(e) { if (e.target.id === 'auth-modal') closeAuthModal(); });

        var signupForm = document.getElementById('signup-form');
        if (signupForm) {
            signupForm.addEventListener('submit', function(e) {
                e.preventDefault();
                clearAuthMessages();
                var ageValue = document.getElementById('signup-age').value;
                // Get guest session ID from localStorage if it exists
                const guestSessionState = JSON.parse(localStorage.getItem('personality_start_state') || '{}');
                const guestSessionId = guestSessionState.sessionId;

                fetch('/api/signup', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        name: document.getElementById('signup-name').value,
                        email: document.getElementById('signup-email').value,
                        age: ageValue ? parseInt(ageValue) : null,
                        sessionId: guestSessionId // Pass guest session ID
                    })
                }).then(function(res) { return res.json(); }).then(function(data) {
                    if (data.success) {
                        showAuthMessage('signup', 'success', 'Success! Redirecting...');
                        // Store tokens and user info
                        if (window.authManager) {
                            window.authManager.storeAuthData(data);
                        }
                        // Redirect to dashboard
                        setTimeout(function() { location.href = '/dashboard'; }, 1500);
                    } else {
                        showAuthMessage('signup', 'error', data.error || 'Signup failed. Please try again.');
                    }
                }).catch(function() { showAuthMessage('signup', 'error', 'An error occurred. Please check your connection.'); });
            });
        }

        var loginForm = document.getElementById('login-form');
        if (loginForm) {
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                clearAuthMessages();
                // Get guest session ID from localStorage if it exists
                const guestSessionState = JSON.parse(localStorage.getItem('personality_start_state') || '{}');
                const guestSessionId = guestSessionState.sessionId;

                fetch('/api/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        email: document.getElementById('login-email').value,
                        sessionId: guestSessionId // Pass guest session ID
                    })
                }).then(function(res) { return res.json(); }).then(function(data) {
                    if (data.success) {
                        showAuthMessage('login', 'success', 'Success! Redirecting...');
                        // Store tokens and user info
                        if (window.authManager) {
                            window.authManager.storeAuthData(data);
                        }
                        // Redirect to dashboard
                        setTimeout(function() { location.href = '/dashboard'; }, 1500);
                    } else {
                        showAuthMessage('login', 'error', data.error || 'Login failed. Please check your email.');
                    }
                }).catch(function() { showAuthMessage('login', 'error', 'An error occurred. Please check your connection.'); });
            });
        }
    });

    window.addEventListener('resize', function() {
        var c = document.getElementById('confetti-canvas');
        if(c) { c.width = window.innerWidth; c.height = window.innerHeight; }
    }, { passive: true });
</script>
</body>
</html>

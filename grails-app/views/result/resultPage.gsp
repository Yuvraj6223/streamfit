<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
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

    .reveal-anim {
        opacity: 0;
        transform: translateY(20px);
        transition: opacity 0.8s ease, transform 0.8s var(--ease-out);
    }
    .visible .reveal-anim {
        opacity: 1;
        transform: translateY(0);
    }

    canvas#confetti-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 11000; }
    </style>
</head>
<body class="theme-wolf">

<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
</div>
<canvas id="confetti-canvas"></canvas>

<!-- Initial Entry Modal -->
<div id="reward-modal" class="reward-modal">
    <div class="reward-content">
        <span class="modal-emoji">✨</span>
        <h2 style="font-size: 2.2rem; font-weight: 900; margin-bottom: 12px; line-height: 1.1;">DNA Analysis Ready</h2>
        <p style="color: var(--text-grey); font-weight: 600; margin-bottom: 40px;">We've calculated your learning style.</p>
        <button class="btn-primary" onclick="revealResults()" style="background: #0f172a;">
            Reveal My Spirit Animal 👉
        </button>
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

            <button class="btn-primary" style="background: var(--theme-primary); box-shadow: 0 15px 30px rgba(0,0,0,0.3);">
                🔓 Unlock Full Report
            </button>
            <a href="#" class="btn-outline" id="btn-next">Take next test (to know more about yourself)</a>

            <p style="margin-top: 30px; font-size: 0.85rem; opacity: 0.6; font-weight: 600;">Want to see your detailed Skill Map?</p>
        </div>

    </div>
</div>

<script>
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

    function revealResults() {
        const urlParams = new URLSearchParams(window.location.search);
        const urlResult = urlParams.get('animal');
        const storedResult = localStorage.getItem('exam_animal_result');
        const keys = Object.keys(ANIMAL_REPORTS);
        const randomResult = keys[Math.floor(Math.random() * keys.length)];
        let resultKey = (urlResult && ANIMAL_REPORTS[urlResult]) ? urlResult : (storedResult || randomResult);
        const data = ANIMAL_REPORTS[resultKey];

        // Update DOM
        document.body.className = data.theme;
        document.getElementById('animal-emoji').innerText = data.emoji;
        document.getElementById('result-title').innerText = data.title;
        document.getElementById('result-tagline').innerText = data.tagline;
        document.getElementById('result-summary').innerText = data.summary;
        document.getElementById('stat-strength').innerText = data.strength;
        document.getElementById('stat-style').innerText = data.style;
        document.getElementById('loss-frame').innerText = data.loss;
        document.getElementById('tribe-text').innerText = data.social;
        document.getElementById('reward-badge').innerText = data.reward;
        document.getElementById('btn-next').innerText = data.next;
        document.getElementById('p1-label').innerText = data.powers[0].l;
        document.getElementById('p2-label').innerText = data.powers[1].l;

        const modal = document.getElementById('reward-modal');
        const results = document.getElementById('results-content');

        modal.style.opacity = '0';
        setTimeout(() => {
            modal.style.display = 'none';
            results.classList.add('visible');

            setTimeout(() => {
                document.getElementById('p1-bar').style.width = data.powers[0].v + '%';
                document.getElementById('p2-bar').style.width = data.powers[1].v + '%';
            }, 600);
        }, 400);

        fireConfetti();
    }

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
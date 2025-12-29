<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="layout" content="main"/>
    <g:set var="pageTitle" value="About LearnerDNA | Student Diagnostic Platform | Career Guidance" />
    <g:set var="pageDescription" value="Learn about LearnerDNA's mission to help students discover their learning style and ideal career path through scientifically-validated diagnostic tests. Trusted by 10,000+ students." />
    <g:set var="pageKeywords" value="about LearnerDNA, student diagnostic platform, career guidance platform, learning style assessment" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${pageTitle}</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
    :root {
        /* BRAND PALETTE - SOFT POP */
        --bg-warm: #FDFCF8;
        --text-dark: #1A1825;
        --text-grey: #505050;

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
        inset: 0;
        z-index: -1;
        background:
                radial-gradient(circle at 20% 20%, rgba(255,255,255,0.25), transparent 40%),
                linear-gradient(
                        180deg,
                        #9C86FF 0%,
                        #C7A3EB 45%,
                        #FFB085 100%
                );
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

    /* --- LAYOUT --- */
    .about-container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 40px 24px;
    }

    /* --- SECTION STYLES --- */
    section {
        margin-bottom: 48px; /* reduced from 64–80px */
        padding-top: 16px;
        opacity: 0;
        transform: translateY(20px);
        transition: all 0.6s var(--ease-smooth);
    }


    section.visible {
        opacity: 1;
        transform: translateY(0);
    }

    .section-heading {
        font-size: clamp(1.8rem, 4vw, 2.5rem);
        font-weight: 800;
        letter-spacing: -0.03em;
        margin: 0 0 24px 0;
        line-height: 1.2;
        color: var(--text-dark);
    }

    .section-paragraph {
        font-size: 1.1rem;
        color: var(--text-grey);
        line-height: 1.8;
        font-weight: 600;
        margin: 0 0 24px 0;
    }

    /* --- HERO SECTION --- */
    .hero-section {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 32px;
        align-items: center;
        padding: 40px 0;
        min-height: auto;
    }


    .hero-headline {
        font-size: clamp(2.5rem, 5vw, 4rem);
        font-weight: 800;
        letter-spacing: -0.03em;
        margin: 0 0 24px 0;
        line-height: 1.1;
        color: var(--text-dark);
    }

    .hero-subheading {
        font-size: 1.2rem;
        color: var(--text-grey);
        line-height: 1.7;
        font-weight: 600;
        margin: 0 0 32px 0;
    }

    .hero-visual img {
        width: 100%;
        border-radius: 32px;
        box-shadow: var(--shadow-float);
    }

    /* --- CTA BUTTON --- */
    .cta-button {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        background: var(--text-dark);
        color: white;
        padding: 16px 32px;
        border-radius: 100px;
        font-weight: 700;
        font-size: 1rem;
        text-decoration: none;
        box-shadow: var(--shadow-float);
        transition: all 0.3s var(--ease-elastic);
        border: none;
        cursor: pointer;
        font-family: inherit;
    }

    .cta-button:hover {
        transform: translateY(-5px) scale(1.05);
        box-shadow: 0 25px 50px -12px rgba(159, 151, 243, 0.4);
    }

    /* --- CARDS --- */
    .card {
        background: var(--card-base);
        border-radius: 28px;
        padding: 26px;
        box-shadow: var(--shadow-soft);
        border: 1px solid rgba(255,255,255,0.5);
        transition: all 0.3s var(--ease-elastic);
    }

    .card.visible {
        opacity: 1;
        transform: translateY(0);
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-float);
    }

    .card h3, .card h4 {
        font-weight: 800;
        color: var(--text-dark);
        margin: 0 0 12px 0;
        font-size: 1.2rem;
        letter-spacing: -0.02em;
    }

    .card p {
        color: var(--text-grey);
        font-weight: 600;
        line-height: 1.6;
        margin: 0;
    }

    /* --- PROBLEM SECTION --- */
    .problem-section {
        text-align: center;
    }

    .problem-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 24px;
        margin-top: 40px;
    }

    /* --- INSIGHT SECTION --- */
    .insight-section {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 60px;
        align-items: center;
        background: var(--pop-cream);
        border-radius: 32px;
        padding: 60px;
        box-shadow: var(--shadow-soft);
    }

    .insight-visual img {
        width: 100%;
        border-radius: 24px;
    }

    /* --- HOW IT WORKS SECTION --- */
    .how-it-works-section {
        text-align: center;
    }

    .steps {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 32px;
        margin-top: 40px;
    }

    .step {
        background: white;
        border-radius: 28px;
        padding: 40px 32px;
        box-shadow: var(--shadow-soft);
        border: 1px solid rgba(255,255,255,0.5);
        transition: all 0.4s var(--ease-elastic);
    }

    .step:hover {
        transform: translateY(-8px) scale(1.05);
        box-shadow: var(--shadow-float);
    }

    .step-icon {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, var(--pop-purple), var(--pop-teal));
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5rem;
        margin: 0 auto 24px;
        box-shadow: 0 10px 20px -5px rgba(159, 151, 243, 0.3);
    }

    .step h3 {
        font-weight: 800;
        color: var(--text-dark);
        margin: 0 0 12px 0;
        font-size: 1.2rem;
    }

    .step p {
        color: var(--text-grey);
        font-weight: 600;
        line-height: 1.6;
        margin: 0;
    }

    /* --- COMPARISON SECTION --- */
    .comparison-section {
        text-align: center;
    }

    .comparison-columns {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 32px;
        margin-top: 40px;
    }

    .column {
        background: white;
        border-radius: 28px;
        padding: 40px;
        box-shadow: var(--shadow-soft);
        border: 1px solid rgba(255,255,255,0.5);
        transition: all 0.3s var(--ease-elastic);
    }

    .column:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-float);
    }

    .column h3 {
        font-weight: 800;
        font-size: 1.3rem;
        margin: 0 0 24px 0;
        color: var(--text-dark);
    }

    .traditional-approach {
        background: linear-gradient(135deg, #FFF4F0 0%, #FFE8E0 100%);
    }

    .streamfit-approach {
        background: linear-gradient(135deg, #F4F3FF 0%, #E5E2FF 100%);
    }

    .column ul {
        list-style: none;
        padding: 0;
        margin: 0;
        text-align: left;
    }

    .column ul li {
        padding: 12px 0;
        color: var(--text-dark);
        font-weight: 600;
        font-size: 1rem;
        line-height: 1.6;
    }

    /* --- WHO IS IT FOR SECTION --- */
    .who-is-it-for-section {
        text-align: center;
    }

    .card-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 24px;
        margin-top: 40px;
    }

    /* --- VISION SECTION --- */
    .vision-section {
        text-align: center;
        background: linear-gradient(135deg, #FFF9EB 0%, #FFF0C2 100%);
        border-radius: 32px;
        padding: 60px;
        box-shadow: var(--shadow-soft);
        position: relative;
        overflow: hidden;
    }

    /* Shine Animation for Vision Section */
    .vision-section::after {
        content: '';
        position: absolute; top: -100%; left: -100%; width: 300%; height: 300%;
        background: linear-gradient(45deg, transparent, rgba(255,255,255,0.6), transparent);
        transform: rotate(45deg);
        animation: shine 4s infinite; pointer-events: none;
    }

    @keyframes shine {
        0% { transform: translateX(-100%) rotate(45deg); }
        20% { transform: translateX(100%) rotate(45deg); }
        100% { transform: translateX(100%) rotate(45deg); }
    }

    .vision-section .section-paragraph {
        position: relative;
        z-index: 2;
    }

    /* --- FINAL CTA SECTION --- */
    .final-cta-section {
        text-align: center;
        padding: 40px 24px;
        background: white;
        border-radius: 32px;
        box-shadow: var(--shadow-float);
    }

    .final-cta-section p {
        font-size: 1.5rem;
        font-weight: 800;
        color: var(--text-dark);
        margin: 0 0 32px 0;
        line-height: 1.4;
    }

    /* --- MOBILE & TABLET --- */
    @media (max-width: 900px) {
        .hero-section {
            grid-template-columns: 1fr;
            gap: 40px;
        }

        .insight-section {
            grid-template-columns: 1fr;
            padding: 40px;
        }

        .comparison-columns {
            grid-template-columns: 1fr;
        }
    }
    @media (max-width: 768px) {
        .hero-section {
            grid-template-columns: 1fr;
            text-align: center;
            padding: 24px 0;
        }

        .hero-headline {
            font-size: 2.1rem;
        }

        .hero-subheading {
            font-size: 1rem;
        }
    }

    @media (max-width: 480px) {
        .about-container {
            padding: 30px 16px;
        }

        section {
            margin-bottom: 36px;
            padding-top: 8px;
        }

        .hero-section {
            padding: 20px 0;
        }

        .hero-headline {
            font-size: 1.9rem;
            line-height: 1.2;
        }

        .hero-subheading {
            font-size: 1rem;
            line-height: 1.5;
        }

        .problem-cards {
            grid-template-columns: 1fr;
            gap: 16px;
        }

        .steps {
            grid-template-columns: 1fr;
            gap: 20px;
        }

        .card {
            padding: 20px;
        }

        .card h3 {
            font-size: 1.1rem;
        }

        .card p {
            font-size: 0.95rem;
        }

        .card-grid {
            grid-template-columns: 1fr;
        }

        .insight-section {
            padding: 32px 24px;
        }

        .vision-section {
            padding: 40px 24px;
        }

        .final-cta-section {
            padding: 32px 20px;
        }
    }

    /* UTILS */
    .animate-in { opacity: 0; animation: reveal 0.8s var(--ease-smooth) forwards; }
    @keyframes reveal { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    .d-1 { animation-delay: 0.1s; } .d-2 { animation-delay: 0.2s; } .d-3 { animation-delay: 0.3s; }

    .hero-visual img {
        max-width: 100%;
        height: auto;
        max-height: 320px;
        object-fit: contain;
    }
    .compact-section {
        margin-bottom: 48px !important;
    }

    .section-header {
        margin-bottom: 24px;
    }

    </style>
</head>
<body>


<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

<div class="about-container">

    <!-- HERO -->
    <section class="hero-section animate-in">
        <div class="hero-content">
            <h1 class="hero-headline">
                🧠 Not all students learn the same way.
            </h1>
            <p class="hero-subheading">
                learnerDNA helps you understand how your brain actually works —
                so your effort finally turns into results.
            </p>

            <a href="${createLink(controller: 'personality', action: 'start')}" class="cta-button">
                🚀 Discover Your Learning DNA
            </a>

            <p style="margin-top:12px;color:#777;font-weight:600;">
                Used by 10,000+ students • Takes just 3 minutes
            </p>
        </div>

        <div class="hero-visual">
            <asset:image
                    src="about.png"
                    alt="LearnerDNA Learning Experience Illustration"
                    class="avatar-img"
                    onerror="this.src='https://placehold.co/600x400?text=Learning+Experience'"
            />

        </div>
    </section>

    <!-- WHY SECTION -->
    <section class="problem-section animate-in compact-section">
        <h2 class="section-heading section-header">💡 Why learnerDNA exists</h2>
        <p class="section-paragraph">
            Students today work harder than ever — yet feel more confused, stressed, and unsure.
            Not because they lack effort, but because they were never taught how they actually learn.
            <br><br>
            learnerDNA was built to fix that.
        </p>
    </section>

    <!-- PROBLEM -->
    <section class="problem-section animate-in compact-section">
        <h2 class="section-heading section-header">😓 The real problem with learning today</h2>
        <div class="problem-cards">
            <div class="card">
                <h3>📚 Studying more, retaining less</h3>
                <p>Students revise repeatedly, yet concepts don’t stick.</p>
            </div>
            <div class="card">
                <h3>⏱️ Time pressure</h3>
                <p>Knowing answers but running out of time in exams.</p>
            </div>
            <div class="card">
                <h3>🤯 No clarity</h3>
                <p>Hard work without understanding what’s going wrong.</p>
            </div>
        </div>
    </section>

    <!-- CORE INSIGHT -->
    <section class="insight-section animate-in compact-section">
        <div>
            <h2 class="section-heading section-header">🧬 Every student has a unique Learning DNA</h2>
            <p class="section-paragraph">
                Some students think fast but make mistakes.<br>
                Some are accurate but slow.<br>
                Some perform best under pressure.<br>
                Others need calm and structure.<br><br>
                Traditional education treats everyone the same — and that’s the real problem.
            </p>
        </div>
        <div class="insight-visual">
            <asset:image
                    src="about.png"
                    alt="Learning DNA"
                    class="avatar-img"
                    onerror="this.src='https://placehold.co/600x400?text=Learning+Experience'"
            />
        </div>
    </section>

    <!-- HOW IT WORKS -->
    <section class="how-it-works-section animate-in">
        <h2 class="section-heading section-header">🎯 How learnerDNA works</h2>

        <div class="steps">
            <div class="step">
                <div class="step-icon">🧠</div>
                <h3>Play short games</h3>
                <p>Quick activities designed to reveal how your brain works.</p>
            </div>

            <div class="step">
                <div class="step-icon">📊</div>
                <h3>Get pattern insights</h3>
                <p>Your decisions reveal learning and thinking patterns.</p>
            </div>

            <div class="step">
                <div class="step-icon">🧬</div>
                <h3>Understand your Learning DNA</h3>
                <p>A clear breakdown of strengths, blind spots, and learning style.</p>
            </div>
        </div>
    </section>

    <!-- COMPARISON -->
    <section class="comparison-section animate-in">
        <h2 class="section-heading section-header">Not another personality test</h2>

        <div class="comparison-columns">
            <div class="column traditional-approach">
                <h3>❌ Traditional Approach</h3>
                <ul>
                    <li>One-size-fits-all learning</li>
                    <li>Focus on marks</li>
                    <li>No learning insight</li>
                </ul>
            </div>

            <div class="column streamfit-approach">
                <h3>✅ learnerDNA Approach</h3>
                <ul>
                    <li>Personal learning patterns</li>
                    <li>Focus on how you think</li>
                    <li>Clarity before preparation</li>
                </ul>
            </div>
        </div>
    </section>

    <!-- WHO IT’S FOR -->
    <section class="who-is-it-for-section animate-in">
        <h2 class="section-heading section-header">👥 Who learnerDNA is for</h2>
        <div class="card-grid">
            <div class="card"><p>🎓 School students (Classes 9–12)</p></div>
            <div class="card"><p>📝 Competitive exam aspirants</p></div>
            <div class="card"><p>🤔 Confused about career choices</p></div>
            <div class="card"><p>👨‍👩‍👧 Parents seeking clarity</p></div>
        </div>
    </section>

    <!-- VISION -->
    <section class="vision-section animate-in">
        <h2 class="section-heading section-header">🌱 Our belief</h2>
        <p class="section-paragraph">
            Before study plans.
            Before coaching.
            Before career choices.
            <br><br>
            Every student deserves to understand how their mind works.
            <br><br>
            learnerDNA exists to make learning personal, confident, and clear.
        </p>
    </section>

    <!-- FINAL CTA -->
    <section class="final-cta-section animate-in">
        <p>
            Discover how your brain actually learns.<br>
            <strong>Start your 3-minute Learning DNA test.</strong>
        </p>
        <a href="${createLink(controller: 'personality', action: 'start')}" class="cta-button">🚀 Start Now</a>

        <p style="font-size:0.9rem;color:#777;margin-top:12px;">
            No sign-up required • Free • Takes 3 minutes
        </p>
    </section>

</div>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const observerOptions = {
            root: null,
            rootMargin: "0px",
            threshold: 0.1
        };

        const observer = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');

                    // Stagger cards in problem section
                    if (entry.target.classList.contains('problem-section')) {
                        const cards = entry.target.querySelectorAll('.card');
                        cards.forEach((card, index) => {
                            setTimeout(() => {
                                card.classList.add('visible');
                            }, index * 200);
                        });
                    }

                    // Stagger cards in who-is-it-for section
                    if (entry.target.classList.contains('who-is-it-for-section')) {
                        const cards = entry.target.querySelectorAll('.card');
                        cards.forEach((card, index) => {
                            setTimeout(() => {
                                card.classList.add('visible');
                            }, index * 150);
                        });
                    }

                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        const sections = document.querySelectorAll('section');
        sections.forEach(section => {
            observer.observe(section);
        });

        // Special handling for step scaling on hover
        const stepObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, { threshold: 0.3 });

        const steps = document.querySelectorAll('.step');
        steps.forEach((step, index) => {
            step.style.opacity = '0';
            step.style.transform = 'translateY(20px)';
            var delay = (index * 0.15) + 's';
            step.style.transition = 'all 0.6s var(--ease-smooth) ' + delay;
            stepObserver.observe(step);
        });

        // Final CTA button pulse animation
        const ctaButton = document.querySelector('.final-cta-section .cta-button');
        if (ctaButton) {
            setInterval(() => {
                ctaButton.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    ctaButton.style.transform = 'scale(1)';
                }, 200);
            }, 3000);
        }
    });
</script>
</html>

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

    /* --- LAYOUT --- */
    .about-container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 40px 24px;
    }

    /* --- SECTION STYLES --- */
    section {
        margin-bottom: 80px;
        opacity: 0;
        transform: translateY(20px);
        transition: all 0.8s var(--ease-smooth);
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
        gap: 40px;
        align-items: center;
        margin-bottom: 100px;
        padding: 60px 0;
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
        padding: 32px;
        box-shadow: var(--shadow-soft);
        border: 1px solid rgba(255,255,255,0.5);
        transition: all 0.3s var(--ease-elastic);
        opacity: 0;
        transform: translateY(20px);
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
        padding: 80px 40px;
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

    @media (max-width: 480px) {
        .about-container {
            padding: 30px 16px;
        }

        section {
            margin-bottom: 60px;
        }

        .hero-section {
            padding: 40px 0;
        }

        .problem-cards {
            grid-template-columns: 1fr;
            gap: 16px;
        }

        .steps {
            grid-template-columns: 1fr;
            gap: 20px;
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
            padding: 60px 24px;
        }
    }

    /* UTILS */
    .animate-in { opacity: 0; animation: reveal 0.8s var(--ease-smooth) forwards; }
    @keyframes reveal { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    .d-1 { animation-delay: 0.1s; } .d-2 { animation-delay: 0.2s; } .d-3 { animation-delay: 0.3s; }
    </style>
</head>
<body>

<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
</div>

<div class="about-container">
        <!-- SECTION 1: HERO -->
        <section class="hero-section animate-in">
            <div class="hero-content">
                <h1 class="hero-headline">🧠 Not all students learn the same way. That’s why most study plans fail.</h1>
                <p class="hero-subheading">StreamFit helps you discover how your brain actually works — so your effort finally turns into results.</p>
                <a href="#" class="cta-button">🔍 Discover Your Learning DNA</a>
            </div>
            <div class="hero-visual">
                <!-- Placeholder for animation -->
                <img src="https://placehold.co/600x400?text=Animation" alt="Learning Animation">
            </div>
        </section>

        <!-- SECTION 2: THE PROBLEM -->
        <section class="problem-section animate-in d-1">
            <h2 class="section-heading">😓 Students today work harder than ever — but results don’t match the effort.</h2>
            <p class="section-paragraph">Long study hours. Endless mock tests. Constant pressure. Yet many students still feel stuck, confused, or burnt out.</p>
            <div class="problem-cards">
                <div class="card">
                    <h3>📚 Studying more, remembering less</h3>
                    <p>You revise again and again, but concepts don’t stick in the exam.</p>
                </div>
                <div class="card">
                    <h3>⏱️ Running out of time</h3>
                    <p>You know the answers — but the clock beats you.</p>
                </div>
                <div class="card">
                    <h3>🤯 Confused despite preparation</h3>
                    <p>You prepare sincerely, yet your scores fluctuate unpredictably.</p>
                </div>
            </div>
        </section>

        <!-- SECTION 3: THE CORE INSIGHT -->
        <section class="insight-section animate-in d-2">
            <div class="insight-content">
                <h2 class="section-heading">🧬 Every student has a different Learning DNA</h2>
                <p class="section-paragraph">
                    Some students are fast but careless.<br>
                    Some are accurate but slow.<br>
                    Some perform best under pressure.<br>
                    Some need calm and structure.<br><br>
                    Traditional education treats everyone the same.<br>
                    That’s the real problem.
                </p>
            </div>
            <div class="insight-visual">
                <img src="https://placehold.co/600x400?text=DNA+Visual" alt="Learning DNA">
            </div>
        </section>

        <!-- SECTION 4: WHAT STREAMFIT DOES -->
        <section class="how-it-works-section animate-in d-3">
            <h2 class="section-heading">🎯 StreamFit helps you understand how you learn, perform, and decide</h2>
            <div class="steps">
                <div class="step">
                    <div class="step-icon">🧠</div>
                    <h3>Short, gamified diagnostics</h3>
                    <p>Quick tests that feel like games — not exams.</p>
                </div>
                <div class="step">
                    <div class="step-icon">📊</div>
                    <h3>Smart scoring & pattern mapping</h3>
                    <p>Your responses reveal how your brain processes information.</p>
                </div>
                <div class="step">
                    <div class="step-icon">🧬</div>
                    <h3>Your Learning DNA dashboard</h3>
                    <p>A clear, visual snapshot of your learning style, strengths, and blind spots.</p>
                </div>
            </div>
        </section>

        <!-- SECTION 5: WHAT MAKES STREAMFIT DIFFERENT -->
        <section class="comparison-section animate-in d-1">
            <h2 class="section-heading">✅ Not another personality quiz. Not another coaching app.</h2>
            <div class="comparison-columns">
                <div class="column traditional-approach">
                    <h3>❌ Traditional Approach</h3>
                    <ul>
                        <li>Labels students as “smart” or “weak”</li>
                        <li>Same advice for everyone</li>
                        <li>Focuses only on marks</li>
                    </ul>
                </div>
                <div class="column streamfit-approach">
                    <h3>✅ StreamFit Approach</h3>
                    <ul>
                        <li>Reveals learning patterns</li>
                        <li>Adapts to how your brain works</li>
                        <li>Focuses on why scores change</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- SECTION 6: WHO STREAMFIT IS FOR -->
        <section class="who-is-it-for-section animate-in d-2">
            <h2 class="section-heading">👥 Who StreamFit is built for</h2>
            <div class="card-grid">
                <div class="card">
                    <h4>🎓 School students (Classes 9–12)</h4>
                </div>
                <div class="card">
                    <h4>📝 Competitive exam aspirants</h4>
                </div>
                <div class="card">
                    <h4>🤔 Students confused about stream or career</h4>
                </div>
                <div class="card">
                    <h4>👨‍👩‍👧 Parents seeking objective clarity</h4>
                </div>
            </div>
        </section>

        <!-- SECTION 7: THE VISION -->
        <section class="vision-section animate-in d-3">
            <h2 class="section-heading">🌱 Our belief is simple</h2>
            <p class="section-paragraph">
                Before study plans.<br>
                Before coaching.<br>
                Before AI tutors.<br><br>
                Students deserve to understand how their brain works.<br><br>
                StreamFit is the foundation for smarter learning systems, personalized coaching, and better career decisions.
            </p>
        </section>

        <!-- SECTION 8: FINAL CTA -->
        <section class="final-cta-section animate-in d-1">
            <p>You don’t need more motivation.<br>You need clarity.</p>
            <a href="#" class="cta-button">🔍 Start with your Learning DNA</a>
        </section>
    </div>

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
</body>
</html>

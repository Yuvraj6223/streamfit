<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="pageTitle" value="Frequently Asked Questions | LearnerDNA Student Diagnostic Tests" />
    <g:set var="pageDescription" value="Get answers to common questions about LearnerDNA's aptitude tests, learning style assessments, and career guidance platform. Free, scientifically-validated, no signup required." />
    <g:set var="pageKeywords" value="FAQ, student aptitude test questions, learning style test help, career guidance FAQ" />

    <!-- FAQ Schema -->
    <g:set var="structuredData">
    {
        "@context": "https://schema.org",
        "@type": "FAQPage",
        "mainEntity": [
            {
                "@type": "Question",
                "name": "Is this scientifically validated?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": "Our assessments are based on established cognitive psychology principles and have been tested with over 10,000 students with 89% reporting accurate matches. We use validated frameworks like VARK learning styles and cognitive load theory."
                }
            },
            {
                "@type": "Question",
                "name": "How long does the test take?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": "The complete Learning DNA assessment takes approximately 20 minutes. Individual diagnostic tests range from 5 to 10 minutes each. You can take tests at your own pace and return anytime."
                }
            },
            {
                "@type": "Question",
                "name": "Is it really free? No hidden costs?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": "Yes, all our diagnostic tests are 100% free with no hidden costs. You get instant results, personalized insights, and shareable reports without any payment. We may offer premium features in the future, but core tests will always remain free."
                }
            },
            {
                "@type": "Question",
                "name": "Do I need to sign up or create an account?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": "No signup required to take tests and view results. You can start immediately. However, creating a free account allows you to save your results, track progress, and access your dashboard anytime."
                }
            },
            {
                "@type": "Question",
                "name": "How accurate are the results?",
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": "Based on feedback from 10,000+ students, 89% reported that their results accurately matched their learning style and strengths. Our tests use scientifically-validated methodologies and are continuously refined based on user data."
                }
            }
        ]
    }
    </g:set>

    <title>${pageTitle}</title>
</head>
<body>
<!-- Enhanced Background Wrapper - Game-like Visual Layers -->
<div class="enhanced-background-wrapper">
    <!-- Layer 1: Enhanced Gradient Mesh with Soft Blobs -->
    <div class="gradient-blobs">
        <div class="blob-shape blob-blue"></div>
        <div class="blob-shape blob-mint"></div>
        <div class="blob-shape blob-peach"></div>
        <div class="blob-shape blob-lavender"></div>
    </div>

    <!-- Layer 2: Floating Star/Sparkle Decorations -->
    <div class="star-decorations">
        <span class="star star-1">⭐</span>
        <span class="star star-2">✨</span>
        <span class="star star-3">💫</span>
        <span class="star star-4">⭐</span>
        <span class="star star-5">✨</span>
        <span class="star star-6">💫</span>
        <span class="star star-7">⭐</span>
        <span class="star star-8">✨</span>
    </div>

    <!-- Layer 3: Floating Educational Icons -->
    <div class="floating-icons">
        <span class="float-icon icon-1">🧠</span>
        <span class="float-icon icon-2">⚡</span>
        <span class="float-icon icon-3">🎯</span>
        <span class="float-icon icon-4">💡</span>
        <span class="float-icon icon-5">🧠</span>
        <span class="float-icon icon-6">⚡</span>
        <span class="float-icon icon-7">💡</span>
        <span class="float-icon icon-8">🏆</span>
        <span class="float-icon icon-9">📚</span>
        <span class="float-icon icon-10">🚀</span>
    </div>

    <!-- Layer 4: Character Illustrations in Corners -->
    <div class="character-corners">
        <div class="corner-character corner-owl">🦉</div>
        <div class="corner-character corner-wolf">🐺</div>
    </div>

    <!-- Layer 5: Tiny Particle Effects -->
    <div class="particle-system">
        <span class="particle p-1"></span>
        <span class="particle p-2"></span>
        <span class="particle p-3"></span>
        <span class="particle p-4"></span>
        <span class="particle p-5"></span>
        <span class="particle p-6"></span>
        <span class="particle p-7"></span>
        <span class="particle p-8"></span>
        <span class="particle p-9"></span>
        <span class="particle p-10"></span>
        <span class="particle p-11"></span>
        <span class="particle p-12"></span>
        <span class="particle p-13"></span>
        <span class="particle p-14"></span>
        <span class="particle p-15"></span>
        <span class="particle p-16"></span>
        <span class="particle p-17"></span>
        <span class="particle p-18"></span>
        <span class="particle p-19"></span>
        <span class="particle p-20"></span>
    </div>
</div>

<!-- Ambient Background Layer - Enhanced with Neon Glow -->
<div class="scenery-layer">
    <div class="blob b-1"></div>
    <div class="blob b-2"></div>
    <div class="blob b-3"></div>
    <div class="particle-container" id="particles"></div>
</div>

<div class="faq-page">
    <!-- FAQ Section -->
    <section class="faq-section">
        <div class="mobile-container">
            <div class="faq-header">
                <h2 class="section-title">Frequently Asked Questions</h2>
                <p class="faq-subtitle">Everything you need to know about learnerDNA</p>
            </div>

            <!-- Search Bar -->
            <div class="faq-search-container">
                <div class="search-wrapper">
%{--                    <span class="search-icon">🔍</span>--}%
                    <input type="text" id="faqSearch" class="faq-search" placeholder="Search for answers...">
                    <span class="search-clear" id="clearSearch">✕</span>
                </div>
            </div>

            <!-- Category Filters -->
            <div class="faq-categories">
                <button class="category-btn active" data-category="all">
                    <span class="category-icon">📚</span>
                    All Questions
                </button>
                <button class="category-btn" data-category="trust">
                    <span class="category-icon">🔒</span>
                    Trust & Safety
                </button>
                <button class="category-btn" data-category="how-it-works">
                    <span class="category-icon">⚙️</span>
                    How It Works
                </button>
                <button class="category-btn" data-category="results">
                    <span class="category-icon">📊</span>
                    Results & Reports
                </button>
            </div>

            <!-- Expand/Collapse Controls -->
            <div class="faq-controls">
                <button class="control-btn" id="expandAll">
                    <span class="control-icon">➕</span>
                    Expand All
                </button>
                <button class="control-btn" id="collapseAll">
                    <span class="control-icon">➖</span>
                    Collapse All
                </button>
                <span class="faq-count"><span id="visibleCount">0</span> questions</span>
            </div>

            <div class="faq-accordion">
                <!-- TRUST BLOCKERS - MOVED TO TOP -->
                <div class="faq-item critical-faq" data-category="trust">
                    <button class="faq-question">
                        <span class="question-icon">🔬</span>
                        <span class="question-text">Is this scientifically validated?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>Our assessments are based on established cognitive psychology principles and have been tested with over 10,000 students with 89% reporting accurate matches.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="trust">
                    <button class="faq-question">
                        <span class="question-icon">🧪</span>
                        <span class="question-text">Is this just another personality test?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>No. Big difference.</strong> Personality tests ask "Do you like parties?" We test <strong>cognitive abilities</strong> — how fast you process information, how you solve problems, how you handle pressure. It's about how your brain works, not just what you prefer. Way more useful for choosing a stream.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">👨‍👩‍👧</span>
                        <span class="question-text">Will this help me convince my parents?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>Yes, if you use it right.</strong> Don't just say "the test said so." Show them your cognitive radar chart, explain your strengths, share the career match reasoning. Parents respect data. One student said: <em>"My dad wanted me in Engineering. I showed him my low spatial reasoning score and high verbal reasoning. He finally understood why Law made more sense for me."</em></p>
                    </div>
                </div>

                <!-- OTHER COMMON QUESTIONS -->
                <div class="faq-item" data-category="how-it-works">
                    <button class="faq-question">
                        <span class="question-icon">⏱️</span>
                        <span class="question-text">How long does it take?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>The complete assessment takes about 20 minutes. You can complete all 9 brain games in one sitting or take breaks between tests.</p>
                    </div>
                </div>

                <div class="faq-item" data-category="trust">
                    <button class="faq-question">
                        <span class="question-icon">💰</span>
                        <span class="question-text">Is it really free?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>Yes! 100% free, no hidden costs, no credit card required. We believe every student deserves access to quality career guidance.</p>
                    </div>
                </div>

                <div class="faq-item" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">🎁</span>
                        <span class="question-text">What do I get?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>You'll receive your Learning Animal profile, cognitive radar chart, work style analysis, and top 3 career/stream recommendations personalized to your strengths.</p>
                    </div>
                </div>

                <div class="faq-item" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">📱</span>
                        <span class="question-text">Can I share my results?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>Absolutely! You can download your results as a PDF or share them directly on social media. Many students share their Learning Animal with friends!</p>
                    </div>
                </div>

                <div class="faq-item" data-category="how-it-works">
                    <button class="faq-question">
                        <span class="question-icon">✅</span>
                        <span class="question-text">Do I need to complete all tests?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>For the most accurate results, we recommend completing all 9 tests. However, you'll get partial insights even if you complete just a few.</p>
                    </div>
                </div>

                <!-- ADDITIONAL CRITICAL QUESTIONS -->
                <div class="faq-item critical-faq" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">👪</span>
                        <span class="question-text">What if my parents disagree with my results?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>Share your detailed profile with them.</strong> It includes scientific reasoning, cognitive data, and career match explanations that parents respect. Many students say this helped them have "the conversation" with their parents using facts, not feelings.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="trust">
                    <button class="faq-question">
                        <span class="question-icon">🎓</span>
                        <span class="question-text">Is this better than school career counseling?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>9 out of 10 students say yes.</strong> School counselors often use generic questionnaires or just look at your marks. We test how your brain actually works — your cognitive strengths, processing speed, learning style. It's personalized, not one-size-fits-all.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">🤔</span>
                        <span class="question-text">What if I disagree with my results?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>That's totally normal! Sometimes the results reveal things you haven't noticed about yourself yet. <strong>Read the full explanation first</strong> — many students say "wait, that actually makes sense" after reading the details. If you still disagree, you can retake the test anytime.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="how-it-works">
                    <button class="faq-question">
                        <span class="question-icon">🔄</span>
                        <span class="question-text">Can I retake the test?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>Yes, anytime!</strong> But most students don't need to. Your cognitive profile is pretty stable. If you do retake it, try to answer honestly based on how you naturally think, not how you wish you thought.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="trust">
                    <button class="faq-question">
                        <span class="question-icon">🔓</span>
                        <span class="question-text">Do I need to sign up before starting?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>Nope! Zero signup required.</strong> Just click "Start Test" and go. We only ask for your email at the END if you want to save your results. No spam, no BS.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">🎯</span>
                        <span class="question-text">What if I'm stuck between two streams?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p>Perfect! That's exactly what this test is for. <strong>We'll show you which stream matches your cognitive strengths</strong> — not just your interests. For example, you might love Biology AND Math, but your brain might be better wired for one over the other. We'll tell you which.</p>
                    </div>
                </div>

                <div class="faq-item critical-faq" data-category="results">
                    <button class="faq-question">
                        <span class="question-icon">🔀</span>
                        <span class="question-text">Can I change my stream choice after this?</span>
                        <span class="faq-icon">+</span>
                    </button>
                    <div class="faq-answer">
                        <p><strong>Of course!</strong> This is a discovery tool, not a binding contract. But here's the thing: <strong>89% of students say it confirmed their gut feeling</strong> or helped them realize something they already suspected. It's validation, not a life sentence.</p>
                    </div>
                </div>

            </div>

            <!-- No Results Message -->
            <div class="no-results" id="noResults" style="display: none;">
                <div class="no-results-icon">🔍</div>
                <h3>No questions found</h3>
                <p>Try adjusting your search or filter to find what you're looking for.</p>
            </div>
        </div>
    </section>

    <!-- Scroll to Top Button -->
    <button class="scroll-to-top" id="scrollToTop" title="Back to top">
        <span>↑</span>
    </button>
</div>

<style>
/* Import Fonts */
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Space+Grotesk:wght@400;500;600;700&family=Outfit:wght@300;400;500;600;700;800;900&display=swap');

/* StreamFit Color Palette - Duolingo-Style Gamified Theme */
:root {
    /* BRAND PALETTE - DUOLINGO-INSPIRED VIBRANT THEME */
    --bg-gradient-top: #A8B5FF;      /* Sky blue at top */
    --bg-gradient-purple: #C5A8FF;   /* Light purple */
    --bg-gradient-lavender: #E8B5FF; /* Lavender purple */
    --bg-gradient-pink: #FFB8E8;     /* Pink purple */
    --bg-gradient-coral: #FFC4B8;    /* Coral pink */
    --bg-gradient-peach: #FFD8A8;    /* Soft peach/yellow */

    --text-dark: #2D2A45;  /* Deep purple-gray for text */
    --text-grey: #7B7896;  /* Medium purple-gray */
    --text-white: #FFFFFF;  /* White text */

    /* PRIMARY COLORS - Duolingo-Style Vibrant Palette */
    --pop-purple: #8B7FE8;  /* Main purple */
    --pop-purple-light: #A89FF3;  /* Light purple */
    --pop-purple-lighter: #C4B5FD;  /* Lighter purple */
    --pop-cyan: #5FE3D0;  /* Bright cyan/turquoise */
    --pop-cyan-light: #7FDBDA;  /* Light cyan */
    --pop-cyan-lighter: #A0E7E5;  /* Lighter cyan */
    --pop-pink: #FFB4D6;  /* Soft pink */
    --pop-pink-light: #FFC4E1;  /* Light pink */
    --pop-yellow: #FFE17B;  /* Pastel yellow */
    --pop-yellow-light: #FFEB99;  /* Light yellow */
    --pop-coral: #FF9AB8;  /* Coral pink */
    --pop-green: #58CC02;  /* Duolingo green */
    --pop-orange: #FF9600;  /* Duolingo orange */

    /* GRADIENT BACKGROUNDS */
    --gradient-purple-cyan: linear-gradient(135deg, #8B7FE8 0%, #5FE3D0 100%);
    --gradient-pink-purple: linear-gradient(135deg, #FFB4D6 0%, #A89FF3 100%);
    --gradient-cyan-yellow: linear-gradient(135deg, #5FE3D0 0%, #FFE17B 100%);
    --gradient-purple-pink: linear-gradient(135deg, #8B7FE8 0%, #FFB4D6 100%);

    /* SURFACES */
    --card-base: rgba(255, 255, 255, 0.85);  /* Semi-transparent white */
    --card-glass: rgba(255, 255, 255, 0.25);  /* Glassmorphism */

    /* GLASSMORPHISM SHADOWS */
    --shadow-soft: 0 12px 30px -10px rgba(139, 127, 232, 0.15);
    --shadow-float: 0 20px 40px -12px rgba(139, 127, 232, 0.25);
    --shadow-glow-purple: 0 8px 32px rgba(139, 127, 232, 0.3);
    --shadow-glow-cyan: 0 8px 32px rgba(95, 227, 208, 0.3);
    --shadow-glow-pink: 0 8px 32px rgba(255, 180, 214, 0.3);

    /* ANIMATION */
    --ease-elastic: cubic-bezier(0.34, 1.56, 0.64, 1);
    --ease-smooth: cubic-bezier(0.16, 1, 0.3, 1);

    /* Legacy mappings for compatibility */
    --navy-blue: #8B7FE8;      /* Maps to pop-purple */
    --bright-blue: #5FE3D0;    /* Maps to pop-cyan */
    --orange: #FF9AB8;         /* Maps to pop-coral */
    --gold: #FFE17B;           /* Maps to pop-yellow */
    --white: #FFFFFF;
    --light-gray: #F5F3FF;     /* Maps to bg-warm */
    --light-blue: #E8E4FF;     /* Light purple tint */
    --light-orange: #FFE8F0;   /* Light pink tint */
    --light-gold: #FFF8E8;     /* Light yellow tint */
    --dark-navy: #2D2A45;      /* Maps to text-dark */
    --text-dark-navy: #2D2A45; /* Maps to text-dark */
    --text-medium-gray: #7B7896; /* Maps to text-grey */
    --text-light-gray: #A89FF3; /* Light purple-gray */
    --text-white: #FFFFFF;
    --border-gray: rgba(139, 127, 232, 0.2);
    --success-green: #5FE3D0;  /* Maps to pop-cyan */
    --success-green-light: rgba(95, 227, 208, 0.15);
    --success-green-dark: #3ABFA8;
    --success-green-bg: rgba(95, 227, 208, 0.05);
    --error-red: #FF9AB8;      /* Maps to pop-coral */
    --error-red-light: rgba(255, 154, 184, 0.15);
    --error-red-dark: #FF7BA0;
    --footer-bg: #2D2A45;      /* Maps to text-dark */
    --orange-hover: #FF7BA0;   /* Darker coral on hover */
    --success-dark: #3ABFA8;

    /* Typography */
    --font-display: 'Plus Jakarta Sans', 'Outfit', sans-serif;
    --font-body: 'Plus Jakarta Sans', 'Space Grotesk', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;

    /* Legacy color mappings for FAQ page */
    --ocean-blue: #8B7FE8;
    --soft-teal-blue: #5FE3D0;
    --sky-blue: #A0E7E5;
    --pure-white: #FFFFFF;
    --charcoal-teal: #2D2A45;
    --soft-text: #7B7896;
    --light-blue-bg: rgba(232, 228, 255, 0.3);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: var(--font-body);
    line-height: 1.6;
    color: var(--text-dark);
    background: transparent;
    -webkit-font-smoothing: antialiased;
}

/* Apply Display Font to All Headlines */
h1, h2, h3, h4, h5, h6,
.section-title,
.faq-question {
    font-family: var(--font-display);
    font-weight: 800;
    letter-spacing: -0.02em;
}

/* --- AMBIENT BACKGROUND - DUOLINGO STYLE --- */
.scenery-layer {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
    overflow: hidden;
    background: linear-gradient(180deg,
        #A8B5FF 0%,           /* Sky blue at top */
        #C5A8FF 20%,          /* Light purple */
        #E8B5FF 40%,          /* Lavender purple */
        #FFB8E8 60%,          /* Pink purple */
        #FFC4B8 80%,          /* Coral pink */
        #FFD8A8 100%          /* Soft peach/yellow at bottom */
    );
}

.blob {
    position: absolute;
    filter: blur(120px);
    opacity: 0.15;
    animation: float-blob 30s infinite ease-in-out alternate;
    pointer-events: none;
}

.b-1 {
    top: -20%;
    right: -15%;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(168, 181, 255, 0.4) 0%, transparent 70%);
    border-radius: 50%;
}

.b-2 {
    bottom: -20%;
    left: -15%;
    width: 700px;
    height: 700px;
    background: radial-gradient(circle, rgba(255, 196, 184, 0.4) 0%, transparent 70%);
    border-radius: 50%;
    animation-delay: -10s;
}

.b-3 {
    top: 35%;
    left: 50%;
    width: 500px;
    height: 500px;
    background: radial-gradient(circle, rgba(232, 181, 255, 0.3) 0%, transparent 70%);
    opacity: 0.12;
    border-radius: 50%;
    animation-duration: 25s;
    animation-delay: -5s;
}

@keyframes float-blob {
    0% {
        transform: translate(0, 0) scale(1) rotate(0deg);
    }
    33% {
        transform: translate(40px, -40px) scale(1.15) rotate(120deg);
    }
    66% {
        transform: translate(-30px, 30px) scale(0.9) rotate(240deg);
    }
    100% {
        transform: translate(0, 0) scale(1) rotate(360deg);
    }
}

/* ========================================
   ENHANCED BACKGROUND LAYERS - GAME-LIKE DEPTH
   ======================================== */

.enhanced-background-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    overflow: hidden;
    z-index: -100;
}

/* Layer 1: Enhanced Gradient Mesh with Soft Blobs */
.gradient-blobs {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -90;
}

.blob-shape {
    position: absolute;
    border-radius: 50%;
    filter: blur(70px);
    will-change: transform;
}

.blob-blue {
    top: 10%;
    right: 5%;
    width: 400px;
    height: 400px;
    background: radial-gradient(circle, rgba(224, 244, 255, 0.25) 0%, transparent 70%);
    animation: float-blob-slow 45s ease-in-out infinite;
}

.blob-mint {
    bottom: 15%;
    left: 8%;
    width: 450px;
    height: 450px;
    background: radial-gradient(circle, rgba(230, 255, 245, 0.2) 0%, transparent 70%);
    animation: float-blob-slow 50s ease-in-out infinite;
    animation-delay: -15s;
}

.blob-peach {
    top: 40%;
    right: 10%;
    width: 350px;
    height: 350px;
    background: radial-gradient(circle, rgba(255, 230, 213, 0.22) 0%, transparent 70%);
    animation: float-blob-slow 40s ease-in-out infinite;
    animation-delay: -25s;
}

.blob-lavender {
    top: 60%;
    left: 15%;
    width: 380px;
    height: 380px;
    background: radial-gradient(circle, rgba(240, 230, 255, 0.18) 0%, transparent 70%);
    animation: float-blob-slow 55s ease-in-out infinite;
    animation-delay: -35s;
}

@keyframes float-blob-slow {
    0%, 100% {
        transform: translate3d(0, 0, 0) scale(1);
    }
    25% {
        transform: translate3d(30px, -30px, 0) scale(1.1);
    }
    50% {
        transform: translate3d(-20px, 40px, 0) scale(0.95);
    }
    75% {
        transform: translate3d(25px, 20px, 0) scale(1.05);
    }
}

/* Layer 2: Floating Star/Sparkle Decorations */
.star-decorations {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -75;
}

.star {
    position: absolute;
    font-size: 2rem;
    opacity: 0.25;
    filter: drop-shadow(0 2px 4px rgba(255, 225, 123, 0.3));
    will-change: transform;
    animation: float-star 7s ease-in-out infinite;
}

.star-1 { top: 8%; left: 12%; animation-delay: 0s; }
.star-2 { top: 15%; right: 18%; font-size: 1.8rem; animation-delay: 0.5s; }
.star-3 { top: 25%; left: 8%; font-size: 2.2rem; animation-delay: 1s; }
.star-4 { top: 45%; right: 10%; animation-delay: 1.5s; }
.star-5 { top: 60%; left: 15%; font-size: 1.9rem; animation-delay: 2s; }
.star-6 { top: 75%; right: 12%; animation-delay: 2.5s; }
.star-7 { bottom: 10%; left: 20%; font-size: 2.1rem; animation-delay: 3s; }
.star-8 { bottom: 20%; right: 8%; animation-delay: 3.5s; }

@keyframes float-star {
    0%, 100% {
        transform: translate3d(0, 0, 0) rotate(0deg);
        opacity: 0.25;
    }
    50% {
        transform: translate3d(0, -20px, 0) rotate(180deg);
        opacity: 0.35;
    }
}

/* Layer 3: Floating Educational Icons */
.floating-icons {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -80;
}

.float-icon {
    position: absolute;
    font-size: 2.5rem;
    opacity: 0.2;
    filter: drop-shadow(0 2px 6px rgba(139, 127, 232, 0.2));
    will-change: transform;
    animation: float-icon-vertical 6s ease-in-out infinite;
}

.icon-1 { top: 12%; left: 5%; font-size: 3rem; animation-delay: 0s; }
.icon-2 { top: 18%; right: 8%; font-size: 2.8rem; animation-delay: 0.7s; }
.icon-3 { top: 30%; left: 10%; animation-delay: 1.4s; }
.icon-4 { top: 38%; right: 6%; font-size: 2.6rem; animation-delay: 2.1s; }
.icon-5 { top: 52%; left: 7%; font-size: 2.9rem; animation-delay: 2.8s; }
.icon-6 { top: 65%; right: 12%; animation-delay: 3.5s; }
.icon-7 { top: 72%; left: 14%; font-size: 2.7rem; animation-delay: 4.2s; }
.icon-8 { bottom: 15%; right: 10%; animation-delay: 4.9s; }
.icon-9 { bottom: 25%; left: 8%; font-size: 2.4rem; animation-delay: 5.6s; }
.icon-10 { bottom: 8%; right: 15%; font-size: 2.8rem; animation-delay: 0.3s; }

@keyframes float-icon-vertical {
    0%, 100% {
        transform: translate3d(0, 0, 0);
        opacity: 0.2;
    }
    50% {
        transform: translate3d(0, -25px, 0);
        opacity: 0.28;
    }
}

/* Layer 4: Character Illustrations in Corners */
.character-corners {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -85;
}

.corner-character {
    position: fixed;
    font-size: 7rem;
    opacity: 0.4;
    filter: drop-shadow(0 4px 12px rgba(139, 127, 232, 0.3));
    will-change: transform;
}

.corner-owl {
    top: 5%;
    left: -2%;
    animation: peek-idle-left 4s ease-in-out infinite;
}

.corner-wolf {
    bottom: 8%;
    right: -2%;
    animation: peek-idle-right 5s ease-in-out infinite;
}

@keyframes peek-idle-left {
    0%, 100% {
        transform: translate3d(0, 0, 0) rotate(-5deg);
    }
    50% {
        transform: translate3d(5px, -8px, 0) rotate(-3deg);
    }
}

@keyframes peek-idle-right {
    0%, 100% {
        transform: translate3d(0, 0, 0) rotate(5deg);
    }
    50% {
        transform: translate3d(-5px, -8px, 0) rotate(3deg);
    }
}

/* Layer 5: Tiny Particle Effects */
.particle-system {
    position: absolute;
    width: 100%;
    height: 100%;
    z-index: -70;
}

.particle {
    position: absolute;
    width: 3px;
    height: 3px;
    border-radius: 50%;
    opacity: 0;
    will-change: transform, opacity;
    animation: particle-rise 12s linear infinite;
}

.particle:nth-child(odd) {
    background: rgba(255, 255, 255, 0.8);
}

.particle:nth-child(even) {
    background: rgba(255, 217, 61, 0.7);
}

.particle:nth-child(3n) {
    background: rgba(168, 181, 255, 0.6);
}

/* Position particles randomly across bottom */
.p-1 { left: 5%; animation-delay: 0s; }
.p-2 { left: 12%; animation-delay: 1s; }
.p-3 { left: 18%; animation-delay: 2s; }
.p-4 { left: 25%; animation-delay: 3s; }
.p-5 { left: 32%; animation-delay: 4s; }
.p-6 { left: 38%; animation-delay: 5s; }
.p-7 { left: 45%; animation-delay: 6s; }
.p-8 { left: 52%; animation-delay: 7s; }
.p-9 { left: 58%; animation-delay: 8s; }
.p-10 { left: 65%; animation-delay: 9s; }
.p-11 { left: 72%; animation-delay: 10s; }
.p-12 { left: 78%; animation-delay: 11s; }
.p-13 { left: 85%; animation-delay: 0.5s; }
.p-14 { left: 92%; animation-delay: 1.5s; }
.p-15 { left: 8%; animation-delay: 2.5s; }
.p-16 { left: 15%; animation-delay: 3.5s; }
.p-17 { left: 48%; animation-delay: 4.5s; }
.p-18 { left: 55%; animation-delay: 5.5s; }
.p-19 { left: 68%; animation-delay: 6.5s; }
.p-20 { left: 95%; animation-delay: 7.5s; }

@keyframes particle-rise {
    0% {
        bottom: 0;
        opacity: 0;
        transform: translate3d(0, 0, 0);
    }
    10% {
        opacity: 0.5;
    }
    50% {
        opacity: 0.6;
        transform: translate3d(15px, -50vh, 0);
    }
    90% {
        opacity: 0.3;
    }
    100% {
        bottom: 100vh;
        opacity: 0;
        transform: translate3d(-20px, -100vh, 0);
    }
}

/* Mobile Optimization - Reduce decorative elements */
@media (max-width: 768px) {
    .blob-shape {
        filter: blur(50px);
    }

    .blob-blue,
    .blob-mint,
    .blob-peach,
    .blob-lavender {
        width: 250px;
        height: 250px;
    }

    .star {
        font-size: 1.5rem;
    }

    .float-icon {
        font-size: 2rem;
    }

    .icon-9,
    .icon-10 {
        display: none;
    }

    .corner-character {
        font-size: 5rem;
    }

    .particle:nth-child(n+16) {
        display: none;
    }
}

/* Reduced Motion Support */
@media (prefers-reduced-motion: reduce) {
    .enhanced-background-wrapper * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
    }

    .blob-shape,
    .star,
    .float-icon,
    .corner-character,
    .particle {
        animation: none !important;
        opacity: 0.15 !important;
    }
}

/* Mobile Container */
.mobile-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* FAQ Header */
.faq-header {
    text-align: center;
    margin-bottom: 40px;
}

.section-title {
    font-size: 2.5rem;
    font-weight: 800;
    color: var(--text-dark);
    text-align: center;
    margin-bottom: 15px;
    text-shadow:
        0 3px 6px rgba(139, 127, 232, 0.15),
        0 1px 2px rgba(0, 0, 0, 0.1);
}

.faq-subtitle {
    font-size: 1.2rem;
    color: var(--text-grey);
    font-weight: 600;
    text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
}

/* FAQ Page Wrapper */
.faq-page {
    padding: 60px 0;
    background: transparent;
    min-height: calc(100vh - 200px);
    position: relative;
}

/* Search Bar */
.faq-search-container {
    max-width: 600px;
    margin: 0 auto 30px;
}

.search-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.search-icon {
    position: absolute;
    left: 22px;
    font-size: 1.2rem;
    pointer-events: none;
    z-index: 1;
}

.faq-search {
    width: 100%;
    padding: 16px 55px 16px 52px;
    border: 3px solid rgba(139, 127, 232, 0.3);
    border-radius: 50px;
    font-size: 1rem;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    outline: none;
    box-shadow: 0 4px 12px rgba(139, 127, 232, 0.1);
}

.faq-search:focus {
    border-color: var(--pop-purple);
    box-shadow: 0 8px 32px rgba(139, 127, 232, 0.25);
    transform: translateY(-2px);
    background: rgba(255, 255, 255, 0.95);
}

.faq-search::placeholder {
    color: var(--text-grey);
}

.search-clear {
    position: absolute;
    right: 20px;
    font-size: 1.2rem;
    color: var(--soft-text);
    cursor: pointer;
    opacity: 0;
    transition: all 0.3s ease;
    padding: 5px;
}

.search-clear.visible {
    opacity: 1;
}

.search-clear:hover {
    color: var(--pop-purple);
    transform: scale(1.2);
}

/* Category Filters */
.faq-categories {
    display: flex;
    justify-content: center;
    gap: 12px;
    margin-bottom: 30px;
    flex-wrap: wrap;
}

.category-btn {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 12px 20px;
    border: 3px solid rgba(139, 127, 232, 0.3);
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 50px;
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--text-dark);
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    box-shadow: 0 4px 12px rgba(139, 127, 232, 0.1);
}

.category-btn:hover {
    border-color: var(--pop-purple);
    transform: translateY(-3px) scale(1.02);
    box-shadow: 0 6px 20px rgba(139, 127, 232, 0.2);
}

.category-btn.active {
    background: linear-gradient(135deg, #8B7FE8 0%, #5FE3D0 100%);
    color: var(--text-white);
    border-color: var(--pop-purple);
    box-shadow: 0 6px 24px rgba(139, 127, 232, 0.35);
    transform: translateY(-2px);
}

.category-icon {
    font-size: 1.2rem;
}

/* FAQ Controls */
.faq-controls {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 15px;
    margin-bottom: 30px;
    flex-wrap: wrap;
}

.control-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 10px 18px;
    border: 3px solid rgba(139, 127, 232, 0.3);
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 50px;
    font-size: 0.9rem;
    font-weight: 700;
    color: var(--pop-purple);
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
    box-shadow: 0 4px 12px rgba(139, 127, 232, 0.1);
}

.control-btn:hover {
    background: rgba(139, 127, 232, 0.1);
    transform: translateY(-2px) scale(1.02);
    border-color: var(--pop-purple);
    box-shadow: 0 6px 16px rgba(139, 127, 232, 0.2);
}

.control-icon {
    font-size: 1rem;
}

.faq-count {
    font-size: 0.9rem;
    color: var(--text-grey);
    font-weight: 700;
    padding: 10px 18px;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 50px;
    border: 3px solid rgba(139, 127, 232, 0.3);
    box-shadow: 0 4px 12px rgba(139, 127, 232, 0.1);
}

/* FAQ SECTION */
.faq-section {
    padding: 80px 0;
    background: transparent;
    position: relative;
}

.faq-accordion {
    max-width: 800px;
    margin: 0 auto;
}

/* No Results Message */
.no-results {
    text-align: center;
    padding: 60px 20px;
    max-width: 500px;
    margin: 0 auto;
}

.no-results-icon {
    font-size: 4rem;
    margin-bottom: 20px;
    opacity: 0.5;
}

.no-results h3 {
    font-size: 1.5rem;
    color: var(--charcoal-teal);
    margin-bottom: 10px;
    font-weight: 700;
}

.no-results p {
    font-size: 1.1rem;
    color: var(--soft-text);
    line-height: 1.6;
}

.faq-item {
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 20px;
    margin-bottom: 15px;
    border: 3px solid rgba(139, 127, 232, 0.3);
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    opacity: 1;
    transform: translateY(0);
    box-shadow: 0 4px 16px rgba(139, 127, 232, 0.1);
}

.faq-item.hidden {
    display: none;
}

.faq-item.fade-in {
    animation: fadeInUp 0.5s ease-out;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Highlight matched text in search */
.faq-item.highlight {
    animation: highlightPulse 0.6s ease-out;
}

@keyframes highlightPulse {
    0%, 100% {
        background: rgba(255, 255, 255, 0.9);
    }
    50% {
        background: rgba(139, 127, 232, 0.15);
    }
}

.faq-item:hover {
    border-color: var(--pop-purple);
    box-shadow: 0 8px 32px rgba(139, 127, 232, 0.25);
    transform: translateY(-4px) scale(1.01);
}

.faq-item.active {
    border-color: var(--pop-purple);
    box-shadow: 0 12px 40px rgba(139, 127, 232, 0.3);
    background: rgba(255, 255, 255, 0.95);
}

/* Critical FAQ Items - Stand Out */
.critical-faq {
    border-color: var(--pop-orange);
    background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 235, 205, 0.9) 100%);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    position: relative;
    box-shadow: 0 6px 20px rgba(255, 150, 0, 0.2);
}

.critical-faq::before {
    content: '🔥';
    position: absolute;
    top: 20px;
    left: -5px;
    font-size: 1.5rem;
    filter: drop-shadow(0 2px 4px rgba(255, 150, 0, 0.3));
}

.critical-faq:hover {
    border-color: #FF6F00;
    box-shadow: 0 10px 32px rgba(255, 152, 0, 0.35);
    transform: translateY(-4px) scale(1.01);
}

.faq-question {
    width: 100%;
    padding: 22px 25px;
    background: none;
    border: none;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    cursor: pointer;
    font-size: 1.1rem;
    font-weight: 600;
    color: var(--charcoal-teal);
    text-align: left;
    transition: all 0.3s ease;
}

.question-icon {
    font-size: 1.8rem;
    flex-shrink: 0;
    transition: transform 0.3s ease;
}

.question-text {
    flex: 1;
}

.faq-item.active .question-icon {
    transform: scale(1.2) rotate(10deg);
}

.critical-faq .faq-question {
    font-weight: 700;
    color: #FF6F00;
}

.faq-question:hover {
    background: rgba(139, 127, 232, 0.08);
}

.critical-faq .faq-question:hover {
    background: rgba(255, 150, 0, 0.08);
}

.faq-icon {
    font-size: 1.5rem;
    color: var(--pop-purple);
    font-weight: 700;
    transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.critical-faq .faq-icon {
    color: #FF6F00;
}

.faq-item.active .faq-icon {
    transform: rotate(45deg);
}

.faq-answer {
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.4s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.3s ease;
    opacity: 0;
}

.faq-item.active .faq-answer {
    max-height: 800px;
    opacity: 1;
}

.faq-answer p {
    padding: 0 25px 20px 35px;
    color: var(--soft-text);
    font-size: 1.05rem;
    line-height: 1.8;
}

.faq-answer p strong {
    color: var(--pop-purple);
    font-weight: 700;
}

.critical-faq .faq-answer p strong {
    color: #FF6F00;
}

.faq-answer p em {
    font-style: italic;
    color: var(--text-dark);
    display: block;
    margin-top: 10px;
    padding-left: 15px;
    border-left: 3px solid var(--pop-purple-light);
    background: rgba(139, 127, 232, 0.05);
    padding: 10px 15px;
    border-radius: 8px;
}

/* Scroll to Top Button */
.scroll-to-top {
    position: fixed;
    bottom: 100px;
    right: 20px;
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #8B7FE8 0%, #5FE3D0 100%);
    color: var(--text-white);
    border: none;
    border-radius: 50%;
    font-size: 1.5rem;
    cursor: pointer;
    box-shadow: 0 6px 20px rgba(139, 127, 232, 0.3);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
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
    transform: translateY(-5px) scale(1.1);
    box-shadow: 0 8px 32px rgba(139, 127, 232, 0.4);
}

.scroll-to-top:active {
    transform: translateY(-2px) scale(1.05);
}

/* Responsive */
@media (max-width: 768px) {
    .section-title {
        font-size: 2rem;
    }

    .faq-subtitle {
        font-size: 1rem;
    }

    .faq-search {
        padding: 14px 50px 14px 48px;
        font-size: 0.95rem;
    }

    .search-icon {
        left: 18px;
        font-size: 1.1rem;
    }

    .search-clear {
        right: 18px;
        font-size: 1rem;
    }

    .faq-categories {
        gap: 8px;
    }

    .category-btn {
        padding: 10px 16px;
        font-size: 0.85rem;
    }

    .category-icon {
        font-size: 1rem;
    }

    .faq-controls {
        gap: 10px;
    }

    .control-btn {
        padding: 8px 14px;
        font-size: 0.85rem;
    }

    .faq-count {
        padding: 8px 14px;
        font-size: 0.85rem;
    }

    .faq-question {
        font-size: 1rem;
        padding: 18px 18px;
        gap: 10px;
    }

    .question-icon {
        font-size: 1.5rem;
    }

    .faq-answer p {
        font-size: 1rem;
        padding: 0 18px 18px 18px;
    }

    .critical-faq::before {
        font-size: 1.2rem;
        top: 18px;
        left: -3px;
    }
}

@media (max-width: 480px) {
    .section-title {
        font-size: 1.7rem;
    }

    .faq-subtitle {
        font-size: 0.9rem;
    }

    .faq-categories {
        flex-direction: column;
        align-items: stretch;
    }

    .category-btn {
        justify-content: center;
    }

    .faq-controls {
        flex-direction: column;
        width: 100%;
    }

    .control-btn,
    .faq-count {
        width: 100%;
        justify-content: center;
    }
}
</style>

<script>
    // Enhanced FAQ functionality with search, filter, and animations
    document.addEventListener('DOMContentLoaded', function() {
        const faqItems = document.querySelectorAll('.faq-item');
        const searchInput = document.getElementById('faqSearch');
        const clearSearch = document.getElementById('clearSearch');
        const categoryBtns = document.querySelectorAll('.category-btn');
        const expandAllBtn = document.getElementById('expandAll');
        const collapseAllBtn = document.getElementById('collapseAll');
        const visibleCount = document.getElementById('visibleCount');

        let currentCategory = 'all';

        // Update visible count and show/hide no results
        function updateCount() {
            const visible = document.querySelectorAll('.faq-item:not(.hidden)').length;
            visibleCount.textContent = visible;

            const noResults = document.getElementById('noResults');
            const accordion = document.querySelector('.faq-accordion');

            if (visible === 0) {
                noResults.style.display = 'block';
                accordion.style.display = 'none';
            } else {
                noResults.style.display = 'none';
                accordion.style.display = 'block';
            }
        }

        // Initial count
        updateCount();

        // FAQ Accordion functionality
        faqItems.forEach(item => {
            const question = item.querySelector('.faq-question');

            question.addEventListener('click', () => {
                const isActive = item.classList.contains('active');

                // Close all items
                faqItems.forEach(i => i.classList.remove('active'));

                // Open clicked item if it wasn't active
                if (!isActive) {
                    item.classList.add('active');
                    // Smooth scroll to item
                    setTimeout(() => {
                        item.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
                    }, 100);
                }
            });
        });

        // Search functionality
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();

            // Show/hide clear button
            if (searchTerm) {
                clearSearch.classList.add('visible');
            } else {
                clearSearch.classList.remove('visible');
            }

            faqItems.forEach(item => {
                const questionText = item.querySelector('.question-text').textContent.toLowerCase();
                const answerText = item.querySelector('.faq-answer p').textContent.toLowerCase();
                const matchesSearch = questionText.includes(searchTerm) || answerText.includes(searchTerm);
                const matchesCategory = currentCategory === 'all' || item.dataset.category === currentCategory;

                if (matchesSearch && matchesCategory) {
                    item.classList.remove('hidden');
                    item.classList.add('fade-in');
                } else {
                    item.classList.add('hidden');
                    item.classList.remove('active');
                }
            });

            updateCount();
        });

        // Clear search
        clearSearch.addEventListener('click', function() {
            searchInput.value = '';
            this.classList.remove('visible');
            searchInput.dispatchEvent(new Event('input'));
            searchInput.focus();
        });

        // Category filter
        categoryBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                // Update active button
                categoryBtns.forEach(b => b.classList.remove('active'));
                this.classList.add('active');

                currentCategory = this.dataset.category;
                const searchTerm = searchInput.value.toLowerCase().trim();

                faqItems.forEach(item => {
                    const questionText = item.querySelector('.question-text').textContent.toLowerCase();
                    const answerText = item.querySelector('.faq-answer p').textContent.toLowerCase();
                    const matchesSearch = !searchTerm || questionText.includes(searchTerm) || answerText.includes(searchTerm);
                    const matchesCategory = currentCategory === 'all' || item.dataset.category === currentCategory;

                    if (matchesSearch && matchesCategory) {
                        item.classList.remove('hidden');
                        item.classList.add('fade-in');
                    } else {
                        item.classList.add('hidden');
                        item.classList.remove('active');
                    }
                });

                updateCount();
            });
        });

        // Expand all
        expandAllBtn.addEventListener('click', function() {
            faqItems.forEach(item => {
                if (!item.classList.contains('hidden')) {
                    item.classList.add('active');
                }
            });
        });

        // Collapse all
        collapseAllBtn.addEventListener('click', function() {
            faqItems.forEach(item => {
                item.classList.remove('active');
            });
        });

        // Keyboard navigation
        searchInput.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                this.value = '';
                clearSearch.classList.remove('visible');
                this.dispatchEvent(new Event('input'));
            }
        });

        // Add stagger animation on load
        faqItems.forEach((item, index) => {
            setTimeout(() => {
                item.classList.add('fade-in');
            }, index * 50);
        });

        // Scroll to top button
        const scrollToTopBtn = document.getElementById('scrollToTop');

        window.addEventListener('scroll', function() {
            if (window.pageYOffset > 300) {
                scrollToTopBtn.classList.add('visible');
            } else {
                scrollToTopBtn.classList.remove('visible');
            }
        });

        scrollToTopBtn.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    });
</script>

</body>
</html>


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
                    <span class="search-icon">🔍</span>
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
    color: var(--ocean-blue);
    text-align: center;
    margin-bottom: 15px;
}

.faq-subtitle {
    font-size: 1.2rem;
    color: var(--soft-text);
    font-weight: 500;
}

/* FAQ Page Wrapper */
.faq-page {
    padding: 60px 0;
    background: var(--light-blue-bg);
    min-height: calc(100vh - 200px);
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
    border: 2px solid var(--sky-blue);
    border-radius: 50px;
    font-size: 1rem;
    background: var(--pure-white);
    transition: all 0.3s ease;
    outline: none;
}

.faq-search:focus {
    border-color: var(--ocean-blue);
    box-shadow: 0 4px 20px rgba(168, 218, 220, 0.3);
    transform: translateY(-2px);
}

.faq-search::placeholder {
    color: var(--soft-text);
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
    color: var(--ocean-blue);
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
    border: 2px solid var(--sky-blue);
    background: var(--pure-white);
    border-radius: 50px;
    font-size: 0.95rem;
    font-weight: 600;
    color: var(--charcoal-teal);
    cursor: pointer;
    transition: all 0.3s ease;
}

.category-btn:hover {
    border-color: var(--ocean-blue);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(168, 218, 220, 0.2);
}

.category-btn.active {
    background: linear-gradient(135deg, var(--ocean-blue) 0%, var(--soft-teal-blue) 100%);
    color: var(--pure-white);
    border-color: var(--ocean-blue);
    box-shadow: 0 4px 16px rgba(58, 109, 137, 0.3);
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
    border: 2px solid var(--sky-blue);
    background: var(--pure-white);
    border-radius: 50px;
    font-size: 0.9rem;
    font-weight: 600;
    color: var(--ocean-blue);
    cursor: pointer;
    transition: all 0.3s ease;
}

.control-btn:hover {
    background: var(--light-blue-bg);
    transform: translateY(-2px);
}

.control-icon {
    font-size: 1rem;
}

.faq-count {
    font-size: 0.9rem;
    color: var(--soft-text);
    font-weight: 600;
    padding: 10px 18px;
    background: var(--pure-white);
    border-radius: 50px;
    border: 2px solid var(--sky-blue);
}

/* FAQ SECTION */
.faq-section {
    padding: 80px 0;
    background: var(--light-blue-bg);
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
    background: var(--pure-white);
    border-radius: 20px;
    margin-bottom: 15px;
    border: 2px solid var(--sky-blue);
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    opacity: 1;
    transform: translateY(0);
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
        background: var(--pure-white);
    }
    50% {
        background: rgba(168, 218, 220, 0.2);
    }
}

.faq-item:hover {
    border-color: var(--ocean-blue);
    box-shadow: 0 6px 24px rgba(168, 218, 220, 0.3);
    transform: translateY(-3px);
}

.faq-item.active {
    border-color: var(--ocean-blue);
    box-shadow: 0 8px 32px rgba(168, 218, 220, 0.4);
}

/* Critical FAQ Items - Stand Out */
.critical-faq {
    border-color: #FF9800;
    background: linear-gradient(135deg, #ffffff 0%, #FFF8F0 100%);
    position: relative;
}

.critical-faq::before {
    content: '🔥';
    position: absolute;
    top: 20px;
    left: -5px;
    font-size: 1.5rem;
}

.critical-faq:hover {
    border-color: #FF6F00;
    box-shadow: 0 6px 20px rgba(255, 152, 0, 0.25);
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
    background: var(--light-blue-bg);
}

.critical-faq .faq-question:hover {
    background: #FFF3E0;
}

.faq-icon {
    font-size: 1.5rem;
    color: var(--ocean-blue);
    font-weight: 700;
    transition: transform 0.3s ease;
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
    color: var(--ocean-blue);
    font-weight: 700;
}

.critical-faq .faq-answer p strong {
    color: #FF6F00;
}

.faq-answer p em {
    font-style: italic;
    color: var(--charcoal-teal);
    display: block;
    margin-top: 10px;
    padding-left: 15px;
    border-left: 3px solid var(--sky-blue);
}

/* Scroll to Top Button */
.scroll-to-top {
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, var(--ocean-blue) 0%, var(--soft-teal-blue) 100%);
    color: var(--pure-white);
    border: none;
    border-radius: 50%;
    font-size: 1.5rem;
    cursor: pointer;
    box-shadow: 0 4px 16px rgba(58, 109, 137, 0.3);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    z-index: 1000;
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
    box-shadow: 0 6px 24px rgba(58, 109, 137, 0.4);
}

.scroll-to-top:active {
    transform: translateY(-2px);
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


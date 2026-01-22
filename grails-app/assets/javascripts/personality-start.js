// Global variables for the current test session
let currentTest = null;
let currentQuestionIndex = 0;
let answers = [];
let questions = [];
let sessionId = null;
let selectedTest = null;
let autoAdvanceTimer = null;
let timeoutId = null;

// Enhanced scroll-to-top function for mobile-first games
function scrollToTop(immediate = false) {
    try {
        // Force immediate scroll for critical game moments
        if (immediate) {
            // Multiple scroll methods for maximum compatibility
            window.scrollTo(0, 0);
            document.documentElement.scrollTop = 0;
            document.body.scrollTop = 0;
            
            // Handle mobile browsers that might resist scrolling
            if (window.scrollY !== 0 || window.pageYOffset !== 0) {
                window.scrollTo(0, 0);
                document.documentElement.scrollTop = 0;
                document.body.scrollTop = 0;
            }
            
            // Reset any scrollable containers
            const scrollableElements = document.querySelectorAll('.question-container, .game-container, .mobile-container');
            scrollableElements.forEach(element => {
                if (element && element.scrollTop !== undefined) {
                    element.scrollTop = 0;
                }
            });
        } else {
            // Smooth scroll for less critical moments
            window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
            
            // Fallback for browsers that don't support smooth scrolling
            setTimeout(() => {
                window.scrollTo(0, 0);
                document.documentElement.scrollTop = 0;
                document.body.scrollTop = 0;
            }, 100);
        }
        
        // Additional mobile viewport fix
        if (window.visualViewport) {
            window.visualViewport.scrollTo({ top: 0, left: 0, behavior: immediate ? 'auto' : 'smooth' });
        }
    } catch (error) {
        console.warn('Scroll-to-top failed:', error);
        // Emergency fallback
        try {
            window.scrollTo(0, 0);
            document.documentElement.scrollTop = 0;
            document.body.scrollTop = 0;
        } catch (fallbackError) {
            console.warn('Emergency scroll fallback failed:', fallbackError);
        }
    }
}

// Performance optimization: Global variables for memory management
let performanceTimer = null;
let animationFrameId = null;
let eventListeners = new Map(); // Track event listeners for cleanup
let domCache = new Map(); // Cache DOM elements

// Performance monitoring
const performance = {
    start: (name) => {
        if (window.performance && window.performance.mark) {
            window.performance.mark(`${name}-start`);
        }
    },
    end: (name) => {
        if (window.performance && window.performance.mark && window.performance.measure) {
            window.performance.mark(`${name}-end`);
            window.performance.measure(name, `${name}-start`, `${name}-end`);
        }
    },
    cleanup: () => {
        // Clear all timers
        if (performanceTimer) {
            clearInterval(performanceTimer);
            performanceTimer = null;
        }
        if (animationFrameId) {
            cancelAnimationFrame(animationFrameId);
            animationFrameId = null;
        }

        // Remove all tracked event listeners
        eventListeners.forEach((handler, element) => {
            element.removeEventListener('click', handler);
        });
        eventListeners.clear();

        // Clear DOM cache
        domCache.clear();
    }
};

// Cache DOM elements
function getCachedElement(id) {
    if (!domCache.has(id)) {
        const element = document.getElementById(id);
        if (element) domCache.set(id, element);
    }
    return domCache.get(id);
}

// Optimized event listener management
function addTrackedListener(element, event, handler) {
    if (element && !eventListeners.has(element)) {
        element.addEventListener(event, handler, { passive: true });
        eventListeners.set(element, handler);
    }
}

// Optimized DOM manipulation with DocumentFragment
function createOptionElement(option, index, totalQuestions) {
    const optionDiv = document.createElement('div');
    optionDiv.className = 'option';
    optionDiv.dataset.value = option.optionValue;

    // Remove emojis from game options for clean gameplay experience
    const textWithoutEmoji = String(option.optionText || '')
        .replace(/[\u{1F000}-\u{1FFFF}]|[\u{2600}-\u{27BF}]|[\u{2300}-\u{23FF}]|[\u{2B50}-\u{2B55}]|[\u{FE00}-\u{FE0F}]|[\u{1F900}-\u{1F9FF}]|[\u{1FA00}-\u{1FA6F}]|[\u{1FA70}-\u{1FAFF}]|[\u{231A}-\u{231B}]|[\u{23E9}-\u{23F3}]|[\u{23F8}-\u{23FA}]|[\u{25AA}-\u{25AB}]|[\u{25B6}]|[\u{25C0}]|[\u{25FB}-\u{25FE}]|[\u{2614}-\u{2615}]|[\u{2648}-\u{2653}]|[\u{267F}]|[\u{2693}]|[\u{26A1}]|[\u{26AA}-\u{26AB}]|[\u{26BD}-\u{26BE}]|[\u{26C4}-\u{26C5}]|[\u{26CE}]|[\u{26D4}]|[\u{26EA}]|[\u{26F2}-\u{26F3}]|[\u{26F5}]|[\u{26FA}]|[\u{26FD}]|[\u{2702}]|[\u{2705}]|[\u{2708}-\u{270D}]|[\u{270F}]|[\u{2712}]|[\u{2714}]|[\u{2716}]|[\u{271D}]|[\u{2721}]|[\u{2728}]|[\u{2733}-\u{2734}]|[\u{2744}]|[\u{2747}]|[\u{274C}]|[\u{274E}]|[\u{2753}-\u{2755}]|[\u{2757}]|[\u{2763}-\u{2764}]|[\u{2795}-\u{2797}]|[\u{27A1}]|[\u{27B0}]|[\u{27BF}]|[\u{2934}-\u{2935}]|[\u{2B05}-\u{2B07}]|[\u{2B1B}-\u{2B1C}]|[\u{3030}]|[\u{303D}]|[\u{3297}]|[\u{3299}]|[\u{00A9}]|[\u{00AE}]|[\u{200D}]|[\u{20E3}]|[\u{E0020}-\u{E007F}]/gu, '')
        .replace(/\s{2,}/g, ' ')
        .trim();
    const safeText = escapeHtml(textWithoutEmoji);

    optionDiv.innerHTML = (
        '<span class="option-copy">' +
        '<span class="option-label">' + safeText + '</span>' +
        '</span>'
    );

    return optionDiv;
}

// Motion polish: safe parallax for stars + reactive cards.
(function () {
    const root = document.documentElement;
    const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    if (prefersReduced) return; // Respect reduced motion

    let ticking = false;
    const starLayer = document.querySelector('.star-decorations');

    // Cache cards once. Use IntersectionObserver to apply micro-translation only when in view (mobile mostly)
    const cards = Array.from(document.querySelectorAll('.test-card'));

    // Parallax factors (very small). Stars move slower than content.
    const STAR_FACTOR = 0.06; // 6% of scroll offset

    // Micro scroll translation for cards disabled to prevent movement
    // const CARD_FACTOR = window.innerWidth <= 768 ? 0.02 : 0; // up to ~1-2px depending on scroll

    function onScrollHandler() {
        if (ticking) return;
        window.requestAnimationFrame(applyMotion);
        ticking = true;
    }

    function applyMotion() {
        const y = window.scrollY || window.pageYOffset || 0;

        // Background star parallax (translateY only, GPU-friendly)
        if (starLayer) {
            const starY = Math.round(y * STAR_FACTOR);
            starLayer.style.transform = 'translate3d(0,' + starY + 'px,0)';
        }

        // Card movement disabled to prevent unwanted tilting
        // if (CARD_FACTOR > 0 && cards.length) {
        //     const cardShift = Math.max(-2, Math.min(2, Math.round(y * CARD_FACTOR))); // clamp to [-2, 2] px
        //     for (let i = 0; i < cards.length; i++) {
        //         const c = cards[i];
        //         // Keep existing hover transforms intact by composing translateZ(0) + translateY
        //         c.style.transform = 'translate3d(0,' + cardShift + 'px,0)';
        //     }
        // }

        ticking = false;
    }

    // Lightweight scroll listener (passive)
    window.addEventListener('scroll', onScrollHandler, { passive: true });
    // Initial run
    applyMotion();

    // Cleanup on page hide (optional safety)
    document.addEventListener('visibilitychange', function () {
        if (document.hidden && starLayer) {
            starLayer.style.transform = 'translate3d(0,0,0)';
        }
    }, { passive: true });
})();

let actionCardIcons = ['⚡', '🛡️', '🎯', '✨', '💡', '🚀', '🧠', '🏆'];

function escapeHtml(str) {
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/\"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

// Featured game key (can be changed later easily)
const featuredGame = 'SPIRIT_ANIMAL';

// Fallback tests to show if API is unavailable or returns no data
const defaultTests = [
    {
        testId: 'SPIRIT_ANIMAL',
        testName: 'Spirit Animal Game',
        testType: 'DIAGNOSTIC',
        description: 'Quick mindset snapshot to find your spirit animal profile.',
        questionCount: 12,
        estimatedMinutes: 3
    }
];

// Save page state to localStorage
function savePageState() {
    const state = {
        selectedTest: selectedTest,
        sessionId: sessionId,
        currentQuestionIndex: currentQuestionIndex,
        answers: answers,
        questions: questions,
        timestamp: Date.now()
    };
    localStorage.setItem('personality_start_state', JSON.stringify(state));
}

// Restore page state from localStorage
function restorePageState() {
    try {
        const savedState = localStorage.getItem('personality_start_state');
        if (!savedState) return;

        const state = JSON.parse(savedState);

        // Only restore if less than 1 hour old
        if (Date.now() - state.timestamp > 3600000) {
            localStorage.removeItem('personality_start_state');
            return;
        }

        // Restore state variables
        if (state.selectedTest) selectedTest = state.selectedTest;
        if (state.sessionId) sessionId = state.sessionId;
        if (state.currentQuestionIndex) currentQuestionIndex = state.currentQuestionIndex;
        if (state.answers) answers = state.answers;
        if (state.questions) questions = state.questions;

        // If we were in a test, restore the test view
        if (sessionId && questions.length > 0) {
            setTimeout(() => {
                // Hide test selection
                document.getElementById('testSelection').classList.add('hidden');
                document.getElementById('questionContainer').classList.remove('hidden');
                document.body.classList.add('game-active');

                // Enhanced scroll to top after DOM changes
                scrollToTop(true);

                // Show game title
                const testEmojis = {
                    'SPIRIT_ANIMAL': '🦉',
                    'COGNITIVE_RADAR': '🧠',
                    'FOCUS_STAMINA': '⚡',
                    'GUESSWORK_QUOTIENT': '🎲',
                    'CURIOSITY_COMPASS': '🧭',
                    'MODALITY_MAP': '🎨',
                    'CHALLENGE_DRIVER': '🏆',
                    'WORK_MODE': '🤝',
                    'PATTERN_SNAPSHOT': '🧩'
                };
                const emoji = testEmojis[selectedTest.testId] || '📝';
                document.getElementById('gameTitle').classList.remove('hidden');
                document.getElementById('gameTitleEmoji').textContent = emoji;
                document.getElementById('gameTitleText').textContent = selectedTest.testName;

                // Show current question
                showQuestion(currentQuestionIndex);
            }, 100);
        }
    } catch (error) {
        console.error('Error restoring page state:', error);
        localStorage.removeItem('personality_start_state');
    }
}

// Clear page state from localStorage
function clearPageState() {
    localStorage.removeItem('personality_start_state');
}

// Add page cleanup for better memory management
window.addEventListener('beforeunload', () => {
    performance.cleanup();
});

// Add visibility change handling for performance
document.addEventListener('visibilitychange', () => {
    if (document.hidden) {
        // Pause animations when page is not visible
        if (animationFrameId) {
            cancelAnimationFrame(animationFrameId);
            animationFrameId = null;
        }
    } else {
        // Resume animations when page becomes visible
        if (!animationFrameId && getCachedElement('livePlayerCount')) {
            initLivePlayers();
        }
    }
});
document.addEventListener('DOMContentLoaded', function () {
    // Clear any existing loading overlay (fix for browser back navigation)
    hideLoadingOverlay();

    // Try to restore state from localStorage
    restorePageState();
    loadTests();
    // Initialize progress bar with game language
    updateProgress(0, 'Choose Your Game');

    // Initialize fake live player count animation
    initLivePlayers();
});

// Load all diagnostic tests
async function loadTests() {
    try {
        const response = await fetch('/api/result/tests', { headers: { 'Accept': 'application/json' } });
        if (!response.ok) throw new Error('Failed to load tests');

        const data = await response.json();
        allTests = Array.isArray(data) && data.length > 0 ? data : defaultTests;
    } catch (error) {
        console.error('Error loading tests:', error);
        // Use fallback to ensure UI is not empty
        allTests = defaultTests;
    }

    // Ensure featured game exists in list; if not add fallback
    const hasFeatured = allTests.some(t => t.testId === featuredGame);
    if (!hasFeatured) {
        const fallback = defaultTests.find(t => t.testId === featuredGame);
        if (fallback) allTests.unshift(fallback);
    }

    // Non-destructive order for non-featured; remove featured for grid
    const featured = allTests.find(t => t.testId === featuredGame);
    const rest = allTests.filter(t => t.testId !== featuredGame);

    renderFeatured(featured);
    renderTests(rest);
}

// Test emoji mapping - using specific icons for each game
const testEmojis = {
    'SPIRIT_ANIMAL': '🦉',  // Owl - one of the spirit animals
    'COGNITIVE_RADAR': '🧠',
    'FOCUS_STAMINA': '⚡',
    'GUESSWORK_QUOTIENT': '🎲',
    'CURIOSITY_COMPASS': '🧭',
    'MODALITY_MAP': '🎨',
    'CHALLENGE_DRIVER': '🏆',
    'WORK_MODE': '🤝',
    'PATTERN_SNAPSHOT': '🧩'
};

function renderFeatured(test) {
    const container = document.getElementById('featuredContainer');
    if (!test || !container) { container.style.display = 'none'; return; }
    const emoji = testEmojis[test.testId] || '';
    container.style.display = 'block';
    container.innerHTML = (
        '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
        '<div class="featured-badges">' +
        '<span class="badge-subtle">🔥 Most Played</span>' +
        '<span class="live-indicator"><span class="live-dot"></span> Live now</span>' +
        '</div>' +
        '<div class="card-header">' +
        '<div class="test-icon">' + emoji + '</div>' +
        '</div>' +
        '<div class="card-body">' +
        '<h3>' + test.testName + '</h3>' +
        '<p style="color: #7B7896; flex-grow: 1; display: flex; align-items: center; text-align:center;">' + (test.description || '') + '</p>' +
        '<p class="player-count" id="livePlayerCount">👥 1,237 players playing right now</p>' +
        '</div>' +
        '</div>'
    );
}

function renderTests(tests) {
    const testGrid = document.getElementById('testGrid');
    const list = Array.isArray(tests) ? tests : allTests;
    testGrid.innerHTML = list.map(test => {
        const emoji = testEmojis[test.testId] || '📝';
        return '<div class="test-card" data-test-id="' + test.testId + '" onclick="selectTest(\'' + test.testId + '\')">' +
            '<div class="card-header">' +
            '<div class="test-icon">' + emoji + '</div>' +
            '</div>' +
            '<div class="card-body">' +
            '<h3>' + test.testName + '</h3>' +
            '<p style="color: #7B7896; flex-grow: 1; display: flex; align-items: center;">' + (test.description || '') + '</p>' +
            '<p style="font-size: 0.85rem; color: #A0A0B0; margin-top: 10px;">' +
            test.questionCount + ' questions • ' + test.estimatedMinutes + ' min' +
            '</p>' +
            '</div>' +
            '</div>';
    }).join('');
}
// Select a test and immediately start it
function selectTest(testId) {
    const testCards = document.querySelectorAll('.test-card');
    testCards.forEach(card => card.classList.remove('selected'));

    const selectedCard = document.querySelector('[data-test-id="' + testId + '"]');
    if (selectedCard) {
        selectedCard.classList.add('selected');
    }

    selectedTest = allTests.find(t => t.testId === testId);

    // Save state when test is selected
    savePageState();

    // Immediately start the game without waiting for a second click
    startTest();
}
// Start the test
async function startTest() {
    // Enhanced scroll to top immediately when starting any game
    scrollToTop(true);

    try {
        // Ensure a test is selected; fallback to first available
        if (!selectedTest && allTests && allTests.length > 0) {
            selectedTest = allTests[0];
        }

        // Special handling for PERSONALITY game - uses different API
        if (selectedTest.testId === 'PERSONALITY') {
            // Load personality questions from dedicated endpoint
            const questionsResponse = await fetch('/api/personality/questions');
            if (!questionsResponse.ok) throw new Error('Failed to load personality questions');

            const rawQuestions = await questionsResponse.json();

            // Map personality API response to frontend format
            questions = rawQuestions.map(q => ({
                questionId: q.id,
                questionText: q.text,
                questionNumber: q.number,
                options: (q.options || []).map(o => ({
                    optionText: o.text,
                    optionValue: o.value
                }))
            }));

            // Create a mock session for personality (it handles sessions differently)
            sessionId = 'personality-session-' + Date.now();
        } else {
            // Normal flow for other games
            const response = await fetch('/api/result/start', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ testId: selectedTest.testId })
            });

            if (!response.ok) throw new Error('Failed to start test');

            const result = await response.json();
            sessionId = result.sessionId;

            // Load questions
            const questionsResponse = await fetch('/api/result/questions/' + selectedTest.testId);
            if (!questionsResponse.ok) throw new Error('Failed to load questions');

            questions = await questionsResponse.json();
        }

        answers = new Array(questions.length).fill(null);

        // Show game container and lock mobile viewport
        document.getElementById('testSelection').classList.add('hidden');
        document.getElementById('questionContainer').classList.remove('hidden');
        document.body.classList.add('game-active'); // Prevent mobile scrolling

        // Force enhanced scroll to top after DOM changes
        setTimeout(() => {
            scrollToTop(true);
        }, 10);
        updateProgress(0, 'Question 1 of ' + questions.length);

        // Show big game title at top
        const emoji = testEmojis[selectedTest.testId] || '📝';
        document.getElementById('gameTitle').classList.remove('hidden');
        document.getElementById('gameTitleEmoji').textContent = emoji;
        document.getElementById('gameTitleText').textContent = selectedTest.testName;

        // Save state
        savePageState();

        // Show first question
        showQuestion(0);
    } catch (error) {
        console.error('Error starting test:', error);
        alert('Failed to start test. Please try again.');
    }
}

// Show Game Moment (NOT a question)
function showQuestion(index) {
    // Clear any existing timer when changing questions
    if (autoAdvanceTimer) {
        clearTimeout(autoAdvanceTimer);
        autoAdvanceTimer = null;
    }

    // Enhanced scroll to top for each new question to ensure mobile-first experience
    scrollToTop(true);

    currentQuestionIndex = index;
    const question = questions[index];

    // Update progress bar
    const progress = ((index + 1) / questions.length) * 100;
    updateProgress(progress, 'Question ' + (index + 1) + ' of ' + questions.length);

    // Reset navigation buttons immediately
    updateNavigationButtons();

    // Update question number display
    const questionNumber = document.getElementById('questionNumber');
    if (questionNumber) {
        questionNumber.textContent = 'Q' + (index + 1);
    }

    // Update game moment text (make it feel like a situation, not a question)
    const questionText = document.getElementById('questionText');
    // Remove emojis from question text for clean gameplay experience
    const cleanQuestionText = String(question.questionText || '')
        .replace(/[\u{1F000}-\u{1FFFF}]|[\u{2600}-\u{27BF}]|[\u{2300}-\u{23FF}]|[\u{2B50}-\u{2B55}]|[\u{FE00}-\u{FE0F}]|[\u{1F900}-\u{1F9FF}]|[\u{1FA00}-\u{1FA6F}]|[\u{1FA70}-\u{1FAFF}]|[\u{231A}-\u{231B}]|[\u{23E9}-\u{23F3}]|[\u{23F8}-\u{23FA}]|[\u{25AA}-\u{25AB}]|[\u{25B6}]|[\u{25C0}]|[\u{25FB}-\u{25FE}]|[\u{2614}-\u{2615}]|[\u{2648}-\u{2653}]|[\u{267F}]|[\u{2693}]|[\u{26A1}]|[\u{26AA}-\u{26AB}]|[\u{26BD}-\u{26BE}]|[\u{26C4}-\u{26C5}]|[\u{26CE}]|[\u{26D4}]|[\u{26EA}]|[\u{26F2}-\u{26F3}]|[\u{26F5}]|[\u{26FA}]|[\u{26FD}]|[\u{2702}]|[\u{2705}]|[\u{2708}-\u{270D}]|[\u{270F}]|[\u{2712}]|[\u{2714}]|[\u{2716}]|[\u{271D}]|[\u{2721}]|[\u{2728}]|[\u{2733}-\u{2734}]|[\u{2744}]|[\u{2747}]|[\u{274C}]|[\u{274E}]|[\u{2753}-\u{2755}]|[\u{2757}]|[\u{2763}-\u{2764}]|[\u{2795}-\u{2797}]|[\u{27A1}]|[\u{27B0}]|[\u{27BF}]|[\u{2934}-\u{2935}]|[\u{2B05}-\u{2B07}]|[\u{2B1B}-\u{2B1C}]|[\u{3030}]|[\u{303D}]|[\u{3297}]|[\u{3299}]|[\u{00A9}]|[\u{00AE}]|[\u{200D}]|[\u{20E3}]|[\u{E0020}-\u{E007F}]/gu, '')
        .replace(/\s{2,}/g, ' ')
        .trim();
    questionText.textContent = cleanQuestionText;
    questionText.style.opacity = '0';

    // Hide options initially
    const optionsContainer = document.getElementById('optionsContainer');
    optionsContainer.classList.remove('show');
    optionsContainer.innerHTML = '';

    // Disable countdown: hide instantly
    const countdownContainer = document.getElementById('countdownContainer');
    countdownContainer.style.display = 'none';

    // Show question text immediately
    questionText.style.transition = 'opacity 0.3s ease';
    questionText.style.opacity = '1';

    // Render action buttons immediately

    // Render action buttons
    if (question.options && question.options.length > 0) {
        const fragment = document.createDocumentFragment();

        question.options.forEach((option, optionIndex) => {
            const optionDiv = createOptionElement(option, optionIndex, questions.length);

            // Check if this option was previously selected
            if (answers[index] === option.optionValue) {
                optionDiv.classList.add('selected');
            }

            // Use optimized event listener
            const clickHandler = () => selectOption(option.optionValue);
            addTrackedListener(optionDiv, 'click', clickHandler);

            fragment.appendChild(optionDiv);
        });

        // Single DOM operation
        optionsContainer.appendChild(fragment);
    } else {

        // Create appropriate options based on the game type
        let gameOptions = [];

        // Generic options for all games
        gameOptions = [
            { optionValue: 'OPTION_1', optionText: 'Option 1' },
            { optionValue: 'OPTION_2', optionText: 'Option 2' },
            { optionValue: 'OPTION_3', optionText: 'Option 3' },
            { optionValue: 'OPTION_4', optionText: 'Option 4' }
        ];

        console.log('DEBUG: Using game-specific options:', gameOptions);

        gameOptions.forEach((option, optionIndex) => {
            const optionDiv = document.createElement('div');
            optionDiv.className = 'option';
            optionDiv.dataset.value = option.optionValue;

            optionDiv.innerHTML = (
                '<span class="option-copy">' +
                '<span class="option-label">' + option.optionText + '</span>' +
                '</span>'
            );

            optionDiv.addEventListener('click', function () {
                selectOption(option.optionValue);
            });

            optionsContainer.appendChild(optionDiv);
        });
    }

    // Show options with animation
    optionsContainer.classList.add('show');

    // Adjust layout density based on rendered option count (UI-only)
    applyOptionLayoutDensity();

    // Update navigation buttons
    updateNavigationButtons();
}

function applyOptionLayoutDensity() {
    const playArea = document.querySelector('#questionContainer .game-play-area');
    const optionsContainer = document.getElementById('optionsContainer');
    if (!playArea || !optionsContainer) return;

    const optionCount = optionsContainer.children ? optionsContainer.children.length : 0;
    playArea.classList.remove('few-options', 'many-options');

    if (optionCount >= 3) {
        playArea.classList.add('many-options');
    } else {
        playArea.classList.add('few-options');
    }
}

// Select option - Instant Reaction
function selectOption(value) {
    // Clear any existing timer
    if (autoAdvanceTimer) {
        clearTimeout(autoAdvanceTimer);
        autoAdvanceTimer = null;
    }

    // Save answer
    answers[currentQuestionIndex] = value;

    // Save state to localStorage
    savePageState();

    // Update UI - remove selected class from all first
    const options = document.querySelectorAll('.option');
    options.forEach(opt => {
        opt.classList.remove('selected');
        // Remove and re-add to restart animation
        void opt.offsetWidth; // Trigger reflow
    });

    // Add selected class to chosen option
    options.forEach(opt => {
        if (opt.dataset.value === value) {
            opt.classList.add('selected');
            opt.classList.add('just-selected');
            setTimeout(() => {
                opt.classList.remove('just-selected');
            }, 450);
        }
    });

    const feedback = document.getElementById('actionFeedback');
    if (feedback) {
        const messages = ['Locked in!', 'Nice move!', 'Great choice!', 'Action confirmed!'];
        feedback.textContent = messages[Math.floor(Math.random() * messages.length)];
        feedback.classList.add('show');
        setTimeout(() => {
            feedback.classList.remove('show');
        }, 650);
    }

    // Update navigation buttons after selection
    updateNavigationButtons();

    // Show green feedback briefly before advancing
    setTimeout(() => {
        if (currentQuestionIndex < questions.length - 1) {
            showQuestion(currentQuestionIndex + 1);
        } else {
            submitTest();
        }
    }, 400); // 400ms delay to show green selection
}

// Update Game Progress Dots (NOT question numbers)
function updateGameProgressDots() {
    const progressMeter = document.getElementById('gameProgressMeter');
    if (!progressMeter) return;

    progressMeter.innerHTML = '';

    questions.forEach((q, index) => {
        const dot = document.createElement('div');
        dot.className = 'progress-dot';

        if (index < currentQuestionIndex) {
            dot.classList.add('completed');
        } else if (index === currentQuestionIndex) {
            dot.classList.add('current');
        }

        // Make dots clickable to navigate
        dot.addEventListener('click', () => {
            if (answers[index] !== null) {
                showQuestion(index);
                updateNavigationButtons();
            }
        });

        progressMeter.appendChild(dot);
    });

    // Update navigation buttons
    updateNavigationButtons();
}

// Update navigation button visibility
function updateNavigationButtons() {
    // Previous button removed - no navigation needed
}

// Navigate to next question


// Update progress
function updateProgress(percentage, text) {
    document.getElementById('progressBar').style.width = percentage + '%';
    document.getElementById('progressText').textContent = text;

    const hudFill = document.getElementById('hudXpFill');
    if (hudFill) hudFill.style.width = percentage + '%';

    const hudLevel = document.getElementById('hudLevelText');
    if (hudLevel) hudLevel.textContent = text;

    const hudSub = document.getElementById('hudXpSub');
    if (hudSub) hudSub.textContent = 'XP ' + Math.round(percentage) + '/100';
}

// Submit test - OPTIMIZED for speed
async function submitTest() {
    let timeoutId; // Declare timeoutId in function scope

    // Validate all questions answered
    const unanswered = answers.filter(a => a === null).length;
    if (unanswered > 0) {
        alert('Please answer all questions. ' + unanswered + ' question(s) remaining.');
        return;
    }

    // Show immediate loading state
    updateProgress(100, 'Analyzing your answers...');
    showLoadingOverlay();

    try {
        // Special handling for PERSONALITY game
        if (selectedTest.testId === 'PERSONALITY') {
            // Prepare answers in personality format
            const formattedAnswers = questions.map((q, index) => ({
                id: q.questionId,
                value: parseInt(answers[index]) // Convert to integer
            }));

            // Add timeout to prevent hanging
            const controller = new AbortController();
            timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout

            const response = await fetch('/api/personality/submit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    answers: formattedAnswers
                    // Gender field omitted - it's optional
                }),
                signal: controller.signal
            });

            clearTimeout(timeoutId);

            if (!response.ok) throw new Error('Failed to submit personality test');

            const result = await response.json();

            if (result.success) {
                // Clear saved state before redirecting
                clearPageState();

                // Redirect to unified result page (same as other games)
                window.location.replace('/result/' + result.sessionId);
            } else {
                throw new Error(result.error || 'Failed to submit test');
            }
        } else {
            // Normal flow for other games
            // Prepare answers in the format expected by the API
            const formattedAnswers = questions.map((q, index) => ({
                questionId: q.questionId,
                answerValue: answers[index],
                timeSpent: 0
            }));

            // Add timeout to prevent hanging
            const controller = new AbortController();
            timeoutId = setTimeout(() => controller.abort(), 10000); // 10 second timeout

            const response = await fetch('/api/result/submit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    sessionId: sessionId,
                    answers: formattedAnswers
                }),
                signal: controller.signal
            });

            clearTimeout(timeoutId);

            if (!response.ok) throw new Error('Failed to submit test');

            const result = await response.json();

            if (result.success) {
                // Clear saved state before redirecting
                clearPageState();

                // IMMEDIATE redirect - results are processing in background
                window.location.replace('/result/' + sessionId);
            } else {
                throw new Error(result.error || 'Failed to submit test');
            }
        }
    } catch (error) {
        if (timeoutId) clearTimeout(timeoutId); // Check if timeoutId exists
        console.error('Error submitting test:', error);

        // Hide loading and show error
        hideLoadingOverlay();

        if (error.name === 'AbortError') {
            alert('Request timed out. Please check your connection and try again.');
        } else {
            alert('Failed to submit test. Please try again.');
        }


        // Restore UI
        document.getElementById('questionContainer').classList.remove('hidden');
        updateProgress(66, 'Question ' + (currentQuestionIndex + 1) + ' of ' + questions.length);
    }
}

// Fast loading overlay
function showLoadingOverlay() {
    const overlay = document.createElement('div');
    overlay.id = 'loading-overlay';
    overlay.innerHTML = `
                <div style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
                           background: rgba(139, 127, 232, 0.95); z-index: 9999; 
                           display: flex; align-items: center; justify-content: center;
                           backdrop-filter: blur(10px);">
                    <div style="text-align: center; color: white;">
                        <div style="font-size: 3rem; margin-bottom: 20px; animation: spin 1s linear infinite;">⚡</div>
                        <h2 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 10px;">Analyzing Your DNA</h2>
                        <p style="font-size: 1rem; opacity: 0.9;">Calculating your learning profile...</p>
                    </div>
                </div>
                <style>
                    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
                </style>
            `;
    document.body.appendChild(overlay);
}

function hideLoadingOverlay() {
    const overlay = document.getElementById('loading-overlay');
    if (overlay) overlay.remove();
}
// Optimized live players with requestAnimationFrame and debouncing
function initLivePlayers() {
    const elId = 'livePlayerCount';
    let base = 1237;
    const min = 1000;
    const maxDelta = 20;
    const minDelta = 5;
    let lastUpdate = 0;
    const updateInterval = 2500 + Math.floor(Math.random() * 1500);

    function tick(timestamp) {
        if (!lastUpdate || timestamp - lastUpdate >= updateInterval) {
            const el = getCachedElement(elId);
            if (el) {
                const sign = Math.random() < 0.55 ? 1 : -1;
                const delta = Math.floor(Math.random() * (maxDelta - minDelta + 1)) + minDelta;
                base = Math.max(min, base + sign * delta);
                el.textContent = '👥 ' + base.toLocaleString() + ' players playing right now';
            }
            lastUpdate = timestamp;
        }
        animationFrameId = requestAnimationFrame(tick);
    }

    // Start animation loop
    animationFrameId = requestAnimationFrame(tick);

    // Initial update
    setTimeout(() => {
        const el = getCachedElement(elId);
        if (el) el.textContent = '👥 ' + base.toLocaleString() + ' players playing right now';
    }, 600);
}

// Card hover effects removed to prevent unwanted movement

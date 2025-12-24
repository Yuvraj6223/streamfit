/**
 * Dynamic Navigation Bar Controller
 * Shows nav bar when NO CTA buttons are visible in viewport
 * Hides nav bar when ANY non-hero CTA button is visible in viewport
 * Nav is always visible in hero section
 */

(function() {
    'use strict';

    // Configuration
    const CONFIG = {
        navSelector: '.main-nav',
        // Track all CTAs except nav CTA and hero CTA
        ctaSelectors: [
            '.sneak-peek-cta .btn-primary-unified',
            '.btn-final-play',
            '.mobile-sticky-cta .btn-primary-unified'
        ],
        // Threshold: how much of the CTA needs to be visible
        intersectionThreshold: 0.3,
        // Hero section - nav always visible here
        heroSelector: '.hero-section.game-portal'
    };

    let nav = null;
    let ctaButtons = [];
    let heroSection = null;
    let observer = null;
    let heroObserver = null;
    let isAnyCTAVisible = false;
    let isInHeroSection = true;

    /**
     * Initialize the dynamic navigation controller
     */
    function init() {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', setup);
        } else {
            setup();
        }
    }

    /**
     * Setup the navigation controller
     */
    function setup() {
        nav = document.querySelector(CONFIG.navSelector);
        heroSection = document.querySelector(CONFIG.heroSelector);
        
        if (!nav) {
            console.warn('Dynamic Nav: Navigation element not found');
            return;
        }

        // Find all CTA buttons (excluding hero and nav CTAs)
        findCTAButtons();

        // Setup observers
        setupHeroObserver();
        setupCTAObserver();

        // Initial state - show nav
        showNav();
    }

    /**
     * Find all CTA buttons to track
     */
    function findCTAButtons() {
        ctaButtons = [];
        
        CONFIG.ctaSelectors.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            elements.forEach(el => {
                // Exclude nav CTA
                if (!el.closest('.main-nav')) {
                    ctaButtons.push(el);
                }
            });
        });

        console.log(`Dynamic Nav: Tracking ${ctaButtons.length} CTA buttons`);
    }

    /**
     * Setup observer for hero section
     */
    function setupHeroObserver() {
        if (!heroSection) return;

        const options = {
            root: null,
            rootMargin: '0px',
            threshold: 0.1
        };

        heroObserver = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                isInHeroSection = entry.isIntersecting;
                updateNavVisibility();
            });
        }, options);

        heroObserver.observe(heroSection);
    }

    /**
     * Setup observer for CTA buttons
     */
    function setupCTAObserver() {
        if (ctaButtons.length === 0) return;

        const options = {
            root: null,
            rootMargin: '0px',
            threshold: CONFIG.intersectionThreshold
        };

        observer = new IntersectionObserver(handleCTAIntersection, options);

        ctaButtons.forEach(cta => {
            observer.observe(cta);
        });
    }

    /**
     * Handle CTA intersection changes
     */
    function handleCTAIntersection(entries) {
        let anyVisible = false;

        // Check if any non-hero CTA is visible
        ctaButtons.forEach(cta => {
            if (isElementInViewport(cta)) {
                anyVisible = true;
            }
        });

        if (anyVisible !== isAnyCTAVisible) {
            isAnyCTAVisible = anyVisible;
            updateNavVisibility();
        }
    }

    /**
     * Check if element is in viewport
     */
    function isElementInViewport(el) {
        const rect = el.getBoundingClientRect();
        const threshold = CONFIG.intersectionThreshold;
        const elementHeight = rect.bottom - rect.top;
        const visibleHeight = Math.min(rect.bottom, window.innerHeight) - Math.max(rect.top, 0);
        
        return visibleHeight / elementHeight >= threshold;
    }

    /**
     * Update nav visibility based on current state
     * Logic: Show nav when in hero OR when no other CTAs are visible
     *        Hide nav when scrolled past hero AND another CTA is visible
     */
    function updateNavVisibility() {
        if (isInHeroSection || !isAnyCTAVisible) {
            showNav();
        } else {
            hideNav();
        }
    }

    /**
     * Hide navigation with smooth fade out
     */
    function hideNav() {
        if (!nav) return;

        nav.style.opacity = '0';
        nav.style.pointerEvents = 'none';
        nav.setAttribute('aria-hidden', 'true');
    }

    /**
     * Show navigation with smooth fade in
     */
    function showNav() {
        if (!nav) return;

        nav.style.opacity = '1';
        nav.style.pointerEvents = 'auto';
        nav.setAttribute('aria-hidden', 'false');
    }

    // Initialize when script loads
    init();

})();


/**
 * Mobile UX Enhancements for LearnerDNA
 * Target: Students aged 14-20 on smartphones
 * Focus: Touch interactions, visual feedback, performance
 */

(function() {
    'use strict';
    
    // Detect mobile device
    const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    const isTouch = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    
    if (!isMobile && !isTouch) return; // Skip on desktop
    
    // Add mobile class to body
    document.addEventListener('DOMContentLoaded', function() {
        document.body.classList.add('mobile-device');
        
        // Initialize all mobile enhancements
        initTouchFeedback();
        initHapticFeedback();
        initAutoAdvance();
        initProgressPersistence();
        initNetworkAwareLoading();
        initScreenshotOptimization();
        preventZoomOnInput();
        optimizeScrolling();
    });
    
    /**
     * Add visual touch feedback to interactive elements
     */
    function initTouchFeedback() {
        const interactiveElements = document.querySelectorAll('.btn, .option, .option-card, .gender-btn');
        
        interactiveElements.forEach(element => {
            element.addEventListener('touchstart', function() {
                this.style.transform = 'scale(0.97)';
            }, { passive: true });
            
            element.addEventListener('touchend', function() {
                this.style.transform = '';
            }, { passive: true });
            
            element.addEventListener('touchcancel', function() {
                this.style.transform = '';
            }, { passive: true });
        });
    }
    
    /**
     * Add haptic feedback for selections (if supported)
     */
    function initHapticFeedback() {
        if (!navigator.vibrate) return;
        
        // Light haptic on option selection
        document.addEventListener('click', function(e) {
            const target = e.target.closest('.option, .option-card, .gender-btn');
            if (target) {
                navigator.vibrate(10); // 10ms light tap
            }
        });
        
        // Medium haptic on button press
        document.addEventListener('click', function(e) {
            const target = e.target.closest('.btn-primary');
            if (target) {
                navigator.vibrate(20); // 20ms medium tap
            }
        });
    }
    
    /**
     * Enhanced auto-advance with visual countdown
     * DISABLED - No countdown indicator shown
     */
    function initAutoAdvance() {
        // Auto-advance functionality disabled
        // The test pages have their own auto-advance logic
        // No visual countdown indicator needed
    }
    
    /**
     * Save progress to localStorage to prevent data loss
     */
    function initProgressPersistence() {
        const testContainer = document.querySelector('.test-container, .personality-test-page');
        if (!testContainer) return;
        
        // Save answers periodically
        setInterval(function() {
            if (window.answers && window.sessionId) {
                localStorage.setItem('test_progress_' + window.sessionId, JSON.stringify({
                    answers: window.answers,
                    currentQuestion: window.currentQuestionIndex || 0,
                    timestamp: Date.now()
                }));
            }
        }, 5000); // Save every 5 seconds
        
        // Restore progress on page load
        if (window.sessionId) {
            const saved = localStorage.getItem('test_progress_' + window.sessionId);
            if (saved) {
                try {
                    const data = JSON.parse(saved);
                    // Only restore if less than 1 hour old
                    if (Date.now() - data.timestamp < 3600000) {
                        window.answers = data.answers;
                        if (typeof window.showQuestion === 'function') {
                            window.showQuestion(data.currentQuestion);
                        }
                    }
                } catch (e) {
                    console.error('Failed to restore progress:', e);
                }
            }
        }
        
        // Clear progress on successful submission
        window.addEventListener('beforeunload', function() {
            // Don't clear if test is in progress
        });
    }
    
    /**
     * Network-aware loading for Indian mobile networks
     */
    function initNetworkAwareLoading() {
        if (!navigator.connection) return;
        
        const connection = navigator.connection;
        const effectiveType = connection.effectiveType;
        
        // On slow connections (2G, slow-3G), reduce animations
        if (effectiveType === '2g' || effectiveType === 'slow-2g') {
            document.body.classList.add('slow-connection');
            
            // Add CSS to reduce animations
            const style = document.createElement('style');
            style.textContent = `
                .slow-connection * {
                    animation-duration: 0.1s !important;
                    transition-duration: 0.1s !important;
                }
                .slow-connection .blob {
                    display: none !important;
                }
            `;
            document.head.appendChild(style);
        }
        
        // Listen for connection changes
        connection.addEventListener('change', function() {
            console.log('Connection changed:', connection.effectiveType);
        });
    }
    
    /**
     * Optimize result cards for screenshots
     */
    function initScreenshotOptimization() {
        const resultCards = document.querySelectorAll('.result-card, .result-header');
        
        resultCards.forEach(card => {
            // Add data attribute for easy screenshot identification
            card.setAttribute('data-screenshot-ready', 'true');
            
            // Ensure all images are loaded before marking as ready
            const images = card.querySelectorAll('img');
            Promise.all(Array.from(images).map(img => {
                return new Promise(resolve => {
                    if (img.complete) {
                        resolve();
                    } else {
                        img.addEventListener('load', resolve);
                        img.addEventListener('error', resolve);
                    }
                });
            })).then(() => {
                card.classList.add('screenshot-ready');
            });
        });
    }
    
    /**
     * Prevent zoom on input focus (iOS)
     */
    function preventZoomOnInput() {
        const inputs = document.querySelectorAll('input, select, textarea');
        inputs.forEach(input => {
            // Ensure font-size is at least 16px to prevent iOS zoom
            const fontSize = window.getComputedStyle(input).fontSize;
            if (parseInt(fontSize) < 16) {
                input.style.fontSize = '16px';
            }
        });
    }
    
    /**
     * Optimize scrolling performance
     */
    function optimizeScrolling() {
        // Add smooth scrolling to all internal links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    e.preventDefault();
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
        
        // Optimize scroll performance with passive listeners
        let ticking = false;
        window.addEventListener('scroll', function() {
            if (!ticking) {
                window.requestAnimationFrame(function() {
                    // Handle scroll events here
                    ticking = false;
                });
                ticking = true;
            }
        }, { passive: true });
    }
    
    /**
     * Add pull-to-refresh indicator (visual only)
     */
    function initPullToRefresh() {
        let startY = 0;
        let currentY = 0;
        let pulling = false;
        
        document.addEventListener('touchstart', function(e) {
            if (window.scrollY === 0) {
                startY = e.touches[0].pageY;
                pulling = true;
            }
        }, { passive: true });
        
        document.addEventListener('touchmove', function(e) {
            if (!pulling) return;
            currentY = e.touches[0].pageY;
            const diff = currentY - startY;
            
            if (diff > 100) {
                // Show refresh indicator
                showRefreshIndicator();
            }
        }, { passive: true });
        
        document.addEventListener('touchend', function() {
            pulling = false;
            hideRefreshIndicator();
        }, { passive: true });
    }
    
    function showRefreshIndicator() {
        let indicator = document.getElementById('refresh-indicator');
        if (!indicator) {
            indicator = document.createElement('div');
            indicator.id = 'refresh-indicator';
            indicator.className = 'pull-to-refresh';
            indicator.textContent = '↓ Pull to refresh';
            document.body.insertBefore(indicator, document.body.firstChild);
        }
        indicator.style.display = 'block';
    }
    
    function hideRefreshIndicator() {
        const indicator = document.getElementById('refresh-indicator');
        if (indicator) {
            indicator.style.display = 'none';
        }
    }
    
})();


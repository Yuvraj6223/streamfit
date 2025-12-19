// StreamFit Application JavaScript
// Mobile-first, progressive enhancement

(function() {
    'use strict';
    
    // Initialize app when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeApp();
    });
    
    function initializeApp() {
        // Service Worker disabled for now - can be enabled later for PWA features
        // if ('serviceWorker' in navigator) {
        //     registerServiceWorker();
        // }

        // Initialize analytics
        initializeAnalytics();

        // Setup global event listeners
        setupGlobalListeners();

        // Check network status
        monitorNetworkStatus();
    }

    // Service Worker Registration (disabled)
    // function registerServiceWorker() {
    //     navigator.serviceWorker.register('/sw.js')
    //         .then(function(registration) {
    //             console.log('Service Worker registered:', registration);
    //         })
    //         .catch(function(error) {
    //             console.log('Service Worker registration failed:', error);
    //         });
    // }
    
    // Analytics Tracking
    function initializeAnalytics() {
        // Track page views
        trackPageView();
        
        // Track user interactions
        document.addEventListener('click', function(e) {
            if (e.target.matches('[data-track]')) {
                const eventType = e.target.dataset.track;
                const eventData = e.target.dataset.trackData ? JSON.parse(e.target.dataset.trackData) : {};
                trackEvent(eventType, eventData);
            }
        });
    }
    
    function trackPageView() {
        const page = window.location.pathname;
        trackEvent('PAGE_VIEW', { page: page });
    }
    
    function trackEvent(eventType, eventData = {}) {
        fetch('/analytics/track', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                eventType: eventType,
                eventData: eventData
            })
        }).catch(function(error) {
            console.error('Analytics tracking error:', error);
        });
    }
    
    // Global Event Listeners
    function setupGlobalListeners() {
        // Handle form submissions
        document.addEventListener('submit', function(e) {
            if (e.target.matches('[data-ajax-form]')) {
                e.preventDefault();
                handleAjaxForm(e.target);
            }
        });
        
        // Handle CTA clicks
        document.addEventListener('click', function(e) {
            if (e.target.matches('[data-cta]')) {
                const ctaType = e.target.dataset.cta;
                const ctaLocation = e.target.dataset.ctaLocation || window.location.pathname;
                trackCTAClick(ctaType, ctaLocation);
            }
        });
    }
    
    function trackCTAClick(ctaType, ctaLocation) {
        fetch('/analytics/track', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                eventType: 'CTA_CLICKED',
                eventData: {
                    ctaType: ctaType,
                    location: ctaLocation
                }
            })
        });
    }
    
    // AJAX Form Handler
    function handleAjaxForm(form) {
        const formData = new FormData(form);
        const data = Object.fromEntries(formData.entries());
        const url = form.action;
        const method = form.method || 'POST';
        
        const submitBtn = form.querySelector('[type="submit"]');
        if (submitBtn) {
            submitBtn.disabled = true;
            submitBtn.dataset.originalText = submitBtn.textContent;
            submitBtn.textContent = 'Processing...';
        }
        
        fetch(url, {
            method: method,
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                if (data.redirectUrl) {
                    window.location.href = data.redirectUrl;
                } else if (form.dataset.successMessage) {
                    showNotification(form.dataset.successMessage, 'success');
                }
            } else {
                showNotification(data.message || 'An error occurred', 'error');
            }
        })
        .catch(error => {
            console.error('Form submission error:', error);
            showNotification('An error occurred. Please try again.', 'error');
        })
        .finally(() => {
            if (submitBtn) {
                submitBtn.disabled = false;
                submitBtn.textContent = submitBtn.dataset.originalText;
            }
        });
    }
    
    // Notification System
    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 16px 24px;
            border-radius: 8px;
            background: ${type === 'success' ? '#22c55e' : type === 'error' ? '#ef4444' : '#3b82f6'};
            color: white;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 10000;
            animation: slideInRight 0.3s ease;
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'slideOutRight 0.3s ease';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
    
    // Network Status Monitor
    function monitorNetworkStatus() {
        window.addEventListener('online', function() {
            showNotification('You are back online', 'success');
        });
        
        window.addEventListener('offline', function() {
            showNotification('You are offline. Some features may not work.', 'warning');
        });
    }
    
    // Utility Functions
    window.StreamFit = {
        trackEvent: trackEvent,
        showNotification: showNotification,
        
        // Share functionality
        share: function(platform, data) {
            return fetch('/share/links', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                if (result.success && result.links[platform]) {
                    // Track share
                    fetch('/share/track', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            platform: platform,
                            testCode: data.testCode
                        })
                    });
                    
                    // Open share link
                    if (navigator.share && platform === 'native') {
                        return navigator.share({
                            title: 'My StreamFit Results',
                            text: result.shareText,
                            url: result.links.generic
                        });
                    } else {
                        window.open(result.links[platform], '_blank');
                    }
                }
            });
        },
        
        // Prebook functionality
        prebook: function(leadType, contactPreference) {
            return fetch('/analytics/prebook', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    leadType: leadType,
                    contactPreference: contactPreference
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showNotification(data.message, 'success');
                } else {
                    showNotification(data.message, 'error');
                }
                return data;
            });
        }
    };
    
    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);
    
})();


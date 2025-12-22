/**
 * Mobile Sharing Functionality for LearnerDNA
 * One-tap sharing to WhatsApp, Instagram, Telegram
 * Screenshot-friendly result cards
 */

(function() {
    'use strict';
    
    /**
     * Initialize sharing functionality
     */
    function initMobileSharing() {
        // Add share buttons to result pages
        const resultContainer = document.querySelector('.results-container, .personality-result-page');
        if (!resultContainer) return;
        
        // Create share section
        const shareSection = createShareSection();
        
        // Insert before action buttons
        const actionButtons = resultContainer.querySelector('.action-buttons, .actions-section');
        if (actionButtons) {
            actionButtons.parentNode.insertBefore(shareSection, actionButtons);
        } else {
            resultContainer.appendChild(shareSection);
        }
    }
    
    /**
     * Create share section with platform buttons
     */
    function createShareSection() {
        const section = document.createElement('div');
        section.className = 'share-section';
        section.style.cssText = `
            background: white;
            border-radius: 16px;
            padding: 24px;
            margin: 24px 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        `;
        
        section.innerHTML = `
            <h3 style="font-size: 1.3rem; font-weight: 700; margin-bottom: 8px; color: #1A1825;">
                📱 Share Your Results
            </h3>
            <p style="font-size: 0.95rem; color: #8E8C9A; margin-bottom: 20px;">
                Show your parents, friends, or post on social media
            </p>
            <div class="share-buttons">
                <button class="share-btn whatsapp" onclick="shareToWhatsApp()">
                    <span style="font-size: 1.5rem;">💬</span>
                    <span>Share on WhatsApp</span>
                </button>
                <button class="share-btn instagram" onclick="shareToInstagram()">
                    <span style="font-size: 1.5rem;">📸</span>
                    <span>Share to Instagram Story</span>
                </button>
                <button class="share-btn telegram" onclick="shareToTelegram()">
                    <span style="font-size: 1.5rem;">✈️</span>
                    <span>Share on Telegram</span>
                </button>
                <button class="share-btn native" onclick="shareNative()">
                    <span style="font-size: 1.5rem;">📤</span>
                    <span>More Options</span>
                </button>
            </div>
        `;
        
        return section;
    }
    
    /**
     * Share to WhatsApp
     */
    window.shareToWhatsApp = function() {
        const shareData = getShareData();
        const text = encodeURIComponent(shareData.text);
        const url = encodeURIComponent(shareData.url);
        
        // WhatsApp share URL
        const whatsappUrl = `https://wa.me/?text=${text}%20${url}`;
        
        // Track share
        trackShare('whatsapp');
        
        // Open WhatsApp
        window.open(whatsappUrl, '_blank');
    };
    
    /**
     * Share to Instagram (via screenshot)
     */
    window.shareToInstagram = function() {
        // Instagram doesn't support direct web sharing
        // Show instructions for screenshot
        showScreenshotInstructions('instagram');
        trackShare('instagram');
    };
    
    /**
     * Share to Telegram
     */
    window.shareToTelegram = function() {
        const shareData = getShareData();
        const text = encodeURIComponent(shareData.text);
        const url = encodeURIComponent(shareData.url);
        
        // Telegram share URL
        const telegramUrl = `https://t.me/share/url?url=${url}&text=${text}`;
        
        // Track share
        trackShare('telegram');
        
        // Open Telegram
        window.open(telegramUrl, '_blank');
    };
    
    /**
     * Native share (Web Share API)
     */
    window.shareNative = function() {
        const shareData = getShareData();
        
        if (navigator.share) {
            navigator.share({
                title: shareData.title,
                text: shareData.text,
                url: shareData.url
            })
            .then(() => {
                trackShare('native');
                console.log('Shared successfully');
            })
            .catch((error) => {
                console.log('Error sharing:', error);
                // Fallback to copy link
                copyToClipboard(shareData.url);
            });
        } else {
            // Fallback: copy link to clipboard
            copyToClipboard(shareData.url);
        }
    };
    
    /**
     * Get share data from current page
     */
    function getShareData() {
        // Try to get result title
        const resultTitle = document.querySelector('.personality-name, .result-title, h1');
        const resultText = resultTitle ? resultTitle.textContent.trim() : 'My LearnerDNA Results';
        
        // Get personality type or test name
        const typeBadge = document.querySelector('.personality-type-badge');
        const typeText = typeBadge ? typeBadge.textContent.trim() : '';
        
        // Construct share text
        let shareText = `🎯 I just discovered my Learning DNA!\n\n`;
        if (typeText) {
            shareText += `I'm a ${resultText} (${typeText})\n\n`;
        } else {
            shareText += `${resultText}\n\n`;
        }
        shareText += `Find out yours in just 3 minutes! 🚀`;
        
        return {
            title: 'My LearnerDNA Results',
            text: shareText,
            url: window.location.href
        };
    }
    
    /**
     * Show screenshot instructions for Instagram
     */
    function showScreenshotInstructions(platform) {
        const modal = document.createElement('div');
        modal.className = 'screenshot-modal';
        modal.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(26, 24, 37, 0.9);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10000;
            padding: 20px;
        `;
        
        const platformName = platform === 'instagram' ? 'Instagram' : 'Social Media';
        const platformEmoji = platform === 'instagram' ? '📸' : '📱';
        
        modal.innerHTML = `
            <div style="background: white; border-radius: 20px; padding: 32px 24px; max-width: 400px; text-align: center;">
                <div style="font-size: 4rem; margin-bottom: 16px;">${platformEmoji}</div>
                <h3 style="font-size: 1.5rem; font-weight: 700; margin-bottom: 12px; color: #1A1825;">
                    Share to ${platformName}
                </h3>
                <p style="font-size: 1rem; color: #8E8C9A; margin-bottom: 24px; line-height: 1.6;">
                    1. Take a screenshot of your results<br>
                    2. Open ${platformName}<br>
                    3. Post your screenshot to your story!
                </p>
                <button onclick="this.closest('.screenshot-modal').remove()" 
                        style="width: 100%; padding: 16px; background: linear-gradient(135deg, #9F97F3 0%, #73D2DE 100%); 
                               color: white; border: none; border-radius: 12px; font-size: 1.1rem; font-weight: 700; 
                               cursor: pointer;">
                    Got it! 👍
                </button>
            </div>
        `;
        
        document.body.appendChild(modal);
        
        // Close on background click
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                modal.remove();
            }
        });
    }
    
    /**
     * Copy text to clipboard
     */
    function copyToClipboard(text) {
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text)
                .then(() => {
                    showToast('Link copied to clipboard! 📋');
                })
                .catch(() => {
                    fallbackCopy(text);
                });
        } else {
            fallbackCopy(text);
        }
    }
    
    /**
     * Fallback copy method
     */
    function fallbackCopy(text) {
        const textarea = document.createElement('textarea');
        textarea.value = text;
        textarea.style.position = 'fixed';
        textarea.style.opacity = '0';
        document.body.appendChild(textarea);
        textarea.select();
        
        try {
            document.execCommand('copy');
            showToast('Link copied to clipboard! 📋');
        } catch (err) {
            showToast('Failed to copy link');
        }
        
        document.body.removeChild(textarea);
    }
    
    /**
     * Show toast notification
     */
    function showToast(message) {
        const toast = document.createElement('div');
        toast.style.cssText = `
            position: fixed;
            bottom: 80px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(26, 24, 37, 0.95);
            color: white;
            padding: 12px 24px;
            border-radius: 24px;
            font-size: 0.95rem;
            font-weight: 600;
            z-index: 10001;
            animation: slideUp 0.3s ease;
        `;
        toast.textContent = message;
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.style.animation = 'slideDown 0.3s ease';
            setTimeout(() => toast.remove(), 300);
        }, 2000);
    }
    
    /**
     * Track share events
     */
    function trackShare(platform) {
        // Track with analytics if available
        if (typeof fetch !== 'undefined') {
            fetch('/analytics/track', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    eventType: 'SHARE',
                    eventData: {
                        platform: platform,
                        page: window.location.pathname
                    }
                })
            }).catch(err => console.log('Analytics tracking failed:', err));
        }
    }
    
    // Initialize on page load
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initMobileSharing);
    } else {
        initMobileSharing();
    }
    
    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateX(-50%) translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
        }
        
        @keyframes slideDown {
            from {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }
            to {
                opacity: 0;
                transform: translateX(-50%) translateY(20px);
            }
        }
    `;
    document.head.appendChild(style);
    
})();


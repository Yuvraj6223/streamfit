// StreamFit Authentication Manager

(function() {
    'use strict';

    // --- Configuration ---
    const TOKEN_KEY = 'streamfit_accessToken';
    const REFRESH_TOKEN_KEY = 'streamfit_refreshToken';
    const USER_INFO_KEY = 'streamfit_user';

    /**
     * Checks if the user is currently logged in by looking for a token.
     * @returns {boolean} True if a token exists, false otherwise.
     */
    function isLoggedIn() {
        return !!localStorage.getItem(TOKEN_KEY);
    }

    /**
     * Retrieves the stored auth token.
     * @returns {string|null} The access token or null if not found.
     */
    function getToken() {
        return localStorage.getItem(TOKEN_KEY);
    }

    /**
     * Stores authentication data (tokens and user info) in localStorage.
     * @param {object} authData - The authentication data from the API.
     * @param {string} authData.accessToken - The JWT access token.
     * @param {string} authData.refreshToken - The JWT refresh token.
     * @param {object} authData.user - Basic user information.
     */
    function storeAuthData(authData) {
        if (authData.accessToken) {
            localStorage.setItem(TOKEN_KEY, authData.accessToken);
        }
        if (authData.refreshToken) {
            localStorage.setItem(REFRESH_TOKEN_KEY, authData.refreshToken);
        }
        if (authData.user) {
            localStorage.setItem(USER_INFO_KEY, JSON.stringify(authData.user));
        }
    }

    /**
     * Clears all authentication data from localStorage.
     */
    function clearAuthData() {
        localStorage.removeItem(TOKEN_KEY);
        localStorage.removeItem(REFRESH_TOKEN_KEY);
        localStorage.removeItem(USER_INFO_KEY);
    }

    /**
     * Performs the logout operation.
     * Calls the logout API endpoint, clears local storage, and redirects.
     */
    async function logout() {
        const token = getToken();
        if (!token) {
            // If already logged out, just ensure data is clear and redirect.
            clearAuthData();
            window.location.href = '/';
            return;
        }

        try {
            // Call the backend to invalidate the session and tokens
            await fetch('/api/logout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                }
            });
        } catch (error) {
            console.error('Logout API call failed, clearing local data anyway.', error);
        } finally {
            // Always clear local data and redirect
            clearAuthData();
            window.location.href = '/';
        }
    }

    /**
     * Updates the navigation bar UI based on login state.
     * Shows/hides the "Start Playing" and "Logout" buttons.
     */
    function updateNavbar() {
        const navCtaWrapper = document.querySelector('.nav-cta-wrapper');
        if (!navCtaWrapper) return;

        // Remove any existing auth buttons to prevent duplicates
        const existingLogoutBtn = document.getElementById('navLogoutBtn');
        if (existingLogoutBtn) {
            existingLogoutBtn.remove();
        }

        const playBtn = document.getElementById('navStartPlaying');

        if (isLoggedIn()) {
            // User is logged in: show Logout button, hide Play button
            if (playBtn) {
                playBtn.style.display = 'none';
            }

            const logoutButton = document.createElement('a');
            logoutButton.href = '#';
            logoutButton.id = 'navLogoutBtn';
            logoutButton.className = 'btn btn-primary nav-cta'; // Style like the original button
            logoutButton.innerHTML = '<span>🔒</span> <span>Logout</span>';

            logoutButton.addEventListener('click', function(e) {
                e.preventDefault();
                logout();
            });

            navCtaWrapper.appendChild(logoutButton);

        } else {
            // User is not logged in: show Play button
            if (playBtn) {
                playBtn.style.display = 'inline-flex';
            }
        }
    }

    /**
     * Wraps the global fetch to automatically add the Authorization header.
     */
    function wrapFetch() {
        const originalFetch = window.fetch;
        window.fetch = function(url, options) {
            const token = getToken();
            let modifiedOptions = options || {};

            // Only add the header for internal API calls
            if (token && url.toString().startsWith('/api/')) {
                modifiedOptions.headers = {
                    ...modifiedOptions.headers,
                    'Authorization': `Bearer ${token}`
                };
            }

            return originalFetch(url, modifiedOptions);
        };
    }

    // --- Auth Modal Functions ---

    function clearAuthMessages() {
        ['signup-error-message', 'signup-success-message', 'login-error-message', 'login-success-message'].forEach(function(id) {
            var el = document.getElementById(id);
            if (el) { el.style.display = 'none'; el.textContent = ''; }
        });
    }

    function showAuthMessage(type, status, msg) {
        var el = document.getElementById(type + '-' + status + '-message');
        if (el) { el.textContent = msg; el.style.display = 'block'; }
    }

    function openAuthModal(mode, action) {
        var m = document.getElementById('auth-modal');
        var s = document.getElementById('signup-form-container');
        var l = document.getElementById('login-form-container');
        if (!m || !s || !l) {
            console.error('Auth modal elements not found!');
            return;
        }

        // Set the desired action for after login/signup succeeds
        window.authManager.postLoginAction = action || 'reload'; // Default to reload

        clearAuthMessages();
        if (mode === 'signup') {
            s.style.display = 'block';
            l.style.display = 'none';
        } else {
            s.style.display = 'none';
            l.style.display = 'block';
        }
        m.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeAuthModal() {
        var m = document.getElementById('auth-modal');
        if (m) {
            m.classList.remove('active');
        }
        document.body.style.overflow = '';
        clearAuthMessages();
        // Reset the post-login action
        window.authManager.postLoginAction = 'reload';
    }

    function handleSuccessfulAuth(data) {
        showAuthMessage('login', 'success', 'Success! Redirecting...');
        showAuthMessage('signup', 'success', 'Success! Redirecting...');

        if (window.authManager) {
            window.authManager.storeAuthData(data);
        }

        setTimeout(function() {
            if (window.authManager.postLoginAction === 'redirect') {
                window.location.href = '/dashboard';
            } else {
                window.location.reload();
            }
        }, 1000);
    }


    // --- Initialization ---

    // Expose functions to the global window object to be used by other scripts
    window.authManager = {
        isLoggedIn: isLoggedIn,
        storeAuthData: storeAuthData,
        logout: logout,
        openAuthModal: openAuthModal,
        closeAuthModal: closeAuthModal,
        postLoginAction: 'reload' // Default action
    };

    // Run on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateNavbar();
        // You might want to wrap fetch here if you are sure it won't interfere with other libraries.
        // For now, we will add the header manually in the resultPage script.
        // wrapFetch();


        // --- Auth Modal Event Listeners ---
        var authModal = document.getElementById('auth-modal');
        if (authModal) {
             var closeBtn = document.getElementById('auth-close-btn');
             if (closeBtn) closeBtn.addEventListener('click', function(e) { e.preventDefault(); closeAuthModal(); });

             authModal.addEventListener('click', function(e) {
                if (e.target.id === 'auth-modal') {
                    closeAuthModal();
                }
             });

            var signupForm = document.getElementById('signup-form');
            if (signupForm) {
                signupForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    clearAuthMessages();
                    var ageValue = document.getElementById('signup-age').value;
                    const guestSessionState = JSON.parse(localStorage.getItem('personality_start_state') || '{}');
                    const guestSessionId = guestSessionState.sessionId;

                    fetch('/api/signup', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            name: document.getElementById('signup-name').value,
                            email: document.getElementById('signup-email').value,
                            age: ageValue ? parseInt(ageValue) : null,
                            sessionId: guestSessionId
                        })
                    }).then(function(res) { return res.json(); }).then(function(data) {
                        if (data.success) {
                            handleSuccessfulAuth(data);
                        } else {
                            showAuthMessage('signup', 'error', data.message || 'An unknown error occurred.');
                        }
                    }).catch(function() {
                        showAuthMessage('signup', 'error', 'Could not connect to the server.');
                    });
                });
            }

            var loginForm = document.getElementById('login-form');
            if (loginForm) {
                loginForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    clearAuthMessages();
                    const guestSessionState = JSON.parse(localStorage.getItem('personality_start_state') || '{}');
                    const guestSessionId = guestSessionState.sessionId;

                    fetch('/api/login', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({
                            email: document.getElementById('login-email').value,
                            sessionId: guestSessionId
                        })
                    }).then(function(res) { return res.json(); }).then(function(data) {
                        if (data.success) {
                            handleSuccessfulAuth(data);
                        } else {
                            showAuthMessage('login', 'error', data.message || 'Invalid credentials.');
                        }
                    }).catch(function() {
                        showAuthMessage('login', 'error', 'Could not connect to the server.');
                    });
                });
            }
        }

        // --- Event Delegation for Modal Triggers ---
        document.body.addEventListener('click', function(e) {
            // For result page button
            if (e.target.id === 'open-dashboard-modal' || e.target.closest('#open-dashboard-modal')) {
                e.preventDefault();
                if (window.authManager && window.authManager.isLoggedIn()) {
                    window.location.href = '/dashboard';
                } else {
                    // This is the "View Dashboard" button, so we want to redirect after login.
                    openAuthModal('signup', 'redirect');
                }
            }
            // For the new nav sign-in button
            if (e.target.id === 'nav-signin-btn' || e.target.closest('#nav-signin-btn')) {
                e.preventDefault();
                // This is a generic sign-in, so we just reload the page.
                openAuthModal('login', 'reload');
            }
            // For switching forms within the modal
            if (e.target.id === 'switch-to-login-link' || e.target.closest('#switch-to-login-link')) {
                e.preventDefault();
                // When switching, preserve the original action intention
                openAuthModal('login', window.authManager.postLoginAction);
            }
            if (e.target.id === 'switch-to-signup-link' || e.target.closest('#switch-to-signup-link')) {
                e.preventDefault();
                // When switching, preserve the original action intention
                openAuthModal('signup', window.authManager.postLoginAction);
            }
        });
    });

    /**
     * Handles browser back/forward cache (bfcache) behavior.
     * When a page is restored from bfcache after a user has logged in, the auth modal
     * might still be visible. This listener checks if the user is logged in on page show
     * and closes the modal if necessary.
     */
    window.addEventListener('pageshow', function(event) {
        if (event.persisted && window.authManager && window.authManager.isLoggedIn()) {
            console.log('Page restored from bfcache, closing auth modal.'); // For debugging
            window.authManager.closeAuthModal();
        }
    });

})();

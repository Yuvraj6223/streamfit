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

    // --- Initialization ---
    
    // Expose functions to the global window object to be used by other scripts
    window.authManager = {
        isLoggedIn: isLoggedIn,
        storeAuthData: storeAuthData,
        logout: logout
    };

    // Run on page load
    document.addEventListener('DOMContentLoaded', function() {
        updateNavbar();
        // You might want to wrap fetch here if you are sure it won't interfere with other libraries.
        // For now, we will add the header manually in the resultPage script.
        // wrapFetch();
    });

})();

<div class="auth-header">
    <h2>✨ Unlock Your Full Report</h2>
    <p>This takes less than 30 seconds</p>
</div>

<div id="signup-success-message" class="auth-message success"></div>
<div id="signup-error-message" class="auth-message error"></div>

<form id="signup-form" data-ajax-form action="${createLink(controller: 'auth', action: 'processSignup')}" method="POST">
    <div class="auth-form-group">
        <label class="auth-form-label">👤 FULL NAME</label>
        <div style="position: relative;">
            <input type="text" id="signup-name" class="auth-form-input" placeholder="Your name" required>
        </div>
    </div>

    <div class="auth-form-group">
        <label class="auth-form-label">✉️ EMAIL</label>
        <div style="position: relative;">
            <input type="email" id="signup-email" class="auth-form-input" placeholder="you@email.com" required>
        </div>
    </div>

    <div class="auth-form-group">
        <label class="auth-form-label">🎂 AGE</label>
        <div style="position: relative;">
            <input type="number" id="signup-age" name="age" class="auth-form-input" placeholder="Optional">
        </div>
    </div>

    <button type="submit" class="auth-submit-btn">
        🚀 Unlock My Dashboard
    </button>
    <p style="text-align:center; font-size:0.75rem; color:#64748b; margin-top:12px;">
        🔒 We only save progress. Never spam. Never sell data.
    </p>

</form>

<div class="auth-footer">
    Already started?
    <a id="switch-to-login-link">Resume journey</a>
</div>

<style>
/* ===== AUTH MODAL CORE STYLES ===== */
.auth-modal {
    position: fixed;
    inset: 0;
    background: rgba(15, 23, 42, 0.92);
    backdrop-filter: blur(12px);
    z-index: 10001;
    display: none;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.auth-modal.active {
    display: flex;
}

.auth-modal-content {
    background: white;
    border-radius: 28px;
    padding: 48px 40px;
    width: 100%;
    max-width: 440px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.25);
    position: relative;
}

/* Close button */
.auth-close-btn {
    position: absolute;
    top: 20px;
    right: 20px;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    border: none;
    background: rgba(0,0,0,0.05);
    font-size: 1.4rem;
    cursor: pointer;
}

/* Shared form styles */
.auth-header { text-align: center; margin-bottom: 24px; }
.auth-header h2 { font-size: 2.2rem; font-weight: 800; }

.auth-form-group { margin-bottom: 18px; }

.auth-form-input {
    width: 100%;
    padding: 14px;
    border-radius: 14px;
    border: 2px solid #eee;
}

.auth-form-input:focus {
    border-color: #9F97F3;
    outline: none;
    box-shadow: 0 0 0 4px rgba(159,151,243,.2);
}

.auth-submit-btn {
    width: 100%;
    padding: 18px;
    border-radius: 100px;
    background: linear-gradient(135deg,#9F97F3,#FF8F7D);
    color: white;
    font-weight: 800;
    border: none;
    cursor: pointer;
}

.auth-footer {
    text-align: center;
    margin-top: 20px;
}

.auth-footer a {
    color: #9F97F3;
    font-weight: 700;
    cursor: pointer;
}
</style>


<div class="auth-header">
    <h2>You're Close</h2>
    <p>Create your account to view your dashboard</p>
</div>

<div class="auth-error-message" id="signup-error-message"></div>
<div class="auth-success-message" id="signup-success-message"></div>

<form id="signup-form">
    <div class="auth-form-group">
        <label class="auth-form-label">Full Name</label>
        <input type="text" id="signup-name" class="auth-form-input" required>
    </div>

    <div class="auth-form-group">
        <label class="auth-form-label">Email</label>
        <input type="email" id="signup-email" class="auth-form-input" required>
    </div>

    <div class="auth-form-group">
        <label class="auth-form-label">Age</label>
        <input type="number" id="signup-age" class="auth-form-input">
    </div>

    <button class="auth-submit-btn">Create Account</button>
</form>

<div class="auth-footer">
    Already have an account?
    <a onclick="switchToLogin()">Login</a>
</div>

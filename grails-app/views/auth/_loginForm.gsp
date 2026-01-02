<style>
/* Uses same CSS — no duplication needed */
</style>

<div class="auth-header">
    <h2>Welcome Back</h2>
    <p>Login to continue</p>
</div>

<div class="auth-error-message" id="login-error-message"></div>
<div class="auth-success-message" id="login-success-message"></div>

<form id="login-form">
    <div class="auth-form-group">
        <label class="auth-form-label">Email</label>
        <input type="email" id="login-email" class="auth-form-input" required>
    </div>

    <div class="auth-form-group">
        <label class="auth-form-label">Name</label>
        <input type="text" id="login-name" class="auth-form-input">
    </div>

    <button class="auth-submit-btn">Login</button>
</form>

<div class="auth-footer">
    Don’t have an account?
    <a onclick="switchToSignup()">Sign up</a>
</div>

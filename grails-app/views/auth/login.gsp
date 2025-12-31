<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="auth"/>
    <title>Login - learnerDNA</title>
    <style>
    :root {
        /* BRAND PALETTE */
        --bg-warm: #FDFCF8;
        --text-dark: #1A1825;
        --text-grey: #505050;

        --pop-coral: #FF8F7D;
        --pop-purple: #9F97F3;
        --pop-teal: #73D2DE;
        --pop-yellow: #FFD86D;
        --pop-cream: #FFF4F0;

        --card-base: #FFFFFF;

        --shadow-soft: 0 12px 30px -10px rgba(28, 26, 40, 0.04);
        --shadow-float: 0 20px 40px -12px rgba(159, 151, 243, 0.2);

        --ease-elastic: cubic-bezier(0.34, 1.56, 0.64, 1);
        --ease-smooth: cubic-bezier(0.16, 1, 0.3, 1);
    }


    /* BODY */
    body {
        font-family: 'Plus Jakarta Sans', sans-serif;
        background:
                radial-gradient(circle at 20% 20%, rgba(255,255,255,0.25), transparent 40%),
                linear-gradient(
                        180deg,
                        #9C86FF 0%,
                        #C7A3EB 45%,
                        #FFB085 100%
                );
        min-height: 100vh;
        margin: 0;
        color: var(--text-dark);
        overflow-x: hidden;
    }


    /* Ambient blobs */
    body::before,
    body::after {
        content: '';
        position: fixed;
        width: 500px;
        height: 500px;
        filter: blur(100px);
        z-index: -1;
    }

    body::before {
        background: #9F97F3;
        top: -10%;
        right: -10%;
    }

    body::after {
        background: #FFB085;
        bottom: -10%;
        left: -10%;
    }

    /* Layout */
    .auth-container {
        max-width: 440px;
        margin: 80px auto;
        padding: 0 16px;
    }

    .auth-card {
        background: var(--card-base);
        border-radius: 28px;
        padding: 48px 40px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.6);
        animation: fadeInUp 0.6s var(--ease-smooth);
    }


    /* Header */
    .auth-header h1 {
        font-size: 2.3rem;
        font-weight: 800;
        margin-bottom: 8px;
    }

    .auth-header p {
        color: var(--text-muted);
        font-weight: 600;
    }

    /* Inputs */
    .form-group {
        margin-bottom: 22px;
    }

    .form-label {
        font-weight: 700;
        margin-bottom: 6px;
        display: block;
    }

    .form-input {
        width: 90%;
        padding: 15px;
        border-radius: 14px;
        border: 2px solid #eee;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .form-input:focus {
        outline: none;
        border-color: var(--pop-purple);
        box-shadow: 0 0 0 4px rgba(159,151,243,0.2);
    }


    /* Button */
    .submit-btn {
        width: 100%;
        padding: 18px;
        border-radius: 100px;
        border: none;
        font-weight: 800;
        font-size: 1.05rem;
        cursor: pointer;
        color: white;
        background: linear-gradient(135deg, var(--pop-purple), var(--pop-coral));
        box-shadow: var(--shadow-float);
        transition: all 0.3s var(--ease-elastic);
    }

    .submit-btn:hover {
        transform: translateY(-4px) scale(1.03);
        box-shadow: 0 25px 50px -12px rgba(159,151,243,0.45);
    }


    /* Footer */
    .auth-footer {
        text-align: center;
        margin-top: 20px;
        color: var(--text-muted);
    }

    .auth-footer a {
        color: var(--primary);
        font-weight: 700;
        text-decoration: none;
    }

    /* Guest */
    .quick-login {
        margin-top: 30px;
        text-align: center;
    }

    .quick-login-btn {
        border: 2px dashed var(--primary);
        padding: 12px 24px;
        border-radius: 100px;
        background: transparent;
        font-weight: 700;
        cursor: pointer;
        color: var(--primary);
        transition: 0.3s;
    }

    .quick-login-btn:hover {
        background: rgba(159,151,243,0.1);
    }

    /* Anim */
    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>Welcome Back</h1>
                <p>Login to view your Dashboard</p>
            </div>
            
            <div class="error-message" id="error-message"></div>
            <div class="success-message" id="success-message"></div>
            
            <form id="login-form">
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input type="email" id="email" class="form-input" placeholder="your@email.com" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="name">Name (Optional)</label>
                    <input type="text" id="name" class="form-input" placeholder="Your Name">
                </div>
                
                <button type="submit" class="submit-btn" id="submit-btn">
                    Login
                </button>
            </form>
            
            <div class="auth-footer">
                Don't have an account? <a href="/signup">Sign up</a>
            </div>
        </div>
    </div>
    
    <script>
        // Login functionality disabled - UI only for now
        document.getElementById('login-form').addEventListener('submit', async (e) => {
            e.preventDefault();

            const errorMsg = document.getElementById('error-message');
            const successMsg = document.getElementById('success-message');

            // Hide messages
            errorMsg.style.display = 'none';
            successMsg.style.display = 'none';

            // Show message that login is coming soon
            errorMsg.textContent = 'Login functionality coming soon! For now, you can continue as guest.';
            errorMsg.style.display = 'block';
            errorMsg.style.background = '#FEF3C7';
            errorMsg.style.color = '#92400E';
            errorMsg.style.border = '1px solid #FCD34D';
        });

        function continueAsGuest() {
            window.location.href = '/diagnostic';
        }
    </script>
</body>
</html>


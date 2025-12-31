<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="auth"/>
    <title>Sign Up - learnerDNA</title>
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

    /* ===== GLOBAL ===== */
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
    }

    /* ===== CONTAINER ===== */
    .auth-container {
        max-width: 440px;
        margin: 80px auto;
        padding: 0 20px;
    }

    /* ===== CARD ===== */
    .auth-card {
        background: var(--card-base);
        border-radius: 28px;
        padding: 48px 40px;
        box-shadow: var(--shadow-float);
        border: 1px solid rgba(255,255,255,0.6);
        animation: fadeInUp 0.7s var(--ease-smooth);
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(25px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* ===== HEADER ===== */
    .auth-header {
        text-align: center;
        margin-bottom: 32px;
    }

    .auth-header h1 {
        font-size: 2.4rem;
        font-weight: 800;
        margin-bottom: 8px;
    }

    .auth-header p {
        color: var(--text-grey);
        font-weight: 600;
    }

    /* ===== FORM ===== */
    .form-group {
        margin-bottom: 22px;
    }

    .form-label {
        font-weight: 700;
        color: var(--text-dark);
        margin-bottom: 6px;
        display: block;
    }

    .form-input {
        width: 90%;
        padding: 14px 16px;
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

    /* ===== BUTTON ===== */
    .submit-btn {
        width: 100%;
        padding: 18px;
        border-radius: 100px;
        border: none;
        background: linear-gradient(135deg, var(--pop-purple), var(--pop-coral));
        color: white;
        font-size: 1.05rem;
        font-weight: 800;
        cursor: pointer;
        box-shadow: var(--shadow-float);
        transition: all 0.3s var(--ease-elastic);
    }

    .submit-btn:hover {
        transform: translateY(-4px) scale(1.03);
        box-shadow: 0 25px 50px -12px rgba(159,151,243,0.45);
    }

    /* ===== FOOTER ===== */
    .auth-footer {
        text-align: center;
        margin-top: 24px;
        color: var(--text-grey);
    }

    .auth-footer a {
        color: var(--pop-purple);
        font-weight: 700;
        text-decoration: none;
    }

    .auth-footer a:hover {
        text-decoration: underline;
    }

    /* ===== ALERTS ===== */
    .error-message {
        background: #FEF3C7;
        color: #92400E;
        border: 1px solid #FCD34D;
        padding: 12px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: none;
    }

    .success-message {
        background: #ECFDF5;
        color: #065F46;
        border: 1px solid #A7F3D0;
        padding: 12px;
        border-radius: 10px;
        margin-bottom: 20px;
        display: none;
    }

    /* MOBILE */
    @media (max-width: 480px) {
        .auth-card {
            padding: 36px 24px;
        }
    }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>You're Close</h1>
                <p>Create your account to view your complete Dashboard</p>
            </div>
            
            <div class="error-message" id="error-message"></div>
            <div class="success-message" id="success-message"></div>
            
            <form id="signup-form">
                <div class="form-group">
                    <label class="form-label" for="name">Full Name</label>
                    <input type="text" id="name" class="form-input" placeholder="Rahul Sharma" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input type="email" id="email" class="form-input" placeholder="your@email.com" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="age">Age (Optional)</label>
                    <input type="number" id="age" class="form-input" placeholder="18" min="1" max="120">
                </div>
                
                <button type="submit" class="submit-btn" id="submit-btn">
                    Create Account
                </button>
            </form>
            
            <div class="auth-footer">
                Already have an account? <a href="/login">Login</a>
            </div>
        </div>
    </div>
    
    <script>
        // Signup functionality disabled - UI only for now
        document.getElementById('signup-form').addEventListener('submit', async (e) => {
            e.preventDefault();

            const errorMsg = document.getElementById('error-message');
            const successMsg = document.getElementById('success-message');

            // Hide messages
            errorMsg.style.display = 'none';
            successMsg.style.display = 'none';

            // Show message that signup is coming soon
            errorMsg.textContent = 'Signup functionality coming soon! For now, you can start taking tests without an account.';
            errorMsg.style.display = 'block';
            errorMsg.style.background = '#FEF3C7';
            errorMsg.style.color = '#92400E';
            errorMsg.style.border = '1px solid #FCD34D';
        });
    </script>
</body>
</html>


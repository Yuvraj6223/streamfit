<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Login - StreamFit</title>
    <style>
        .auth-container {
            max-width: 450px;
            margin: 80px auto;
            padding: 0 20px;
        }
        
        .auth-card {
            background: white;
            border-radius: 20px;
            padding: 50px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }
        
        .auth-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .auth-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #333;
        }
        
        .auth-header p {
            font-size: 1.1rem;
            color: #666;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-input {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
        }
        
        .submit-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        
        .auth-footer {
            text-align: center;
            margin-top: 25px;
            color: #666;
        }
        
        .auth-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .auth-footer a:hover {
            text-decoration: underline;
        }
        
        .error-message {
            background: #ffe0e0;
            color: #d32f2f;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        .success-message {
            background: #e0ffe0;
            color: #2f7d32;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
        }
        
        .quick-login {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            text-align: center;
        }
        
        .quick-login p {
            margin-bottom: 15px;
            color: #666;
        }
        
        .quick-login-btn {
            background: white;
            border: 2px solid #e0e0e0;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .quick-login-btn:hover {
            border-color: #667eea;
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>🔐 Welcome Back</h1>
                <p>Login to continue your learning journey</p>
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
            
            <div class="quick-login">
                <p>Or continue as guest</p>
                <button class="quick-login-btn" onclick="continueAsGuest()">
                    Continue as Guest →
                </button>
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


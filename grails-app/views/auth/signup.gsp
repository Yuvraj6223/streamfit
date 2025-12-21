<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Sign Up - StreamFit</title>
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
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <h1>🚀 Get Started</h1>
                <p>Create your account to unlock your Learning DNA</p>
            </div>
            
            <div class="error-message" id="error-message"></div>
            <div class="success-message" id="success-message"></div>
            
            <form id="signup-form">
                <div class="form-group">
                    <label class="form-label" for="name">Full Name</label>
                    <input type="text" id="name" class="form-input" placeholder="John Doe" required>
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
        document.getElementById('signup-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const age = document.getElementById('age').value;
            const submitBtn = document.getElementById('submit-btn');
            const errorMsg = document.getElementById('error-message');
            const successMsg = document.getElementById('success-message');
            
            // Hide messages
            errorMsg.style.display = 'none';
            successMsg.style.display = 'none';
            
            // Disable button
            submitBtn.disabled = true;
            submitBtn.textContent = 'Creating account...';
            
            try {
                const response = await fetch('/api/auth/signup', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        name,
                        email,
                        age: age ? parseInt(age) : null,
                        agreedToTerms: true
                    })
                });
                
                const data = await response.json();
                
                if (data.success) {
                    successMsg.textContent = 'Account created! Redirecting...';
                    successMsg.style.display = 'block';
                    
                    setTimeout(() => {
                        window.location.href = '/diagnostic';
                    }, 1000);
                } else {
                    errorMsg.textContent = data.error || 'Signup failed';
                    errorMsg.style.display = 'block';
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Create Account';
                }
            } catch (error) {
                console.error('Signup error:', error);
                errorMsg.textContent = 'An error occurred. Please try again.';
                errorMsg.style.display = 'block';
                submitBtn.disabled = false;
                submitBtn.textContent = 'Create Account';
            }
        });
    </script>
</body>
</html>


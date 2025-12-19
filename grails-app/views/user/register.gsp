<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Get Started - StreamFit</title>
</head>
<body>
    <div class="register-page">
        <div class="mobile-container">
            <div class="register-card">
                <h1 class="register-title">
                    <span class="emoji">🚀</span>
                    Let's Get Started!
                </h1>
                <p class="register-subtitle">
                    Tell us a bit about yourself to personalize your experience
                </p>
                
                <form id="register-form">
                    <div class="form-group">
                        <label for="name">Name (Optional)</label>
                        <input type="text" id="name" name="name" class="form-control" placeholder="Your name">
                    </div>
                    
                    <div class="form-group">
                        <label for="age">Age *</label>
                        <input type="number" id="age" name="age" class="form-control" min="14" max="20" required placeholder="14-20">
                    </div>
                    
                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <select id="gender" name="gender" class="form-control">
                            <option value="">Select...</option>
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                            <option value="OTHER">Other</option>
                            <option value="PREFER_NOT_TO_SAY">Prefer not to say</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="educationLevel">Education Level</label>
                        <select id="educationLevel" name="educationLevel" class="form-control">
                            <option value="">Select...</option>
                            <option value="CLASS_9">Class 9</option>
                            <option value="CLASS_10">Class 10</option>
                            <option value="CLASS_11">Class 11</option>
                            <option value="CLASS_12">Class 12</option>
                            <option value="COLLEGE">College</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="currentStream">Current Stream (if applicable)</label>
                        <select id="currentStream" name="currentStream" class="form-control">
                            <option value="">Select...</option>
                            <option value="SCIENCE">Science</option>
                            <option value="COMMERCE">Commerce</option>
                            <option value="ARTS">Arts</option>
                            <option value="UNDECIDED">Undecided</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email (Optional)</label>
                        <input type="email" id="email" name="email" class="form-control" placeholder="your@email.com">
                        <small class="form-text">We'll send you your results and updates</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="phoneNumber">Phone Number (Optional)</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="+91 XXXXX XXXXX">
                    </div>
                    
                    <div class="form-check">
                        <input type="checkbox" id="agreedToTerms" name="agreedToTerms" required>
                        <label for="agreedToTerms">
                            I agree to the <a href="#" target="_blank">Terms & Conditions</a> *
                        </label>
                    </div>
                    
                    <div class="form-check">
                        <input type="checkbox" id="optInForUpdates" name="optInForUpdates">
                        <label for="optInForUpdates">
                            Send me updates and personalized recommendations
                        </label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-large btn-block">
                        Start My Journey 🎯
                    </button>
                </form>
                
                <div class="register-footer">
                    <p>Already started? <a href="${createLink(controller: 'home', action: 'index')}">Continue</a></p>
                </div>
            </div>
        </div>
    </div>
    
    <style>
        .register-page {
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .register-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .register-title {
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 12px;
            color: #333;
        }
        
        .register-title .emoji {
            font-size: 2.5rem;
            display: block;
            margin-bottom: 12px;
        }
        
        .register-subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-text {
            display: block;
            margin-top: 4px;
            font-size: 0.85rem;
            color: #888;
        }
        
        .form-check {
            margin-bottom: 16px;
            display: flex;
            align-items: flex-start;
        }
        
        .form-check input[type="checkbox"] {
            margin-right: 8px;
            margin-top: 4px;
        }
        
        .form-check label {
            font-size: 0.95rem;
            color: #666;
        }
        
        .form-check a {
            color: #667eea;
            text-decoration: none;
        }
        
        .form-check a:hover {
            text-decoration: underline;
        }
        
        .register-footer {
            text-align: center;
            margin-top: 24px;
            color: #666;
        }
        
        .register-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .register-footer a:hover {
            text-decoration: underline;
        }
    </style>
    
    <content tag="scripts">
        <script>
            document.getElementById('register-form').addEventListener('submit', function(e) {
                e.preventDefault();
                
                const formData = {
                    name: document.getElementById('name').value,
                    age: document.getElementById('age').value,
                    gender: document.getElementById('gender').value,
                    educationLevel: document.getElementById('educationLevel').value,
                    currentStream: document.getElementById('currentStream').value,
                    email: document.getElementById('email').value,
                    phoneNumber: document.getElementById('phoneNumber').value,
                    agreedToTerms: document.getElementById('agreedToTerms').checked,
                    optInForUpdates: document.getElementById('optInForUpdates').checked
                };
                
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.textContent = 'Creating your profile...';
                
                fetch('${createLink(controller: 'user', action: 'register')}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        window.location.href = '${createLink(controller: 'test', action: 'index')}';
                    } else {
                        alert('Error: ' + data.message);
                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Start My Journey 🎯';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('An error occurred. Please try again.');
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Start My Journey 🎯';
                });
            });
        </script>
    </content>
</body>
</html>


<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Access Denied - learnerDNA</title>
</head>
<body>
    <div class="error-page">
        <div class="mobile-container">
            <div class="error-card">
                <div class="error-emoji">🚫</div>
                <h1 class="error-title">403</h1>
                <h2 class="error-subtitle">Access Denied</h2>
                <p class="error-message">
                    You don't have permission to access this resource.
                </p>
                
                <div class="error-actions">
                    <a href="${createLink(controller: 'home', action: 'index')}" class="btn btn-primary btn-large">
                        Go to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <style>
        .error-page {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }
        
        .error-card {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }
        
        .error-emoji {
            font-size: 5rem;
            margin-bottom: 20px;
        }
        
        .error-title {
            font-size: 4rem;
            font-weight: 800;
            color: #f59e0b;
            margin-bottom: 12px;
        }
        
        .error-subtitle {
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 16px;
        }
        
        .error-message {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .error-actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
    </style>
</body>
</html>


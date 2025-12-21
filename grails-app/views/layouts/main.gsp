<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><g:layoutTitle default="16Personalities - Free Personality Test"/></title>
    
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="personality-test.css"/>
    <asset:javascript src="application.js"/>
    
    <g:layoutHead/>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .mobile-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        /* Navigation Styles */
        .main-nav {
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-logo {
            font-size: 1.8rem;
            font-weight: 700;
            text-decoration: none;
            color: #333;
        }
        
        .nav-logo .purple {
            color: #667eea;
        }
        
        .nav-logo .badge {
            background: #667eea;
            color: white;
            padding: 4px 12px;
            border-radius: 8px;
            font-size: 1.2rem;
            margin-left: 8px;
        }
        
        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
            list-style: none;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #555;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: #667eea;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }
        
        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }
        
        .btn-block {
            width: 100%;
            text-align: center;
        }
        
        /* Footer Styles */
        .main-footer {
            background: white;
            margin-top: 60px;
            padding: 40px 0 20px;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .footer-section h3 {
            font-size: 1.1rem;
            margin-bottom: 16px;
            color: #333;
        }
        
        .footer-section ul {
            list-style: none;
        }
        
        .footer-section ul li {
            margin-bottom: 12px;
        }
        
        .footer-section a {
            color: #666;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer-section a:hover {
            color: #667eea;
        }
        
        .footer-bottom {
            border-top: 1px solid #eee;
            padding-top: 20px;
            text-align: center;
            color: #888;
            font-size: 0.9rem;
        }
        
        /* Zigzag Divider */
        .zigzag {
            height: 20px;
            background: linear-gradient(135deg, #667eea 25%, transparent 25%) -10px 0,
                        linear-gradient(225deg, #667eea 25%, transparent 25%) -10px 0,
                        linear-gradient(315deg, #667eea 25%, transparent 25%),
                        linear-gradient(45deg, #667eea 25%, transparent 25%);
            background-size: 20px 20px;
            background-color: white;
        }
        
        /* Mobile Menu */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            
            .footer-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="main-nav">
        <div class="nav-container">
            <a href="${createLink(uri: '/')}" class="nav-logo">
                <span class="purple">16</span>Personalities
                <span class="badge">Free</span>
            </a>
            <ul class="nav-links">
                <li><a href="${createLink(uri: '/')}">Home</a></li>
                <li><a href="${createLink(controller: 'personality', action: 'index')}">Take Test</a></li>
                <li><a href="${createLink(controller: 'personality', action: 'types')}">Personality Types</a></li>
                <li><a href="${createLink(uri: '/about')}">About</a></li>
            </ul>
            <a href="${createLink(controller: 'personality', action: 'start')}" class="btn btn-primary">
                Free Test
            </a>
        </div>
    </nav>
    
    <div class="zigzag"></div>
    
    <!-- Main Content -->
    <g:layoutBody/>
    
    <!-- Footer -->
    <div class="zigzag" style="transform: scaleY(-1);"></div>
    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-section">
                    <h3>Products</h3>
                    <ul>
                        <li><a href="${createLink(controller: 'personality', action: 'index')}">Personality Test</a></li>
                        <li><a href="${createLink(controller: 'personality', action: 'types')}">Personality Types</a></li>
                        <li><a href="${createLink(uri: '/career')}">Career Suite</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>Resources</h3>
                    <ul>
                        <li><a href="${createLink(uri: '/articles')}">Articles</a></li>
                        <li><a href="${createLink(uri: '/framework')}">Our Framework</a></li>
                        <li><a href="${createLink(uri: '/faq')}">FAQ</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>Help</h3>
                    <ul>
                        <li><a href="${createLink(uri: '/contact')}">Contact Us</a></li>
                        <li><a href="${createLink(uri: '/privacy')}">Privacy Policy</a></li>
                        <li><a href="${createLink(uri: '/terms')}">Terms & Conditions</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>About</h3>
                    <ul>
                        <li><a href="https://www.16personalities.com" target="_blank">16Personalities Official</a></li>
                        <li><a href="https://github.com/SwapnilSoni1999/16personalities-api" target="_blank">Source API</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>©2025 16Personalities Test - Unofficial Implementation</p>
                <p style="margin-top: 8px; font-size: 0.85rem;">
                    This is an educational project based on the 16personalities framework. 
                    Visit <a href="https://www.16personalities.com" target="_blank" style="color: #667eea;">16personalities.com</a> for the official test.
                </p>
            </div>
        </div>
    </footer>
</body>
</html>


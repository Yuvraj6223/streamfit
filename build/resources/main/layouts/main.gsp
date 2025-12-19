<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <title><g:layoutTitle default="StreamFit - Discover Your Learning DNA"/></title>
    
    <meta name="description" content="StreamFit helps students aged 14-20 discover their cognitive traits, learning styles, and stream-fit potential through gamified diagnostics.">
    <meta name="keywords" content="learning style, cognitive assessment, career guidance, stream selection, student assessment">
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${assetPath(src: 'favicon.ico')}">
    
    <!-- CSS -->
    <asset:stylesheet src="application.css"/>
    <asset:stylesheet src="mobile.css"/>
    
    <g:layoutHead/>
    
    <style>
        /* Global Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            width: 100%;
            overflow-x: hidden;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
            width: 100%;
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }

        #app {
            width: 100%;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Container Styles */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            width: 100%;
            box-sizing: border-box;
        }

        .mobile-container {
            max-width: 480px;
            margin: 0 auto;
            padding: 0 16px;
            width: 100%;
            box-sizing: border-box;
        }

        /* Mobile-first responsive design */
        @media (max-width: 768px) {
            .container {
                padding: 0 16px;
            }

            .mobile-container {
                padding: 0 12px;
            }
        }

        @media (max-width: 480px) {
            .container,
            .mobile-container {
                padding: 0 12px;
            }
        }
    </style>
</head>
<body>
    <div id="app">
        <g:layoutBody/>
    </div>
    
    <!-- JavaScript -->
    <asset:javascript src="application.js"/>
    <g:pageProperty name="page.scripts"/>
</body>
</html>


package com.streamfit

class UrlMappings {

    static mappings = {
        // Home
        "/"(controller: 'home', action: 'index')
        "/about"(controller: 'about', action: 'index')
        "/faq"(controller: 'faq', action: 'index')

        // User
        "/register"(controller: 'user', action: 'register')
        "/profile"(controller: 'user', action: 'profile')

        // Authentication
        "/login"(controller: 'auth', action: 'login')
        "/signup"(controller: 'auth', action: 'signup')

        // ========== API v1 Endpoints (Recommended) ==========
        // Authentication API v1
        "/api/v1/auth/login"(controller: 'auth', action: 'doLogin')
        "/api/v1/auth/signup"(controller: 'auth', action: 'doSignup')
        "/api/v1/auth/logout"(controller: 'auth', action: 'logout')
        "/api/v1/auth/me"(controller: 'auth', action: 'me')
        "/api/v1/login"(controller: "auth", action: "processLogin")
        "/api/v1/signup"(controller: "auth", action: "processSignup")

        // Dashboard API v1
        "/api/v1/dashboard/data"(controller: 'dashboard', action: 'data')

        // Personality API v1
        "/api/v1/personality/questions"(controller: 'personality', action: 'questions')
        "/api/v1/personality/submit"(controller: 'personality', action: 'submit')
        "/api/v1/personality/result/$sessionId"(controller: 'personality', action: 'getResult')

        // Result API v1
        "/api/v1/result/tests"(controller: 'result', action: 'tests')
        "/api/v1/result/test/$testId"(controller: 'result', action: 'test')
        "/api/v1/result/questions/$testId"(controller: 'result', action: 'questions')
        "/api/v1/result/start"(controller: 'result', action: 'start')
        "/api/v1/result/response"(controller: 'result', action: 'submitResponse')
        "/api/v1/result/submit"(controller: 'result', action: 'submit')
        "/api/v1/result/status/$sessionId"(controller: 'result', action: 'status')
        "/api/v1/result/$sessionId"(controller: 'result', action: 'result')
        "/api/v1/result/history"(controller: 'result', action: 'history')

        // ========== Legacy API Endpoints (Backward Compatibility) ==========
        "/api/auth/login"(controller: 'auth', action: 'doLogin')
        "/api/auth/signup"(controller: 'auth', action: 'doSignup')
        "/api/auth/logout"(controller: 'auth', action: 'logout')
        "/api/auth/me"(controller: 'auth', action: 'me')
        // API endpoints for actual authentication (with JWT support)
        "/api/login"(controller: "auth", action: "processLogin")
        "/api/signup"(controller: "auth", action: "processSignup")
        "/api/logout"(controller: "auth", action: "logout")
        "/api/me"(controller: "auth", action: "me")
        "/api/token/refresh"(controller: "auth", action: "refreshToken")

        // Personality Test Pages
        "/personality"(controller: 'personality', action: 'index')
        "/personality/start"(controller: 'personality', action: 'start')
        "/personality/result"(controller: 'personality', action: 'result')
        "/personality/types"(controller: 'personality', action: 'types')

        // Analytics - Stub endpoints in HomeController (prevents 404 errors)
        "/analytics"(controller: 'home', action: 'analytics')
        "/analytics/track"(controller: 'home', action: 'track')

        // Dashboard
        "/dashboard"(controller: 'dashboard', action: 'index')
        "/api/dashboard/data"(controller: 'dashboard', action: 'data')
        
        // Admin - Cache monitoring
        "/admin/cache/stats"(controller: 'dashboard', action: 'cacheStats')

        // Legacy Personality API endpoints
        "/api/personality/questions"(controller: 'personality', action: 'questions')
        "/api/personality/submit"(controller: 'personality', action: 'submit')
        "/api/personality/result/$sessionId"(controller: 'personality', action: 'getResult')

        // Result Test Pages
        "/result"(controller: 'result', action: 'index')
        "/result/test/$testId"(controller: 'result', action: 'testPage')
        "/result/$sessionId"(controller: 'result', action: 'resultPage')

        // Legacy Result API endpoints
        "/api/result/tests"(controller: 'result', action: 'tests')
        "/api/result/test/$testId"(controller: 'result', action: 'test')
        "/api/result/questions/$testId"(controller: 'result', action: 'questions')
        "/api/result/start"(controller: 'result', action: 'start')
        "/api/result/response"(controller: 'result', action: 'submitResponse')
        "/api/result/submit"(controller: 'result', action: 'submit')
        "/api/result/status/$sessionId"(controller: 'result', action: 'status')
        "/api/result/$sessionId"(controller: 'result', action: 'result')
        "/api/result/history"(controller: 'result', action: 'history')

        // SEO - Sitemap and Robots
        "/sitemap.xml"(controller: 'sitemap', action: 'index')
        "/robots.txt"(controller: 'sitemap', action: 'robots')

        // Health Check endpoints
        "/health"(controller: 'health', action: 'check')
        "/health/live"(controller: 'health', action: 'live')
        "/health/ready"(controller: 'health', action: 'ready')

        // Error pages
        "401"(view: '/error/401')
        "403"(view: '/error/403')
        "404"(view: '/error/404')
        "429"(view: '/error/429')
        "500"(view: '/error/500')
    }
}



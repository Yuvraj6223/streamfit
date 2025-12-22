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
        "/api/auth/login"(controller: 'auth', action: 'doLogin')
        "/api/auth/signup"(controller: 'auth', action: 'doSignup')
        "/api/auth/logout"(controller: 'auth', action: 'logout')
        "/api/auth/me"(controller: 'auth', action: 'me')

        // Personality Test Pages
        "/personality"(controller: 'personality', action: 'index')
        "/personality/start"(controller: 'personality', action: 'start')
        "/personality/result"(controller: 'personality', action: 'result')
        "/personality/types"(controller: 'personality', action: 'types')

        // Analytics
        "/analytics"(controller: 'analytics', action: 'index')
        "/analytics/track"(controller: 'analytics', action: 'track')

        // Dashboard
        "/dashboard"(controller: 'dashboard', action: 'index')
        "/api/dashboard/data"(controller: 'dashboard', action: 'data')

        // Personality API endpoints (16personalities compatible)
        "/api/personality/questions"(controller: 'personality', action: 'questions')
        "/api/personality/submit"(controller: 'personality', action: 'submit')
        "/api/personality/result/$sessionId"(controller: 'personality', action: 'getResult')

        // Diagnostic Test Pages
        "/diagnostic"(controller: 'diagnostic', action: 'index')
        "/diagnostic/test/$testId"(controller: 'diagnostic', action: 'testPage')
        "/diagnostic/result/$sessionId"(controller: 'diagnostic', action: 'resultPage')

        // Diagnostic API endpoints
        "/api/diagnostic/tests"(controller: 'diagnostic', action: 'tests')
        "/api/diagnostic/test/$testId"(controller: 'diagnostic', action: 'test')
        "/api/diagnostic/questions/$testId"(controller: 'diagnostic', action: 'questions')
        "/api/diagnostic/start"(controller: 'diagnostic', action: 'start')
        "/api/diagnostic/response"(controller: 'diagnostic', action: 'submitResponse')
        "/api/diagnostic/submit"(controller: 'diagnostic', action: 'submit')
        "/api/diagnostic/result/$sessionId"(controller: 'diagnostic', action: 'result')
        "/api/diagnostic/history"(controller: 'diagnostic', action: 'history')

        // SEO - Sitemap and Robots
        "/sitemap.xml"(controller: 'sitemap', action: 'index')
        "/robots.txt"(controller: 'sitemap', action: 'robots')

        // Error pages
        "404"(view: '/error/404')
        "500"(view: '/error/500')
        "403"(view: '/error/403')
    }
}



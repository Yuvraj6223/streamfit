package com.streamfit

class UrlMappings {

    static mappings = {
        // Home
        "/"(controller: 'home', action: 'index')
        "/welcome"(controller: 'home', action: 'welcome')
        "/about"(controller: 'home', action: 'about')
        
        // User
        "/register"(controller: 'user', action: 'register')
        "/profile"(controller: 'user', action: 'profile')
        "/user/preferences"(controller: 'user', action: 'updatePreferences')
        "/user/stats"(controller: 'user', action: 'stats')
        
        // Tests
        "/tests"(controller: 'test', action: 'index')
        "/test/$testCode/start"(controller: 'test', action: 'start')
        "/test/question"(controller: 'test', action: 'question')
        "/test/submit"(controller: 'test', action: 'submitAnswer')
        "/test/result"(controller: 'test', action: 'result')
        "/test/history"(controller: 'test', action: 'history')
        "/test/abandon"(controller: 'test', action: 'abandon')
        
        // Dashboard
        "/dashboard"(controller: 'dashboard', action: 'index')
        "/dashboard/dna"(controller: 'dashboard', action: 'learningDNA')
        "/dashboard/data"(controller: 'dashboard', action: 'data')
        
        // Sharing
        "/share/$userId"(controller: 'share', action: 'index')
        "/share/card"(controller: 'share', action: 'card')
        "/share/links"(controller: 'share', action: 'links')
        "/share/track"(controller: 'share', action: 'track')
        
        // Analytics
        "/analytics"(controller: 'analytics', action: 'index')
        "/analytics/track"(controller: 'analytics', action: 'track')
        "/analytics/prebook"(controller: 'analytics', action: 'prebook')
        "/analytics/stats"(controller: 'analytics', action: 'stats')
        "/analytics/dropoff"(controller: 'analytics', action: 'dropoffRates')
        "/analytics/cta"(controller: 'analytics', action: 'ctaStats')
        "/analytics/prebooking"(controller: 'analytics', action: 'prebookingStats')
        
        // API endpoints
        "/api/share/card/$userId/image"(controller: 'share', action: 'image')
        
        // Error pages
        "404"(view: '/error/404')
        "500"(view: '/error/500')
        "403"(view: '/error/403')
    }
}



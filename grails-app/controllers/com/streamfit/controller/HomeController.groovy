package com.streamfit.controller

import grails.converters.JSON

class HomeController {

    /**
     * Landing page - 16personalities style
     */
    def index() {
        // Simply render the landing page
        [:]
    }

    def about() {
        render view: 'about'
    }
    
    /**
     * Analytics tracking stub - prevents 404 errors
     * POST /analytics/track
     */
    def track() {
        try {
            // Simply acknowledge the analytics request without processing
            // This prevents frontend errors while keeping the app lightweight
            response.status = 200
            render([success: true, message: 'Analytics tracking disabled'] as JSON)
        } catch (Exception e) {
            response.status = 200
            render([success: true, message: 'Analytics tracking disabled'] as JSON)
        }
    }
    
    /**
     * Analytics page stub - prevents 404 errors
     * GET /analytics
     */
    def analytics() {
        response.status = 404
        render(view: '/error/404')
    }
}


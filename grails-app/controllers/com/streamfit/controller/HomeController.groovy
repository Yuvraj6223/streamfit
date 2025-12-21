package com.streamfit.controller

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
}


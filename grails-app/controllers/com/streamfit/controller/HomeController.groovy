package com.streamfit.controller

import com.streamfit.user.User
import com.streamfit.service.UserService
import com.streamfit.service.TestService

class HomeController {

    UserService userService
    TestService testService
    
    def index() {
        // Get or create user from session
        def userId = session.userId
        User user = null
        
        if (userId) {
            user = userService.getUserById(userId)
        }
        
        // Get all available tests
        def coreTests = testService.getCoreTests()
        def streamFitTests = testService.getStreamFitTests()
        
        [
            user: user,
            coreTests: coreTests,
            streamFitTests: streamFitTests
        ]
    }
    
    def welcome() {
        render view: 'welcome'
    }
    
    def about() {
        render view: 'about'
    }
}


package com.streamfit.controller

import com.streamfit.service.UserService
import com.streamfit.service.SharingService
import grails.converters.JSON

class ShareController {

    UserService userService
    SharingService sharingService
    
    def index(String userId) {
        def user = userService.getUserById(userId)
        
        if (!user) {
            flash.error = "User not found"
            redirect controller: 'home', action: 'index'
            return
        }
        
        def resultCard = sharingService.generateResultCard(user)
        
        [
            user: user,
            resultCard: resultCard
        ]
    }
    
    def card() {
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            response.status = 404
            render([success: false, message: 'User not found'] as JSON)
            return
        }
        
        def params = request.JSON ?: params
        def testCode = params.testCode
        
        def resultCard = sharingService.generateResultCard(user, testCode)
        
        render([
            success: true,
            card: resultCard
        ] as JSON)
    }
    
    def links() {
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            response.status = 404
            render([success: false, message: 'User not found'] as JSON)
            return
        }
        
        def params = request.JSON ?: params
        def testCode = params.testCode
        
        def shareLinks = sharingService.getShareLinks(user, testCode)
        
        render([
            success: true,
            links: shareLinks
        ] as JSON)
    }
    
    def track() {
        def userId = session.userId
        
        if (!userId) {
            response.status = 401
            render([success: false, message: 'User not logged in'] as JSON)
            return
        }
        
        def user = userService.getUserById(userId)
        
        if (!user) {
            response.status = 404
            render([success: false, message: 'User not found'] as JSON)
            return
        }
        
        def params = request.JSON ?: params
        def platform = params.platform
        def testCode = params.testCode
        
        def result = sharingService.trackShare(user, platform, testCode)
        
        render([
            success: true,
            result: result
        ] as JSON)
    }
    
    def image(String userId) {
        def user = userService.getUserById(userId)
        
        if (!user) {
            response.status = 404
            render([success: false, message: 'User not found'] as JSON)
            return
        }
        
        def imageData = sharingService.generateShareableImage(user)
        
        // In production, this would generate an actual image
        // For now, returning image metadata
        render([
            success: true,
            image: imageData
        ] as JSON)
    }
}


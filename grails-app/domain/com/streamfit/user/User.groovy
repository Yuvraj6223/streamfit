package com.streamfit.user

class User {

    String userId
    String name
    String email
    String phoneNumber
    Integer age
    String gender
    String educationLevel
    String currentStream

    // Tracking
    Date dateCreated
    Date lastUpdated
    String ipAddress
    String userAgent
    String referralSource

    // Preferences
    Boolean agreedToTerms = false
    Boolean optInForUpdates = false
    Boolean prebookedStreamMap = false

    static constraints = {
        userId unique: true, blank: false
        name nullable: true
        email nullable: true, email: true
        phoneNumber nullable: true
        age nullable: true, min: 1, max: 120
        gender nullable: true, inList: ['MALE', 'FEMALE', 'OTHER', 'PREFER_NOT_TO_SAY']
        educationLevel nullable: true
        currentStream nullable: true
        ipAddress nullable: true
        userAgent nullable: true
        referralSource nullable: true
    }

    static hasMany = [sessions: com.streamfit.UserSession]

    static mapping = {
        table 'streamfit_user'  // ← CHANGED THIS
        version false
    }

    String toString() {
        return name ?: userId
    }
}
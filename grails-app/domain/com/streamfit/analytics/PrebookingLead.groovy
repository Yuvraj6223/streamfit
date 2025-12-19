package com.streamfit.analytics

import com.streamfit.user.User

class PrebookingLead {
    
    User user
    String leadType // STREAMMAP_REPORT, COACHING, ADVANCED_DIAGNOSTICS
    String status // PENDING, CONTACTED, CONVERTED, DECLINED
    String contactPreference // EMAIL, PHONE, WHATSAPP
    String notes
    
    Date prebookedAt
    Date contactedAt
    Date convertedAt
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [user: User]
    
    static constraints = {
        leadType blank: false, inList: ['STREAMMAP_REPORT', 'COACHING', 'ADVANCED_DIAGNOSTICS']
        status inList: ['PENDING', 'CONTACTED', 'CONVERTED', 'DECLINED']
        contactPreference nullable: true, inList: ['EMAIL', 'PHONE', 'WHATSAPP']
        notes nullable: true, maxSize: 2000
        prebookedAt nullable: false
        contactedAt nullable: true
        convertedAt nullable: true
    }
    
    static mapping = {
        table 'prebooking_lead'
        version false
        notes sqlType: 'text'
    }
    
    String toString() {
        return "${leadType} - ${user} - ${status}"
    }
}


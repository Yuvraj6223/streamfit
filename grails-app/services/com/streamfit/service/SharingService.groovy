package com.streamfit.service

import com.streamfit.user.User
import com.streamfit.dashboard.LearningDNA
import grails.gorm.transactions.Transactional

@Transactional
class SharingService {

    def analyticsService
    def grailsApplication
    
    def generateResultCard(User user, String testCode = null) {
        LearningDNA dna = LearningDNA.findByUser(user)
        
        if (!dna) {
            log.error "No Learning DNA found for user: ${user.userId}"
            return null
        }
        
        def card = [
            userId: user.userId,
            title: 'My StreamFit Learning DNA',
            persona: dna.learningStylePersona ? "${dna.learningStyleEmoji} ${dna.learningStylePersona}" : null,
            cognitive: dna.cognitiveSkew ? "${dna.cognitiveEmoji} ${dna.cognitiveSkew}" : null,
            workStyle: dna.workStyle ? "${dna.workStyleEmoji} ${dna.workStyle}" : null,
            topStream: dna.topStreamSuggestions?.first(),
            shareUrl: generateShareUrl(user),
            imageUrl: generateCardImageUrl(user),
            timestamp: new Date()
        ]
        
        return card
    }
    
    def generateShareText(User user, String platform = 'generic') {
        LearningDNA dna = LearningDNA.findByUser(user)
        
        if (!dna) {
            return "Discover your Learning DNA on StreamFit! 🚀"
        }
        
        def baseText = "I'm a ${dna.learningStylePersona ?: 'unique learner'}"
        
        if (dna.cognitiveSkew) {
            baseText += " with ${dna.cognitiveSkew} strengths"
        }
        
        if (dna.topStreamSuggestions) {
            baseText += "! My top stream: ${dna.topStreamSuggestions.first()}"
        }
        
        baseText += " 🎯\n\nDiscover YOUR Learning DNA on StreamFit! 🚀"
        
        // Platform-specific formatting
        switch (platform) {
            case 'whatsapp':
                return formatForWhatsApp(baseText, user)
            case 'instagram':
                return formatForInstagram(baseText, user)
            case 'telegram':
                return formatForTelegram(baseText, user)
            default:
                return baseText + "\n${generateShareUrl(user)}"
        }
    }
    
    def getShareLinks(User user, String testCode = null) {
        def shareText = generateShareText(user, 'generic')
        def shareUrl = generateShareUrl(user)
        def encodedText = URLEncoder.encode(shareText, 'UTF-8')
        def encodedUrl = URLEncoder.encode(shareUrl, 'UTF-8')
        
        return [
            whatsapp: "https://wa.me/?text=${encodedText}",
            instagram: generateInstagramShareData(user),
            telegram: "https://t.me/share/url?url=${encodedUrl}&text=${encodedText}",
            twitter: "https://twitter.com/intent/tweet?text=${encodedText}",
            facebook: "https://www.facebook.com/sharer/sharer.php?u=${encodedUrl}",
            linkedin: "https://www.linkedin.com/sharing/share-offsite/?url=${encodedUrl}",
            generic: shareUrl
        ]
    }
    
    def trackShare(User user, String platform, String testCode = null) {
        analyticsService?.trackResultShared(user, platform, testCode)
        
        log.info "User ${user.userId} shared results on ${platform}"
        
        return [
            success: true,
            platform: platform,
            timestamp: new Date()
        ]
    }
    
    def generateShareableImage(User user) {
        // This would integrate with an image generation service
        // For now, returning a placeholder structure
        
        LearningDNA dna = LearningDNA.findByUser(user)
        
        return [
            imageUrl: generateCardImageUrl(user),
            width: 1200,
            height: 630,
            format: 'PNG',
            elements: [
                background: '#6366F1',
                title: 'My Learning DNA',
                persona: "${dna?.learningStyleEmoji} ${dna?.learningStylePersona}",
                cognitive: "${dna?.cognitiveEmoji} ${dna?.cognitiveSkew}",
                workStyle: "${dna?.workStyleEmoji} ${dna?.workStyle}",
                footer: 'Discover yours at StreamFit'
            ]
        ]
    }
    
    private String generateShareUrl(User user) {
        def baseUrl = grailsApplication.config.getProperty('grails.serverURL', String, 'http://localhost:8080')
        return "${baseUrl}/share/${user.userId}"
    }
    
    private String generateCardImageUrl(User user) {
        def baseUrl = grailsApplication.config.getProperty('grails.serverURL', String, 'http://localhost:8080')
        return "${baseUrl}/api/share/card/${user.userId}/image"
    }
    
    private String formatForWhatsApp(String text, User user) {
        return """
${text}

🔗 ${generateShareUrl(user)}

#StreamFit #LearningDNA #KnowYourself
        """.trim()
    }
    
    private String formatForInstagram(String text, User user) {
        // Instagram doesn't support link sharing in posts, so we focus on the text
        return """
${text}

Link in bio! 🔗

#StreamFit #LearningDNA #StudentLife #CareerGuidance #KnowYourself #Education #PersonalGrowth
        """.trim()
    }
    
    private String formatForTelegram(String text, User user) {
        return """
${text}

👉 ${generateShareUrl(user)}

#StreamFit #LearningDNA
        """.trim()
    }
    
    private Map generateInstagramShareData(User user) {
        // Instagram requires image-based sharing
        return [
            type: 'image',
            imageUrl: generateCardImageUrl(user),
            caption: formatForInstagram(generateShareText(user, 'instagram'), user),
            hashtags: ['StreamFit', 'LearningDNA', 'StudentLife', 'CareerGuidance']
        ]
    }
}


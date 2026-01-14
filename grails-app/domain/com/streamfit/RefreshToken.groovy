package com.streamfit

import com.streamfit.user.User
import java.time.Instant

class RefreshToken {
    String tokenId          // UUID for this refresh token
    User user               // FK to streamfit_user
    String token            // The actual refresh token value (hashed)
    Date expiresAt          // Expiration timestamp
    Date createdAt          // Creation timestamp
    Date revokedAt          // Revocation timestamp (null if active)
    String ipAddress        // IP where token was issued
    String userAgent        // User agent where token was issued
    Integer rotationCount   // How many times this token was rotated
    String parentTokenId    // Reference to previous token in rotation chain

    static constraints = {
        tokenId unique: true, blank: false
        user nullable: false
        token blank: false, maxSize: 500
        expiresAt nullable: false
        createdAt nullable: false
        revokedAt nullable: true
        ipAddress nullable: true, maxSize: 45
        userAgent nullable: true, maxSize: 500
        rotationCount nullable: false, min: 0
        parentTokenId nullable: true
    }

    static mapping = {
        table 'refresh_token'
        version false
        token type: 'text'
        indexes 'user_id_idx': 'user_id', 'token_id_idx': 'tokenId', 'expires_at_idx': 'expiresAt', 'revoked_at_idx': 'revokedAt'
    }

    static belongsTo = [user: User]

    /**
     * Check if token is still valid (not expired and not revoked)
     */
    boolean isValid() {
        return revokedAt == null && expiresAt > new Date()
    }

    String toString() {
        return "RefreshToken(${tokenId}, user=${user.userId}, valid=${isValid()})"
    }
}


package com.streamfit.service

import com.streamfit.RefreshToken
import com.streamfit.user.User
import grails.gorm.transactions.Transactional
import groovy.json.JsonOutput
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.beans.factory.annotation.Value
import java.security.MessageDigest
import java.util.concurrent.TimeUnit
import java.util.Base64

@Transactional
class RefreshTokenService {

    RedisTemplate<String, Object> redisTemplate

    @Value('${cache.ttl.refresh-token:604800}')  // 7 days
    private long refreshTokenTTL

    private static final String CACHE_VERSION = "v1"

    /**
     * Generate cache key for refresh token
     */
    private String getCacheKey(String tokenId) {
        return "${CACHE_VERSION}:refresh:${tokenId}"
    }

    /**
     * Hash the refresh token for secure storage
     */
    private String hashToken(String token) {
        try {
            MessageDigest digest = MessageDigest.getInstance('SHA-256')
            byte[] hashedBytes = digest.digest(token.getBytes('UTF-8'))
            return Base64.encoder.encodeToString(hashedBytes)
        } catch (Exception e) {
            log.error("Error hashing refresh token: ${e.message}", e)
            throw new RuntimeException("Token hashing failed", e)
        }
    }

    /**
     * Store refresh token in database
     * Optionally cache in Redis for faster lookups
     */
    RefreshToken saveRefreshToken(String tokenId, User user, String token, Date expiresAt, String ipAddress, String userAgent) {
        try {
            def hashedToken = hashToken(token)

            def refreshToken = new RefreshToken(
                tokenId: tokenId,
                user: user,
                token: hashedToken,
                expiresAt: expiresAt,
                createdAt: new Date(),
                revokedAt: null,
                ipAddress: ipAddress,
                userAgent: userAgent,
                rotationCount: 0,
                parentTokenId: null
            )

            if (!refreshToken.save(flush: true)) {
                log.error("Failed to save refresh token: ${refreshToken.errors}")
                throw new RuntimeException("Failed to save refresh token")
            }

            // Cache in Redis for faster lookups
            cacheRefreshToken(tokenId, refreshToken)

            log.info("Refresh token saved: ${tokenId} for user ${user.userId}")
            return refreshToken
        } catch (Exception e) {
            log.error("Error saving refresh token: ${e.message}", e)
            throw e
        }
    }

    /**
     * Cache refresh token metadata in Redis
     */
    private void cacheRefreshToken(String tokenId, RefreshToken refreshToken) {
        try {
            def cacheData = [
                tokenId: refreshToken.tokenId,
                userId: refreshToken.user.userId,
                expiresAt: refreshToken.expiresAt.time,
                valid: true
            ]
            redisTemplate?.opsForValue()?.set(getCacheKey(tokenId), JsonOutput.toJson(cacheData), refreshTokenTTL, TimeUnit.SECONDS)
            log.debug("Refresh token cached: ${tokenId}")
        } catch (Exception e) {
            log.warn("Failed to cache refresh token: ${e.message}")
            // Don't fail if cache fails, DB is source of truth
        }
    }

    /**
     * Find and validate refresh token
     * Checks DB and then cache
     */
    RefreshToken findValidToken(String tokenId) {
        try {
            // Try cache first
            try {
                def cached = redisTemplate?.opsForValue()?.get(getCacheKey(tokenId))
                if (cached) {
                    def cacheData = new groovy.json.JsonSlurper().parseText(cached.toString())
                    if (cacheData.valid && cacheData.expiresAt > System.currentTimeMillis()) {
                        log.debug("Refresh token found in cache: ${tokenId}")
                        // Fetch from DB to get full object
                        return RefreshToken.findByTokenId(tokenId)
                    }
                }
            } catch (Exception e) {
                log.warn("Cache lookup failed for refresh token ${tokenId}: ${e.message}")
            }

            // Fall back to DB
            def token = RefreshToken.findByTokenId(tokenId)

            if (!token) {
                log.warn("Refresh token not found: ${tokenId}")
                return null
            }

            if (!token.isValid()) {
                log.warn("Refresh token is invalid: ${tokenId}")
                return null
            }

            return token
        } catch (Exception e) {
            log.error("Error finding refresh token: ${e.message}", e)
            return null
        }
    }

    /**
     * Rotate refresh token (create new, invalidate old)
     * Returns new refresh token or null if rotation fails
     */
    RefreshToken rotateRefreshToken(String oldTokenId, String newToken, String newTokenId, Date newExpiresAt, String ipAddress, String userAgent) {
        try {
            def oldToken = RefreshToken.findByTokenId(oldTokenId)

            if (!oldToken) {
                log.warn("Cannot rotate: old token not found ${oldTokenId}")
                return null
            }

            if (!oldToken.isValid()) {
                log.warn("Cannot rotate: old token is invalid ${oldTokenId}")
                return null
            }

            // Revoke old token
            oldToken.revokedAt = new Date()
            oldToken.save(flush: true)
            log.debug("Old refresh token revoked: ${oldTokenId}")

            // Create new token
            def hashedToken = hashToken(newToken)
            def newRefreshToken = new RefreshToken(
                tokenId: newTokenId,
                user: oldToken.user,
                token: hashedToken,
                expiresAt: newExpiresAt,
                createdAt: new Date(),
                revokedAt: null,
                ipAddress: ipAddress,
                userAgent: userAgent,
                rotationCount: oldToken.rotationCount + 1,
                parentTokenId: oldTokenId
            )

            if (!newRefreshToken.save(flush: true)) {
                log.error("Failed to save rotated refresh token: ${newRefreshToken.errors}")
                // Try to un-revoke the old token
                oldToken.revokedAt = null
                oldToken.save(flush: true)
                return null
            }

            // Invalidate old token in cache
            invalidateCache(oldTokenId)
            // Cache new token
            cacheRefreshToken(newTokenId, newRefreshToken)

            log.info("Refresh token rotated: ${oldTokenId} -> ${newTokenId}, rotation count: ${newRefreshToken.rotationCount}")
            return newRefreshToken
        } catch (Exception e) {
            log.error("Error rotating refresh token: ${e.message}", e)
            return null
        }
    }

    /**
     * Revoke/invalidate a refresh token
     */
    boolean revokeToken(String tokenId) {
        try {
            def token = RefreshToken.findByTokenId(tokenId)

            if (!token) {
                log.warn("Cannot revoke: token not found ${tokenId}")
                return false
            }

            token.revokedAt = new Date()
            token.save(flush: true)

            // Invalidate cache
            invalidateCache(tokenId)

            log.info("Refresh token revoked: ${tokenId}")
            return true
        } catch (Exception e) {
            log.error("Error revoking refresh token: ${e.message}", e)
            return false
        }
    }

    /**
     * Revoke all tokens for a user (logout)
     */
    int revokeAllTokensForUser(String userId) {
        try {
            def user = com.streamfit.user.User.findByUserId(userId)
            if (!user) return 0

            def tokens = RefreshToken.findAllByUserAndRevokedAtIsNull(user)
            int count = 0

            tokens.each { token ->
                token.revokedAt = new Date()
                token.save(flush: true)
                invalidateCache(token.tokenId)
                count++
            }

            log.info("Revoked ${count} refresh tokens for user ${userId}")
            return count
        } catch (Exception e) {
            log.error("Error revoking all tokens for user: ${e.message}", e)
            return 0
        }
    }

    /**
     * Delete expired tokens (cleanup)
     */
    int deleteExpiredTokens() {
        try {
            def expiredTokens = RefreshToken.findAllByExpiresAtLessThan(new Date())

            if (expiredTokens.isEmpty()) return 0

            expiredTokens.each { token ->
                invalidateCache(token.tokenId)
                token.delete()
            }

            log.info("Deleted ${expiredTokens.size()} expired refresh tokens")
            return expiredTokens.size()
        } catch (Exception e) {
            log.error("Error deleting expired tokens: ${e.message}", e)
            return 0
        }
    }

    /**
     * Invalidate token in cache
     */
    private void invalidateCache(String tokenId) {
        try {
            redisTemplate?.delete(getCacheKey(tokenId))
            log.debug("Cache invalidated for refresh token: ${tokenId}")
        } catch (Exception e) {
            log.warn("Failed to invalidate cache for refresh token: ${e.message}")
        }
    }

    /**
     * Clean up user cache when token is issued/refreshed
     */
    void invalidateUserCache(String userId) {
        try {
            redisTemplate?.delete("${CACHE_VERSION}:user:${userId}")
            redisTemplate?.delete("${CACHE_VERSION}:user:${userId}:stats")
            log.debug("User cache invalidated: ${userId}")
        } catch (Exception e) {
            log.warn("Failed to invalidate user cache: ${e.message}")
        }
    }
}


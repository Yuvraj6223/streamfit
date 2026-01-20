package com.streamfit.service

import com.streamfit.RefreshToken
import com.streamfit.user.User
import grails.gorm.transactions.Transactional
import groovy.json.JsonOutput
import org.springframework.beans.factory.annotation.Value
import org.springframework.data.redis.core.RedisTemplate
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer
import org.springframework.data.redis.serializer.StringRedisSerializer

import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import java.nio.charset.StandardCharsets
import java.util.Base64
import java.util.concurrent.TimeUnit

@Transactional
class RefreshTokenService {

    RedisTemplate<String, Object> redisTemplate

    @Value('${cache.ttl.refresh-token:604800}')  // 7 days
    private long refreshTokenTTL

    @Value('${jwt.secret:}')
    private String hmacSecret

    private static final String CACHE_VERSION = "v1"
    private static final String HMAC_ALGORITHM = "HmacSHA256"

    void init() {
        if (redisTemplate) {
            redisTemplate.setKeySerializer(new StringRedisSerializer())
            redisTemplate.setValueSerializer(new GenericJackson2JsonRedisSerializer())
        }
    }

    private String getCacheKey(String tokenId) {
        return "${CACHE_VERSION}:refresh:${tokenId}"
    }

    private String hashToken(String token) {
        try {
            if (!hmacSecret || hmacSecret.length() < 32) {
                throw new IllegalStateException(
                    "jwt.secret is not configured or is less than 32 characters long. " +
                    "This is required for HMAC hashing of refresh tokens."
                )
            }
            Mac mac = Mac.getInstance(HMAC_ALGORITHM)
            SecretKeySpec secretKeySpec = new SecretKeySpec(hmacSecret.getBytes(StandardCharsets.UTF_8), HMAC_ALGORITHM)
            mac.init(secretKeySpec)
            byte[] hashedBytes = mac.doFinal(token.getBytes(StandardCharsets.UTF_8))
            return Base64.getEncoder().encodeToString(hashedBytes)
        } catch (Exception e) {
            log.error("Error hashing refresh token: ${e.message}", e)
            throw new RuntimeException("Token hashing failed", e)
        }
    }

    RefreshToken saveRefreshToken(String tokenId, User user, String token, Date expiresAt, String ipAddress, String userAgent) {
        def hashedToken = hashToken(token)
        def refreshToken = new RefreshToken(
            tokenId: tokenId,
            user: user,
            token: hashedToken,
            expiresAt: expiresAt,
            createdAt: new Date(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            rotationCount: 0,
            parentTokenId: null
        )

        if (!refreshToken.save(flush: true)) {
            log.error("Failed to save refresh token: ${refreshToken.errors}")
            throw new RuntimeException("Failed to save refresh token")
        }

        cacheRefreshToken(tokenId, refreshToken)
        log.info("Refresh token saved: ${tokenId} for user ${user.userId}")
        return refreshToken
    }

    private void cacheRefreshToken(String tokenId, RefreshToken refreshToken) {
        try {
            def cacheData = [
                tokenId: refreshToken.tokenId,
                userId: refreshToken.user.userId,
                expiresAt: refreshToken.expiresAt.time,
                valid: true
            ]
            redisTemplate?.opsForValue()?.set(getCacheKey(tokenId), cacheData, refreshTokenTTL, TimeUnit.SECONDS)
            log.debug("Refresh token cached: ${tokenId}")
        } catch (Exception e) {
            log.warn("Failed to cache refresh token: ${e.message}")
        }
    }

    RefreshToken findValidToken(String tokenId) {
        try {
            def cached = redisTemplate?.opsForValue()?.get(getCacheKey(tokenId))
            if (cached instanceof Map && cached.valid && cached.expiresAt > System.currentTimeMillis()) {
                log.debug("Refresh token found in cache: ${tokenId}")
                return RefreshToken.findByTokenId(tokenId)
            }

            def token = RefreshToken.findByTokenId(tokenId)
            if (token && token.isValid()) {
                return token
            }

            log.warn("Refresh token is invalid or not found: ${tokenId}")
            return null
        } catch (Exception e) {
            log.error("Error finding refresh token: ${e.message}", e)
            return null
        }
    }

    RefreshToken rotateRefreshToken(String oldTokenId, String newToken, String newTokenId, Date newExpiresAt, String ipAddress, String userAgent) {
        def oldToken = RefreshToken.findByTokenId(oldTokenId)
        if (!oldToken || !oldToken.isValid()) {
            log.warn("Cannot rotate: old token is invalid or not found ${oldTokenId}")
            return null
        }

        oldToken.revokedAt = new Date()
        oldToken.save(flush: true)

        def newRefreshToken = new RefreshToken(
            tokenId: newTokenId,
            user: oldToken.user,
            token: hashToken(newToken),
            expiresAt: newExpiresAt,
            createdAt: new Date(),
            ipAddress: ipAddress,
            userAgent: userAgent,
            rotationCount: oldToken.rotationCount + 1,
            parentTokenId: oldTokenId
        )

        if (!newRefreshToken.save(flush: true)) {
            log.error("Failed to save rotated refresh token: ${newRefreshToken.errors}")
            oldToken.revokedAt = null
            oldToken.save(flush: true) // Rollback revocation
            return null
        }

        invalidateCache(oldTokenId)
        cacheRefreshToken( newTokenId, newRefreshToken)
        log.info("Refresh token rotated: ${oldTokenId} -> ${newTokenId}")
        return newRefreshToken
    }

    boolean revokeToken(String tokenId) {
        def token = RefreshToken.findByTokenId(tokenId)
        if (!token) {
            log.warn("Cannot revoke: token not found ${tokenId}")
            return false
        }

        token.revokedAt = new Date()
        token.save(flush: true)
        invalidateCache(tokenId)
        log.info("Refresh token revoked: ${tokenId}")
        return true
    }

    int revokeAllTokensForUser(String userId) {
        def user = User.findByUserId(userId)
        if (!user) return 0

        def tokensToRevoke = RefreshToken.findAllByUserAndRevokedAtIsNull(user)
        tokensToRevoke.each { invalidateCache(it.tokenId) }

        int count = RefreshToken.executeUpdate(
            "update RefreshToken r set r.revokedAt = :now where r.user = :user and r.revokedAt is null",
            [now: new Date(), user: user]
        )
        log.info("Revoked ${count} refresh tokens for user ${userId}")
        return count
    }

    int deleteExpiredTokens() {
        def expiredTokens = RefreshToken.findAllByExpiresAtLessThan(new Date())
        if (expiredTokens.isEmpty()) return 0

        expiredTokens.each { invalidateCache(it.tokenId) }

        int count = RefreshToken.executeUpdate(
            "delete from RefreshToken r where r.expiresAt < :now",
            [now: new Date()]
        )
        log.info("Deleted ${count} expired refresh tokens")
        return count
    }

    void invalidateUserCache(String userId) {
        try {
            redisTemplate?.delete("${CACHE_VERSION}:user:${userId}")
            redisTemplate?.delete("${CACHE_VERSION}:user:${userId}:stats")
            log.debug("User cache invalidated: ${userId}")
        } catch (Exception e) {
            log.warn("Failed to invalidate user cache: ${e.message}")
        }
    }

    private void invalidateCache(String tokenId) {
        try {
            redisTemplate?.delete(getCacheKey(tokenId))
            log.debug("Cache invalidated for refresh token: ${tokenId}")
        } catch (Exception e) {
            log.warn("Failed to invalidate cache for refresh token: ${e.message}")
        }
    }
}

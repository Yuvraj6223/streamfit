package com.streamfit.service

import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import io.jsonwebtoken.JwtException
import io.jsonwebtoken.Claims
import org.springframework.beans.factory.annotation.Value
import javax.crypto.SecretKey
import java.util.Date
import java.nio.charset.StandardCharsets

class JwtTokenService {

    // ...existing code...

    @Value('${jwt.secret:your-super-secret-key-change-this-in-production-at-least-32-characters}')
    private String jwtSecret

    @Value('${jwt.access-token-expiry:3600}')  // 1 hour in seconds
    private long accessTokenExpiry

    @Value('${jwt.refresh-token-expiry:604800}')  // 7 days in seconds
    private long refreshTokenExpiry

    /**
     * Get the signing key from secret
     */
    private SecretKey getSigningKey() {
        byte[] decodedKey = jwtSecret.getBytes(StandardCharsets.UTF_8)
        return Keys.hmacShaKeyFor(decodedKey)
    }

    /**
     * Generate Access Token (short-lived, 1 hour)
     * Payload: uid, sid, role, iat, exp
     *
     * @param userId User ID (null for guests)
     * @param sessionId Session ID
     * @param role "guest" or "user"
     * @return JWT token string
     */
    String generateAccessToken(String userId, String sessionId, String role = 'guest') {
        try {
            long now = System.currentTimeMillis()
            long expiryMs = accessTokenExpiry * 1000L

            def token = Jwts.builder()
                .subject(userId ?: 'guest')
                .claim('uid', userId)
                .claim('sid', sessionId)
                .claim('role', role)
                .issuedAt(new Date(now))
                .expiration(new Date(now + expiryMs))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact()

            log.debug("Access token generated for uid=${userId}, sid=${sessionId}, role=${role}")
            return token
        } catch (Exception e) {
            log.error("Error generating access token: ${e.message}", e)
            throw new RuntimeException("Failed to generate access token", e)
        }
    }

    /**
     * Generate Refresh Token (long-lived, 7 days)
     * Payload: uid, sid, role, iat, exp
     *
     * @param userId User ID (null for guests)
     * @param sessionId Session ID
     * @param role "guest" or "user"
     * @return JWT token string
     */
    String generateRefreshToken(String userId, String sessionId, String role = 'guest') {
        try {
            long now = System.currentTimeMillis()
            long expiryMs = refreshTokenExpiry * 1000L

            def token = Jwts.builder()
                .subject(userId ?: 'guest')
                .claim('uid', userId)
                .claim('sid', sessionId)
                .claim('role', role)
                .claim('type', 'refresh')  // Mark as refresh token
                .issuedAt(new Date(now))
                .expiration(new Date(now + expiryMs))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact()

            log.debug("Refresh token generated for uid=${userId}, sid=${sessionId}, role=${role}")
            return token
        } catch (Exception e) {
            log.error("Error generating refresh token: ${e.message}", e)
            throw new RuntimeException("Failed to generate refresh token", e)
        }
    }

    /**
     * Validate and extract claims from token
     *
     * @param token JWT token
     * @return Claims object or null if invalid
     */
    Claims validateToken(String token) {
        try {
            if (!token) {
                log.debug("Token is empty")
                return null
            }

            // Remove "Bearer " prefix if present
            token = token.startsWith('Bearer ') ? token.substring(7) : token

            def claims = Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .body

            log.debug("Token validated successfully for subject=${claims.subject}")
            return claims
        } catch (JwtException e) {
            log.warn("JWT validation failed: ${e.message}")
            return null
        } catch (Exception e) {
            log.error("Unexpected error validating token: ${e.message}", e)
            return null
        }
    }

    /**
     * Extract userId from token claims
     */
    String getUserIdFromToken(String token) {
        Claims claims = validateToken(token)
        return claims?.get('uid', String.class)
    }

    /**
     * Extract sessionId from token claims
     */
    String getSessionIdFromToken(String token) {
        Claims claims = validateToken(token)
        return claims?.get('sid', String.class)
    }

    /**
     * Extract role from token claims
     */
    String getRoleFromToken(String token) {
        Claims claims = validateToken(token)
        return claims?.get('role', String.class) ?: 'guest'
    }

    /**
     * Check if token is expired
     */
    boolean isTokenExpired(String token) {
        try {
            Claims claims = validateToken(token)
            if (!claims) return true
            return claims.expiration.before(new Date())
        } catch (Exception e) {
            return true
        }
    }

    /**
     * Get expiration time from token
     */
    Date getExpirationFromToken(String token) {
        Claims claims = validateToken(token)
        return claims?.expiration
    }

    /**
     * Generate both access and refresh tokens
     * Returns a map with both tokens
     */
    Map<String, Object> generateTokenPair(String userId, String sessionId, String role = 'guest') {
        return [
            accessToken: generateAccessToken(userId, sessionId, role),
            refreshToken: generateRefreshToken(userId, sessionId, role),
            expiresIn: accessTokenExpiry,
            tokenType: 'Bearer'
        ]
    }
}


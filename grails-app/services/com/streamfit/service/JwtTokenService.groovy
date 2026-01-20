package com.streamfit.service

import io.jsonwebtoken.Claims
import io.jsonwebtoken.JwtException
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm
import io.jsonwebtoken.security.Keys
import org.springframework.beans.factory.annotation.Value
import javax.crypto.SecretKey
import java.nio.charset.StandardCharsets
import java.security.SecureRandom
import java.util.Base64
import java.util.Date

class JwtTokenService {

    @Value('${jwt.secret:}')
    private String jwtSecret

    @Value('${jwt.access-token-expiry:3600}')  // 1 hour in seconds
    private long accessTokenExpiry

    private SecretKey signingKey

    private static final SecureRandom secureRandom = new SecureRandom()
    private static final Base64.Encoder base64Encoder = Base64.getUrlEncoder()

    private SecretKey getSigningKey() {
        if (signingKey == null) {
            if (!jwtSecret || jwtSecret.length() < 32) {
                throw new IllegalStateException(
                    "jwt.secret is not configured or is less than 32 characters long in application.yml. " +
                    "This is a critical security vulnerability. Please provide a strong, random secret."
                )
            }
            byte[] decodedKey = jwtSecret.getBytes(StandardCharsets.UTF_8)
            this.signingKey = Keys.hmacShaKeyFor(decodedKey)
        }
        return signingKey
    }

    String generateAccessToken(String userId, String sessionId, String role = 'guest') {
        long now = System.currentTimeMillis()
        long expiryMs = accessTokenExpiry * 1000L

        def claims = Jwts.claims()
            .subject(userId ?: 'guest')
            .add('uid', userId)
            .add('sid', sessionId)
            .add('role', role)
            .issuedAt(new Date(now))
            .expiration(new Date(now + expiryMs))
            .build()

        return buildAndSignJwt(claims)
    }

    String generateRefreshToken() {
        byte[] randomBytes = new byte[32]
        secureRandom.nextBytes(randomBytes)
        return base64Encoder.encodeToString(randomBytes)
    }

    Map<String, Object> generateTokenPair(String userId, String sessionId, String role = 'guest') {
        return [
            accessToken: generateAccessToken(userId, sessionId, role),
            refreshToken: generateRefreshToken(),
            expiresIn: accessTokenExpiry,
            tokenType: 'Bearer'
        ]
    }

    Claims validateToken(String token) {
        try {
            if (!token) {
                log.debug("Token is empty")
                return null
            }

            token = token.startsWith('Bearer ') ? token.substring(7) : token

            return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .body
        } catch (JwtException e) {
            log.warn("JWT validation failed: ${e.message}")
            return null
        } catch (Exception e) {
            log.error("Unexpected error validating token: ${e.message}", e)
            return null
        }
    }

    String getUserIdFromClaims(Claims claims) {
        return claims?.get('uid', String.class)
    }

    String getSessionIdFromClaims(Claims claims) {
        return claims?.get('sid', String.class)
    }

    String getRoleFromClaims(Claims claims) {
        return claims?.get('role', String.class) ?: 'guest'
    }

    Date getExpirationFromClaims(Claims claims) {
        return claims?.expiration
    }

    boolean isTokenExpired(Claims claims) {
        return claims?.expiration?.before(new Date()) ?: true
    }

    private String buildAndSignJwt(Claims claims) {
        try {
            return Jwts.builder()
                .claims(claims)
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact()
        } catch (Exception e) {
            log.error("Error building and signing JWT: ${e.message}", e)
            throw new RuntimeException("Failed to build and sign JWT", e)
        }
    }
}

package com.project.back_end.services;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.Instant;
import java.util.Date;
import java.util.Optional;

@Service
public class TokenService {

    private final String secret;
    private final Duration expiration;

    public TokenService(
            @Value("${app.jwt.secret:}") String secret,
            @Value("${app.jwt.expiration-minutes:120}") long expirationMinutes
    ) {
        this.secret = secret == null ? "" : secret.trim();
        this.expiration = Duration.ofMinutes(expirationMinutes);
    }

    /**
     * Requisito do assignment: gerar JWT usando o email do usuário.
     */
    public String generateToken(String email) {
        return Jwts.builder()
                .subject(email)
                .issuedAt(Date.from(Instant.now()))
                .expiration(Date.from(Instant.now().plus(expiration)))
                .signWith(getSigningKey())
                .compact();
    }

    public String generateToken(String email, String role, Long userId) {
        return Jwts.builder()
                .subject(email)
                .claim("role", role)
                .claim("userId", userId)
                .issuedAt(Date.from(Instant.now()))
                .expiration(Date.from(Instant.now().plus(expiration)))
                .signWith(getSigningKey())
                .compact();
    }

    /**
     * Requisito do assignment: retornar a signing key usando o secret configurado.
     */
    public SecretKey getSigningKey() {
        if (secret.isBlank()) {
            throw new IllegalStateException("APP_JWT_SECRET não configurado.");
        }
        byte[] keyBytes = secret.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    public Optional<Claims> parseClaims(String token) {
        try {
            Claims claims = Jwts.parser()
                    .verifyWith(getSigningKey())
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();
            return Optional.of(claims);
        } catch (Exception ex) {
            return Optional.empty();
        }
    }
}



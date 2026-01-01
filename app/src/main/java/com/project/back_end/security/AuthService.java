package com.project.back_end.security;

import com.project.back_end.services.TokenService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Optional;

@Service
public class AuthService {

    private final TokenService tokenService;

    public AuthService(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    public Optional<AuthPrincipal> authenticate(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || authHeader.isBlank() || !authHeader.startsWith("Bearer ")) {
            return Optional.empty();
        }

        String token = authHeader.substring("Bearer ".length()).trim();
        Optional<Claims> claimsOpt = tokenService.parseClaims(token);
        if (claimsOpt.isEmpty()) {
            return Optional.empty();
        }

        Claims claims = claimsOpt.get();
        String email = claims.getSubject();
        String role = claims.get("role", String.class);
        Long userId = claims.get("userId", Long.class);
        return Optional.of(new AuthPrincipal(email, role, userId));
    }

    public Optional<AuthPrincipal> requireRole(HttpServletRequest request, String... allowedRoles) {
        Optional<AuthPrincipal> principalOpt = authenticate(request);
        if (principalOpt.isEmpty()) {
            return Optional.empty();
        }
        AuthPrincipal principal = principalOpt.get();
        if (principal.getRole() == null) {
            return Optional.empty();
        }
        boolean ok = Arrays.stream(allowedRoles).anyMatch(r -> r.equalsIgnoreCase(principal.getRole()));
        return ok ? Optional.of(principal) : Optional.empty();
    }
}



package com.project.back_end.security;

public class AuthPrincipal {
    private final String email;
    private final String role;
    private final Long userId;

    public AuthPrincipal(String email, String role, Long userId) {
        this.email = email;
        this.role = role;
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public String getRole() {
        return role;
    }

    public Long getUserId() {
        return userId;
    }
}



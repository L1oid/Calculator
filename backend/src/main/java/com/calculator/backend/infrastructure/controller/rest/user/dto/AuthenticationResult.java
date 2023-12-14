package com.calculator.backend.infrastructure.controller.rest.user.dto;


public class AuthenticationResult {
    private final String token;
    private final String email;
    private final String avatar;

    public AuthenticationResult(String token, String email, String avatar) {
        this.token = token;
        this.email = email;
        this.avatar = avatar;
    }

    public String getToken() {
        return token;
    }

    public String getEmail() {
        return email;
    }

    public String getAvatar() {
        return avatar;
    }
}
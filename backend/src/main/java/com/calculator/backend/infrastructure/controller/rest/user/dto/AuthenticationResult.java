package com.calculator.backend.infrastructure.controller.rest.user.dto;


public class AuthenticationResult {
    private final String token;
    private final String email;

    public AuthenticationResult(String token, String email) {
        this.token = token;
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public String getEmail() {
        return email;
    }
}
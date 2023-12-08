package com.calculator.backend.application.auth.service.impl.dto;

import com.calculator.backend.application.auth.service.status.UserStatus;

public class UserCheckResult {
    private final UserStatus status;
    private final String email;

    public UserCheckResult(UserStatus status, String email) {
        this.status = status;
        this.email = email;
    }

    public UserStatus getStatus() {
        return status;
    }

    public String getEmail() {
        return email;
    }
}
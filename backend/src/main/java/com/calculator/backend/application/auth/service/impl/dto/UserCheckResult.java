package com.calculator.backend.application.auth.service.impl.dto;

import com.calculator.backend.application.auth.service.status.UserStatus;

public class UserCheckResult {
    private final UserStatus status;
    private final String email;
    private final String avatar;

    public UserCheckResult(UserStatus status, String email, String avatar) {
        this.status = status;
        this.email = email;
        this.avatar = avatar;
    }

    public UserStatus getStatus() {
        return status;
    }

    public String getEmail() {
        return email;
    }

    public String getAvatar() {
        return avatar;
    }
}
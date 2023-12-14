package com.calculator.backend.application.auth.service.impl.dto;

import com.calculator.backend.application.auth.service.status.UserStatus;

public class UserCheckResult {
    private final UserStatus status;
    private final String email;
    private final byte[] avatar;

    public UserCheckResult(UserStatus status, String email, byte[] avatar) {
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

    public byte[] getAvatar() {
        return avatar;
    }
}
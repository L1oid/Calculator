package com.calculator.backend.application.auth.service.status;

public enum UserStatus {
    USER_ALREADY_EXISTS(1),
    EMAIL_ALREADY_EXISTS(2),
    SUCCESSFUL_REGISTRATION(3),
    USER_NOT_FOUND(4),
    INCORRECT_PASSWORD(5),
    SUCCESSFUL_AUTHENTICATION(6),
    SUCCESSFUL_CHANGE_PASSWORD(7),
    ERROR(0);

    private final int code;

    UserStatus(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
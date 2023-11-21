package pack.application.auth.service.status;

public enum UserAddStatus {
    USER_ALREADY_EXISTS(1),
    EMAIL_ALREADY_EXISTS(2),
    SUCCESSFUL_REGISTRATION(3),
    ERROR(0);

    private final int code;

    UserAddStatus(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
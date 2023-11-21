package pack.application.auth.service.status;

public enum UserCheckStatus {
    USER_NOT_FOUND(1),
    INCORRECT_PASSWORD(2),
    SUCCESSFUL_AUTHENTICATION(3),
    ERROR(0);

    private final int code;

    UserCheckStatus(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
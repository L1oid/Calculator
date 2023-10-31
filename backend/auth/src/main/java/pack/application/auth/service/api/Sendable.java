package pack.application.auth.service.api;

public interface Sendable {
    void sendCheckUser(Boolean status);
    void sendAddUser(Boolean status);
    void sendCheckToken(Boolean status);
    void sendCreateToken(String token);
}
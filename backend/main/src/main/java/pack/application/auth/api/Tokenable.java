package pack.application.auth.api;

public interface Tokenable {
    String getToken(String login);
    Boolean checkToken(String login, String token);
}
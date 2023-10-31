package pack.application.auth.service.api;

public interface UserRepositable {
    Boolean checkUser(String login, String password) throws Exception;
    Boolean addUser(String login, String password, String email) throws Exception;
}
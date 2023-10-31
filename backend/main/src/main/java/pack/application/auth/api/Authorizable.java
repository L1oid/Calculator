package pack.application.auth.api;

import pack.application.auth.impl.dto.User;

public interface Authorizable {
    Boolean checkUser(String login, String password);
    Boolean addUser(String login, String password, String email);
}
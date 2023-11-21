package pack.application.auth.service.api;

import pack.application.auth.service.status.UserAddStatus;
import pack.application.auth.service.status.UserCheckStatus;

public interface UserRepositable {
    UserCheckStatus checkUser(String login, String password) throws Exception;
    UserAddStatus addUser(String login, String password, String email) throws Exception;
}
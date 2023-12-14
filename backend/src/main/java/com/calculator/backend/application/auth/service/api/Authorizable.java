package com.calculator.backend.application.auth.service.api;

import com.calculator.backend.application.auth.service.impl.dto.User;
import com.calculator.backend.application.auth.service.impl.dto.UserCheckResult;
import com.calculator.backend.application.auth.service.status.UserStatus;

public interface Authorizable {
    void injectRepository(UserRepositable repository);
    void injectToken(Tokenable useToken);
    UserStatus changePassword(User user) throws Exception;
    UserStatus deleteAccount(String login) throws Exception;
    UserCheckResult checkUser(User user) throws Exception;
    UserStatus addUser(User user) throws Exception;
    String uploadAvatar(String login, String avatar) throws Exception;
    String createToken(User user);
    Boolean checkToken(User user, String token);
}
package com.calculator.backend.application.auth.service.api;

import com.calculator.backend.application.auth.service.impl.dto.User;
import com.calculator.backend.application.auth.service.status.UserAddStatus;
import com.calculator.backend.application.auth.service.status.UserCheckStatus;

public interface Authorizable {
    void injectRepository(UserRepositable repository);
    void injectToken(Tokenable useToken);
    UserCheckStatus checkUser(User user) throws Exception;
    UserAddStatus addUser(User user) throws Exception;
    String createToken(User user);
    Boolean checkToken(User user, String token);
}
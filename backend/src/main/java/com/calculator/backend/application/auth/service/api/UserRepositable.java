package com.calculator.backend.application.auth.service.api;

import com.calculator.backend.application.auth.service.status.UserAddStatus;
import com.calculator.backend.application.auth.service.status.UserCheckStatus;

public interface UserRepositable {
    UserCheckStatus checkUser(String login, String password) throws Exception;
    UserAddStatus addUser(String login, String password, String email) throws Exception;
}
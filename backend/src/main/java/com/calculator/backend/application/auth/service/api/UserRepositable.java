package com.calculator.backend.application.auth.service.api;

import com.calculator.backend.application.auth.service.impl.dto.UserCheckResult;
import com.calculator.backend.application.auth.service.status.UserStatus;

public interface UserRepositable {
    UserCheckResult checkUser(String login, String password) throws Exception;
    UserStatus addUser(String login, String password, String email) throws Exception;
    UserStatus changePassword(String login, String password, String newPassword) throws Exception;
    UserStatus deleteAccount(String login) throws Exception;
}
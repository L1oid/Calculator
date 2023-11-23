package com.calculator.backend.application.auth.service.api;

import com.calculator.backend.application.auth.service.impl.dto.User;

public interface Tokenable {
    String createToken(User user);
    boolean checkToken(User user, String token);
}
package com.calculator.backend.application.auth.token;

import java.security.Key;
import com.calculator.backend.application.auth.service.api.Tokenable;
import com.calculator.backend.application.auth.service.impl.dto.User;

public class Token implements Tokenable {

    private static final TokenKey tokenKey = new TokenKey();
    private static final Key key = tokenKey.getKey();
    
    @Override
    public String createToken(User user) {
        TokenIssuer tokenIssuer = new TokenIssuer(key);
        return tokenIssuer.issueToken(user.getLogin());
    }

    @Override
    public boolean checkToken(User user, String token) {
        TokenValidator tokenValidator = new TokenValidator(key);
        return user.getLogin().equals(tokenValidator.validate(token));
    }
}
package com.calculator.backend.application.auth.service.impl;

import com.calculator.backend.application.auth.service.api.Authorizable;
import com.calculator.backend.application.auth.service.api.Tokenable;
import com.calculator.backend.application.auth.service.api.UserRepositable;
import com.calculator.backend.application.auth.service.impl.dto.User;
import com.calculator.backend.application.auth.service.impl.dto.UserCheckResult;
import com.calculator.backend.application.auth.service.status.UserStatus;

public class Auth implements Authorizable {

    private UserRepositable repository;
    private Tokenable useToken;

    @Override
    public void injectRepository(UserRepositable repository) {
        this.repository = repository;
    } 

    @Override
    public void injectToken(Tokenable useToken) {
        this.useToken = useToken;
    }

    @Override
    public UserStatus changePassword(User user) throws Exception {
        return repository.changePassword(user.getLogin(), user.getPassword(), user.getNewPassword());
    }

    @Override
    public UserStatus deleteAccount(String login) throws Exception {
        return repository.deleteAccount(login);
    }

    @Override
    public UserCheckResult checkUser(User user) throws Exception {
        return repository.checkUser(user.getLogin(), user.getPassword());
    }

    @Override
    public UserStatus addUser(User user) throws Exception {
        return repository.addUser(user.getLogin(), user.getPassword(), user.getEmail());
    }

    @Override
    public String uploadAvatar(String login, String avatar) throws Exception {
        return repository.uploadAvatar(login, avatar);
    }

    @Override
    public String createToken(User user) {
        return useToken.createToken(user);
    }

    @Override
    public Boolean checkToken(User user, String token) {
        return useToken.checkToken(user, token);
    }
}
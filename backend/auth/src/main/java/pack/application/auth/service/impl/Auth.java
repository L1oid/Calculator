package pack.application.auth.service.impl;

import pack.application.auth.service.api.Authorizable;
import pack.application.auth.service.api.Tokenable;
import pack.application.auth.service.api.Sendable;
import pack.application.auth.service.api.UserRepositable;
import pack.application.auth.service.impl.dto.User;

public class Auth implements Authorizable {

    private UserRepositable repository;
    private Tokenable useToken;
    private Sendable sender;

    @Override
    public void injectRepository(UserRepositable repository) {
        this.repository = repository;
    } 

    @Override
    public void injectToken(Tokenable useToken) {
        this.useToken = useToken;
    }

    @Override
    public void injectSender(Sendable sender) {
        this.sender = sender;
    }

    @Override
    public void checkUser(User user) throws Exception {
        Boolean status = repository.checkUser(user.getLogin(), user.getPassword());
        sender.sendCheckUser(status);
    }

    @Override
    public void addUser(User user) throws Exception {
        Boolean status = repository.addUser(user.getLogin(), user.getPassword(), user.getEmail());
        sender.sendAddUser(status);
    }

    @Override
    public void createToken(User user) {
        String token = useToken.createToken(user);
        sender.sendCreateToken(token);
    }

    @Override
    public void checkToken(User user, String token) {
        Boolean status = useToken.checkToken(user, token);
        sender.sendCheckToken(status);
    }
}
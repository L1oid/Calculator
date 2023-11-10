package pack.application.auth.service.impl;

import pack.application.auth.service.api.Authorizable;
import pack.application.auth.service.api.Tokenable;
import pack.application.auth.service.api.UserRepositable;
import pack.application.auth.service.impl.dto.User;

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
    public Boolean checkUser(User user) throws Exception {
        Boolean status = repository.checkUser(user.getLogin(), user.getPassword());
        return status;
    }

    @Override
    public Boolean addUser(User user) throws Exception {
        Boolean status = repository.addUser(user.getLogin(), user.getPassword(), user.getEmail());
        return status;
    }

    @Override
    public String createToken(User user) {
        String token = useToken.createToken(user);
        return token;
    }

    @Override
    public Boolean checkToken(User user, String token) {
        Boolean status = useToken.checkToken(user, token);
        return status;
    }
}
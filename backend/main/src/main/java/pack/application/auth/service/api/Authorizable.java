package pack.application.auth.service.api;

import pack.application.auth.service.impl.dto.User;

public interface Authorizable {
    void injectRepository(UserRepositable repository);
    void injectToken(Tokenable useToken);
    Boolean checkUser(User user) throws Exception;
    Boolean addUser(User user) throws Exception;
    String createToken(User user);
    Boolean checkToken(User user, String token);
}
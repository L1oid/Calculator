package pack.application.auth.service.api;

import pack.application.auth.service.impl.dto.User;

public interface Authorizable {
    void injectRepository(UserRepositable repository);
    void injectToken(Tokenable useToken);
    void injectSender(Sendable sender);
    void checkUser(User user) throws Exception;;
    void addUser(User user) throws Exception;;
    void createToken(User user);
    void checkToken(User user, String token);
}
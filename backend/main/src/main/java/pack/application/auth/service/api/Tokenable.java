package pack.application.auth.service.api;

import pack.application.auth.service.impl.dto.User;

public interface Tokenable {
    String createToken(User user);
    boolean checkToken(User user, String token);
}
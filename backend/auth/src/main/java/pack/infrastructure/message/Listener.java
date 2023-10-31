package pack.infrastructure.message;

import jakarta.ejb.MessageDriven;
import jakarta.inject.Inject;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;

import pack.application.auth.service.api.Authorizable;
import pack.application.auth.service.impl.dto.User;
import pack.infrastructure.builder.Built;

@MessageDriven(mappedName = "jms/AuthQueue")
public class Listener implements MessageListener {

    @Inject @Built
    private Authorizable model;

    @Override
    public void onMessage(Message message) {
        try {
            String type = message.getJMSType();
            switch (type) {
                case "checkUser":
                    {
                        String login = message.getStringProperty("login");
                        String password = message.getStringProperty("password");
                        User user = new User();
                        user.setLogin(login);
                        user.setPassword(password);
                        model.checkUser(user);
                        break;
                    }
                    
                case "addUser":
                    {
                        String login = message.getStringProperty("login");
                        String password = message.getStringProperty("password");
                        String email = message.getStringProperty("email");
                        User user = new User();
                        user.setLogin(login);
                        user.setPassword(password);
                        user.setEmail(email);
                        model.addUser(user);
                        break;
                    }
                case "getToken":
                    {
                        String login = message.getStringProperty("login");
                        User user = new User();
                        user.setLogin(login);
                        model.createToken(user);
                        break;
                    }
                case "checkToken":
                    {
                        String login = message.getStringProperty("login");
                        String token = message.getStringProperty("token");
                        User user = new User();
                        user.setLogin(login);
                        model.checkToken(user, token);
                        break;
                    }
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();;
        }
    }
}
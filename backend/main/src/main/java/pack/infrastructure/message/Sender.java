package pack.infrastructure.message;

import jakarta.annotation.Resource;
import jakarta.jms.ConnectionFactory;
import jakarta.jms.JMSConsumer;
import jakarta.jms.JMSContext;
import jakarta.jms.JMSProducer;
import jakarta.jms.Message;
import jakarta.jms.Queue;

import pack.application.auth.api.Authorizable;
import pack.application.auth.api.Tokenable;
import pack.application.auth.impl.dto.User;

public class Sender implements Authorizable, Tokenable {
    @Resource(mappedName = "jms/NewAuthFactory")    
    private ConnectionFactory connectionFactory;

    @Resource(mappedName = "jms/AuthQueue")
    private Queue queueAuth;

    @Resource(mappedName = "jms/Auth2Queue")
    private Queue queueAuth2;

    public Boolean checkUser(String login, String password) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();     
            JMSConsumer consumer = context.createConsumer(queueAuth2);       
            Message message = context.createMessage();
            message.setJMSType("checkUser");
            message.setStringProperty("login", login);
            message.setStringProperty("password", password);
            producer.send(queueAuth, message);
            Message newMessage = consumer.receive(); 
            Boolean status = newMessage.getBooleanProperty("status");
            context.close();
            return status;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addUser(String login, String password, String email) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();     
            JMSConsumer consumer = context.createConsumer(queueAuth2);       
            Message message = context.createMessage();
            message.setJMSType("addUser");
            message.setStringProperty("login", login);
            message.setStringProperty("password", password);
            message.setStringProperty("email", email);
            producer.send(queueAuth, message);
            Message newMessage = consumer.receive();
            Boolean status = newMessage.getBooleanProperty("status");
            context.close();
            return status;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String getToken(String login) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();     
            JMSConsumer consumer = context.createConsumer(queueAuth2);       
            Message message = context.createMessage();
            message.setJMSType("getToken");
            message.setStringProperty("login", login);
            producer.send(queueAuth, message);
            Message newMessage = consumer.receive(); 
            String token = newMessage.getStringProperty("token");
            context.close();
            return token;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Boolean checkToken(String login, String token) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();     
            JMSConsumer consumer = context.createConsumer(queueAuth2);       
            Message message = context.createMessage();
            message.setJMSType("checkToken");
            message.setStringProperty("login", login);
            message.setStringProperty("token", token);
            producer.send(queueAuth, message);
            Message newMessage = consumer.receive(); 
            Boolean status = newMessage.getBooleanProperty("status");
            context.close();
            return status;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
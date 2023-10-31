package pack.infrastructure.message;

import jakarta.annotation.Resource;
import jakarta.jms.ConnectionFactory;
import jakarta.jms.JMSContext;
import jakarta.jms.JMSProducer;
import jakarta.jms.Message;
import jakarta.jms.Queue;

import pack.application.auth.service.api.Sendable;

public class Sender implements Sendable {
    
    @Resource(mappedName = "jms/NewAuthFactory")    
    private ConnectionFactory connectionFactory;

    @Resource(mappedName = "jms/AuthQueue")
    private Queue queueAuth;

    @Resource(mappedName = "jms/Auth2Queue")
    private Queue queueAuth2;

    @Override
    public void sendCheckUser(Boolean status) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();
            Message message = context.createMessage();
            message.setJMSType("checkUserResult");
            message.setBooleanProperty("status", status);
            producer.send(queueAuth2, message);
            context.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void sendAddUser(Boolean status) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();
            Message message = context.createMessage();
            message.setJMSType("addUserResult");
            message.setBooleanProperty("status", status);
            producer.send(queueAuth2, message);
            context.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void sendCheckToken(Boolean status) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();
            Message message = context.createMessage();
            message.setJMSType("checkTokenResult");
            message.setBooleanProperty("status", status);
            producer.send(queueAuth2, message);
            context.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void sendCreateToken(String token) {
        try {
            JMSContext context = connectionFactory.createContext();
            JMSProducer producer = context.createProducer();
            Message message = context.createMessage();
            message.setJMSType("createTokenResult");
            message.setStringProperty("token", token);
            producer.send(queueAuth2, message);
            context.close();
        } catch(Exception e){
            e.printStackTrace();
        }
    }
}
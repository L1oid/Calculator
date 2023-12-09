package com.calculator.backend.application.chat.api;

import com.calculator.backend.application.chat.impl.dto.Message;

public interface MessageSendable {
    Message getUserMessage(String text, String username);
    Message getHelloMessage(String username);
    Message getGoodbyeMessage(String username);
}
package com.calculator.backend.application.chat.api;

import com.calculator.backend.application.chat.impl.dto.Message;

public interface Sendable {
    void injectChat(Chatable chat);
    void broadcast(Message message);
}
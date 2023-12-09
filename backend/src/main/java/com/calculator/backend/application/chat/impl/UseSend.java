package com.calculator.backend.application.chat.impl;

import com.calculator.backend.application.chat.impl.dto.Message;
import com.calculator.backend.application.chat.api.Sendable;
import com.calculator.backend.application.chat.api.Chatable;

public class UseSend implements Sendable {

    private Chatable chat;

    @Override
    public void injectChat(Chatable chat) {
        this.chat = chat;
    }

    @Override
    public void broadcast(Message message) {
        chat.broadcast(message);
    }
}
package com.calculator.backend.infrastructure.builder.chat;

import com.calculator.backend.infrastructure.builder.Built;
import com.calculator.backend.application.chat.api.Sendable;
import com.calculator.backend.application.chat.api.Chatable;

import jakarta.inject.Inject;
import jakarta.enterprise.inject.Produces;
import jakarta.enterprise.inject.Default;

public class ChatBuilder {

    @Inject @Default
    private Sendable send;

    @Inject @Default
    private Chatable chat;

    @Produces @Built
    public Sendable buildChat() {
        send.injectChat(chat);
        return send;
    }
}
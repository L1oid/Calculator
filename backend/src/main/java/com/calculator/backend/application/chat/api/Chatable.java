package com.calculator.backend.application.chat.api;

import com.calculator.backend.application.chat.impl.dto.Message;

public interface Chatable {
    void broadcast(Message message);
}
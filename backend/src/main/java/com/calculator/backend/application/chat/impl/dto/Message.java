package com.calculator.backend.application.chat.impl.dto;

public class Message {
    private String username;
    private String text;

    public void setText(String text) {
        this.text = text;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getText() {
        return text;
    }

    public String getUsername() {
        return username;
    }
}
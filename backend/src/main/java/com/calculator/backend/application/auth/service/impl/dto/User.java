package com.calculator.backend.application.auth.service.impl.dto;

public class User {
    private String login;
    private String password;
    private String newPassword;
    private String email;
    private String avatar;

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String Login) {
        this.login = Login;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
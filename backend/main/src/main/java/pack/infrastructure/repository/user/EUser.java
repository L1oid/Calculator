package pack.infrastructure.repository.user;

import java.io.Serializable;

import jakarta.persistence.*;

@Entity
@Table(name = "\"users\"")
public class EUser implements Serializable {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "\"id\"")
    private int userId;

    @Column(name = "\"login\"")
    private String login;

    @Column(name = "\"password\"")
    private String password;

    @Column(name = "\"email\"")
    private String email;

    protected EUser() {}
    
    public EUser(String login, String password, String email) {
        this.login = login;
        this.email = email;
        this.password = password;
    }
    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
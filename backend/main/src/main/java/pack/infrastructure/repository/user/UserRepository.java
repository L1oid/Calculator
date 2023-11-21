package pack.infrastructure.repository.user;

import java.util.List;
import java.util.logging.Logger;

import jakarta.persistence.*;
import jakarta.transaction.*;

import pack.application.auth.service.api.UserRepositable;
import pack.application.auth.service.status.UserAddStatus;
import pack.application.auth.service.status.UserCheckStatus;

public class UserRepository implements UserRepositable {

    private static final Logger logger = Logger.getLogger(UserRepository.class.getName());

    @PersistenceUnit(unitName = "test-resource_PersistenceUnit")
    private EntityManagerFactory entityManagerFactory;

    @Override
    public UserCheckStatus checkUser(String login, String password) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
            List<EUser> users = query.setParameter("login", login).getResultList();

            if (!users.isEmpty()) {
                if (users.get(0).getPassword().equals(password)) {
                    return UserCheckStatus.SUCCESSFUL_AUTHENTICATION;
                } else {
                    return UserCheckStatus.INCORRECT_PASSWORD;
                }
            } else {
                return UserCheckStatus.USER_NOT_FOUND;
            }
        } catch (Exception ex) {
            logger.severe("Error while checking user: " + ex.getMessage());
            return UserCheckStatus.ERROR;
        }
    }

    @Override
    public UserAddStatus addUser(String login, String password, String email) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            EntityTransaction transaction = entityManager.getTransaction();

            try {
                transaction.begin();

                TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
                List<EUser> users = query.setParameter("login", login).getResultList();

                if (!users.isEmpty()) {
                    return UserAddStatus.USER_ALREADY_EXISTS;
                }

                query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.email = :email", EUser.class);
                users = query.setParameter("email", email).getResultList();

                if (!users.isEmpty()) {
                    return UserAddStatus.EMAIL_ALREADY_EXISTS;
                }

                EUser newUser = new EUser(login, password, email);
                entityManager.persist(newUser);
                transaction.commit();

                logger.info("User successfully registered: " + login);
                return UserAddStatus.SUCCESSFUL_REGISTRATION;
            } catch (Exception ex) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                logger.severe("Error while adding user: " + ex.getMessage());
                return UserAddStatus.ERROR;
            }
        }
    }
}
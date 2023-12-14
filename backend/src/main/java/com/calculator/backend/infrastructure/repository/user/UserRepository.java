package com.calculator.backend.infrastructure.repository.user;

import java.util.List;
import java.util.logging.Logger;

import jakarta.persistence.*;

import com.calculator.backend.application.auth.service.api.UserRepositable;
import com.calculator.backend.application.auth.service.status.UserStatus;
import com.calculator.backend.application.auth.service.impl.dto.UserCheckResult;

public class UserRepository implements UserRepositable {

    private static final Logger logger = Logger.getLogger(UserRepository.class.getName());

    @PersistenceUnit(unitName = "test-resource_PersistenceUnit")
    private EntityManagerFactory entityManagerFactory;

    @Override
    public UserCheckResult checkUser(String login, String password) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
            List<EUser> users = query.setParameter("login", login).getResultList();

            if (!users.isEmpty()) {
                if (users.get(0).getPassword().equals(password)) {
                    String email = users.get(0).getEmail();
                    return new UserCheckResult(UserStatus.SUCCESSFUL_AUTHENTICATION, email);
                } else {
                    return new UserCheckResult(UserStatus.INCORRECT_PASSWORD, null);
                }
            } else {
                return new UserCheckResult(UserStatus.USER_NOT_FOUND, null);
            }
        } catch (Exception ex) {
            logger.severe("Error while checking user: " + ex.getMessage());
            return new UserCheckResult(UserStatus.ERROR, null);
        }
    }

    @Override
    public UserStatus changePassword(String login, String password, String newPassword) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            EntityTransaction transaction = entityManager.getTransaction();

            try {

                TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
                List<EUser> users = query.setParameter("login", login).getResultList();

                if (!users.isEmpty()) {
                    EUser user = users.get(0);
                    if (user.getPassword().equals(password)) {
                        transaction.begin();
                        user.setPassword(newPassword);
                        transaction.commit();
                        return UserStatus.SUCCESSFUL_CHANGE_PASSWORD;
                    } else {
                        return UserStatus.INCORRECT_PASSWORD;
                    }
                } else {
                    return UserStatus.USER_NOT_FOUND;
                }
            } catch (Exception ex) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                logger.severe("Error while checking user: " + ex.getMessage());
                return UserStatus.ERROR;
            }
        }
    }

    @Override
    public UserStatus deleteAccount(String login) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            EntityTransaction transaction = entityManager.getTransaction();

            try {

                TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
                List<EUser> users = query.setParameter("login", login).getResultList();

                if (!users.isEmpty()) {
                    EUser user = users.get(0);
                    transaction.begin();
                    entityManager.remove(user);
                    transaction.commit();
                    return UserStatus.SUCCESSFUL_DELETE_ACCOUNT;
                } else {
                    return UserStatus.USER_NOT_FOUND;
                }
            } catch (Exception ex) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                logger.severe("Error while checking user: " + ex.getMessage());
                return UserStatus.ERROR;
            }
        }
    }

    @Override
    public String uploadAvatar(String login, String avatar) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            EntityTransaction transaction = entityManager.getTransaction();

            try {
                TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
                List<EUser> users = query.setParameter("login", login).getResultList();

                if (!users.isEmpty()) {
                    EUser user = users.get(0);
                    transaction.begin();
                    user.setAvatar(avatar);
                    transaction.commit();
                    return avatar;
                } else {
                    return "";
                }
            } catch (Exception ex) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                logger.severe("Error while checking user: " + ex.getMessage());
                return "";
            }
        }
    }

    @Override
    public UserStatus addUser(String login, String password, String email) throws Exception {
        try (EntityManager entityManager = entityManagerFactory.createEntityManager()) {
            EntityTransaction transaction = entityManager.getTransaction();

            try {
                transaction.begin();

                TypedQuery<EUser> query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.login = :login", EUser.class);
                List<EUser> users = query.setParameter("login", login).getResultList();

                if (!users.isEmpty()) {
                    return UserStatus.USER_ALREADY_EXISTS;
                }

                query = entityManager.createQuery("SELECT u FROM EUser u WHERE u.email = :email", EUser.class);
                users = query.setParameter("email", email).getResultList();

                if (!users.isEmpty()) {
                    return UserStatus.EMAIL_ALREADY_EXISTS;
                }

                EUser newUser = new EUser(login, password, email, "");
                entityManager.persist(newUser);
                transaction.commit();

                logger.info("User successfully registered: " + login);
                return UserStatus.SUCCESSFUL_REGISTRATION;
            } catch (Exception ex) {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                logger.severe("Error while adding user: " + ex.getMessage());
                return UserStatus.ERROR;
            }
        }
    }
}
package com.calculator.backend.infrastructure.controller.rest.user;

import java.util.logging.Logger;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import jakarta.json.bind.Jsonb;
import jakarta.json.bind.JsonbBuilder;
import jakarta.json.bind.JsonbException;
import jakarta.inject.Inject;

import com.calculator.backend.application.auth.service.impl.dto.User;
import com.calculator.backend.application.auth.service.impl.dto.UserCheckResult;
import com.calculator.backend.application.auth.service.api.Authorizable;
import com.calculator.backend.application.auth.service.api.Tokenable;
import com.calculator.backend.application.auth.service.status.UserStatus;
import com.calculator.backend.infrastructure.interceptor.TokenRequired;
import com.calculator.backend.infrastructure.builder.Built;
import com.calculator.backend.infrastructure.controller.rest.user.dto.AuthenticationResult;

@Path("/users")
public class UserController {

    @Inject @Built
    Authorizable model;

    @Inject
    Tokenable tokenable;

    private static final Jsonb jsonb = JsonbBuilder.create();
    private static final Logger logger = Logger.getLogger(UserController.class.getName());

    @POST
    @Path("/authenticate")
    @Consumes("application/json")
    @Produces("application/json")
    public Response authenticateUser(String userJson) {
        try {
            User user = jsonb.fromJson(userJson, User.class);
            UserCheckResult result = model.checkUser(user);
            UserStatus status = result.getStatus();
            AuthenticationResult authenticationResult;

            switch (status) {
                case SUCCESSFUL_AUTHENTICATION:
                    String token = tokenable.createToken(user);
                    String email = result.getEmail();
                    authenticationResult = new AuthenticationResult(token, email);
                    return Response.ok(jsonb.toJson(authenticationResult)).build();
                case INCORRECT_PASSWORD:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("IncorrectPassword")).build();
                case USER_NOT_FOUND:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("UserNotFound")).build();
                default:
                    return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(jsonb.toJson("Unavailable DataBase Connection")).build();
            }
        } catch (JsonbException e) {
            return handleJsonbException(e);
        } catch (Exception e) {
            return handleException(e);
        }
    }

    @POST
    @Path("/register")
    @Consumes("application/json")
    @Produces("application/json")
    public Response registerUser(String userJson) {
        try {
            User user = jsonb.fromJson(userJson, User.class);
            UserStatus status = model.addUser(user);

            switch (status) {
                case SUCCESSFUL_REGISTRATION:
                    return Response.ok(jsonb.toJson("UserCreated")).build();
                case USER_ALREADY_EXISTS:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("UserAlreadyExist")).build();
                case EMAIL_ALREADY_EXISTS:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("EmailAlreadyExist")).build();
                default:
                    return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(jsonb.toJson("Unavailable DataBase Connection")).build();
            }
        } catch (JsonbException e) {
            return handleJsonbException(e);
        } catch (Exception e) {
            return handleException(e);
        }
    }

    @POST
    @TokenRequired
    @Path("/change_password")
    @Consumes("application/json")
    @Produces("application/json")
    public Response changePassword(@HeaderParam("login") String login, @HeaderParam("token") String token, String passwordJson) {
        try {
            User user = jsonb.fromJson(passwordJson, User.class);
            UserStatus status = model.changePassword(user);

            switch (status) {
                case SUCCESSFUL_CHANGE_PASSWORD:
                    return Response.ok(jsonb.toJson("SuccessChangePassword")).build();
                case INCORRECT_PASSWORD:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("IncorrectPassword")).build();
                case USER_NOT_FOUND:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("UserNotFound")).build();
                default:
                    return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(jsonb.toJson("Unavailable DataBase Connection")).build();
            }
        } catch (JsonbException e) {
            return handleJsonbException(e);
        } catch (Exception e) {
            return handleException(e);
        }
    }

    @DELETE
    @TokenRequired
    @Path("/delete")
    @Consumes("application/json")
    @Produces("application/json")
    public Response deleteAccount(@HeaderParam("login") String login, @HeaderParam("token") String token) {
        try {
            UserStatus status = model.deleteAccount(login);
            switch (status) {
                case SUCCESSFUL_DELETE_ACCOUNT:
                    return Response.ok(jsonb.toJson("SuccessDeleteAccount")).build();
                case USER_NOT_FOUND:
                    return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("UserNotFound")).build();
                default:
                    return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(jsonb.toJson("Unavailable DataBase Connection")).build();
            }
        } catch (JsonbException e) {
            return handleJsonbException(e);
        } catch (Exception e) {
            return handleException(e);
        }
    }

    private Response handleJsonbException(JsonbException e) {
        logger.severe("JsonbException: " + e.getMessage());
        return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();
    }

    private Response handleException(Exception e) {
        logger.severe("Error: " + e.getMessage());
        return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();
    }
}

package pack.infrastructure.controller.rest.user;

import java.util.logging.Logger;
import java.util.logging.Level;

import jakarta.ws.rs.Path;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.core.Response;
import jakarta.json.bind.Jsonb;
import jakarta.json.bind.JsonbBuilder;
import jakarta.json.bind.JsonbException;
import jakarta.inject.Inject;

import pack.application.auth.service.impl.dto.User;
import pack.application.auth.service.api.Authorizable;
import pack.application.auth.service.api.Tokenable;
import pack.application.auth.service.status.UserAddStatus;
import pack.application.auth.service.status.UserCheckStatus;
import pack.infrastructure.builder.Built;

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
            UserCheckStatus status = model.checkUser(user);

            switch (status) {
                case SUCCESSFUL_AUTHENTICATION:
                    String token = tokenable.createToken(user);
                    return Response.ok(jsonb.toJson(token)).build();
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
            UserAddStatus status = model.addUser(user);

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

    private Response handleJsonbException(JsonbException e) {
        logger.severe("JsonbException: " + e.getMessage());
        return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();
    }

    private Response handleException(Exception e) {
        logger.severe("Error: " + e.getMessage());
        return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();
    }
}

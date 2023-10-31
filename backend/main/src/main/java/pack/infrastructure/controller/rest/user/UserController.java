package pack.infrastructure.controller.rest.user;

import jakarta.ws.rs.Path;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.core.Response;
import jakarta.json.bind.Jsonb;
import jakarta.json.bind.JsonbBuilder;
import jakarta.json.bind.JsonbException;
import jakarta.inject.Inject;

import pack.application.auth.impl.dto.User;
import pack.application.auth.api.Authorizable;
import pack.application.auth.api.Tokenable;

@Path("/users")
public class UserController {
    @Inject
    Authorizable model;

    @Inject
    Tokenable tokenable;

    @POST
    @Path("/auth")
    @Consumes("application/json")
    @Produces("application/json")
    public Response authUser(String userJson) {
        User user;
        Jsonb jsonb = JsonbBuilder.create();
        try {
            user = jsonb.fromJson(userJson, new User(){}.getClass().getGenericSuperclass());
            Boolean usrTrue = model.checkUser(user.getLogin(), user.getPassword());
            if (usrTrue == null) {
                return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(jsonb.toJson("Unavailable DataBase Connection")).build();
            } else if (usrTrue == true) {
                String token = tokenable.getToken(user.getLogin());
                return Response.ok(jsonb.toJson(token)).build();
            } else return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("UserNotFound")).build();
        } catch (JsonbException e) {
            return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();	             
        } catch (Exception e) {
            return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();	             
        }    
    }
    
    @POST
    @Path("/register")
    @Consumes("application/json")
    @Produces("application/json")
    public Response createUser(String User) {
        Jsonb jsonb = JsonbBuilder.create();             
        User newUser;
        try {  
            newUser = jsonb.fromJson(User,new User(){}.getClass().getGenericSuperclass());    
            Boolean userCreated = model.addUser(newUser.getLogin(), newUser.getPassword(), newUser.getEmail());
            if (userCreated == null) {
                return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(jsonb.toJson("Unavailable DataBase Connection")).build();
            } else if (userCreated == false) {
                return Response.status(Response.Status.UNAUTHORIZED).entity(jsonb.toJson("UserAlreadyExist")).build();
            } else return Response.ok(jsonb.toJson("userCreated")).build();
        } catch (JsonbException e) {
            return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();	             
        } catch (Exception e) {
            return Response.status(Response.Status.BAD_REQUEST).entity(jsonb.toJson(e.getMessage())).build();	             
        }    
    }
}
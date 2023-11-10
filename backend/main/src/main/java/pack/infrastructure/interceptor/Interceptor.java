package pack.infrastructure.interceptor;

import java.io.IOException;
import jakarta.inject.Inject;
import jakarta.ws.rs.NotAuthorizedException;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerRequestFilter;
import jakarta.ws.rs.core.Response;
import jakarta.json.bind.Jsonb;
import jakarta.json.bind.JsonbBuilder;
import jakarta.ws.rs.ext.Provider;
import jakarta.ws.rs.core.MediaType;

import pack.application.auth.service.api.Authorizable;
import pack.application.auth.service.api.Tokenable;
import pack.application.auth.service.impl.dto.User;

@Provider
@TokenRequired
public class Interceptor implements ContainerRequestFilter {

    @Inject
    private Tokenable useToken;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        String login = requestContext.getHeaderString("login");
        String token = requestContext.getHeaderString("token");
        Jsonb jsonb = JsonbBuilder.create();

        User user = new User();
        user.setLogin(login);

        if (login == null | token == null) requestContext.abortWith(
            Response.status(Response.Status.UNAUTHORIZED)
            .type(MediaType.APPLICATION_JSON)
            .entity(jsonb.toJson("Authorization Token Required"))
            .build()
        );

        if (!useToken.checkToken(user, token)) requestContext.abortWith(
            Response.status(Response.Status.UNAUTHORIZED)
            .type(MediaType.APPLICATION_JSON)
            .entity(jsonb.toJson("Authorization Token Expired"))
            .build()
        );
    } 
}
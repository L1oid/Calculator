package pack.infrastructure.builder.user;

import pack.infrastructure.builder.Built;
import pack.application.auth.service.api.Authorizable;
import pack.application.auth.service.api.UserRepositable;
import pack.application.auth.service.api.Tokenable;

import jakarta.inject.Inject;
import jakarta.enterprise.inject.Produces;
import jakarta.enterprise.inject.Default;

public class UserBuilder { 

    @Inject @Default
    private Authorizable model;

    @Inject @Default
    private UserRepositable repository;

    @Inject @Default
    private Tokenable useToken;

    @Produces @Built
    public Authorizable buildModel() {
	   model.injectRepository(repository);
       model.injectToken(useToken);
       return model;
    } 
}
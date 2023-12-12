import '/state/actions/user_actions.dart';

String errorChangePasswordReducer(String errorChangePassword, dynamic action) {
  if (action is ChangePasswordMessageAction) {
    return action.errorChangePassword;
  } else if (action is LogoutAction) {
    errorChangePassword = "";
  }
  return errorChangePassword;
}

String successChangePasswordReducer(String successChangePassword, dynamic action) {
  if (action is ChangePasswordMessageAction) {
    return action.successChangePassword;
  } else if (action is LogoutAction) {
    successChangePassword = "";
  }
  return successChangePassword;
}

String usernameReducer(String username, dynamic action) {
  if (action is UsernameSaveAction) {
    return action.username;
  } else if (action is LogoutAction) {
    username = "";
  }
  return username;
}

String emailReducer(String email, dynamic action) {
  if (action is EmailSaveAction) {
    return action.email;
  } else if (action is LogoutAction) {
    email = "";
  }
  return email;
}

String authTokenReducer(String authToken, dynamic action) {
  if (action is AuthMessageAction) {
    return action.token;
  } else if (action is LogoutAction) {
    authToken = "";
  }
  return authToken;
}

String authErrorReducer(String authError, dynamic action) {
  if (action is AuthMessageAction) {
    return action.authError;
  } else if (action is LogoutAction) {
    authError = "";
  }
  return authError;
}

String regErrorReducer(String regError, dynamic action) {
  if (action is RegMessageAction) {
    return action.regError;
  } else if (action is LogoutAction) {
    regError = "";
  }
  return regError;
}

String regSuccessReducer(String regSuccess, dynamic action) {
  if (action is RegMessageAction) {
    return action.regSuccess;
  } else if (action is LogoutAction) {
    regSuccess = "";
  }
  return regSuccess;
}
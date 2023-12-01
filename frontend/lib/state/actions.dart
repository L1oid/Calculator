class LogoutAction {}

class ClearSymbolAction {}

class ClearExpressionAction {}

class CalculateAction {}

class AddSymbolAction {
  final String symbol;

  AddSymbolAction(this.symbol);
}

class SlaeResultAction {
  final List<List<double>> slaeMatrix;

  SlaeResultAction(this.slaeMatrix);
}

class AuthRequestAction {
  final String username;
  final String password;

  AuthRequestAction(this.username, this.password);
}

class AuthSuccessAction {
  final String token;

  AuthSuccessAction(this.token);
}

class AuthFailureAction {
  final String authError;

  AuthFailureAction(this.authError);
}

class RegRequestAction {
  final String username;
  final String password;
  final String email;

  RegRequestAction(this.username, this.password, this.email);
}

class RegFailureAction {
  final String regError;

  RegFailureAction(this.regError);
}

class RegSuccessAction {
  final String regSuccess;

  RegSuccessAction(this.regSuccess);
}
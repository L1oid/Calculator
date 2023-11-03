class AddSymbolAction {
  final String symbol;

  AddSymbolAction(this.symbol);
}

class ClearSymbolAction {}

class ClearExpressionAction {}

class CalculateAction {}

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
  final String error;

  AuthFailureAction(this.error);
}
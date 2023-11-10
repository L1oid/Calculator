class AppState {
  final String expression;
  final bool isAuthenticated;
  final String authToken;
  final String authError;

  AppState(this.expression, this.isAuthenticated, this.authToken, this.authError);
}
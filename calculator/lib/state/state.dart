class AppState {
  final String expression;
  final String authToken;
  final String authError;
  final String regError;
  final String regSuccess;

  AppState(this.expression, this.authToken, this.authError, this.regError, this.regSuccess);
}
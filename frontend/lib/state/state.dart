class AppState {
  final String expression;
  final String slaeResult;

  final String username;
  final String email;

  final String successChangePassword;
  final String errorChangePassword;

  final String authToken;
  final String authError;

  final String regError;
  final String regSuccess;

  final List<Map<String, String>> messages;

  AppState(this.expression,
      this.authToken,
      this.authError,
      this.regError,
      this.regSuccess,
      this.slaeResult,
      this.username,
      this.email,
      this.successChangePassword,
      this.errorChangePassword,
      this.messages);
}
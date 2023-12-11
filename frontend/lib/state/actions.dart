class ConnectWebSocketAction {}

class ReceiveMessageAction {
  final String message;

  ReceiveMessageAction(this.message);
}

class SendMessageAction {
  final String text;

  SendMessageAction(this.text);
}

class CloseWebSocketAction {}

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

class RegRequestAction {
  final String username;
  final String password;
  final String email;

  RegRequestAction(this.username, this.password, this.email);
}

class UsernameSaveAction {
  final String username;

  UsernameSaveAction(this.username);
}

class EmailSaveAction {
  final String email;

  EmailSaveAction(this.email);
}

class ChangePasswordAction {
  final String currentPassword;
  final String newPassword;
  final String repeatPassword;

  ChangePasswordAction(this.currentPassword,
      this.newPassword,
      this.repeatPassword);
}

class ChangePasswordMessageAction {
  final String errorChangePassword;
  final String successChangePassword;

  ChangePasswordMessageAction(this.errorChangePassword,
      this.successChangePassword);
}

class RegMessageAction {
  final String regError;
  final String regSuccess;

  RegMessageAction(this.regError, this.regSuccess);
}

class AuthMessageAction {
  final String authError;
  final String token;

  AuthMessageAction(this.authError, this.token);
}
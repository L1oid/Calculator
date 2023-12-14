import 'dart:typed_data';

class LogoutAction {}
class DeleteAccountAction {}

class UploadUserAvatarAction {
  final Uint8List? avatarImage;

  UploadUserAvatarAction(this.avatarImage);
}

class AvatarSaveAction {
  final Uint8List? avatarImage;

  AvatarSaveAction(this.avatarImage);
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

class TokenSaveAction {
  final String token;

  TokenSaveAction(this.token);
}

class AuthMessageAction {
  final String authError;

  AuthMessageAction(this.authError);
}
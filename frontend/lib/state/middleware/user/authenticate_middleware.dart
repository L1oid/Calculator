import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

Middleware<AppState> authenticate() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AuthRequestAction) {
      Map<String, String> requestBody = {
        'login': action.username,
        'password': action.password
      };

      final response = await http.post(
        Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/authenticate'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'];
        final email = data['email'];
        final avatar = base64Decode(data['avatar']);

        store.dispatch(TokenSaveAction(token));
        store.dispatch(UsernameSaveAction(action.username));
        store.dispatch(EmailSaveAction(email));
        if (avatar.isEmpty) {
          store.dispatch(AvatarSaveAction(null));
        } else {
          store.dispatch(AvatarSaveAction(avatar));
        }
      } else if (response.statusCode == 401) {
        final errorMessage = json.decode(response.body);
        if (errorMessage == "UserNotFound") {
          store.dispatch(AuthMessageAction("Такого пользователя не существует"));
        } else if (errorMessage == "IncorrectPassword") {
          store.dispatch(AuthMessageAction("Неверный пароль"));
        }
      } else {
        store.dispatch(AuthMessageAction("Неизвестная ошибка"));
      }
    }
    next(action);
  };
}
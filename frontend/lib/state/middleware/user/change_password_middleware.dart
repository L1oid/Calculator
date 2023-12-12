import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

Middleware<AppState> changePassword() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is ChangePasswordAction) {
      if (action.newPassword != action.repeatPassword) {
        store.dispatch(ChangePasswordMessageAction("Введённые пароли не совпадают", ""));
      } else {
        Map<String, String> requestBody = {
          'login': store.state.username,
          'password': action.currentPassword,
          'newPassword': action.newPassword
        };

        final response = await http.post(
          Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/change_password'),
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
            'login' : store.state.username,
            'token' : store.state.authToken
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          store.dispatch(ChangePasswordMessageAction("", "Пароль успешно изменён"));
        } else if (response.statusCode == 401) {
          final errorMessage = json.decode(response.body);
          if (errorMessage == "IncorrectPassword") {
            store.dispatch(ChangePasswordMessageAction("Текущий пароль введён неверно", ""));
          } else {
            store.dispatch(LogoutAction());
            store.dispatch(AuthMessageAction("Ошибка авторизации", ""));
          }
        } else {
          store.dispatch(ChangePasswordMessageAction("Неизвестная ошибка", ""));
        }
      }
    }
    next(action);
  };
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

Middleware<AppState> registration() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is RegRequestAction) {
      Map<String, String> requestBody = {
        'login': action.username,
        'password': action.password,
        'email' : action.email
      };

      final response = await http.post(
        Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/register'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        store.dispatch(RegMessageAction("", "Вы успешно зарегестрировались. Вернитесь на экран авторизации."));
      } else if (response.statusCode == 401) {
        final errorMessage = json.decode(response.body);
        if (errorMessage == "UserAlreadyExist") {
          store.dispatch(RegMessageAction("Такой пользователь уже существует", ""));
        } else if (errorMessage == "EmailAlreadyExist") {
          store.dispatch(RegMessageAction("Почта занята", ""));
        }
      } else {
        store.dispatch(RegMessageAction("Неизвестная ошибка", ""));
      }
    }
    next(action);
  };
}
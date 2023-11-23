import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'state.dart';
import 'actions.dart';

Middleware<AppState> authMiddleware() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AuthRequestAction) {
      try {
        Map<String, String> requestBody = {
          'login': action.username,
          'password': action.password
        };

        final response = await http.post(
          Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/authenticate'),
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
          },
          body: jsonEncode(requestBody),
        );

        final errorMessage = json.decode(response.body);

        if (response.statusCode == 200) {
          final token = json.decode(response.body);
          store.dispatch(AuthSuccessAction(token));
        } else if (response.statusCode == 401) {
          if (errorMessage == "UserNotFound") {
            store.dispatch(AuthFailureAction("Такого пользователя не существует"));
          } else if (errorMessage == "IncorrectPassword") {
            store.dispatch(AuthFailureAction("Неверный пароль"));
          } else {
            store.dispatch(AuthFailureAction("Неизвестная ошибка"));
          }
        } else {
          store.dispatch(AuthFailureAction("Неизвестная ошибка"));
        }
      } catch (error) {
        store.dispatch(AuthFailureAction("Неизвестная ошибка"));
      }
    }
    next(action);
  };
}

Middleware<AppState> regMiddleware() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is RegRequestAction) {
      try {
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

        final errorMessage = json.decode(response.body);

        if (response.statusCode == 200) {
          store.dispatch(RegFailureAction(""));
          store.dispatch(RegSuccessAction("Вы успешно зарегестрировались. Вернитесь на экран авторизации."));
        } else if (response.statusCode == 401) {
          store.dispatch(RegSuccessAction(""));
          if (errorMessage == "UserAlreadyExist") {
            store.dispatch(RegFailureAction("Такой пользователь уже существует"));
          } else if (errorMessage == "EmailAlreadyExist") {
            store.dispatch(RegFailureAction("Почта занята"));
          } else {
            store.dispatch(RegFailureAction("Неизвестная ошибка"));
          }
        } else {
          store.dispatch(RegFailureAction("Неизвестная ошибка"));
        }
      } catch (error) {
        store.dispatch(RegFailureAction("Неизвестная ошибка"));
      }
    }
    next(action);
  };
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'state.dart';
import 'actions.dart';

Middleware<AppState> userMiddleware() {
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

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final token = data['token'];
          final email = data['email'];

          store.dispatch(AuthFailureAction(""));
          store.dispatch(AuthSuccessAction(token));
          store.dispatch(UsernameSaveAction(action.username));
          store.dispatch(EmailSaveAction(email));
        } else if (response.statusCode == 401) {
          final errorMessage = json.decode(response.body);
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

    } else if (action is RegRequestAction) {
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

        if (response.statusCode == 200) {
          store.dispatch(RegFailureAction(""));
          store.dispatch(RegSuccessAction("Вы успешно зарегестрировались. Вернитесь на экран авторизации."));
        } else if (response.statusCode == 401) {
          final errorMessage = json.decode(response.body);
          store.dispatch(RegSuccessAction(""));
          if (errorMessage == "UserAlreadyExist") {
            store.dispatch(RegFailureAction("Такой пользователь уже существует"));
          } else if (errorMessage == "EmailAlreadyExist") {
            store.dispatch(RegFailureAction("Почта занята"));
          } else {
            store.dispatch(RegFailureAction("Неизвестная ошибка"));
          }
        } else {
          store.dispatch(RegSuccessAction(""));
          store.dispatch(RegFailureAction("Неизвестная ошибка"));
        }
      } catch (error) {
        store.dispatch(RegSuccessAction(""));
        store.dispatch(RegFailureAction("Неизвестная ошибка"));
      }

    } else if (action is ChangePasswordAction) {
      if (action.newPassword != action.repeatPassword) {
        store.dispatch(ChangePasswordMessageAction("Введённые пароли не совпадают", ""));
      } else {
        try {
          Map<String, String> requestBody = {
            'login': store.state.username,
            'password': action.currentPassword,
            'newPassword': action.newPassword
          };

          final response = await http.post(
            Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/change_password'),
            headers: {
              'Content-Type': 'application/json;charset=utf-8',
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
              store.dispatch(ChangePasswordMessageAction("Неизвестная ошибка", ""));
            }
          } else {
            store.dispatch(ChangePasswordMessageAction("Неизвестная ошибка", ""));
          }
        } catch (error) {
          store.dispatch(ChangePasswordMessageAction("Неизвестная ошибка", ""));
        }
      }
    }
    next(action);
  };
}
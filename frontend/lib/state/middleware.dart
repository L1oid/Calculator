import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
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
            'Content-Type': 'application/json;charset=utf-8'
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final token = data['token'];
          final email = data['email'];

          store.dispatch(AuthMessageAction("", token));
          store.dispatch(UsernameSaveAction(action.username));
          store.dispatch(EmailSaveAction(email));
        } else if (response.statusCode == 401) {
          final errorMessage = json.decode(response.body);
          if (errorMessage == "UserNotFound") {
            store.dispatch(AuthMessageAction("Такого пользователя не существует", ""));
          } else if (errorMessage == "IncorrectPassword") {
            store.dispatch(AuthMessageAction("Неверный пароль", ""));
          }
        } else {
          store.dispatch(AuthMessageAction("Неизвестная ошибка", ""));
        }
      } catch (error) {
        store.dispatch(AuthMessageAction("Неизвестная ошибка", ""));
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
      } catch (error) {
        store.dispatch(RegMessageAction("Неизвестная ошибка", ""));
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
              'token' : store.state.authToken,
              'login' : store.state.username
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

Middleware<AppState> chatMiddleware() {
  WebSocketChannel? channel;

  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is ConnectWebSocketAction) {
      channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/backend-1.0-SNAPSHOT/chat/${store.state.username}'));
      channel?.stream.listen((message) {
        store.dispatch(ReceiveMessageAction(message));
      });
    } else if (action is SendMessageAction) {
      Map<String, String> message = {'text': action.text};
      channel!.sink.add(jsonEncode(message));
    } else if (action is CloseWebSocketAction) {
      channel?.sink.close();
    }
    next(action);
  };
}
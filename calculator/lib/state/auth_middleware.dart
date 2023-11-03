import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'app_state.dart';
import 'reducers.dart';

Middleware<AppState> createAuthMiddleware() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AuthRequestAction) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/server/api/users/auth'),
          body: {
            'login': action.username,
            'password': action.password,
            'email': "",
          },
        );
        print(action.username);
        print(action.password);
        if (response.statusCode == 200) {
          print("middleware: успешно");
          final jsonData = json.decode(response.body);
          final token = jsonData['token'];
          store.dispatch(AuthSuccessAction(token));
        } else {
          print("middleware: ошибка");
          final jsonData = json.decode(response.body);
          final errorMessage = jsonData['message'];
          store.dispatch(AuthFailureAction(errorMessage));
        }
      } catch (error) {
        store.dispatch(AuthFailureAction('Failed to authenticate'));
      }
    }

    next(action);
  };
}

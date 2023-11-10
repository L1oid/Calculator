import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'app_state.dart';
import 'actions.dart';

Middleware<AppState> createAuthMiddleware() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is AuthRequestAction) {
      try {
        Map<String, String> requestBody = {
          'login': action.username,
          'password': action.password
        };

        final response = await http.post(
          Uri.parse('http://localhost:8080/server/api/users/auth'),
          headers: {
            'Content-Type': 'application/json;charset=utf-8',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final token = json.decode(response.body);
          store.dispatch(AuthSuccessAction(token));
        } else {
          final errorMessage = json.decode(response.body);
          store.dispatch(AuthFailureAction(errorMessage));
        }
      } catch (error) {
        store.dispatch(AuthFailureAction('Failed to authenticate'));
      }
    }

    next(action);
  };
}

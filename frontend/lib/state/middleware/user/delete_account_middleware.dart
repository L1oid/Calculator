import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

Middleware<AppState> deleteAccount() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is DeleteAccountAction) {
      String login = store.state.username;

      final response = await http.delete(
        Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/delete'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'token' : store.state.authToken,
          'login' : login
        }
      );

      if (response.statusCode == 200) {
        store.dispatch(LogoutAction());
      } else {
        store.dispatch(LogoutAction());
        store.dispatch(AuthMessageAction("Ошибка авторизации"));
      }
    }
    next(action);
  };
}
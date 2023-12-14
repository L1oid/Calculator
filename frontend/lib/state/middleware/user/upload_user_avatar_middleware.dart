import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

Middleware<AppState> uploadUserAvatar() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is UploadUserAvatarAction) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/upload_user_avatar'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'login' : store.state.username,
          'token' : store.state.authToken
        },
        body: jsonEncode({'avatar': base64Encode(action.avatarImage as List<int>)})
      );

      if (response.statusCode == 200) {
        store.dispatch(AvatarSaveAction(base64Decode(response.body)));
      } else if (response.statusCode == 401) {
        store.dispatch(LogoutAction());
        store.dispatch(AuthMessageAction("Ошибка авторизации"));
      } else {
        store.dispatch(AvatarSaveAction(store.state.avatarImage));
      }
    }
    next(action);
  };
}
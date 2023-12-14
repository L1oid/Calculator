import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

Middleware<AppState> uploadUserData() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is UploadUserDataAction) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/backend-1.0-SNAPSHOT/api/users/upload_user_data'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'login' : store.state.username,
          'token' : store.state.authToken
        },
        body: {
          'file': base64Encode(action.avatarImage as List<int>)
        },
      );

      if (response.statusCode == 200) {
        List<int> fileBytes = response.bodyBytes;
        Uint8List storedFile = Uint8List.fromList(fileBytes);
        store.dispatch(AddStoreUserDataAction(storedFile));
      } else if (response.statusCode == 401) {

      } else {

      }
    }
    next(action);
  };
}
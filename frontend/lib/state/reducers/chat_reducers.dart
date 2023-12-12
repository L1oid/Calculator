import 'dart:convert';
import '/state/actions/chat_actions.dart';
import '/state/actions/user_actions.dart';

List<Map<String, String>> sendChatMessageReducer(List<Map<String, String>> messages, dynamic action) {
  if (action is ReceiveMessageAction) {
    Map<String, String> decodedMessage = Map<String, String>.from(
        jsonDecode(action.message));
    return List.from(messages)
      ..add(decodedMessage);
  } else if (action is LogoutAction) {
    return List.from(messages)
      ..clear();
  } else {
    return messages;
  }
}
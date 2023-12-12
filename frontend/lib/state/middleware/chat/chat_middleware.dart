import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '/state/state.dart';
import '/state/actions/chat_actions.dart';

Middleware<AppState> chat() {
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
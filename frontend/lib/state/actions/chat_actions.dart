class ConnectWebSocketAction {}

class ReceiveMessageAction {
  final String message;

  ReceiveMessageAction(this.message);
}

class SendMessageAction {
  final String text;

  SendMessageAction(this.text);
}

class CloseWebSocketAction {}
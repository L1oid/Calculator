import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/actions/chat_actions.dart';
import '/state/state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late Store<AppState> store;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      store = StoreProvider.of<AppState>(context);
      store.dispatch(ConnectWebSocketAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Map<String, String>>>(
        converter: (store) => store.state.messages,
        builder: (context, messages) {
          final TextEditingController messageController = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Чат'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      return ListTile(
                        title: Text(message['username'] ?? ''),
                        subtitle: Text(message['text'] ?? ''),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Введите сообщение',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          store.dispatch(SendMessageAction(messageController.text));
                          messageController.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    store.dispatch(CloseWebSocketAction());
    super.dispose();
  }
}
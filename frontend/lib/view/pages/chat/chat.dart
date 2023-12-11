import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../../state/actions.dart';
import '../../../state/state.dart';

class ChatScreen extends StatefulWidget {
  final String login;

  const ChatScreen({super.key, required this.login});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  late Store<AppState> store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = StoreProvider.of<AppState>(context);
    store.dispatch(ConnectWebSocketAction());
  }

  void sendMessage(String text) {
    store.dispatch(SendMessageAction(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: store.state.messages.length,
              itemBuilder: (context, index) {
                var message = store.state.messages[index];
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

  @override
  void dispose() {
    store.dispatch(CloseWebSocketAction());
    super.dispose();
  }
}
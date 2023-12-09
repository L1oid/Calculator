import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final String login;

  const ChatScreen({super.key, required this.login});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/backend-1.0-SNAPSHOT/chat/${widget.login}'));
    channel.stream.listen((message) {
      getMessage(message);
    });
  }

  void getMessage(String message) {
    Map<String, String> decodedMessage = Map<String, String>.from(jsonDecode(message));
    setState(() {
      messages.add(decodedMessage);
    });
  }

  void sendMessage(String text) {
    Map<String, String> message = {'text': text};
    channel.sink.add(jsonEncode(message));
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
                      hintText: 'Введите сообщение',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(messageController.text);
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
    channel.sink.close();
    super.dispose();
  }
}
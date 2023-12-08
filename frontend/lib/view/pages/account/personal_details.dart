import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Мои данные'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Text("Имя пользователя: ${store.state.username}", style: const TextStyle(fontSize: 24.0)),
                const SizedBox(height: 16.0),
                Text("Почта: ${store.state.email}", style: const TextStyle(fontSize: 24.0)),
              ],
            ),
          ),
        );
      },
    );
  }
}
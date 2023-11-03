import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../state/app_state.dart';
import '../../state/reducers.dart';

class LoginScreen extends StatelessWidget {
  final Store<AppState> store;

  const LoginScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Логин',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                const username = "user";
                const password = "12345";
                store.dispatch(AuthRequestAction(username, password));
              },
              child: const Text('Войти'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {

              },
              child: const Text('Регистрация'),
            ),
          ],
        ),
      ),
    );
  }
}
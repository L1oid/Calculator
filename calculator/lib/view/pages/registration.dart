import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../state/state.dart';
import '../../state/actions.dart';
import '/view/widgets/drawer.dart';

class RegMessageData {
  final String regError;
  final String regSuccess;

  RegMessageData({required this.regError, required this.regSuccess});
}

class RegistrationScreen extends StatelessWidget {
  final Store<AppState> store;

  RegistrationScreen({Key? key, required this.store}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RegMessageData>(
        converter: (store) {
          return RegMessageData(
            regError: store.state.regError,
            regSuccess: store.state.regSuccess,
          );
        },
        builder: (context, messageData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Регистрация'),
            ),
            drawer: AppDrawer(store: store),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Логин',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Пароль',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Почта',
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      final email = emailController.text;
                      store.dispatch(RegRequestAction(username, password, email));
                    },
                    child: const Text('Создать аккаунт'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    messageData.regError,
                    style: const TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                  Text(
                    messageData.regSuccess,
                    style: const TextStyle(fontSize: 16.0, color: Colors.green),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
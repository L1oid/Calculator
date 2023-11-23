import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../state/state.dart';
import '../../state/actions.dart';
import 'registration.dart';
import '/view/widgets/drawer.dart';

class LoginScreen extends StatelessWidget {
  final Store<AppState> store;

  LoginScreen({Key? key, required this.store}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
        converter: (store) => store.state.authError,
        builder: (context, authError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Авторизация'),
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
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      store.dispatch(AuthRequestAction(username, password));
                    },
                    child: const Text('Войти'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegistrationScreen(store: store)),
                      );
                    },
                    child: const Text('Регистрация'),
                  ),
                  Text(
                    authError,
                    style: const TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
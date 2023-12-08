import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/state/actions.dart';
import '/view/widgets/drawer.dart';
import 'registration.dart';
import 'account.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        final TextEditingController usernameController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();


        if (store.state.authToken != '') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AccountScreen()),
            );
          });
          return const SizedBox.shrink();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Вход'),
            ),
            drawer: const AppDrawer(),
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
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                      );
                    },
                    child: const Text('Регистрация'),
                  ),
                  Text(
                    store.state.authError,
                    style: const TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/state/actions.dart';
import '/view/widgets/drawer.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        final TextEditingController usernameController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();
        final TextEditingController emailController = TextEditingController();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Регистрация'),
          ),
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
                  store.state.regError,
                  style: const TextStyle(fontSize: 16.0, color: Colors.red),
                ),
                Text(
                  store.state.regSuccess,
                  style: const TextStyle(fontSize: 16.0, color: Colors.green),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

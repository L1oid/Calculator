import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions.dart';
import '/view/pages/account/account.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {
        final TextEditingController usernameController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();

        if (vm.authToken == '') {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Вход'),
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
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      vm.authRequest(username, password);

                    },
                    child: const Text('Войти'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration_screen');
                    },
                    child: const Text('Регистрация'),
                  ),
                  Text(
                    vm.authError,
                    style: const TextStyle(fontSize: 16.0, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const AccountScreen();
        }
      },
    );
  }
}

class ViewModel {
  final String authToken;
  final String authError;
  final void Function(String username, String password) authRequest;
  ViewModel({
    required this.authToken,
    required this.authError,
    required this.authRequest

  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        authToken: store.state.authToken,
        authError: store.state.authError,
        authRequest: (String username, String password) => store.dispatch(
            AuthRequestAction(username, password))
    );
  }
}

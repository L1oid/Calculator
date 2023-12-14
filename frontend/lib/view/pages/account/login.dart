import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {
        final TextEditingController usernameController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();

        return WillPopScope(
            onWillPop: () async {
              vm.authMessage("");
              return true;
            },
            child: Scaffold(
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
                        border: OutlineInputBorder(),
                        labelText: 'Логин',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                        vm.authMessage("");
                        Navigator.pushNamed(context, '/registration_account_screen');
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
            ),
        );
      },
    );
  }
}

class ViewModel {
  final String authError;
  final void Function(String username, String password) authRequest;
  final void Function(String authError) authMessage;
  ViewModel({
    required this.authError,
    required this.authRequest,
    required this.authMessage

  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        authError: store.state.authError,
        authRequest: (String username, String password) => store.dispatch(
            AuthRequestAction(username, password)),
        authMessage: (String authError) => store.dispatch(
            AuthMessageAction(authError))
    );
  }
}

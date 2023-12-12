import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/state/actions/user_actions.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {
        final TextEditingController usernameController = TextEditingController();
        final TextEditingController passwordController = TextEditingController();
        final TextEditingController emailController = TextEditingController();

        return WillPopScope(
            onWillPop: () async {
              vm.regMessages("","");
              return true;
            },
            child: Scaffold(
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
                        vm.regRequest(username, password, email);
                      },
                      child: const Text('Создать аккаунт'),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      vm.regError,
                      style: const TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                    Text(
                      vm.regSuccess,
                      style: const TextStyle(fontSize: 16.0, color: Colors.green),
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
  final String regError;
  final String regSuccess;
  final void Function(String username, String password, String email) regRequest;
  final void Function(String regError, String regSuccess) regMessages;
  ViewModel({
    required this.regError,
    required this.regSuccess,
    required this.regRequest,
    required this.regMessages

  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        regError: store.state.regError,
        regSuccess: store.state.regSuccess,
        regRequest: (String username, String password, String email) => store.dispatch(
            RegRequestAction(username, password, email)
        ),
        regMessages: (String regError, String regSuccess) => store.dispatch(
            RegMessageAction(regError, regSuccess)
        )
    );
  }
}
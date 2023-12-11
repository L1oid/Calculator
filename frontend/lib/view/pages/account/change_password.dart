import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/actions.dart';
import '/state/state.dart';
import '/view/pages/account/login.dart';

class ChangePasswordScreen extends StatelessWidget {

  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {

        if (vm.authToken == '') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
          return const SizedBox.shrink();
        } else {

          final TextEditingController currentPasswordController = TextEditingController();
          final TextEditingController newPasswordController = TextEditingController();
          final TextEditingController repeatPasswordController = TextEditingController();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Сменить пароль'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Текущий пароль'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Новый пароль'),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: repeatPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Повторите новый пароль'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                      onPressed: () {
                        final currentPassword = currentPasswordController.text;
                        final newPassword = newPasswordController.text;
                        final repeatPassword = repeatPasswordController.text;

                        vm.changePassword(currentPassword, newPassword, repeatPassword);
                      },
                      child: const Text('Сохранить изменения')
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                      vm.errorChangePassword,
                      style: const TextStyle(fontSize: 16.0, color: Colors.red)
                  ),
                  Text(
                      vm.successChangePassword,
                      style: const TextStyle(fontSize: 16.0, color: Colors.green)
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ViewModel {
  final String authToken;
  final String errorChangePassword;
  final String successChangePassword;
  final void Function(String currentPassword, String newPassword, String repeatPassword) changePassword;
  ViewModel({
    required this.authToken,
    required this.errorChangePassword,
    required this.successChangePassword,
    required this.changePassword

  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        authToken: store.state.authToken,
        errorChangePassword: store.state.errorChangePassword,
        successChangePassword: store.state.successChangePassword,
        changePassword: (String currentPassword, String newPassword, String repeatPassword) => store.dispatch(
              ChangePasswordAction(
                  currentPassword,
                  newPassword,
                  repeatPassword
              ))
    );
  }
}

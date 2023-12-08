import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/actions.dart';
import '/state/state.dart';

class ChangePasswordScreen extends StatelessWidget {

  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
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

                    store.dispatch(ChangePasswordAction(currentPassword, newPassword, repeatPassword));
                  },
                  child: const Text('Сохранить изменения')
                ),
                const SizedBox(height: 16.0),
                Text(
                  store.state.errorChangePassword,
                  style: const TextStyle(fontSize: 16.0, color: Colors.red)
                ),
                Text(
                  store.state.successChangePassword,
                  style: const TextStyle(fontSize: 16.0, color: Colors.green)
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

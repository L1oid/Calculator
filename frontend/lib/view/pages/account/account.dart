import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/view/widgets/delete_account_dialog.dart';
import '/view/pages/account/login.dart';
import '/state/state.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
        converter: (store) => store.state.authToken,
        builder: (context, authToken) {
          if (authToken != '') {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Личный кабинет'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: ListView(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/personal_details_screen');
                          },
                          child: const Text('Мои данные', style: TextStyle(fontSize: 16.0)),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/change_password_screen');
                          },
                          child: const Text('Сменить пароль', style: TextStyle(fontSize: 16.0)),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            deleteAccountDialog(context);
                          },
                          child: const Text('Удалить аккаунт', style: TextStyle(fontSize: 16.0)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const LoginScreen();
          }
        }
    );
  }
}

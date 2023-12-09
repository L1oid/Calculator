import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/view/widgets/drawer.dart';
import '/view/pages/account/personal_details.dart';
import '/view/pages/account/change_password.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Личный кабинет'),
          ),
          drawer: const AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: 300,
                child: ListView(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()),
                        );
                      },
                      child: const Text('Мои данные', style: TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                        );
                      },
                      child: const Text('Сменить пароль', style: TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Удалить аккаунт', style: TextStyle(fontSize: 16.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

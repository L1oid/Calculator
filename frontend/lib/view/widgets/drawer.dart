import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/view/pages/login.dart';
import '/view/pages/basic_calculator.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        builder: (context, store) {
          return Drawer(
            child: Builder(
              builder: (context) => ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text(
                      'Меню',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(store.state.authToken != '' ? 'Личный кабинет' : 'Войти'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Базовый калькулятор'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BasicCalculatorScreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('СЛАУ калькулятор'),
                    onTap: () {

                    },
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

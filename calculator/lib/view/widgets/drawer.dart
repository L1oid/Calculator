import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../../state/state.dart';
import '../pages/home.dart';
import '/view/pages/login.dart';

class AppDrawer extends StatelessWidget {
  final Store<AppState> store;

  const AppDrawer({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
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
              title: const Text('Войти'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(store: store)),
                );
              },
            ),
            ListTile(
              title: const Text('Базовый калькулятор'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen(store: store)),
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
}

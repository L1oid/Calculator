import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/actions.dart';
import '/state/state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
        converter: (Store<AppState> store) => ViewModel.fromStore(store),
        builder: (context, vm) {
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
                    title: Text(vm.authToken != '' ? 'Личный кабинет' : 'Войти'),
                    onTap: () {
                      Navigator.pushNamed(context, '/login_screen');
                    },
                  ),
                  ListTile(
                    title: const Text('Базовый калькулятор'),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  ListTile(
                    title: const Text('СЛАУ калькулятор'),
                    onTap: vm.authToken != '' ? () {
                      Navigator.pushNamed(context, '/slae_calculator_screen');
                    } : null,
                    enabled: vm.authToken != '',
                  ),
                  ListTile(
                    title: const Text('Чат'),
                    onTap: vm.authToken != '' ? () {
                      Navigator.pushNamed(context, '/chat_screen');
                    } : null,
                    enabled: vm.authToken != '',
                  ),
                  if (vm.authToken != '')
                    ListTile(
                      title: const Text(
                        'Выйти',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        vm.logout();
                      },
                    ),
                ],
              ),
            ),
          );
        }
    );
  }
}

class ViewModel {
  final String authToken;
  final void Function() logout;
  ViewModel({
    required this.authToken,
    required this.logout
  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        authToken: store.state.authToken,
        logout: () => store.dispatch(LogoutAction())
    );
  }
}
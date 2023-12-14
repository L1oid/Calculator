import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/actions/user_actions.dart';
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
                UserAccountsDrawerHeader(
                  accountName: Text(
                      vm.authToken != '' ? vm.username : 'Гость',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)
                  ),
                  accountEmail: Text(
                      vm.email
                  ),
                  currentAccountPicture: vm.authToken != '' ? CircleAvatar(
                    backgroundImage: vm.avatarImage != null
                        ? Image.memory(vm.avatarImage!).image
                        : const AssetImage("default.jpg"),
                  ) : null,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text(vm.authToken != '' ? 'Личный кабинет' : 'Войти'),
                  onTap: () {
                    Navigator.pushNamed(context, '/account_screen');
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
                  onTap: vm.authToken != ''
                      ? () {
                    Navigator.pushNamed(
                        context, '/slae_calculator_screen');
                  }
                      : null,
                  enabled: vm.authToken != '',
                ),
                ListTile(
                  title: const Text('Чат'),
                  onTap: vm.authToken != ''
                      ? () {
                    Navigator.pushNamed(context, '/chat_screen');
                  }
                      : null,
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
      },
    );
  }
}

class ViewModel {
  final String authToken;
  final String username;
  final String email;
  final Uint8List? avatarImage;
  final void Function() logout;
  ViewModel({
    required this.authToken,
    required this.logout,
    required this.username,
    required this.avatarImage,
    required this.email
  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        authToken: store.state.authToken,
        username: store.state.username,
        email: store.state.email,
        avatarImage: store.state.avatarImage,
        logout: () => store.dispatch(LogoutAction())
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/view/pages/chat/chat.dart';
import 'package:redux/redux.dart';
import '/state/actions.dart';
import '/state/state.dart';
import '/view/pages/account/login.dart';
import '/view/pages/calculators/basic_calculator.dart';
import '/view/pages/calculators/slae_calculator.dart';

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
                    onTap: vm.authToken != '' ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SlaeCalculatorScreen()),
                      );
                    } : null,
                    enabled: vm.authToken != '',
                  ),
                  ListTile(
                    title: const Text('Чат'),
                    onTap: vm.authToken != '' ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatScreen()),
                      );
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
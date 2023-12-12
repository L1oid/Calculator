import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/view/pages/account/login.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {

        if (vm.authToken == '') {
          return const LoginScreen();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Мои данные'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Text("Имя пользователя: ${vm.username}", style: const TextStyle(fontSize: 24.0)),
                  const SizedBox(height: 16.0),
                  Text("Почта: ${vm.email}", style: const TextStyle(fontSize: 24.0)),
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
  final String username;
  final String email;
  ViewModel({
    required this.authToken,
    required this.username,
    required this.email
  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
      authToken: store.state.authToken,
      username: store.state.username,
      email: store.state.email,
    );
  }
}
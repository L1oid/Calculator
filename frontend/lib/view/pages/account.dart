import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/view/widgets/drawer.dart';

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
          body: const Padding(
            padding: EdgeInsets.all(16.0),
          ),
        );
      },
    );
  }
}

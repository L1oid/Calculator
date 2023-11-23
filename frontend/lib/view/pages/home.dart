import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import '../../state/state.dart';
import 'basic.dart';
import '/view/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  final Store<AppState> store;

  const HomeScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Лучший калькулятор на планете',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Лучший калькулятор на планете'),
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          drawer: AppDrawer(store: store),
          body: const BasicCalculatorScreen(),
        ),
      ),
    );
  }
}
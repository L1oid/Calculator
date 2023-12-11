import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/view/pages/calculators/basic_calculator.dart';

class HomeScreen extends StatelessWidget {
  final Store<AppState> store;

  const HomeScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Лучший калькулятор на планете',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BasicCalculatorScreen(),
      ),
    );
  }
}

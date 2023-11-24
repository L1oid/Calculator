import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import 'basic_calculator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return MaterialApp(
          title: 'Лучший калькулятор на планете',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const BasicCalculatorScreen()
        );
      },
    );
  }
}
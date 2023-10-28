import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'state/store.dart';
import 'view/component.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = createStore();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CalculatorScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'state/store.dart';
import 'view/pages/home.dart';

void main() {
  final store = createStore();
  runApp(
    StoreProvider(
      store: store,
      child: const HomeScreen(),
    ),
  );
}
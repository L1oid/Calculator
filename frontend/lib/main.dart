import 'package:flutter/material.dart';
import 'state/store.dart';
import 'view/pages/home.dart';

void main() {
  final store = createStore();
  runApp(HomeScreen(store: store));
}

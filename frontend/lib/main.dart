import 'package:flutter/material.dart';
import 'view/pages/home.dart';
import '/state/store.dart';

void main() {
  final store = createStore();
  runApp(HomeScreen(store: store));
}
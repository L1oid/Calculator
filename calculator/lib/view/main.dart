import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  void pressCalculate() {

  }

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      TextField(decoration: InputDecoration(border: OutlineInputBorder())),
      ElevatedButton(onPressed: null, child: Text("Calculate"))
    ]);
  }
}

void main() {
  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(title: const Text('Calculator')),
              body: const MyWidget()
          )
      )
  );
}
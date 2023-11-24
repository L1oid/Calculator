import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/view/widgets/drawer.dart';
import '/state/state.dart';
import '/state/actions.dart';

class BasicCalculatorScreen extends StatelessWidget {
  const BasicCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
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
          drawer: const AppDrawer(),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    store.state.expression,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              const Divider(),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      buildButton('1', context),
                      buildButton('2', context),
                      buildButton('3', context),
                      buildButton('+', context),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('4', context),
                      buildButton('5', context),
                      buildButton('6', context),
                      buildButton('-', context),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('7', context),
                      buildButton('8', context),
                      buildButton('9', context),
                      buildButton('*', context),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('0', context),
                      buildButton('(', context),
                      buildButton(')', context),
                      buildButton('/', context),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('.', context),
                      buildButton('<-', context),
                      buildButton('C', context),
                      buildButton('=', context),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildButton(String buttonText, BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == 'C') {
            StoreProvider.of<AppState>(context).dispatch(ClearExpressionAction());
          } else if (buttonText == '=') {
            StoreProvider.of<AppState>(context).dispatch(CalculateAction());
          } else if (buttonText == '<-') {
            StoreProvider.of<AppState>(context).dispatch(ClearSymbolAction());
          } else {
            StoreProvider.of<AppState>(context).dispatch(AddSymbolAction(buttonText));
          }
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

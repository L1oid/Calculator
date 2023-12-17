import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/state/actions/calculator_actions.dart';
import '/view/widgets/drawer.dart';

class BasicCalculatorScreen extends StatelessWidget {
  const BasicCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.expression,
      builder: (context, expression) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Калькулятор'),
          ),
          drawer: const AppDrawer(),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    expression,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      buildButton('1', context),
                      buildButton('2', context),
                      buildButton('3', context),
                      buildButton('+', context),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('4', context),
                      buildButton('5', context),
                      buildButton('6', context),
                      buildButton('-', context),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('7', context),
                      buildButton('8', context),
                      buildButton('9', context),
                      buildButton('*', context),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('0', context),
                      buildButton('(', context),
                      buildButton(')', context),
                      buildButton('/', context),
                    ],
                  ),
                  Row(
                    children: [
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
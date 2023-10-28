import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import '/state/app_state.dart';
import "/state/reducers.dart";

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
      converter: (store) => store.state.expression,
      builder: (context, expression) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Calculator'),
          ),
          body: Column(
            children: <Widget>[
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
              const Divider(),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      buildButton('1'),
                      buildButton('2'),
                      buildButton('3'),
                      buildButton('+'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('4'),
                      buildButton('5'),
                      buildButton('6'),
                      buildButton('-'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('7'),
                      buildButton('8'),
                      buildButton('9'),
                      buildButton('*'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('0'),
                      buildButton('('),
                      buildButton(')'),
                      buildButton('/'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      buildButton('.'),
                      buildButton('<-'),
                      buildButton('C'),
                      buildButton('='),
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

  Widget buildButton(String buttonText) {
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
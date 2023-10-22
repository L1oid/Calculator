import 'package:flutter/material.dart';
import '/domain/calculator_factory.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  String expression = '';

  void addSymbol(String buttonText) {
    setState(() {
      expression += buttonText;
    });
  }

  void calculate() {
    final calculator = CalculatorFactory.createCalculator();
    try {
      final result = calculator.calculate(expression);
      setState(() {
        expression = result.toString();
      });
    } catch (e) {
      setState(() {
        expression = e.toString();
      });
    }
  }

  void clearSymbol() {
    setState(() {
      if (expression != null && expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
      }
    });
  }

  void clearExpression() {
    setState(() {
      expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == 'C') {
            clearExpression();
          } else if (buttonText == '=') {
            calculate();
          } else if (buttonText == '<-'){
            clearSymbol();
          } else {
            addSymbol(buttonText);
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
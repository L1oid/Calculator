import 'package:flutter/material.dart';
import '/domain/calculator_factory.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      _expression += buttonText;
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Divider(),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('+'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('0'),
                  _buildButton('.'),
                  _buildButton('('),
                  _buildButton(')'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('C'),
                  _buildButton('='),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (buttonText == 'C') {
            _clear();
          } else if (buttonText == '=') {
            final calculator = CalculatorFactory.createCalculator();
            try {
              final result = calculator.calculate(_expression);
              setState(() {
                _expression = result.toString();
              });
            } catch (e) {
              setState(() {
                _expression = e.toString();
              });
            }
          } else {
            _onButtonPressed(buttonText);
          }
        },
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

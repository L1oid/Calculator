import 'api/calculator_interface.dart';
class BasicCalculator implements Calculator {
  @override
  double calculate(String input) {
    final tokens = _tokenize(input);
    final result = _evaluate(tokens);
    return result;
  }

  List<String> _tokenize(String input) {
    final cleanedInput = input.replaceAll(' ', '');
    final tokenRegExp = RegExp(r'(\d+\.\d+|\d+|[+\-*/()])');
    return tokenRegExp.allMatches(cleanedInput).map((match) => match.group(0)!).toList();
  }

  double _evaluate(List<String> tokens) {
    final stack = <double>[];
    final operators = <String>[];

    for (final token in tokens) {
      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          _applyOperator(stack, operators.removeLast());
        }
        operators.removeLast();
      } else {
        while (operators.isNotEmpty && _hasHigherPrecedence(operators.last, token)) {
          _applyOperator(stack, operators.removeLast());
        }
        operators.add(token);
      }
    }

    while (operators.isNotEmpty) {
      _applyOperator(stack, operators.removeLast());
    }

    if (stack.length != 1 || operators.isNotEmpty) {
      throw "Неверное выражение";
    }

    return stack.first;
  }

  bool _hasHigherPrecedence(String op1, String op2) {
    final precedence = {'+': 1, '-': 1, '*': 2, '/': 2};
    return (precedence[op1] ?? 0) >= (precedence[op2] ?? 0);
  }

  void _applyOperator(List<double> stack, String operator) {
    if (stack.length < 2) {
      throw "Неверное выражение";
    }
    final operand2 = stack.removeLast();
    final operand1 = stack.removeLast();

    switch (operator) {
      case '+':
        stack.add(operand1 + operand2);
        break;
      case '-':
        stack.add(operand1 - operand2);
        break;
      case '*':
        stack.add(operand1 * operand2);
        break;
      case '/':
        if (operand2 == 0) {
          throw "Деление на ноль";
        }
        stack.add(operand1 / operand2);
        break;
      default:
        throw "Неизвестный оператор: $operator";
    }
  }
}
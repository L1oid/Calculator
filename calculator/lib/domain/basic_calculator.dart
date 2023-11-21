import 'api/calculator_interface.dart';

class BasicCalculator implements Calculator {
  @override
  double calculate(String input) {
    final tokens = tokenize(input);
    final result = evaluate(tokens);
    return result;
  }

  List<String> tokenize(String input) {
    final cleanedInput = input.replaceAll(' ', '');
    final tokenRegExp = RegExp(r'(\d+\.\d+|\d+|[+\-*/()])');
    final matches = tokenRegExp.allMatches(cleanedInput).map((match) => match.group(0)!).toList();

    for (int i = 0; i < matches.length; i++) {
      if (matches[i] == '-' && (i == 0 || matches[i - 1] == '(' || matches[i - 1] == '*' || matches[i - 1] == '/')) {
        if (i + 1 < matches.length) {
          if (matches[i + 1] == '(') {
            matches[i] = '-1';
            matches.insert(i + 1, '*');
          } else if (double.tryParse(matches[i + 1]) != null) {
            matches[i] = '-${matches[i + 1]}';
            matches.removeAt(i + 1);
          }
        }
      }
    }
    return matches;
  }



  double evaluate(List<String> tokens) {
    final stack = <double>[];
    final operators = <String>[];

    for (int i = 0; i < tokens.length; i++) {
      final token = tokens[i];

      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          applyOperator(stack, operators.removeLast());
        }
        operators.removeLast();
      } else {
        if (token == '-' && (i == 0 || tokens[i - 1] == '(' || tokens[i - 1] == '*' || tokens[i - 1] == '/')) {
          stack.add(-1);
          operators.add('*');
        } else {
          while (operators.isNotEmpty && hasHigherPrecedence(operators.last, token)) {
            applyOperator(stack, operators.removeLast());
          }
          operators.add(token);
        }
      }
    }

    while (operators.isNotEmpty) {
      applyOperator(stack, operators.removeLast());
    }

    if (stack.length != 1 || operators.isNotEmpty) {
      throw "Неверное выражение";
    }

    return stack.first;
  }

  bool hasHigherPrecedence(String op1, String op2) {
    final precedence = {'+': 1, '-': 1, '*': 2, '/': 2};
    return (precedence[op1] ?? 0) >= (precedence[op2] ?? 0);
  }

  void applyOperator(List<double> stack, String operator) {
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
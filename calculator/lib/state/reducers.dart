import 'app_state.dart';
import '/domain/calculator_factory.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(expressionReducer(state.expression, action));
}

String expressionReducer(String expression, dynamic action) {
  if (action is AddSymbolAction) {
    return expression + action.symbol;
  } else if (action is ClearSymbolAction) {
    if (expression.isNotEmpty) {
      return expression.substring(0, expression.length - 1);
    }
  } else if (action is ClearExpressionAction) {
    return '';
  } else if (action is CalculateAction) {
    final calculator = CalculatorFactory.createCalculator();
    try {
      final result = calculator.calculate(expression);
      expression = result.toString();
    } catch (e) {
      expression = e.toString();
    }
  }
  return expression;
}

class AddSymbolAction {
  final String symbol;

  AddSymbolAction(this.symbol);
}

class ClearSymbolAction {}

class ClearExpressionAction {}

class CalculateAction {}

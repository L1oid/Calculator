import '/domain/impl/calculator_factory.dart';
import '/state/actions/calculator_actions.dart';
import '/state/actions/user_actions.dart';

String slaeResultReducer(String slaeResult, dynamic action) {
  if (action is SlaeResultAction) {
    final slaeCalculator = SlaeCalculatorFactory.createCalculator();
    try {
      slaeResult = slaeCalculator.calculate(action.slaeMatrix);
    } catch (e) {
      slaeResult = e.toString();
    }
  } else if (action is LogoutAction) {
    slaeResult = "";
  }
  return slaeResult;
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
    final basicCalculator = BasicCalculatorFactory.createCalculator();
    try {
      final result = basicCalculator.calculate(expression);
      expression = result.toString();
    } catch (e) {
      expression = e.toString();
    }
  } else if (action is LogoutAction) {
    expression = "";
  }
  return expression;
}
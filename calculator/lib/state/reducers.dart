import 'app_state.dart';
import '/domain/calculator_factory.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    expressionReducer(state.expression, action),
    authReducer(state.isAuthenticated, action),
    authTokenReducer(state.authToken, action), // New field
  );
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

bool authReducer(bool isAuthenticated, dynamic action) {
  if (action is AuthSuccessAction) {
    return true;
  } else if (action is AuthFailureAction) {
    return false;
  }
  return isAuthenticated;
}

String authTokenReducer(String authToken, dynamic action) {
  if (action is AuthSuccessAction) {
    return action.token;
  }
  return authToken;
}
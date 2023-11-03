import 'app_state.dart';
import '/domain/calculator_factory.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    expressionReducer(state.expression, action),
    authReducer(state.isAuthenticated, action),
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

//actions
class AddSymbolAction {
  final String symbol;

  AddSymbolAction(this.symbol);
}

class ClearSymbolAction {}

class ClearExpressionAction {}

class CalculateAction {}

class AuthRequestAction {
  final String username;
  final String password;

  AuthRequestAction(this.username, this.password);
}

class AuthSuccessAction {
  final String token;

  AuthSuccessAction(this.token);
}

class AuthFailureAction {
  final String error;

  AuthFailureAction(this.error);
}

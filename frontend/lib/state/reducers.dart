import 'state.dart';
import '/domain/calculator_factory.dart';
import 'actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    expressionReducer(state.expression, action),
    authTokenReducer(state.authToken, action),
    authErrorReducer(state.authError, action),
    regErrorReducer(state.regError, action),
    regSuccessReducer(state.regSuccess, action),
    slaeResultReducer(state.slaeResult, action)
  );
}

String slaeResultReducer(String slaeResult, dynamic action) {
  if (action is SlaeResultAction) {
    final slaeCalculator = SlaeCalculatorFactory.createCalculator();
    try {
      final result = slaeCalculator.calculate(action.slaeMatrix);
      for (int i = 0; i < 3; i++) {
        slaeResult += "x${i + 1} = ";
        slaeResult += result[i].toString();
        slaeResult += ";";
        if (i != 2) {
          slaeResult += "    ";
        }
      }
    } catch (e) {
      slaeResult = e.toString();
    }
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
  }
  return expression;
}

String authTokenReducer(String authToken, dynamic action) {
  if (action is AuthSuccessAction) {
    return action.token;
  } else if (action is LogoutAction) {
    authToken = "";
  }
  return authToken;
}

String authErrorReducer(String authError, dynamic action) {
  if (action is AuthFailureAction) {
    return action.authError;
  }
  return authError;
}

String regErrorReducer(String regError, dynamic action) {
  if (action is RegFailureAction) {
    return action.regError;
  }
  return regError;
}

String regSuccessReducer(String regSuccess, dynamic action) {
  if (action is RegSuccessAction) {
    return action.regSuccess;
  }
  return regSuccess;
}
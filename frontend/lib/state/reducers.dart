import 'dart:convert';
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
    slaeResultReducer(state.slaeResult, action),
    usernameReducer(state.username, action),
    emailReducer(state.email, action),
    errorChangePasswordReducer(state.errorChangePassword, action),
    successChangePasswordReducer(state.successChangePassword, action),
    sendChatMessageReducer(state.messages, action)
  );
}

List<Map<String, String>> sendChatMessageReducer(List<Map<String, String>> messages, dynamic action) {
  if (action is ReceiveMessageAction) {
    Map<String, String> decodedMessage = Map<String, String>.from(
        jsonDecode(action.message));
    return List.from(messages)
      ..add(decodedMessage);
  } else if (action is LogoutAction) {
    return List.from(messages)
      ..clear();
  } else {
    return messages;
  }
}

String errorChangePasswordReducer(String errorChangePassword, dynamic action) {
  if (action is ChangePasswordMessageAction) {
    return action.errorChangePassword;
  } else if (action is LogoutAction) {
    errorChangePassword = "";
  }
  return errorChangePassword;
}

String successChangePasswordReducer(String successChangePassword, dynamic action) {
  if (action is ChangePasswordMessageAction) {
    return action.successChangePassword;
  } else if (action is LogoutAction) {
    successChangePassword = "";
  }
  return successChangePassword;
}

String usernameReducer(String username, dynamic action) {
  if (action is UsernameSaveAction) {
    return action.username;
  } else if (action is LogoutAction) {
    username = "";
  }
  return username;
}

String emailReducer(String email, dynamic action) {
  if (action is EmailSaveAction) {
    return action.email;
  } else if (action is LogoutAction) {
    email = "";
  }
  return email;
}

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

String authTokenReducer(String authToken, dynamic action) {
  if (action is AuthMessageAction) {
    return action.token;
  } else if (action is LogoutAction) {
    authToken = "";
  }
  return authToken;
}

String authErrorReducer(String authError, dynamic action) {
  if (action is AuthMessageAction) {
    return action.authError;
  } else if (action is LogoutAction) {
    authError = "";
  }
  return authError;
}

String regErrorReducer(String regError, dynamic action) {
  if (action is RegMessageAction) {
    return action.regError;
  } else if (action is LogoutAction) {
    regError = "";
  }
  return regError;
}

String regSuccessReducer(String regSuccess, dynamic action) {
  if (action is RegMessageAction) {
    return action.regSuccess;
  } else if (action is LogoutAction) {
    regSuccess = "";
  }
  return regSuccess;
}
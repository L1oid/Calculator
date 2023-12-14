import '/state/state.dart';
import '/state/reducers/calculator_reducers.dart';
import '/state/reducers/user_reducers.dart';
import '/state/reducers/chat_reducers.dart';

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
    sendChatMessageReducer(state.messages, action),
    avatarImageReducer(state.avatarImage, action)
  );
}
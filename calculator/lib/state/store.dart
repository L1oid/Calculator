import 'package:redux/redux.dart';
import 'reducers.dart';
import 'app_state.dart';
import 'auth_middleware.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState('', false, ''), // Include an empty string as the initial token
    middleware: [createAuthMiddleware()],
  );
}
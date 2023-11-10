import 'package:redux/redux.dart';
import 'reducers.dart';
import 'state.dart';
import 'middleware.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState('', false, '', ''), // Include an empty string as the initial token
    middleware: [createAuthMiddleware()],
  );
}
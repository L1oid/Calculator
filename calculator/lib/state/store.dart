import 'package:redux/redux.dart';
import 'reducers.dart';
import 'app_state.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState(''),
  );
}

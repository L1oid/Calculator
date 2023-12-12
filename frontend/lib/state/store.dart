import 'package:redux/redux.dart';
import 'reducers/app_reducer.dart';
import '/state/state.dart';
import '/state/middleware/chat/chat_middleware.dart';
import '/state/middleware/user/delete_account_middleware.dart';
import '/state/middleware/user/authenticate_middleware.dart';
import '/state/middleware/user/registration_middleware.dart';
import '/state/middleware/user/change_password_middleware.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState('', '', '', '', '', '', '', '', '', '', []),
    middleware: [chat(), deleteAccount(), authenticate(), registration(), changePassword()]
  );
}
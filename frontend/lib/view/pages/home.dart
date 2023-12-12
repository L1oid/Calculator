import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';
import '/view/pages/calculators/basic_calculator.dart';
import '/view/pages/calculators/slae_calculator.dart';
import '/view/pages/account/account.dart';
import '/view/pages/account/change_password.dart';
import '/view/pages/account/personal_details.dart';
import '/view/pages/account/registration.dart';
import '/view/pages/chat/chat.dart';

class HomeScreen extends StatelessWidget {
  final Store<AppState> store;

  const HomeScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Лучший калькулятор на планете',
        initialRoute: '/',
        routes: {
          '/': (context) => const BasicCalculatorScreen(),
          '/slae_calculator_screen': (context) => const SlaeCalculatorScreen(),
          '/chat_screen': (context) => const ChatScreen(),
          '/change_password_screen': (context) => const ChangePasswordScreen(),
          '/account_screen': (context) => const AccountScreen(),
          '/personal_details_screen': (context) => const PersonalDetailsScreen(),
          '/registration_account_screen': (context) => const RegistrationScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        )
      ),
    );
  }
}

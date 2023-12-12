import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/actions/user_actions.dart';
import '/state/state.dart';

void deleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Удаление аккаунта'),
        content: const Text('Вы подтверждаете своё действие ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(DeleteAccountAction());
              Navigator.pop(context);
            },
            child: const Text('Да'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Нет'),
          ),
        ],
      );
    },
  );
}
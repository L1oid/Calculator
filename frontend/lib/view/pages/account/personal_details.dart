import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/state/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:image_picker/image_picker.dart';
import '/state/state.dart';
import '/view/pages/account/login.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});


  Future<void> pickImage(ViewModel vm, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      StoreProvider.of<AppState>(context).dispatch(UploadUserDataAction(imageBytes));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {

        if (vm.authToken == '') {
          return const LoginScreen();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Мои данные'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () => pickImage(vm, context),
                    child: CircleAvatar(
                      radius: 145.0,
                      backgroundImage: vm.avatarImage != null
                          ? Image.memory(vm.avatarImage!).image
                          : const AssetImage("default.jpg"),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text("Имя пользователя: ${vm.username}", style: const TextStyle(fontSize: 24.0)),
                  const SizedBox(height: 16.0),
                  Text("Почта: ${vm.email}", style: const TextStyle(fontSize: 24.0)),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ViewModel {
  final String authToken;
  final String username;
  final String email;
  final Uint8List? avatarImage;
  ViewModel({
    required this.authToken,
    required this.username,
    required this.email,
    required this.avatarImage
  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
      authToken: store.state.authToken,
      username: store.state.username,
      email: store.state.email,
      avatarImage: store.state.avatarImage
    );
  }
}
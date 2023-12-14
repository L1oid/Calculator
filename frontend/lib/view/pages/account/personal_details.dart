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
      StoreProvider.of<AppState>(context).dispatch(UploadUserAvatarAction(imageBytes));
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
                      radius: 100.0,
                      child: ClipOval(
                        child: SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: vm.avatarImage != null
                              ? Image.memory(vm.avatarImage!, fit: BoxFit.cover)
                              : Image.asset("default.jpg", fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    readOnly: true,
                    initialValue: vm.username,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Имя пользователя",
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    readOnly: true,
                    initialValue: vm.email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Почта",
                    ),
                  ),
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
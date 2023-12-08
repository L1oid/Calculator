import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/state/actions.dart';
import '/state/state.dart';
import '/view/widgets/drawer.dart';
import '/view/pages/account/login.dart';

class SlaeCalculatorScreen extends StatelessWidget {
  const SlaeCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {

        late List<List<TextEditingController>> controllers;

        if (store.state.authToken == '') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
          return const SizedBox.shrink();
        } else {
          controllers = List.generate(
            3,
                (rowIndex) => List.generate(4, (colIndex) => TextEditingController()),
          );

          return Scaffold(
            appBar: AppBar(
              title: const Text('СЛАУ Калькулятор'),
            ),
            drawer: const AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text("Метод Гаусса", style: TextStyle(fontSize: 24.0)),
                  const SizedBox(height: 16.0),
                  Column(
                    children: List.generate(
                      3,
                          (rowIndex) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                              (colIndex) {
                            if (colIndex < (4 - 2)) {
                              return Row(
                                children: [
                                  buildTextField(rowIndex, colIndex, controllers),
                                  const SizedBox(width: 8.0),
                                  Text("x${colIndex + 1}", style: const TextStyle(fontSize: 24.0)),
                                  const SizedBox(width: 8.0),
                                  const Text("+", style: TextStyle(fontSize: 24.0)),
                                  const SizedBox(width: 8.0)
                                ],
                              );
                            } else if (colIndex == (4 - 2)) {
                              return Row(
                                children: [
                                  buildTextField(rowIndex, colIndex, controllers),
                                  const SizedBox(width: 8.0),
                                  Text("x${colIndex + 1}", style: const TextStyle(fontSize: 24.0)),
                                  const SizedBox(width: 8.0),
                                  const Text("=", style: TextStyle(fontSize: 24.0)),
                                  const SizedBox(width: 8.0)
                                ],
                              );
                            } else {
                              return buildTextField(rowIndex, colIndex, controllers);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      List<List<double>> matrix = controllers.map((rowControllers) =>
                          rowControllers.map((controller) => double.parse(controller.text)).toList()).toList();
                      store.dispatch(SlaeResultAction(matrix));
                    },
                    child: const Text('Решить'),
                  ),
                  const SizedBox(height: 16.0),
                  if (store.state.slaeResult != "")
                    const Text("Ответ:", style: TextStyle(fontSize: 24.0)),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        store.state.slaeResult,
                        style: const TextStyle(fontSize: 24.0),
                      ),
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

  Widget buildTextField(int rowIndex, int colIndex, List<List<TextEditingController>> controllers) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controllers[rowIndex][colIndex],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

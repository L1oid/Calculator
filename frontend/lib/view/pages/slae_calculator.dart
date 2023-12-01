import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '/state/state.dart';
import '/view/widgets/drawer.dart';
import 'login.dart';

class SlaeCalculatorScreen extends StatelessWidget {
  const SlaeCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        if (store.state.authToken == '') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
          return const SizedBox.shrink();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('СЛАУ Калькулятор'),
            ),
            drawer: const AppDrawer(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                                  buildTextField(),
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
                                  buildTextField(),
                                  const SizedBox(width: 8.0),
                                  Text("x${colIndex + 1}", style: const TextStyle(fontSize: 24.0)),
                                  const SizedBox(width: 8.0),
                                  const Text("=", style: TextStyle(fontSize: 24.0)),
                                  const SizedBox(width: 8.0)
                                ],
                              );
                            } else {
                              return buildTextField();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text('Решить'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildTextField() {
    return const SizedBox(
      width: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
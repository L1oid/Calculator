import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:frontend/state/actions.dart';
import 'package:redux/redux.dart';
import '/state/state.dart';

class SlaeCalculatorScreen extends StatelessWidget {
  const SlaeCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {

        late List<List<TextEditingController>> controllers;

        controllers = List.generate(
          3,
              (rowIndex) => List.generate(4, (colIndex) => TextEditingController()),
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('СЛАУ Калькулятор'),
          ),
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
                    vm.slaeCalculate(matrix);
                  },
                  child: const Text('Решить'),
                ),
                const SizedBox(height: 16.0),
                if (vm.slaeResult != "")
                  const Text("Ответ:", style: TextStyle(fontSize: 24.0)),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      vm.slaeResult,
                      style: const TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
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

class ViewModel {
  final String slaeResult;
  final void Function(List<List<double>> matrix) slaeCalculate;
  ViewModel({
    required this.slaeResult,
    required this.slaeCalculate
  });

  static fromStore(Store<AppState> store) {
    return ViewModel(
        slaeResult: store.state.slaeResult,
        slaeCalculate: (List<List<double>> matrix) => store.dispatch(SlaeResultAction(matrix))
    );
  }
}

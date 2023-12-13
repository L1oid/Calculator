import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '/state/actions/calculator_actions.dart';
import '/state/state.dart';

class SlaeCalculatorScreen extends StatefulWidget {
  const SlaeCalculatorScreen({super.key});

  @override
  SlaeCalculatorScreenState createState() => SlaeCalculatorScreenState();
}

class SlaeCalculatorScreenState extends State<SlaeCalculatorScreen> {
  late List<List<TextEditingController>> controllers;
  int dimension = 2;

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  void initializeControllers() {
    controllers = List.generate(
      dimension,
          (rowIndex) => List.generate(dimension + 1, (colIndex) => TextEditingController()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.fromStore(store),
      builder: (context, vm) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (dimension > 2) {
                          setState(() {
                            dimension--;
                            initializeControllers();
                          });
                        }
                      },
                      child: const Text('-'),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        if (dimension < 6) {
                          setState(() {
                            dimension++;
                            initializeControllers();
                          });
                        }
                      },
                      child: const Text('+'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: List.generate(
                    dimension,
                        (rowIndex) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        dimension + 1,
                            (colIndex) {
                          if (colIndex < ((dimension + 1) - 2)) {
                            return Row(
                              children: [
                                buildTextField(rowIndex, colIndex, dimension, controllers),
                                const Text("+", style: TextStyle(fontSize: 16.0)),
                              ],
                            );
                          } else if (colIndex == ((dimension + 1) - 2)) {
                            return Row(
                              children: [
                                buildTextField(rowIndex, colIndex, dimension, controllers),
                                const Text("=", style: TextStyle(fontSize: 16.0)),
                              ],
                            );
                          } else {
                            return buildTextField(rowIndex, colIndex, dimension, controllers);
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

  Widget buildTextField(int rowIndex, int colIndex, int dimension, List<List<TextEditingController>> controllers) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        width: 45,
        height: 45,
        child: TextField(
          controller: controllers[rowIndex][colIndex],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: colIndex == ((dimension + 1) - 1) ? null : 'x${colIndex + 1}',
          ),
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

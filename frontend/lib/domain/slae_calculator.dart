import 'api/calculator_interface.dart';

class SlaeCalculator implements SlaeCalculatorInterface {
  @override
  List<double> calculate(List<List<double>> matrix) {
    const row = 3;
    const column = 4;

    List<double> result = [0, 0, 0];

    for (int i = 0; i < row; i++) {
      result[i] = matrix[i][0];
    }

    result[2] = 999;

    return result;
  }
}
import 'api/calculator_interface.dart';

class SlaeCalculator implements SlaeCalculatorInterface {
  @override
  String calculate(List<List<double>> matrix) {
    int n = matrix.length;
    List<double> x = List<double>.filled(n, 0.0);
    double max;
    int k, index;
    const double eps = 0.00001;
    String result = '';

    k = 0;
    while (k < n) {
      max = matrix[k][k].abs();
      index = k;
      for (int i = k + 1; i < n; i++) {
        if (matrix[i][k].abs() > max) {
          max = matrix[i][k].abs();
          index = i;
        }
      }

      if (max < eps) {
        result += "Решение получить невозможно из-за нулевого столбца $index матрицы";
        return result;
      }

      for (int j = 0; j <= n; j++) {
        double temp = matrix[k][j];
        matrix[k][j] = matrix[index][j];
        matrix[index][j] = temp;
      }

      for (int i = k; i < n; i++) {
        double temp = matrix[i][k];
        if (temp.abs() < eps) continue;
        for (int j = 0; j <= n; j++) {
          matrix[i][j] = matrix[i][j] / temp;
        }

        if (i == k) continue;

        for (int j = 0; j <= n; j++) {
          matrix[i][j] = matrix[i][j] - matrix[k][j];
        }
      }
      k++;
    }

    for (k = n - 1; k >= 0; k--) {
      x[k] = matrix[k][n];
      for (int i = 0; i < k; i++) {
        matrix[i][n] = matrix[i][n] - matrix[i][k] * x[k];
      }
    }

    for (int i = 0; i < n; i++) {
      String formattedValue = x[i] == x[i].toInt() ? x[i].toString() : x[i].toStringAsFixed(2).replaceAll(RegExp(r"(\.0)$"), "");
      result += "x${i + 1} = $formattedValue\n";
    }

    return result;
  }
}

import 'api/calculator_interface.dart';
import 'basic_calculator.dart';

class CalculatorFactory {
  static Calculator createCalculator() {
    return BasicCalculator();
  }
}
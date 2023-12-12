import '/domain/api/calculator_interface.dart';
import 'basic_calculator.dart';
import 'slae_calculator.dart';

class BasicCalculatorFactory {
  static BasicCalculatorInterface createCalculator() {
    return BasicCalculator();
  }
}

class SlaeCalculatorFactory {
  static SlaeCalculatorInterface createCalculator() {
    return SlaeCalculator();
  }
}
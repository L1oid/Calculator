class ClearSymbolAction {}

class ClearExpressionAction {}

class CalculateAction {}

class AddSymbolAction {
  final String symbol;

  AddSymbolAction(this.symbol);
}

class SlaeResultAction {
  final List<List<double>> slaeMatrix;

  SlaeResultAction(this.slaeMatrix);
}
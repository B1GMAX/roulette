import 'dart:ui';

class BetModel {
  final int? tableNumber;
  final Color? tableColor;
  final List<int>? firstRange;
  final List<int>? secondRange;
  final bool? isNumberEven;

  BetModel(
      {this.tableNumber,
      this.tableColor,
      this.firstRange,
      this.secondRange,
      this.isNumberEven});
}

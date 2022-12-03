import 'dart:ui';

class BetModel {
  final int? selectedNumber;
  final Color? tableColor;
  final List<int>? firstRange;
  final List<int>? secondRange;
  final bool? isNumberEven;
  final int? zero;
  final List<int>? firstDozen;
  final List<int>? secondDozen;
  final List<int>? thirdDozen;

  BetModel(
      {this.selectedNumber,
      this.tableColor,
      this.firstRange,
      this.secondRange,
      this.isNumberEven,
      this.zero,
      this.firstDozen,
      this.secondDozen,
      this.thirdDozen});

  bool get readyForGame =>
      selectedNumber != null ||
      tableColor != null ||
      firstRange != null ||
      secondRange != null ||
      isNumberEven != null ||
      zero != null ||
      firstDozen != null ||
      secondDozen != null ||
      thirdDozen != null;
}

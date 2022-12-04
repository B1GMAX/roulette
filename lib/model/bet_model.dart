import 'dart:ui';

import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BetModel &&
          runtimeType == other.runtimeType &&
          selectedNumber == other.selectedNumber &&
          tableColor == other.tableColor &&
          listEquals(firstRange, other.firstRange)&&
          listEquals(secondRange, other.secondRange)&&
          isNumberEven == other.isNumberEven &&
          zero == other.zero &&
          listEquals(firstDozen, other.firstDozen)&&
          listEquals(secondDozen, other.secondDozen)&&
          listEquals(thirdDozen, other.thirdDozen);

  @override
  int get hashCode =>
      selectedNumber.hashCode ^
      tableColor.hashCode ^
      firstRange.hashCode ^
      secondRange.hashCode ^
      isNumberEven.hashCode ^
      zero.hashCode ^
      firstDozen.hashCode ^
      secondDozen.hashCode ^
      thirdDozen.hashCode;

  @override
  String toString() {
    return 'BetModel{selectedNumber: $selectedNumber, tableColor: $tableColor, firstRange: $firstRange, secondRange: $secondRange, isNumberEven: $isNumberEven, zero: $zero, firstDozen: $firstDozen, secondDozen: $secondDozen, thirdDozen: $thirdDozen}';
  }
}

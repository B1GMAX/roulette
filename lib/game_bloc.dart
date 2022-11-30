import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  final _betController = BehaviorSubject<int>();

  final _userValueController = BehaviorSubject<int>();

  final _tableNumberController = BehaviorSubject<int>();

  final _tableColorController = BehaviorSubject<Color>();

  final _firstRangeNumbersController = BehaviorSubject<List<int>>();

  final _secondRangeNumbersController = BehaviorSubject<List<int>>();

  final _isNumberEvenController = BehaviorSubject<bool>();

  Stream<bool> get isNumberEvenStream => _isNumberEvenController.stream;

  Stream<List<int>> get firstRangeNumbersStream =>
      _firstRangeNumbersController.stream;

  Stream<List<int>> get secondRangeNumbersStream =>
      _secondRangeNumbersController.stream;

  Stream<Color> get tableColorStream => _tableColorController.stream;

  Stream<int> get userValueStream => _userValueController.stream;

  Stream<int> get betStream => _betController.stream;

  Stream<int> get tableNumberStream => _tableNumberController.stream;

  Sink<int> get tableNumberSink => _tableNumberController.sink;

  Sink<Color> get tableColorSink => _tableColorController.sink;

  Sink<List<int>> get firstRangeNumbersSink =>
      _firstRangeNumbersController.sink;

  Sink<List<int>> get secondRangeNumbersSink =>
      _secondRangeNumbersController.sink;

  Sink<bool> get isNumberEvenSink => _isNumberEvenController.sink;

  int _countBet = 10;
  int _userValue = 30000;

  void increaseCount() {
    _countBet = _countBet + 1;
    _betController.add(_countBet);
  }

  void decreaseCount() {
    if (_countBet > 10) _countBet = _countBet - 1;
    _betController.add(_countBet);
  }

  void start(BuildContext context, int bet, int? tableNumber, Color? tableColor,
      List<int>? firstRange, List<int>? secondRange, bool? isEven) {
    Random rng = Random();
    print(rng.nextInt(36));
    _showResultDialog(rng.nextInt(36), tableNumber, context, bet, tableColor,
        firstRange, secondRange, isEven);
  }

  void _showResultDialog(
      int number,
      int? tableNumber,
      BuildContext context,
      int bet,
      Color? tableColor,
      List<int>? firstRange,
      List<int>? secondRange, bool? isEven) {
    showDialog(
      context: context,
      builder: (context) {
        print('number - $number');
        print('tableNumber - $tableNumber');
        print('tableColor - $tableColor');
        print('firstRange - $firstRange');
        print('secondRange - $secondRange');
        Color colorNumber = number.isEven ? Colors.black : Colors.red;
        if (tableNumber != null) {
          if (tableNumber == number) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (tableColor != null) {
          if (tableColor == colorNumber) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (firstRange != null) {
          if (firstRange.contains(tableNumber)) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (secondRange != null) {
          if (secondRange.contains(tableNumber)) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (isEven != null) {
          if (number.isEven == isEven) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        return AlertDialog(
          content: Container(
            color: colorNumber,
            child: Text(
              '$number',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void dispose() {
    _betController.close();
    _userValueController.close();
    _tableColorController.close();
    _firstRangeNumbersController.close();
    _secondRangeNumbersController.close();
    _isNumberEvenController.close();
  }
}

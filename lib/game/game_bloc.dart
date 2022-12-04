import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roulette/model/user_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:roulette/wheel.dart';
import '../model/bet_model.dart';

class GameBloc {
  GameBloc() {
    if (FirebaseAuth.instance.currentUser != null) {
      _readUser();
    }
  }

  final _betController = BehaviorSubject<int>();

  final _userModelController = BehaviorSubject<UserModel>();

  final _isItemSelectedController = BehaviorSubject<bool>();

  final _gridItemIndexController = BehaviorSubject<int>();

  final _isZeroSelectedController = BehaviorSubject<bool>();

  final _isFirsEighteenSelectedController = BehaviorSubject<bool>();

  final _isEvenSelectedController = BehaviorSubject<bool>();

  final _isRedSelectedController = BehaviorSubject<bool>();

  final _isBlackSelectedController = BehaviorSubject<bool>();

  final _isOddSelectedController = BehaviorSubject<bool>();

  final _isSecondEighteenSelectedController = BehaviorSubject<bool>();

  final _isFirstDozenSelectedController = BehaviorSubject<bool>();

  final _isSecondDozenSelectedController = BehaviorSubject<bool>();

  final _isThirdDozenSelectedController = BehaviorSubject<bool>();

  Stream<bool> get isFirstDozenSelectedStream =>
      _isFirstDozenSelectedController.stream;

  Stream<bool> get isSecondDozenSelectedStream =>
      _isSecondDozenSelectedController.stream;

  Stream<bool> get isThirdDozenSelectedStream =>
      _isThirdDozenSelectedController.stream;

  Stream<bool> get isZeroSelectedStream => _isZeroSelectedController.stream;

  Stream<bool> get isFirstEighteenSelectedStream =>
      _isFirsEighteenSelectedController.stream;

  Stream<bool> get isEvenSelectedStream => _isEvenSelectedController.stream;

  Stream<bool> get isRedSelectedStream => _isRedSelectedController.stream;

  Stream<bool> get isBlackSelectedStream => _isBlackSelectedController.stream;

  Stream<bool> get isOddSelectedStream => _isOddSelectedController.stream;

  Stream<bool> get isSecondEighteenSelectedStream =>
      _isSecondEighteenSelectedController.stream;

  Stream<int> get gridItemIndexStream => _gridItemIndexController.stream;

  Stream<bool> get isItemSelectedStream => _isItemSelectedController.stream;

  Stream<int> get betStream => _betController.stream;

  Stream<UserModel> get userModelStream => _userModelController.stream;

  Sink<bool> get isItemSelectedSink => _isItemSelectedController.sink;

  Sink<bool> get isZeroSelectedSink => _isZeroSelectedController.sink;

  Sink<bool> get isFirsEighteenSelectedSink =>
      _isFirsEighteenSelectedController.sink;

  Sink<bool> get isEvenSelectedSink => _isEvenSelectedController.sink;

  Sink<bool> get isRedSelectedSink => _isRedSelectedController.sink;

  Sink<bool> get isBlackSelectedSink => _isBlackSelectedController.sink;

  Sink<bool> get isOddSelectedSink => _isOddSelectedController.sink;

  Sink<bool> get isSecondEighteenSelectedSink =>
      _isSecondEighteenSelectedController.sink;

  Sink<bool> get isFirstDozenSelectedSink =>
      _isFirstDozenSelectedController.sink;

  Sink<bool> get isSecondDozenSelectedSink =>
      _isSecondDozenSelectedController.sink;

  Sink<bool> get isThirdDozenSelectedSink =>
      _isThirdDozenSelectedController.sink;

  final List<BetModel> betModelList = [];

  int _countBet = 10;
  int _userValue = 0;
  int _winRate = 0;

  void increaseCount() {
    _countBet = _countBet + 1;
    _betController.add(_countBet);
  }

  void decreaseCount() {
    if (_countBet > 10) _countBet = _countBet - 1;
    _betController.add(_countBet);
  }

  void start(int bet, BuildContext context) async {
    if (betModelList.isNotEmpty && _userValue > 0) {
      Random rng = Random();
      _showResultDialog(rng.nextInt(36), context, bet, betModelList);
    }
  }

  void _showResultDialog(
      int number, BuildContext context, int bet, List<BetModel> betModelList) {
    showDialog(
      context: context,
      builder: (context) {
        Color colorNumber = number.isEven ? Colors.black : Colors.red;
        for (final betModel in betModelList) {
          _calculateUserValue(betModel, number, bet, colorNumber);
        }

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'value': _userValue, 'winRate': _winRate});

        _userModelController.add(_userModelController.value
            .copyWith(value: _userValue, winRate: _winRate));

        final changeButton = BehaviorSubject<bool>();

        return AlertDialog(
          backgroundColor: Colors.brown,
          content: StreamBuilder<bool>(
              initialData: false,
              stream: changeButton.stream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wheel(
                            onPressed: () {
                              changeButton.add(true);
                            },
                          ),
                          snapshot.data!
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 25, bottom: 25),
                                  width: 70,
                                  height: 20,
                                  color:
                                      number == 0 ? Colors.green : colorNumber,
                                  child: Text(
                                    number.toString(),
                                    style: const TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'))
                        ],
                      )
                    : const SizedBox.shrink();
              }),
        );
      },
    );
  }

  void _calculateUserValue(
      BetModel betModel, int number, int bet, Color colorNumber) {
    if (betModel.selectedNumber != null) {
      if (betModel.selectedNumber == number) {
        _userValue += bet * 35;
      } else {
        if (_userValue > 0) _userValue -= bet * 35;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.tableColor != null) {
      if (betModel.tableColor == colorNumber) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.firstRange != null) {
      if (betModel.firstRange!.contains(number)) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.secondRange != null) {
      if (betModel.secondRange!.contains(number)) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.isNumberEven != null) {
      if (number.isEven == betModel.isNumberEven) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.zero != null) {
      if (number == betModel.zero) {
        _userValue += bet * 35;
      } else {
        if (_userValue > 0) _userValue -= bet * 35;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.firstDozen != null) {
      if (betModel.firstDozen!.contains(number)) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.secondDozen != null) {
      if (betModel.secondDozen!.contains(number)) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }
    if (betModel.thirdDozen != null) {
      if (betModel.thirdDozen!.contains(number)) {
        _userValue += bet;
      } else {
        if (_userValue > 0) _userValue -= bet;
        if (_userValue < 0) _userValue = 0;
      }
    }

    if (_userModelController.hasValue) {
      if (_userValue >= _userModelController.value.value) {
        _winRate = _winRate + 1;
      } else {
        _winRate = 0;
      }
    }
  }

  void addBet(BetModel betModel) {
    betModelList.add(betModel);
  }

  void removeBet(BetModel betModel) {
    betModelList.remove(betModel);
  }

  void selectItemInGrid(int index) {
    _gridItemIndexController.add(index);
  }

  void _readUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _userModelController.add(
          UserModel(
              name: documentSnapshot['name'],
              value: documentSnapshot['value'],
              winRate: documentSnapshot['winRate']),
        );
        _userValue = documentSnapshot['value'];
        _winRate = documentSnapshot['winRate'];
      }
    });
  }

  void getFreeCoins() {
    _userValue += 100;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'value': _userValue});

    _userModelController
        .add(_userModelController.value.copyWith(value: _userValue));
  }

  void dispose() {
    _betController.close();
    _userModelController.close();
    _isItemSelectedController.close();
    _gridItemIndexController.close();
    _isZeroSelectedController.close();
    _isBlackSelectedController.close();
    _isEvenSelectedController.close();
    _isFirsEighteenSelectedController.close();
    _isSecondEighteenSelectedController.close();
    _isRedSelectedController.close();
    _isOddSelectedController.close();
    _isThirdDozenSelectedController.close();
    _isFirstDozenSelectedController.close();
    _isSecondDozenSelectedController.close();
  }
}

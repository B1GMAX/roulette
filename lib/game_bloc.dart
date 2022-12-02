import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roulette/bet_model.dart';
import 'package:roulette/sign_in_or_sing_up_screen.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  final NavigatorState navigator;

  GameBloc({required this.navigator}) {
    print(
        'FirebaseAuth.instance.currentUser!.isAnonymous - ${FirebaseAuth.instance.currentUser!.isAnonymous}');
    if (FirebaseAuth.instance.currentUser != null &&
        !FirebaseAuth.instance.currentUser!.isAnonymous) {
      _userValueController.add(_userValue = 2000);
      _userNameController.add(FirebaseAuth.instance.currentUser!.email ?? '');
    }
  }

  final _userNameController = BehaviorSubject<String>();

  final _betController = BehaviorSubject<int>();

  final _userValueController = BehaviorSubject<int>();

  final _betModelController = BehaviorSubject<BetModel>();

  Stream<String> get userNameStream => _userNameController.stream;

  Stream<int> get userValueStream => _userValueController.stream;

  Stream<int> get betStream => _betController.stream;

  Sink<BetModel> get betModelSink => _betModelController.sink;

  int _countBet = 10;
  int _userValue = 0;

  void increaseCount() {
    _countBet = _countBet + 1;
    _betController.add(_countBet);
  }

  void decreaseCount() {
    if (_countBet > 10) _countBet = _countBet - 1;
    _betController.add(_countBet);
  }

  void start(int bet, BuildContext context) async {
    if (!FirebaseAuth.instance.currentUser!.isAnonymous) {
      if (_betModelController.hasValue) {
        Random rng = Random();
        _showResultDialog(
            rng.nextInt(36), context, bet, _betModelController.value);
      }
    } else {
      await FirebaseAuth.instance.signOut();

      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInOrSignUpScreen()));
    }
  }

  void _showResultDialog(
      int number, BuildContext context, int bet, BetModel betModel) {
    showDialog(
      context: context,
      builder: (context) {
        Color colorNumber = number.isEven ? Colors.black : Colors.red;
        if (betModel.tableNumber != null) {
          if (betModel.tableNumber == number) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (betModel.tableColor != null) {
          if (betModel.tableColor == colorNumber) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (betModel.firstRange != null) {
          if (betModel.firstRange!.contains(betModel.tableNumber)) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (betModel.secondRange != null) {
          if (betModel.secondRange!.contains(betModel.tableNumber)) {
            _userValueController.add(_userValue = _userValue + bet);
          } else {
            _userValueController.add(_userValue = _userValue - bet);
          }
        }
        if (betModel.isNumberEven != null) {
          if (number.isEven == betModel.isNumberEven) {
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

  void addValue(BetModel betModel) {
    betModelSink.add(betModel);
  }

  void dispose() {
    _betController.close();
    _userValueController.close();
    _betModelController.close();
    _userNameController.close();
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roulette/bet_model.dart';
import 'package:roulette/sign_in_or_sing_up_screen.dart';
import 'package:roulette/user_model.dart';
import 'package:rxdart/rxdart.dart';

class GameBloc {
  final NavigatorState navigator;

  GameBloc({required this.navigator}) {
    _readUser();
  }

  final _betController = BehaviorSubject<int>();

  final _betModelController = BehaviorSubject<BetModel>();

  final _userModelController = BehaviorSubject<UserModel>();

  Stream<int> get betStream => _betController.stream;

  Stream<UserModel> get userModelStream => _userModelController.stream;

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

      navigator.pushReplacement(MaterialPageRoute(
          builder: (context) => const SignInOrSignUpScreen()));
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
            _userValue += bet * 35;
          } else {
            _userValue -= bet * 35;
          }
        }
        if (betModel.tableColor != null) {
          if (betModel.tableColor == colorNumber) {
            _userValue += bet;
          } else {
            _userValue -= -bet;
          }
        }
        if (betModel.firstRange != null) {
          if (betModel.firstRange!.contains(betModel.tableNumber)) {
            _userValue += bet;
          } else {
            _userValue -= bet;
          }
        }
        if (betModel.secondRange != null) {
          if (betModel.secondRange!.contains(betModel.tableNumber)) {
            _userValue += bet;
          } else {
            _userValue -= bet;
          }
        }
        if (betModel.isNumberEven != null) {
          if (number.isEven == betModel.isNumberEven) {
            _userValue += bet;
          } else {
            _userValue -= bet;
          }
        }
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'value': _userValue});

        _userModelController
            .add(_userModelController.value.copyWith(value: _userValue));
        return AlertDialog(
          content: Container(
            color: colorNumber,
            child: Text(
              number.toString(),
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

  void _readUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _userModelController.add(UserModel(
            name: documentSnapshot['name'], value: documentSnapshot['value']));
        _userValue = documentSnapshot['value'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void dispose() {
    _betController.close();
    _betModelController.close();
    _userModelController.close();
  }
}

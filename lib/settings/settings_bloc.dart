import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roulette/regist_user/sign_in_or_sing_up_screen.dart';
import 'package:roulette/settings/rating_dialog.dart';

class SettingsBloc {
  final NavigatorState navigator;

  SettingsBloc(this.navigator);

  void signOut() async {
    await FirebaseAuth.instance.signOut();

    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SignInOrSignUpScreen(),
      ),
    );
  }

  void showRetaDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const RatingDialog());
  }

  void delete() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();

      await FirebaseAuth.instance.currentUser!.delete();

      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInOrSignUpScreen(),
        ),
      );
    }
  }
}

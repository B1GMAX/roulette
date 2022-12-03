import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roulette/rating_dialog.dart';
import 'package:roulette/sign_in_or_sing_up_screen.dart';

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
      await FirebaseAuth.instance.currentUser!.delete();
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInOrSignUpScreen(),
        ),
      );
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roulette/slide_screen.dart';
import 'package:roulette/user_model.dart';

class AnonimRegistBloc {
  final NavigatorState navigator;

  AnonimRegistBloc(this.navigator);

  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future createAnonymUser() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.signInAnonymously().then((result) {
        print('9 anonim');
        final docUser = FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid);

        final user = UserModel(
            name: nameController.text.trim(), value: 2000, winRate: 0);
        final json = user.toJson();

        docUser.set(json);
      });
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => SlideScreen()));
    } catch (e) {
      print(e);
    }
  }
}

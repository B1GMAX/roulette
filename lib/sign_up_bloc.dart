import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roulette/game_screen.dart';
import 'package:roulette/user_model.dart';

class SignUpBloc {
  final NavigatorState navigator;

  SignUpBloc({required this.navigator});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      _createUser();

      navigator
          .pushReplacement(MaterialPageRoute(builder: (context) => GameScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    } catch (e) {
      print(e);
    }

  }

  Future createAnonymUser() async {
    await FirebaseAuth.instance.signInAnonymously();
    navigator
        .pushReplacement(MaterialPageRoute(builder: (context) => GameScreen()));
  }

  Future _createUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

    final user =
        UserModel(name: nameController.text, value: 2000);
    final json = user.toJson();

    await docUser.set(json);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

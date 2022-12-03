import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/anonim_regist_screen.dart';
import 'package:roulette/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final VoidCallback goToSignIn;

  const SignUpScreen({required this.goToSignIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SignUpBloc>(
      dispose: (context, bloc) => bloc.dispose(),
      create: (context) => SignUpBloc(navigator: Navigator.of(context)),
      builder: (context, child) {
        return Scaffold(
          body: Form(
            key: context.read<SignUpBloc>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.deepPurple,
                    controller: context.read<SignUpBloc>().nameController,
                    decoration: const InputDecoration(
                      focusColor: Colors.deepPurple,
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.deepPurple),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (name) => name != null &&
                            context
                                .read<SignUpBloc>()
                                .nameController
                                .text
                                .isEmpty
                        ? 'Enter your name'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.deepPurple,
                    controller: context.read<SignUpBloc>().emailController,
                    decoration: const InputDecoration(
                      focusColor: Colors.deepPurple,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.deepPurple),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
                  child: TextFormField(
                    cursorColor: Colors.deepPurple,
                    style: const TextStyle(color: Colors.white),
                    controller: context.read<SignUpBloc>().passwordController,
                    decoration: const InputDecoration(
                      focusColor: Colors.deepPurple,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.deepPurple),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 characters'
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignUpBloc>().signUp();
                  },
                  child: const Text('Sing Up'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnonimRegistrScreen()));
                  },
                  child: const Text('Log in anonymously'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: goToSignIn, child: const Text('Sing In'))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

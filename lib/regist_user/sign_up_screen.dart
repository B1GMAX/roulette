import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/regist_user/sign_up_bloc.dart';

import '../widget/user_input_field.dart';
import 'anonim_regist_screen.dart';

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
                  child: UserInputField(
                    textColor: Colors.white,
                    fieldStyleColor: Colors.deepPurple,
                    hintText: 'Name',
                    validator: (name) => name != null &&
                            context
                                .read<SignUpBloc>()
                                .nameController
                                .text
                                .isEmpty
                        ? 'Enter your name'
                        : null,
                    textEditingController:
                        context.read<SignUpBloc>().nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
                  child: UserInputField(
                    textColor: Colors.white,
                    fieldStyleColor: Colors.deepPurple,
                    hintText: 'Email',
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                    textEditingController:
                        context.read<SignUpBloc>().emailController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
                  child: UserInputField(
                    textColor: Colors.white,
                    fieldStyleColor: Colors.deepPurple,
                    hintText: 'Password',
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 characters'
                        : null,
                    textEditingController:
                        context.read<SignUpBloc>().passwordController,
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
                            builder: (context) => const AnonimRegistrScreen()));
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

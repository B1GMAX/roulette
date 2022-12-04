import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/regist_user/sign_in_bloc.dart';

import '../widget/user_input_field.dart';
import 'anonim_regist_screen.dart';

class SignInScreen extends StatelessWidget {
  final VoidCallback goToSignUp;

  const SignInScreen({required this.goToSignUp, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SignInBloc>(
      dispose: (context, bloc) => bloc.dispose(),
      create: (context) => SignInBloc(navigator: Navigator.of(context)),
      builder: (context, child) {
        return Scaffold(
          body: Form(
            key: context.read<SignInBloc>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: UserInputField(
                    textColor: Colors.white,
                    fieldStyleColor: Colors.deepPurple,
                    hintText: 'Name',
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                    textEditingController:
                        context.read<SignInBloc>().emailController,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: UserInputField(
                    textColor: Colors.white,
                    fieldStyleColor: Colors.deepPurple,
                    hintText: 'Password',
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min 6 characters'
                        : null,
                    textEditingController:
                        context.read<SignInBloc>().passwordController,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignInBloc>().signIn();
                  },
                  child: const Text('Sing In'),
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
                      'No account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: goToSignUp, child: const Text('Sing Up'))
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

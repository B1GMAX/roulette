import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/sign_in_bloc.dart';

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
                  child: TextFormField(
                    cursorColor: Colors.deepPurple,
                    controller: context.read<SignInBloc>().emailController,
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
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: TextFormField(
                    cursorColor: Colors.deepPurple,
                    controller: context.read<SignInBloc>().passwordController,
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
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignInBloc>().signIn();
                  },
                  child: Text('Sing In'),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignInBloc>().createAnonymUser();
                  },
                  child: Text('Log in anonymously'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No account?"),
                    TextButton(onPressed: goToSignUp, child: Text('Sing Up'))
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

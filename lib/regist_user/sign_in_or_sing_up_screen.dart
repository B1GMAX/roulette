import 'package:flutter/cupertino.dart';
import 'package:roulette/regist_user/sign_in_screen.dart';
import 'package:roulette/regist_user/sign_up_screen.dart';

class SignInOrSignUpScreen extends StatefulWidget {
  const SignInOrSignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignInOrSignUpScreen> createState() => _SignInOrSignUpScreenState();
}

class _SignInOrSignUpScreenState extends State<SignInOrSignUpScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignInScreen(
          goToSignUp: toggle,
        )
      : SignUpScreen(
          goToSignIn: toggle,
        );

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}

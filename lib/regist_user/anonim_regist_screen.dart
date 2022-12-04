import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/regist_user/anonim_registr_bloc.dart';

import '../widget/user_input_field.dart';


class AnonimRegistrScreen extends StatelessWidget {
  const AnonimRegistrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AnonimRegistBloc(Navigator.of(context)),
      builder: (context, child) {
        return Scaffold(
          body: Form(
            key: context.read<AnonimRegistBloc>().formKey,
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
                                .read<AnonimRegistBloc>()
                                .nameController
                                .text
                                .isEmpty
                        ? 'Enter your name'
                        : null,
                    textEditingController:
                        context.read<AnonimRegistBloc>().nameController,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<AnonimRegistBloc>().createAnonymUser();
                  },
                  child: const Text('Play'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/anonim_registr_bloc.dart';

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
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.deepPurple,
                    controller: context.read<AnonimRegistBloc>().nameController,
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
                            context.read<AnonimRegistBloc>().nameController
                                .text
                                .isEmpty
                        ? 'Enter your name'
                        : null,
                  ),
                ),
                SizedBox(height: 35,),
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

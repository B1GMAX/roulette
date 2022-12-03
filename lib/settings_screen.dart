import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SettingsBloc>(
      create: (BuildContext context) => SettingsBloc(Navigator.of(context)),
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<SettingsBloc>().signOut();
              },
              child: Text('Sign out'),
            ),
          ],
        );
      },
    );
  }
}

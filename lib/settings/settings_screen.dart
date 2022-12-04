import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/settings/settings_bloc.dart';

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
                context.read<SettingsBloc>().showRetaDialog(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Rate App',
                style: TextStyle(fontSize: 37),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SettingsBloc>().signOut();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 50),
              ),
              child: const Text(
                'Sign out',
                style: TextStyle(fontSize: 35),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<SettingsBloc>().delete();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(160, 50),
              ),
              child: const Text(
                'Delete account',
                style: TextStyle(fontSize: 28),
              ),
            ),
          ],
        );
      },
    );
  }
}

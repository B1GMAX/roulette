import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/game/game_screen.dart';
import 'package:roulette/rating/rating_screen.dart';
import 'package:roulette/settings/settings_screen.dart';
import 'package:roulette/slide/slide_bloc.dart';

class SlideScreen extends StatefulWidget {
  const SlideScreen({Key? key}) : super(key: key);

  @override
  State<SlideScreen> createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Provider<SlideBloc>(
      create: (context) => SlideBloc(this),
      dispose: (context, bloc) => bloc.dispose(),
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TabBar(
                  onTap: (index) {
                    context
                        .read<SlideBloc>()
                        .changeUnderlineTabColorByOnTap(index);
                  },
                  controller: context.read<SlideBloc>().tabController,
                  tabs: const [
                    Tab(
                      child: Text('Game'),
                    ),
                    Tab(
                      child: Text('Rating'),
                    ),
                    Tab(
                      child: Text('Settings'),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      context
                          .read<SlideBloc>()
                          .changeUnderlineTabColorByOnPageChange(value);
                    },
                    controller: context.read<SlideBloc>().pageController,
                    children: const [
                      GameScreen(),
                      RatingScreen(),
                      SettingsScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

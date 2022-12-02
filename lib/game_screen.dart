import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/bet_model.dart';
import 'package:roulette/game_bloc.dart';
import 'package:roulette/rotatedContainer.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GameBloc>(
      dispose: (context, bloc) => bloc.dispose(),
      create: (BuildContext context) => GameBloc(navigator: Navigator.of(context)),
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 9, right: 9, top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: RotatedContainer(
                              '1st 12',
                              '1-18',
                              'Even',
                              () => context.read<GameBloc>().addValue(
                                    BetModel(firstRange: [1 - 18]),
                                  ),
                              () => context.read<GameBloc>().addValue(
                                    BetModel(isNumberEven: true),
                                  ),
                            ),
                          ),
                          RotatedContainer(
                              '2nd 12',
                              'Red',
                              'Black',
                              () => context.read<GameBloc>().addValue(
                                    BetModel(tableColor: Colors.red),
                                  ),
                              () => context.read<GameBloc>().addValue(
                                    BetModel(tableColor: Colors.black),
                                  ),
                              Colors.red,
                              Colors.black),
                          RotatedContainer(
                            '3nd 12',
                            'Odd',
                            '19-36',
                            () => context.read<GameBloc>().addValue(
                                  BetModel(isNumberEven: false),
                                ),
                            () => context.read<GameBloc>().addValue(
                                  BetModel(secondRange: [19 - 36]),
                                ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.white,
                                width: 1.2,
                              )),
                              alignment: Alignment.center,
                              height: 50,
                              child: const Text(
                                '0',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 36,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, mainAxisExtent: 45),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    print('value - ${index + 1}');
                                    context
                                        .read<GameBloc>()
                                        .betModelSink
                                        .add(BetModel(tableNumber: index + 1));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1.2),
                                      color: index.isEven
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.2,
                                      ),
                                    ),
                                    height: 40,
                                    child: const Text('2-1',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.2,
                                      ),
                                    ),
                                    height: 40,
                                    child: const Text('2-1',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.2,
                                      ),
                                    ),
                                    height: 40,
                                    child: const Text('2-1',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<int>(
                            stream: context.read<GameBloc>().userValueStream,
                            builder: (context, userSnapshot) {
                              return StreamBuilder<String>(
                                initialData: '',
                                stream: context.read<GameBloc>().userNameStream,
                                builder: (context, nameSnapshot) {
                                  return Column(
                                    children: [
                                      Text(nameSnapshot.data!),
                                      Text('${userSnapshot.data}'),
                                    ],
                                  );
                                }
                              );
                            }),
                        StreamBuilder<int>(
                          initialData: 10,
                          stream: context.read<GameBloc>().betStream,
                          builder: (context, betSnapshot) {
                            return Column(
                              children: [
                                const Text('Bet',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 18)),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<GameBloc>()
                                              .decreaseCount();
                                        },
                                        icon: const Icon(Icons.remove)),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<GameBloc>()
                                              .increaseCount();
                                        },
                                        icon: Icon(Icons.add)),
                                  ],
                                ),
                                Text('${betSnapshot.data}'),
                                StreamBuilder<int>(
                                  initialData: 10,
                                  stream: context.read<GameBloc>().betStream,
                                  builder: (context, betSnapshot) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<GameBloc>()
                                            .start(betSnapshot.data!, context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber),
                                      child: const Text('Start',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/bet_model.dart';
import 'package:roulette/game_bloc.dart';
import 'package:roulette/rotated_container.dart';
import 'package:roulette/user_model.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GameBloc>(
      dispose: (context, bloc) => bloc.dispose(),
      create: (BuildContext context) => GameBloc(Navigator.of(context)),
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 9, right: 9, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: StreamBuilder<bool>(
                            initialData: false,
                            stream: context
                                .read<GameBloc>()
                                .isFirstEighteenSelectedStream,
                            builder: (context, firstEighteenSnapshot) {
                              return StreamBuilder<bool>(
                                  initialData: false,
                                  stream: context
                                      .read<GameBloc>()
                                      .isEvenSelectedStream,
                                  builder: (context, evenSnapshot) {
                                    return StreamBuilder<bool>(
                                        initialData: false,
                                        stream: context
                                            .read<GameBloc>()
                                            .isFirstDozenSelectedStream,
                                        builder: (context, firstDozenSnapshot) {
                                          return RotatedContainer(
                                            '1st 12',
                                            '1-18',
                                            'Even',
                                                () {
                                              context.read<GameBloc>().addValue(
                                                BetModel(
                                                    firstRange:
                                                    List<int>.generate(
                                                        18,
                                                            (i) => i + 1)),
                                              );
                                            },
                                                () {
                                              !evenSnapshot.data!
                                                  ? context
                                                  .read<GameBloc>()
                                                  .addValue(
                                                BetModel(
                                                    isNumberEven: true),
                                              )
                                                  : context
                                                  .read<GameBloc>()
                                                  .addValue(
                                                BetModel(
                                                    isNumberEven: null),
                                              );
                                              context
                                                  .read<GameBloc>()
                                                  .isEvenSelectedSink
                                                  .add(!evenSnapshot.data!);
                                            },
                                                () {
                                              !firstDozenSnapshot.data!
                                                  ? context
                                                  .read<GameBloc>()
                                                  .addValue(BetModel(
                                                  firstDozen: List<
                                                      int>.generate(
                                                      12,
                                                          (i) => i + 1)))
                                                  : context
                                                  .read<GameBloc>()
                                                  .addValue(BetModel(
                                                  firstDozen: null));
                                              context
                                                  .read<GameBloc>()
                                                  .isFirstDozenSelectedSink
                                                  .add(!firstDozenSnapshot
                                                  .data!);
                                            },
                                            firstEighteenSnapshot.data!,
                                            evenSnapshot.data!,
                                            firstDozenSnapshot.data!,
                                          );
                                        });
                                  });
                            }),
                      ),
                      StreamBuilder<bool>(
                          initialData: false,
                          stream: context
                              .read<GameBloc>()
                              .isRedSelectedStream,
                          builder: (context, redSnapshot) {
                            return StreamBuilder<bool>(
                                initialData: false,
                                stream: context
                                    .read<GameBloc>()
                                    .isBlackSelectedStream,
                                builder: (context, blackSnapshot) {
                                  return StreamBuilder<bool>(
                                      initialData: false,
                                      stream: context
                                          .read<GameBloc>()
                                          .isSecondDozenSelectedStream,
                                      builder: (context, secondDozenSnapshot) {
                                        return RotatedContainer(
                                            '2nd 12',
                                            'Red',
                                            'Black', () {
                                          context.read<GameBloc>().addValue(
                                              BetModel(tableColor: Colors.red));
                                        }, () {
                                          !blackSnapshot.data!
                                              ? context
                                              .read<GameBloc>()
                                              .addValue(
                                            BetModel(
                                                tableColor:
                                                Colors.black),
                                          )
                                              : context
                                              .read<GameBloc>()
                                              .addValue(
                                            BetModel(tableColor: null),
                                          );
                                          context
                                              .read<GameBloc>()
                                              .isBlackSelectedSink
                                              .add(!blackSnapshot.data!);
                                        }, () {
                                          !secondDozenSnapshot.data!
                                              ? context
                                              .read<GameBloc>()
                                              .addValue(BetModel(
                                              secondDozen:
                                              List<int>.generate(12,
                                                      (i) {
                                                    return  i + 13;
                                                  },),),)
                                              : context
                                              .read<GameBloc>()
                                              .addValue(BetModel(
                                              secondDozen: null));
                                          context
                                              .read<GameBloc>()
                                              .isSecondDozenSelectedSink
                                              .add(!secondDozenSnapshot.data!);
                                        },
                                            redSnapshot.data!,
                                            blackSnapshot.data!,
                                            secondDozenSnapshot.data!,
                                            Colors.red,
                                            Colors.black);
                                      });
                                });
                          }),
                      StreamBuilder<bool>(
                          initialData: false,
                          stream: context
                              .read<GameBloc>()
                              .isOddSelectedStream,
                          builder: (context, oddSnapshot) {
                            return StreamBuilder<bool>(
                                initialData: false,
                                stream: context
                                    .read<GameBloc>()
                                    .isSecondEighteenSelectedStream,
                                builder: (context, secondEighteenSnapshot) {
                                  return StreamBuilder<bool>(
                                      initialData: false,
                                      stream: context
                                          .read<GameBloc>()
                                          .isThirdDozenSelectedStream,
                                      builder: (context, thirdDozenSnapshot) {
                                        return RotatedContainer(
                                            '3nd 12',
                                            'Odd',
                                            '19-36', () {
                                          !oddSnapshot.data!
                                              ? context
                                              .read<GameBloc>()
                                              .addValue(
                                            BetModel(
                                                isNumberEven: false),
                                          )
                                              : context
                                              .read<GameBloc>()
                                              .addValue(
                                            BetModel(
                                                isNumberEven: null),
                                          );
                                          context
                                              .read<GameBloc>()
                                              .isOddSelectedSink
                                              .add(!oddSnapshot.data!);
                                        }, () {
                                          !secondEighteenSnapshot.data!
                                              ? context
                                              .read<GameBloc>()
                                              .addValue(
                                            BetModel(
                                                secondRange: List<int>.generate(18,
                                                      (i) {
                                                    return  i + 19;
                                                  },),),
                                          )
                                              : context
                                              .read<GameBloc>()
                                              .addValue(
                                            BetModel(secondRange: null),
                                          );
                                          context
                                              .read<GameBloc>()
                                              .isSecondEighteenSelectedSink
                                              .add(!secondEighteenSnapshot
                                              .data!);
                                        }, () {
                                          !thirdDozenSnapshot.data!
                                              ? context
                                              .read<GameBloc>()
                                              .addValue(BetModel(
                                              thirdDozen: List<int>.generate(36,
                                                    (i) {
                                                  return  i + 25;
                                                },),))
                                              : context
                                              .read<GameBloc>()
                                              .addValue(BetModel(
                                              thirdDozen: null));
                                          context
                                              .read<GameBloc>()
                                              .isThirdDozenSelectedSink
                                              .add(!thirdDozenSnapshot.data!);
                                        },
                                            oddSnapshot.data!,
                                            secondEighteenSnapshot.data!,
                                            thirdDozenSnapshot.data!);
                                      });
                                });
                          }),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        StreamBuilder<bool>(
                            initialData: false,
                            stream:
                            context
                                .read<GameBloc>()
                                .isZeroSelectedStream,
                            builder: (context, zeroSnapshot) {
                              return GestureDetector(
                                onTap: !zeroSnapshot.data!
                                    ? () {
                                  context
                                      .read<GameBloc>()
                                      .betModelSink
                                      .add(BetModel(zero: 0));
                                  context
                                      .read<GameBloc>()
                                      .isZeroSelectedSink
                                      .add(!zeroSnapshot.data!);
                                }
                                    : () {
                                  context
                                      .read<GameBloc>()
                                      .betModelSink
                                      .add(BetModel(zero: null));
                                  context
                                      .read<GameBloc>()
                                      .isZeroSelectedSink
                                      .add(!zeroSnapshot.data!);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: !zeroSnapshot.data!
                                            ? Colors.white
                                            : Colors.amber,
                                        width: !zeroSnapshot.data! ? 1.2 : 3,
                                      )),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: const Text(
                                    '0',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }),
                        StreamBuilder<int>(
                            initialData: 37,
                            stream:
                            context
                                .read<GameBloc>()
                                .gridItemIndexStream,
                            builder: (context, indexSnapshot) {
                              return GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 36,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, mainAxisExtent: 43),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: indexSnapshot.data! != index
                                        ? () {
                                      print('value - ${index + 1}');
                                      context
                                          .read<GameBloc>()
                                          .betModelSink
                                          .add(BetModel(
                                          selectedNumber: index + 1));
                                      context
                                          .read<GameBloc>()
                                          .selectItemInGrid(index);
                                    }
                                        : () {
                                      context
                                          .read<GameBloc>()
                                          .selectItemInGrid(37);
                                      context
                                          .read<GameBloc>()
                                          .betModelSink
                                          .add(BetModel(
                                          selectedNumber: null));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: indexSnapshot.data! == index
                                                ? Colors.amber
                                                : Colors.white,
                                            width: indexSnapshot.data! == index
                                                ? 3
                                                : 1.2),
                                        color: index.isEven
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
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
                    StreamBuilder<UserModel>(
                        stream: context
                            .read<GameBloc>()
                            .userModelStream,
                        builder: (context, userSnapshot) {
                          return userSnapshot.hasData
                              ? Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userSnapshot.data!.name,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${userSnapshot.data!.value}',
                                  style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                userSnapshot.data!.value == 0
                                    ? ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<GameBloc>()
                                        .getFreeCoins();
                                  },
                                  child: Text('Get free coins'),
                                )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          )
                              : SizedBox.shrink();
                        }),
                    StreamBuilder<int>(
                      initialData: 10,
                      stream: context
                          .read<GameBloc>()
                          .betStream,
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
                                      context.read<GameBloc>().decreaseCount();
                                    },
                                    icon: const Icon(Icons.remove)),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      context.read<GameBloc>().increaseCount();
                                    },
                                    icon: Icon(Icons.add)),
                              ],
                            ),
                            Text('${betSnapshot.data}'),
                            StreamBuilder<int>(
                              initialData: 10,
                              stream: context
                                  .read<GameBloc>()
                                  .betStream,
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
                                          color: Colors.black, fontSize: 16)),
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
        );
      },
    );
  }
}

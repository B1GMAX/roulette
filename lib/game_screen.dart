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
        final bloc = context.read<GameBloc>();
        return Padding(
          padding: const EdgeInsets.only(left: 9, right: 9, top: 16),
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
                            stream: bloc.isFirstEighteenSelectedStream,
                            builder: (context, firstEighteenSnapshot) {
                              return StreamBuilder<bool>(
                                  initialData: false,
                                  stream: bloc.isEvenSelectedStream,
                                  builder: (context, evenSnapshot) {
                                    return StreamBuilder<bool>(
                                        initialData: false,
                                        stream: bloc.isFirstDozenSelectedStream,
                                        builder: (context, firstDozenSnapshot) {
                                          return RotatedContainer(
                                            '1st 12',
                                            '1-18',
                                            'Even',
                                            () {
                                              !firstEighteenSnapshot.data!
                                                  ? bloc.addValue(
                                                      BetModel(
                                                          firstRange: List<
                                                                  int>.generate(
                                                              18,
                                                              (i) => i + 1)),
                                                    )
                                                  : bloc.addValue(
                                                      BetModel(
                                                          firstRange: null),
                                                    );
                                              bloc.isFirsEighteenSelectedSink
                                                  .add(!firstEighteenSnapshot
                                                      .data!);
                                            },
                                            () {
                                              !evenSnapshot.data!
                                                  ? bloc.addValue(
                                                      BetModel(
                                                          isNumberEven: true),
                                                    )
                                                  : bloc.addValue(
                                                      BetModel(
                                                          isNumberEven: null),
                                                    );
                                              bloc.isEvenSelectedSink
                                                  .add(!evenSnapshot.data!);
                                            },
                                            () {
                                              !firstDozenSnapshot.data!
                                                  ? bloc.addValue(BetModel(
                                                      firstDozen:
                                                          List<int>.generate(12,
                                                              (i) => i + 1)))
                                                  : bloc.addValue(BetModel(
                                                      firstDozen: null));
                                              bloc.isFirstDozenSelectedSink.add(
                                                  !firstDozenSnapshot.data!);
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
                          stream: bloc.isRedSelectedStream,
                          builder: (context, redSnapshot) {
                            return StreamBuilder<bool>(
                                initialData: false,
                                stream: bloc.isBlackSelectedStream,
                                builder: (context, blackSnapshot) {
                                  return StreamBuilder<bool>(
                                      initialData: false,
                                      stream: bloc.isSecondDozenSelectedStream,
                                      builder: (context, secondDozenSnapshot) {
                                        return RotatedContainer(
                                            '2nd 12', 'Red', 'Black', () {
                                          !redSnapshot.data!
                                              ? bloc.addValue(
                                                  BetModel(
                                                      tableColor: Colors.red),
                                                )
                                              : bloc.addValue(
                                                  BetModel(tableColor: null),
                                                );
                                          bloc.isRedSelectedSink
                                              .add(!redSnapshot.data!);
                                        }, () {
                                          !blackSnapshot.data!
                                              ? bloc.addValue(
                                                  BetModel(
                                                      tableColor: Colors.black),
                                                )
                                              : bloc.addValue(
                                                  BetModel(tableColor: null),
                                                );
                                          bloc.isBlackSelectedSink
                                              .add(!blackSnapshot.data!);
                                        }, () {
                                          !secondDozenSnapshot.data!
                                              ? bloc.addValue(
                                                  BetModel(
                                                    secondDozen:
                                                        List<int>.generate(
                                                      12,
                                                      (i) {
                                                        return i + 13;
                                                      },
                                                    ),
                                                  ),
                                                )
                                              : bloc.addValue(
                                                  BetModel(secondDozen: null));
                                          bloc.isSecondDozenSelectedSink
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
                          stream: bloc.isOddSelectedStream,
                          builder: (context, oddSnapshot) {
                            return StreamBuilder<bool>(
                                initialData: false,
                                stream: bloc.isSecondEighteenSelectedStream,
                                builder: (context, secondEighteenSnapshot) {
                                  return StreamBuilder<bool>(
                                      initialData: false,
                                      stream: bloc.isThirdDozenSelectedStream,
                                      builder: (context, thirdDozenSnapshot) {
                                        return RotatedContainer(
                                            '3nd 12', 'Odd', '19-36', () {
                                          !oddSnapshot.data!
                                              ? bloc.addValue(
                                                  BetModel(isNumberEven: false),
                                                )
                                              : bloc.addValue(
                                                  BetModel(isNumberEven: null),
                                                );
                                          bloc.isOddSelectedSink
                                              .add(!oddSnapshot.data!);
                                        }, () {
                                          !secondEighteenSnapshot.data!
                                              ? bloc.addValue(
                                                  BetModel(
                                                    secondRange:
                                                        List<int>.generate(
                                                      18,
                                                      (i) {
                                                        return i + 19;
                                                      },
                                                    ),
                                                  ),
                                                )
                                              : bloc.addValue(
                                                  BetModel(secondRange: null),
                                                );
                                          bloc.isSecondEighteenSelectedSink.add(
                                              !secondEighteenSnapshot.data!);
                                        }, () {
                                          !thirdDozenSnapshot.data!
                                              ? bloc.addValue(BetModel(
                                                  thirdDozen:
                                                      List<int>.generate(
                                                    36,
                                                    (i) {
                                                      return i + 25;
                                                    },
                                                  ),
                                                ))
                                              : bloc.addValue(
                                                  BetModel(thirdDozen: null));
                                          bloc.isThirdDozenSelectedSink
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
                            stream: bloc.isZeroSelectedStream,
                            builder: (context, zeroSnapshot) {
                              return GestureDetector(
                                onTap: !zeroSnapshot.data!
                                    ? () {
                                        bloc.betModelSink
                                            .add(BetModel(zero: 0));
                                        bloc.isZeroSelectedSink
                                            .add(!zeroSnapshot.data!);
                                      }
                                    : () {
                                        bloc.betModelSink
                                            .add(BetModel(zero: null));
                                        bloc.isZeroSelectedSink
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
                            stream: bloc.gridItemIndexStream,
                            builder: (context, indexSnapshot) {
                              return GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 36,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, mainAxisExtent: 40),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: indexSnapshot.data! != index
                                        ? () {
                                            print('value - ${index + 1}');
                                            bloc.betModelSink.add(BetModel(
                                                selectedNumber: index + 1));
                                            bloc.selectItemInGrid(index);
                                          }
                                        : () {
                                            bloc.selectItemInGrid(37);
                                            bloc.betModelSink.add(
                                                BetModel(selectedNumber: null));
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
                        stream: bloc.userModelStream,
                        builder: (context, userSnapshot) {
                          return userSnapshot.hasData
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35,),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            userSnapshot.data!.name,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            '${userSnapshot.data!.value}',
                                            style: const TextStyle(
                                                color: Colors.amber,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'winRate: ${userSnapshot.data!.winRate}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      userSnapshot.data!.value == 0
                                          ? ElevatedButton(
                                              onPressed: () {
                                                bloc.getFreeCoins();
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
                      stream: bloc.betStream,
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
                                      bloc.decreaseCount();
                                    },
                                    icon: const Icon(Icons.remove)),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () {
                                      bloc.increaseCount();
                                    },
                                    icon: Icon(Icons.add)),
                              ],
                            ),
                            Text('${betSnapshot.data}'),
                            StreamBuilder<int>(
                              initialData: 10,
                              stream: bloc.betStream,
                              builder: (context, betSnapshot) {
                                return ElevatedButton(
                                  onPressed: () {
                                    bloc.start(betSnapshot.data!, context);
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

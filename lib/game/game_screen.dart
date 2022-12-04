import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/model/user_model.dart';

import '../model/bet_model.dart';
import '../widget/bet_widget.dart';
import '../widget/bottom_container.dart';
import '../widget/rotated_container.dart';
import '../widget/table_widget.dart';
import '../widget/user_widget.dart';
import 'game_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GameBloc>(
      dispose: (context, bloc) => bloc.dispose(),
      create: (context) => GameBloc(),
      builder: (context, child) {
        final bloc = context.read<GameBloc>();
        return SingleChildScrollView(
          child: Padding(
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
                                                final bet = BetModel(
                                                    firstRange:
                                                        List<int>.generate(
                                                            18, (i) => i + 1));
                                                if (!firstEighteenSnapshot
                                                    .data!) {
                                                  bloc.addBet(bet);
                                                } else {
                                                  bloc.removeBet(bet);
                                                }
                                                bloc.isFirsEighteenSelectedSink
                                                    .add(!firstEighteenSnapshot
                                                        .data!);
                                              },
                                              () {
                                                final bet =
                                                    BetModel(isNumberEven: true);
                                                if (!evenSnapshot.data!) {
                                                  bloc.addBet(bet);
                                                } else {
                                                  bloc.removeBet(bet);
                                                }
                                                bloc.isEvenSelectedSink
                                                    .add(!evenSnapshot.data!);
                                              },
                                              () {
                                                final bet = BetModel(
                                                    firstDozen:
                                                        List<int>.generate(
                                                            12, (i) => i + 1));
                                                if (!firstDozenSnapshot.data!) {
                                                  bloc.addBet(bet);
                                                } else {
                                                  bloc.removeBet(bet);
                                                }
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
                                            final bet =
                                                BetModel(tableColor: Colors.red);
                                            if (!redSnapshot.data!) {
                                              bloc.addBet(bet);
                                            } else {
                                              bloc.removeBet(bet);
                                            }
                                            bloc.isRedSelectedSink
                                                .add(!redSnapshot.data!);
                                          }, () {
                                            final bet = BetModel(
                                                tableColor: Colors.black);
                                            if (!blackSnapshot.data!) {
                                              bloc.addBet(bet);
                                            } else {
                                              bloc.removeBet(bet);
                                            }
                                            bloc.isBlackSelectedSink
                                                .add(!blackSnapshot.data!);
                                          }, () {
                                            final bet = BetModel(
                                                secondDozen: List<int>.generate(
                                              12,
                                              (i) {
                                                return i + 13;
                                              },
                                            ));
                                            if (!secondDozenSnapshot.data!) {
                                              bloc.addBet(bet);
                                            } else {
                                              bloc.removeBet(bet);
                                            }
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
                                            final bet =
                                                BetModel(isNumberEven: false);
                                            if (!oddSnapshot.data!) {
                                              bloc.addBet(bet);
                                            } else {
                                              bloc.removeBet(bet);
                                            }

                                            bloc.isOddSelectedSink
                                                .add(!oddSnapshot.data!);
                                          }, () {
                                            final bet = BetModel(
                                                secondRange: List<int>.generate(
                                              18,
                                              (i) {
                                                return i + 19;
                                              },
                                            ));
                                            if (!secondEighteenSnapshot.data!) {
                                              bloc.addBet(bet);
                                            } else {
                                              bloc.removeBet(bet);
                                            }
                                            bloc.isSecondEighteenSelectedSink.add(
                                                !secondEighteenSnapshot.data!);
                                          }, () {
                                            final bet = BetModel(
                                                thirdDozen: List<int>.generate(
                                              36,
                                              (i) {
                                                return i + 25;
                                              },
                                            ));
                                            if (!thirdDozenSnapshot.data!) {
                                              bloc.addBet(bet);
                                            } else {
                                              bloc.removeBet(bet);
                                            }

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
                                  onTap: () {
                                    final bet = BetModel(zero: 0);
                                    !zeroSnapshot.data!
                                        ? bloc.addBet(bet)
                                        : bloc.removeBet(bet);
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
                                    return TableWidget(
                                      addBetModelAction: () {
                                        final bet =
                                            BetModel(selectedNumber: index + 1);
                                        if (indexSnapshot.data! != index) {
                                          bloc.addBet(bet);
                                        } else {
                                          bloc.removeBet(bet);
                                        }
                                        bloc.selectItemInGrid(
                                            indexSnapshot.data! != index
                                                ? index
                                                : 37);
                                      },
                                      indexSnapshot: indexSnapshot.data!,
                                      index: index,
                                    );
                                  },
                                );
                              }),
                          Row(
                            children: const [
                              Expanded(child: BottomContainer()),
                              Expanded(child: BottomContainer()),
                              Expanded(child: BottomContainer()),
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
                                      left: 35,
                                    ),
                                    child: UserWidget(
                                      userName: userSnapshot.data!.name,
                                      userValue: userSnapshot.data!.value,
                                      userWinRate: userSnapshot.data!.winRate,
                                      getFreeCoins: () => bloc.getFreeCoins(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          }),
                      StreamBuilder<int>(
                        initialData: 10,
                        stream: bloc.betStream,
                        builder: (context, betSnapshot) {
                          return BetWidget(
                              decreaseCount: () => bloc.decreaseCount(),
                              increaseCount: () => bloc.increaseCount(),
                              value: betSnapshot.data!,
                              start: () =>
                                  bloc.start(betSnapshot.data!, context));
                        },
                      ),
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

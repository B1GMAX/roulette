import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/game_bloc.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<GameBloc>(
      dispose: (context, bloc) => bloc.dispose(),
      create: (BuildContext context) => GameBloc(),
      builder: (context, child) {
        return Scaffold(
          body: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 55),
                  height: 629,
                  width: 365,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              width: 180,
                              height: 50,
                              margin: const EdgeInsets.only(left: 50),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                children: [
                                  const Text(
                                    '1st 12',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.white),
                                              right: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          width: 90,
                                          height: 30,
                                          child: const Text(
                                            '1-18',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<GameBloc>()
                                              .firstRangeNumbersSink
                                              .add([1, 18]);
                                        },
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          width: 88,
                                          height: 30,
                                          child: const Text(
                                            'Even',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<GameBloc>()
                                              .isNumberEvenSink
                                              .add(true);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                children: [
                                  const Text(
                                    '2nd 12',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<GameBloc>()
                                              .tableColorSink
                                              .add(Colors.red);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.white),
                                                right: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.red),
                                          alignment: Alignment.center,
                                          width: 90,
                                          height: 30,
                                          child: const Text(
                                            'Red',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<GameBloc>()
                                              .tableColorSink
                                              .add(Colors.black);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              color: Colors.black),
                                          alignment: Alignment.center,
                                          width: 88,
                                          height: 30,
                                          child: const Text(
                                            'Black',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Column(
                                children: [
                                  const Text(
                                    '3rd 12',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.white),
                                              right: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          width: 90,
                                          height: 30,
                                          child: const Text(
                                            'Odd',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<GameBloc>()
                                              .isNumberEvenSink
                                              .add(false);
                                        },
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          width: 88,
                                          height: 30,
                                          child: const Text(
                                            '19-36',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<GameBloc>()
                                              .secondRangeNumbersSink
                                              .add([19, 36]);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
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
                            Expanded(
                              child: GridView.builder(
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
                                          .tableNumberSink
                                          .add(index + 1);
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
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.2,
                                    ),
                                  ),
                                  height: 40,
                                  width: 105,
                                  child: const Text('2-1',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.2,
                                    ),
                                  ),
                                  height: 40,
                                  width: 105,
                                  child: const Text('2-1',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1.2,
                                    ),
                                  ),
                                  height: 40,
                                  width: 105,
                                  child: const Text('2-1',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<int>(
                        initialData: 30000,
                        stream: context.read<GameBloc>().userValueStream,
                        builder: (context, userSnapshot) {
                          return Column(
                            children: [
                              Text('User name'),
                              Text('${userSnapshot.data}'),
                            ],
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
                            StreamBuilder<List<int>>(
                              stream: context
                                  .read<GameBloc>()
                                  .secondRangeNumbersStream,
                              builder: (context, secondRangeSnapshot) {
                                return StreamBuilder<List<int>>(
                                  stream: context
                                      .read<GameBloc>()
                                      .firstRangeNumbersStream,
                                  builder: (context, firstRangeSnapshot) {
                                    return StreamBuilder<Color>(
                                      stream: context
                                          .read<GameBloc>()
                                          .tableColorStream,
                                      builder: (context, colorSnapshot) {
                                        return StreamBuilder<int?>(
                                          stream: context
                                              .read<GameBloc>()
                                              .tableNumberStream,
                                          builder:
                                              (context, tableNumberSnapshot) {
                                            return StreamBuilder<bool>(
                                                stream: context
                                                    .read<GameBloc>()
                                                    .isNumberEvenStream,
                                                builder:
                                                    (context, isEvenSnapshot) {
                                                  return ElevatedButton(
                                                    onPressed: isEvenSnapshot
                                                                .hasData ||
                                                            secondRangeSnapshot
                                                                .hasData ||
                                                            firstRangeSnapshot
                                                                .hasData ||
                                                            colorSnapshot
                                                                .hasData ||
                                                            tableNumberSnapshot
                                                                .hasData
                                                        ? () {
                                                            context.read<GameBloc>().start(
                                                                context,
                                                                betSnapshot
                                                                    .data!,
                                                                tableNumberSnapshot
                                                                    .data,
                                                                colorSnapshot
                                                                    .data,
                                                                firstRangeSnapshot
                                                                    .data,
                                                                secondRangeSnapshot
                                                                    .data,
                                                                isEvenSnapshot
                                                                    .data);
                                                            print('Start');
                                                          }
                                                        : () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.amber),
                                                    child: const Text('Start',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16)),
                                                  );
                                                });
                                          },
                                        );
                                      },
                                    );
                                  },
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

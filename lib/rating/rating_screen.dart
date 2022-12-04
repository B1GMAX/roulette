import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/rating/rating_bloc.dart';
import 'package:roulette/model/user_model.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<RatingBloc>(
      create: (BuildContext context) => RatingBloc(),
      builder: (context, child) {
        return StreamBuilder<UserModel>(
            stream: context.read<RatingBloc>().userModelStream,
            builder: (context, userModelSnapshot) {
              return Column(
                children: [
                  userModelSnapshot.hasData
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  userModelSnapshot.data!.name,
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.red),
                                ),
                                Text(
                                  'winRate: ${userModelSnapshot.data!.winRate}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Text(
                              userModelSnapshot.data!.value.toString(),
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.amber),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  StreamBuilder<List<UserModel>>(
                      stream: context.read<RatingBloc>().usersModelListStream,
                      builder: (context, usersSnapshot) {
                        return usersSnapshot.hasData
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: ListView.builder(
                                    itemCount: usersSnapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.indigo)),
                                        margin: const EdgeInsets.only(
                                            top: 15, right: 35, left: 35),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text((index + 1).toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black)),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      usersSnapshot
                                                          .data![index].name,
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.red),
                                                    ),
                                                    Text(
                                                      'winRate: ${usersSnapshot.data![index].winRate}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: Text(
                                                usersSnapshot.data![index].value
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.amber),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      }),
                ],
              );
            });
      },
    );
  }
}

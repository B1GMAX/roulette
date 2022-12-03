import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roulette/rating_bloc.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<RatingBloc>(
      create: (BuildContext context) => RatingBloc(),
      builder: (context, child) {
        return StreamBuilder(
            stream: context.read<RatingBloc>().readUsers(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo)),
                            margin: const EdgeInsets.only(
                                top: 15, right: 35, left: 35),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(index.toString()),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      snapshot.data![index].name,
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.red),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                Text(snapshot.data![index].value.toString(),
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.amber))
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox.shrink();
            });
      },
    );
  }
}

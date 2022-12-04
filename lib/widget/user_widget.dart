import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  final String userName;
  final int userValue;
  final int userWinRate;
  final VoidCallback getFreeCoins;

  const UserWidget(
      {Key? key,
      required this.userName,
      required this.userValue,
      required this.userWinRate,
      required this.getFreeCoins})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              userName,
              style: const TextStyle(
                  color: Colors.red, fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              userValue.toString(),
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
          'winRate: $userWinRate',
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        userValue == 0
            ? ElevatedButton(
                onPressed: getFreeCoins,
                child: const Text('Get free coins'),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

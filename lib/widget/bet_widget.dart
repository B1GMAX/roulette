import 'package:flutter/material.dart';

class BetWidget extends StatelessWidget {
  final VoidCallback decreaseCount;
  final VoidCallback increaseCount;
  final int value;
  final VoidCallback start;

  const BetWidget(
      {Key? key,
      required this.decreaseCount,
      required this.increaseCount,
      required this.value,
      required this.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Bet', style: TextStyle(color: Colors.amber, fontSize: 18)),
        Row(
          children: [
            IconButton(
                onPressed: decreaseCount, icon: const Icon(Icons.remove)),
            const SizedBox(
              width: 5,
            ),
            IconButton(onPressed: increaseCount, icon: const Icon(Icons.add)),
          ],
        ),
        Text(value.toString()),
        ElevatedButton(
          onPressed: start,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
          child: const Text('Start',
              style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
      ],
    );
  }
}

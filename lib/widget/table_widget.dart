import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final VoidCallback addBetModelAction;
  final int indexSnapshot;
  final int index;

  const TableWidget(
      {Key? key,
      required this.addBetModelAction,
      required this.indexSnapshot,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addBetModelAction,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: indexSnapshot == index ? Colors.amber : Colors.white,
              width: indexSnapshot == index ? 3 : 1.2),
          color: index.isEven ? Colors.red : Colors.black,
        ),
        alignment: Alignment.center,
        child: Text(
          '${index + 1}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

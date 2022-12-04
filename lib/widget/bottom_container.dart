import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1.2,
        ),
      ),
      height: 40,
      child: const Text('2-1', style: TextStyle(color: Colors.white)),
    );
  }
}

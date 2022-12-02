import 'package:flutter/material.dart';

class RotatedContainer extends StatelessWidget {
  final String textInColumn;
  final String firstTextInRow;
  final String secondTextInRow;
  final VoidCallback firstColumnAction;
  final VoidCallback secondColumnAction;
  final Color? firstColumnColor;
  final Color? secondColumnColor;

  const RotatedContainer(this.textInColumn, this.firstTextInRow,
      this.secondTextInRow, this.firstColumnAction, this.secondColumnAction,
      [this.firstColumnColor, this.secondColumnColor, Key? key])
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: Column(
          children: [
            Text(
              textInColumn,
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: firstColumnAction,
                  child: Container(
                    decoration: BoxDecoration(
                        border: const Border(
                          top: BorderSide(color: Colors.white),
                          right: BorderSide(color: Colors.white),
                        ),
                        color: firstColumnColor),
                    alignment: Alignment.center,
                    width: 90,
                    height: 30,
                    child: Text(
                      firstTextInRow,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: secondColumnAction,
                  child: Container(
                    decoration: BoxDecoration(
                        border: const Border(
                          top: BorderSide(color: Colors.white),
                        ),
                        color: secondColumnColor),
                    alignment: Alignment.center,
                    width: 88,
                    height: 30,
                    child: Text(
                      secondTextInRow,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

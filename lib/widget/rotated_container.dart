import 'package:flutter/material.dart';

class RotatedContainer extends StatelessWidget {
  final String textInColumn;
  final String firstTextInRow;
  final String secondTextInRow;
  final VoidCallback firstRowAction;
  final VoidCallback secondRowAction;
  final VoidCallback dozenAction;
  final bool isDozenSelected;
  final Color? firstColumnColor;
  final Color? secondColumnColor;
  final bool isFirstElevenSelected;
  final bool isSecondElementSelected;

  const RotatedContainer(
      this.textInColumn,
      this.firstTextInRow,
      this.secondTextInRow,
      this.firstRowAction,
      this.secondRowAction,
      this.dozenAction,
      this.isFirstElevenSelected,
      this.isSecondElementSelected,
      this.isDozenSelected,
      [this.firstColumnColor,
      this.secondColumnColor,
      Key? key])
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: Column(
          children: [
            GestureDetector(
              onTap: dozenAction,
              child: Container(
                width: 158,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: isDozenSelected
                      ? Border.all(color: Colors.amber, width: 1.8)
                      : Border.all(color: Colors.transparent),
                ),
                child: Text(
                  textInColumn,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: firstRowAction,
                  child: Container(
                    decoration: BoxDecoration(
                        border: !isFirstElevenSelected
                            ? const Border(
                                top: BorderSide(color: Colors.white),
                                right: BorderSide(color: Colors.white),
                              )
                            : Border.all(color: Colors.amber, width: 3),
                        color: firstColumnColor),
                    alignment: Alignment.center,
                    width: 79,
                    height: 30,
                    child: Text(
                      firstTextInRow,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: secondRowAction,
                  child: Container(
                    decoration: BoxDecoration(
                        border: !isSecondElementSelected
                            ? const Border(
                                top: BorderSide(color: Colors.white),
                              )
                            : Border.all(color: Colors.amber, width: 3),
                        color: secondColumnColor),
                    alignment: Alignment.center,
                    width: 79,
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

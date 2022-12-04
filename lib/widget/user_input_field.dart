import 'package:flutter/material.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Color textColor;
  final Color fieldStyleColor;
  final String hintText;
  final String? Function(String?) validator;

  const UserInputField(
      {Key? key,
      required this.textEditingController,
      required this.textColor,
      required this.fieldStyleColor,
      required this.hintText,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: textColor),
      cursorColor: fieldStyleColor,
      controller: textEditingController,
      decoration: InputDecoration(
        focusColor: fieldStyleColor,
        hintText: hintText,
        hintStyle: TextStyle(color: fieldStyleColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: fieldStyleColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: fieldStyleColor),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}

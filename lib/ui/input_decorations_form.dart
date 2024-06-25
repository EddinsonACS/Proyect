import 'package:flutter/material.dart';

class InputDecorationsForm {
  static InputDecoration authInputDecorationForm(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 3)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.blueGrey,
              )
            : null);
  }
}

import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xA9037584),
      content: Center(
        child: Text(message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
      ),
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}

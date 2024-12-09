import 'package:flutter/material.dart';

class EasySnackbar {
  static void show({required BuildContext context, required String text}) {
    var snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      elevation: 32,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

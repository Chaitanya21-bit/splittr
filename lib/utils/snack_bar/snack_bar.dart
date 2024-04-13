import 'package:flutter/material.dart';

Future<void> showSnackBar(BuildContext context, String message) async {
  await ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    ).closed;
}

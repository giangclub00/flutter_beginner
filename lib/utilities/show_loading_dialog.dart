import 'package:flutter/material.dart';

Future<void> showLoading(
  BuildContext context
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('An error occurred'),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(
                margin: const EdgeInsets.only(left: 5),
                child: const Text("Loading")),
          ],
        ),
      );
    },
  );
}

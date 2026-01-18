import 'package:flutter/material.dart';

class MessagePopup extends StatelessWidget {
  final String message;
  final String title;

  const MessagePopup({
    super.key, 
    required this.message,
    required this.title,
  });

  static void show(
    BuildContext context, {
    required String message,
    required String title,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => MessagePopup(
        message: message,
        title: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
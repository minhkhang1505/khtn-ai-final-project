import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Hello! Start a new conversation🎉',
          style: TextStyle(
            fontSize: 30,
            color: colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
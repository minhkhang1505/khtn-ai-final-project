import 'package:flutter/material.dart';

class FailureStateWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  const FailureStateWidget({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Something went wrong. Please try again.",
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          ElevatedButton(onPressed: onRetry, child: const Text("Try again")),
        ],
      ),
    );
  }
}

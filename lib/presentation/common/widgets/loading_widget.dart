import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

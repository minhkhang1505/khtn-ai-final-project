import 'package:flutter/material.dart';

/// Footer widget displaying app version
class AccountFooter extends StatelessWidget {
  final String version;

  const AccountFooter({super.key, required this.version});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Version $version',
        style: TextStyle(color: colorScheme.onSurface.withAlpha(140)),
      ),
    );
  }
}

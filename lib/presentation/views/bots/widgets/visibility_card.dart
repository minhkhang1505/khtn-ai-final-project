import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/expanded_button.dart';

class VisibilityCard extends StatefulWidget {
  final VoidCallback onStatusChanged;

  const VisibilityCard({
    super.key,
    required this.onStatusChanged,
  });

  @override
  State<VisibilityCard> createState() => _VisibilityCardState();
}

class _VisibilityCardState extends State<VisibilityCard> {
  bool isPublic = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
        side: BorderSide(
          color: colorScheme.outlineVariant.withAlpha(100),
          width: 1.5,
        ),
      ),
      color: colorScheme.surfaceContainerLow.withAlpha(10),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Visibility and Sharing',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),

            // Visibility Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make this bot public',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Enable or disable this bot',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: isPublic,
                  onChanged: (value) {
                    setState(() {
                      isPublic = value;
                      widget.onStatusChanged.call();
                    });
                    // TODO: update visibility status
                  },
                )
              ],
            ),
            const SizedBox(height: 16),

            // Share Bot Section
            const Text(
              'Share your bot',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ExpandedButton(
              onPressed: () {
                // TODO: Handle edit visibility action
              },
              icon: const Icon(Icons.share, size: 16),
              label: 'Share Bot',
            ),
          ],
        ),
      ),
    );
  }
}
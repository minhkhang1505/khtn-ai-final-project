import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

/// Section for account actions like logout
class AccountActionsSection extends StatelessWidget {
  final VoidCallback? onLogoutPressed;

  const AccountActionsSection({super.key, this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorScheme.outlineVariant.withAlpha(150),
          width: 1.5,
        ),
        color: colorScheme.surfaceContainerLow,
        borderRadius: AppBorderRadius.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Account Actions",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: AppBorderRadius.medium,
                side: BorderSide(color: colorScheme.errorContainer, width: 1),
              ),
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: onLogoutPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_logout.svg',
                  colorFilter: ColorFilter.mode(
                    colorScheme.error,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Text("Log Out", style: TextStyle(color: colorScheme.error)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

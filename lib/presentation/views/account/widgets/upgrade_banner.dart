import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

/// Banner widget promoting upgrade to Pro plan
class UpgradeBanner extends StatelessWidget {
  final VoidCallback? onDismiss;
  final VoidCallback? onTap;

  const UpgradeBanner({super.key, this.onDismiss, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 6, 0),
        height: 70,
        decoration: BoxDecoration(
          color: colorScheme.primary.withAlpha(50),
          borderRadius: AppBorderRadius.large,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/ic_upgrade.svg',
              colorFilter: ColorFilter.mode(
                colorScheme.primary.withAlpha(200),
                BlendMode.srcIn,
              ),
            ),
            const Expanded(
              child: Text(
                "Upgrade to Pro for unlimited access",
                style: TextStyle(fontSize: 14),
              ),
            ),
            IconButton(onPressed: onDismiss, icon: const Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}

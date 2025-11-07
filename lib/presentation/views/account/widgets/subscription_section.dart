import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/views/account/models/account_models.dart';

/// Section displaying current subscription plan
class SubscriptionSection extends StatelessWidget {
  final SubscriptionPlan currentPlan;
  final VoidCallback? onUpgradePressed;
  final bool isProUser;

  const SubscriptionSection({
    super.key,
    required this.currentPlan,
    this.onUpgradePressed,
    required this.isProUser,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isProUser
              ? Colors.yellow
              : colorScheme.outlineVariant.withAlpha(150),
          width: 1.5,
        ),
        color: isProUser
            ? Colors.yellow.withAlpha(10)
            : colorScheme.surfaceContainerLow,
        borderRadius: AppBorderRadius.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Subscription",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          if (isProUser)
            ProPlanInfo(plan: currentPlan)
          else
            _CurrentPlanInfo(plan: currentPlan),
          const SizedBox(height: 16),
          if (!isProUser)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: AppBorderRadius.medium,
                ),
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: onUpgradePressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_upgrade.svg',
                    colorFilter: ColorFilter.mode(
                      colorScheme.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Upgrade to Pro",
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ProPlanInfo extends StatelessWidget {
  final SubscriptionPlan plan;

  const ProPlanInfo({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(plan.name, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: AppBorderRadius.small,
              ),
              child: Text(
                "Active",
                style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
              ),
            ),
          ],
        ),
        Text(
          "${plan.price}/month, next billing date: ${plan.nextBillingDate}",
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface.withAlpha(140),
          ),
        ),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...plan.features.map(
              (feature) => Row(
                children: [
                  Icon(Icons.check, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    feature.title,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withAlpha(140),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CurrentPlanInfo extends StatelessWidget {
  final SubscriptionPlan plan;

  const _CurrentPlanInfo({required this.plan});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(plan.name, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            if (plan.isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: AppBorderRadius.small,
                ),
                child: Text(
                  "Current",
                  style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
                ),
              ),
          ],
        ),
        Text(
          plan.subtitle,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurface.withAlpha(140),
          ),
        ),
      ],
    );
  }
}

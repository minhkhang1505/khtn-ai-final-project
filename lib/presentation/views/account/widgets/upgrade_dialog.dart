import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/views/account/models/account_models.dart';

/// Dialog for displaying and confirming plan upgrade
class UpgradeDialog extends StatelessWidget {
  final SubscriptionPlan upgradePlan;
  final VoidCallback? onUpgradeConfirmed;
  final VoidCallback? onDismiss;

  const UpgradeDialog({
    super.key,
    required this.upgradePlan,
    this.onUpgradeConfirmed,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DialogHeader(onDismiss: onDismiss ?? () => Navigator.pop(context)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _PriceDisplay(plan: upgradePlan),
                  const SizedBox(height: 16),
                  _FeaturesList(features: upgradePlan.features),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.large,
                      ),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: onUpgradeConfirmed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_promote.svg',
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
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  final VoidCallback onDismiss;

  const _DialogHeader({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 2, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_upgrade.svg',
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          const Text("Upgrade to Pro"),
          const Spacer(),
          IconButton(
            onPressed: onDismiss,
            icon: Icon(Icons.close, size: 16, color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

class _PriceDisplay extends StatelessWidget {
  final SubscriptionPlan plan;

  const _PriceDisplay({required this.plan});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              plan.price,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(plan.billingPeriod, style: const TextStyle(fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
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

class _FeaturesList extends StatelessWidget {
  final List<PlanFeature> features;

  const _FeaturesList({required this.features});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: features
          .map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(Icons.check, color: colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          feature.description,
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
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'bots_card.dart';

class BotList extends StatelessWidget {
  final ValueChanged<BotModel>? onTap;
  final ValueChanged<String>? onFavoriteToggle;
  final Future<void> Function(BotModel)? onEdit;
  final List<BotModel> bots;
  const BotList({
    super.key,
    required this.bots,
    this.onTap,
    this.onFavoriteToggle,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final bot = bots[index];
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.horizontal - 4,
            right: AppSpacing.horizontal - 4,
            bottom: index == bots.length - 1
                ? AppSpacing.vertical
                : AppSpacing.cardSpacing,
          ),
          child: InkWell(
            borderRadius: AppBorderRadius.medium,
            onTap: () => onTap?.call(bot),
            child: BotCard(
              bot: bot,
              onFavoriteToggle: () {
                onFavoriteToggle?.call(bot.id);
              },
              onEdit: onEdit != null ? () => onEdit!(bot) : null,
            ),
          ),
        );
      }, childCount: bots.length),
    );
  }
}

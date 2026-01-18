import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';

class EditBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final BotModel bot;

  const EditBotAppBar({super.key, required this.bot, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: false,
      leading: IconButton(
        onPressed: onBackPressed,
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                bot.assistantName,
                style: AppBarInfo.titleTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(height: 4),
          // Subtitle - only show on tablet and desktop
          if (ResponsiveHelper.isDesktop(context) ||
              ResponsiveHelper.isTablet(context))
            Text(
              bot.description.isEmpty ? 'No description' : bot.description,
              style: AppBarInfo.subtitleTextStyle,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

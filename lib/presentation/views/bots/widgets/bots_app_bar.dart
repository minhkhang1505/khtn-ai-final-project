import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';

class BotAppBar extends StatelessWidget implements PreferredSizeWidget {

  const BotAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bots', style: AppBarInfo.titleTextStyle),
          SizedBox(height: 4),
          if (ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTablet(context)) 
            Text('Automate tasks with AI-powered workflows', style: AppBarInfo.subtitleTextStyle),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

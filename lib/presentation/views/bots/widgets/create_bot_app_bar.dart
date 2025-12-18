import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';

class CreateBotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreateBotAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: false,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create Bot', style: AppBarInfo.titleTextStyle),
          SizedBox(height: 4),
          if (ResponsiveHelper.isDesktop(context) ||
              ResponsiveHelper.isTablet(context))
            Text(
              'Set up your AI assistant bot',
              style: AppBarInfo.subtitleTextStyle,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

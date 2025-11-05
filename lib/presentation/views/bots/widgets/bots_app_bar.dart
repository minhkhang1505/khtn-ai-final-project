import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';

class BotAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddBot;

  const BotAppBar({super.key, required this.onAddBot});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bots', style: AppBarInfo.titleTextStyle),
            SizedBox(height: 4),
            if (ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTablet(context)) 
              Text('Automate tasks with AI-powered workflows', style: AppBarInfo.subtitleTextStyle),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: onAddBot,
          icon: SvgPicture.asset(
            'assets/icons/ic_add.svg',
            width: 45,
            height: 45,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

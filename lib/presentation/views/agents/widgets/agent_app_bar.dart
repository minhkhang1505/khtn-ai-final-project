import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';

class AgentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddAgent;

  const AgentAppBar({super.key, required this.onAddAgent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Agents', style: AppBarInfo.titleTextStyle),
          SizedBox(height: 4),
          if (ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTablet(context)) 
            Text('Automate tasks with AI-powered workflows', style: AppBarInfo.subtitleTextStyle),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onAddAgent,
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

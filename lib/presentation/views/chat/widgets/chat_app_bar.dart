import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'bot_option_menu.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddNewChat;
  
  const ChatAppBar({super.key, required this.onAddNewChat});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      automaticallyImplyLeading: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chat', style: AppBarInfo.titleTextStyle),
        ],
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(width: 120, child: BotOptionMenu()),
            ),

            IconButton(
              onPressed: () {
                // TODO: Handle add new chat
              },
              icon: SvgPicture.asset(
                'assets/icons/ic_add.svg',
                width: 45,
                height: 45,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'bot_option_menu.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddNewChat;
  
  const ChatAppBar({super.key, required this.onAddNewChat});

  void _onAddNewChat() {
    onAddNewChat();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.read<ChatViewModel>();
    return AppBar(
      automaticallyImplyLeading: true,
      title: (ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTablet(context))
          ? Text(
              vm.conversationTitle,
              style: AppBarInfo.titleTextStyle,
            )
          : null,
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 200, 
                  minWidth: 50, 
                ),
                child: BotOptionMenu(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/ic_add.svg',
                  width: 45,
                  height: 45,
                  colorFilter: ColorFilter.mode(
                    colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  _onAddNewChat();
                },
                // () async {
                //   final confirm = await showDialog<bool>(
                //     context: context,
                //     builder: (ctx) => AlertDialog(
                //       title: const Text('Draft dialog data'),
                //       content: Text(vm.messagesContent),
                //       actions: [
                //         TextButton(
                //           onPressed: () => Navigator.of(ctx).pop(false),
                //           child: const Text('Cancel'),
                //         ),
                //         TextButton(
                //           onPressed: () => Navigator.of(ctx).pop(true),
                //           child: const Text('Delete', style: TextStyle(color: Colors.red)),
                //         ),
                //       ],
                //     ),
                //   );
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

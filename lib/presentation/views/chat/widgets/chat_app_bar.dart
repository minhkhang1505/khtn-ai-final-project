import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_app_bar_view_model.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'bot_option_menu.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddNewChat;
  final ValueChanged<AssistantModel>? onModelChanged;
  
  const ChatAppBar({super.key, required this.onAddNewChat, this.onModelChanged});

  void _onAddNewChat() {
    onAddNewChat();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final chatAppBarViewModel = sl<ChatAppBarViewModel>();

    return AppBar(
      automaticallyImplyLeading: true,
      title: (ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTablet(context))
          ? Text(
              chatAppBarViewModel.conversationTitle,
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
                child: BotOptionMenu(
                  onSelected: (assistant) {
                    if (onModelChanged != null) {
                      onModelChanged!(assistant);
                    }
                  }
                ),
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

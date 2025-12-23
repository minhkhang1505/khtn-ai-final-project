import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:khtn_ai_final_project/presentation/views/chat/widgets/message_input.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/message_popup.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';

import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';

import 'widgets/chat_app_bar.dart';
import 'widgets/chat_drawer.dart';
import 'widgets/message_list.dart';
import 'widgets/usage_button.dart';
import 'widgets/empty_widget.dart';


/// Chat page - Main chat interface
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.read<ChatViewModel>();
    return Scaffold(
      appBar: ChatAppBar(onAddNewChat: () => vm.newChat()),
      drawer: ChatDrawer(),
      body: Column(
        children: [
          // Message list or welcome message
          Expanded(
            child: vm.conversationId.isEmpty
                ? const EmptyWidget()
                : // Message list
                  MessageList(scrollController: vm.scrollController),
          ),

          // Loading indicator
          if (context.watch<ChatViewModel>().isLoading)
            const LoadingIndicatorWidget(),

          // Error message
          if (context.watch<ChatViewModel>().error != null)
            Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    if (vm.error != null && vm.error!.isNotEmpty) {
                      MessagePopup.show(context, message: vm.error!, title: 'Error');
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          vm.error ?? '',
                          style: TextStyle(
                            color: colorScheme.onErrorContainer,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 18,
                          color: colorScheme.onErrorContainer,
                        ),
                        onPressed: () => vm.clearError(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Usage button - positioned above message input
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: const UsageButton(),
            ),
          ),

          // Message input field
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: MessageInput(
                controller: vm.inputController,
                onSend: (message) {
                  vm.clearError();
                  vm.sendMessage(message);
                  vm.clearFiles();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

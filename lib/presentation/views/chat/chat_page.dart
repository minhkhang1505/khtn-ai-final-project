import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_app_bar_view_model.dart';
import 'package:provider/provider.dart';

import 'package:khtn_ai_final_project/presentation/views/chat/widgets/message_input.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/message_popup.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';

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
    // Listen to ChatViewModel changes so UI updates when conversation changes
    final chatViewModel = context.watch<ChatViewModel>();
    final modelSelectorViewModel = sl<ChatAppBarViewModel>();

    return Scaffold(
      appBar: ChatAppBar(
        onAddNewChat: () => chatViewModel.newChat(),
        onModelChanged: (model) {
          // Update selected model in ModelSelectorViewModel
        },
      ),
      drawer: ChatDrawer(
        onDeleted: (String conversationId) {
          // If the deleted conversation is the current one, open new chat
          if (chatViewModel.conversationId == conversationId) {
            chatViewModel.newChat();
          }
        },
        onAddNewChat: () => chatViewModel.newChat(),
        onConversationSelected: (conversation) {
            // Open chat with this conversation
            chatViewModel.openChat(conversation);
            // Set the selected model in model selector`
            modelSelectorViewModel.setSelectedAssistant(conversation.bot);
        },
      ),

      body: Column(
        children: [
          // Message list or welcome message
          Expanded(
            child: chatViewModel.conversationId.isEmpty
                ? const EmptyWidget()
                : // Message list
                  MessageList(scrollController: chatViewModel.scrollController),
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
                    if (chatViewModel.error != null && chatViewModel.error!.isNotEmpty) {
                      MessagePopup.show(context, message: chatViewModel.error!, title: 'Error');
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
                          chatViewModel.error ?? '',
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
                        onPressed: () => chatViewModel.clearError(),
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
                onSend: (message, files) {
                  final assistant = modelSelectorViewModel.selectedAssistant;
                  chatViewModel.sendMessage(message, assistant, files);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

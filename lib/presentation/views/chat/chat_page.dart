import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';

import 'widgets/chat_app_bar.dart';
import 'widgets/chat_drawer.dart';
import 'widgets/message_input.dart';
import 'widgets/message_list.dart';

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
          Expanded(
            child: vm.conversationId.isEmpty
                ? Center(
                    child: Text(
                      'Hello! Start a new conversation🎉',
                      style: TextStyle(
                        fontSize: 30,
                        color: colorScheme.primary,
                      ),
                    ),
                  )
                : // Message list
                  MessageList(scrollController: vm.scrollController),
          ),

          if (context.watch<ChatViewModel>().isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

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

          // Message input field
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: MessageInput(
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

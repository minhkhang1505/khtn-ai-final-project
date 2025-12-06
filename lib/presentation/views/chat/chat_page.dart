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

            // Error message with close button
            if (context.watch<ChatViewModel>().error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Something went wrong: ${vm.error}",
                    style: TextStyle(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: colorScheme.error),
                    onPressed: vm.clearError,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

          // Message input field
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: MessageInput(onSend: (message) {
                vm.clearError();
                vm.sendMessage(message);
                vm.clearFiles();
              }),
            ),
          ),
        ],
      ),
    );
  }
}

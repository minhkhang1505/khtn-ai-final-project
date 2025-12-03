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

  void onAddNewChat() {
    // TODO: Handle add new chat
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.read<ChatViewModel>();
    return Scaffold(
      appBar: ChatAppBar(
        onAddNewChat: onAddNewChat,
      ),
      drawer: ChatDrawer(),
      body: Column(
        children: [
          Expanded(
            child: vm.conversations.isEmpty
                ? Center(
                    child: Text(
                      'No conversations yet. Start a new chat!',
                      style: TextStyle(
                        fontSize: 30,
                        color: colorScheme.primary,
                      ),
                    ),
                  )
                : // Message list
                MessageList(
                    scrollController: vm.scrollController,
                  ),
          ),

          if (context.watch<ChatViewModel>().isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

          // Placeholder for error message
          if (context.watch<ChatViewModel>().error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Something went wrong",
                style: TextStyle(color: colorScheme.error, fontWeight: FontWeight.bold),
              ),
            ),

          // Message input field
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: ResponsiveHelper.horizontalPadding(context),
              child: MessageInput(
                onSend: (message) => vm.sendMessage(message),
                onAddPressed: () {
                  // TODO: Handle add button press
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

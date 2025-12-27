import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/di/injection.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_drawer_view_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';

class ChatDrawer extends StatefulWidget {
  final VoidCallback? onAddNewChat;
  final VoidCallback? onNewChat;
  final ValueChanged<String>? onConversationSelected;
  const ChatDrawer({super.key, this.onNewChat, this.onAddNewChat, this.onConversationSelected});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final ChatDrawerViewModel chatDrawerViewModel = sl<ChatDrawerViewModel>();
  final ChatViewModel chatViewModel = sl<ChatViewModel>();

  @override
  void initState() {
    super.initState();
  }

  String _getTimeDistance(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${difference.inDays}d ago';
      // dateTime.toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      child: SafeArea(
        child: AnimatedBuilder(
          animation: chatDrawerViewModel,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: Text(
                    'Chat Conversations',
                    style: TextStyle(
                      fontSize: 20,
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      // Action buttons
                      ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('New Chat'),
                        onTap: () {
                          Navigator.pop(context); // Close drawer
                          widget.onAddNewChat?.call();
                        },
                      ),
                      const SizedBox(height: 10),

                      // Your Conversations
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'Your Conversations',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),

                      if (chatDrawerViewModel.isLoading)
                        const Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            ],
                          ),
                        )
                      else ...chatDrawerViewModel.conversations.map((conversation) {
                        final isUserBot = conversation.bot.name.isNotEmpty;
                        return ListTile(
                          title: Text(conversation.title),
                          subtitle: Row(
                            children: [
                              // Tag bot - show "Bot" badge if this is a user-created bot
                              if (isUserBot) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: colorScheme.primary.withValues(alpha: 0.7),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Bot',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                _getTimeDistance(DateTime.parse(conversation.createdAt)),
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Delete conversation'),
                                  content: const Text('Are you sure you want to delete this conversation?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(true),
                                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                chatDrawerViewModel.deleteConversation(conversation.id);
                                if (chatViewModel.conversationId == conversation.id) {
                                  widget.onNewChat?.call();
                                }
                              }
                            },
                          ),
                          onTap: () {
                            // Open chat with this conversation
                            if (widget.onConversationSelected != null) {
                              widget.onConversationSelected!(conversation.id);
                            }
                            Navigator.pop(context); // Close drawer
                          },
                        );
                      }),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
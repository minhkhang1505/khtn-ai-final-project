import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final List<Map<String, dynamic>> models = AssistantModelType.values.map((type) {
    return {
      "name": type.name,
    };
  }).toList();

  @override
  void initState() {
    super.initState();
    final vm = context.read<ChatViewModel>();
    vm.getConversations();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final conversations = vm.conversations;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                'AI Bots',
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
                  // --- Action buttons ---
                  // ListTile(
                  //   leading: const Icon(Icons.add),
                  //   title: const Text('Create Bot'),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/bots/new');
                  //     // TODO: Create new chat page with bot
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.edit),
                  //   title: const Text('Edit Bot'),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/bots/edit', arguments: bot);
                  //   },
                  // ),
                  const SizedBox(height: 10),

                  // Your Bots
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

                  ...conversations.map((conversation) {
                    return ListTile(
                        title: Text(conversation.title),
                        trailing: IconButton(
                        icon: Icon(
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
                            // TODO: Add delete conversation logic here
                            // Call ViewModel to delete the conversation and update UI
                            // API not implemented yet
                          }
                        },
                      ),
                      onTap: () {
                        // Open chat with this conversation
                        Navigator.pop(context); // Close drawer
                        vm.conversationId = conversation.id;
                        vm.conversationTitle = conversation.title;
                        vm.clearMessages();
                        vm.clearError();
                        vm.getConversationHistory();
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
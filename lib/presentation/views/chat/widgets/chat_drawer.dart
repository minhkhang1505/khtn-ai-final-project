import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot_view_model.dart';
import 'package:khtn_ai_final_project/data/models/assistant_model.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat_view_model.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final BotViewModel botViewModel = BotViewModel();
  final List<Map<String, dynamic>> models = AssistantModelType.values.map((type) {
    return {
      "name": type.name,
    };
  }).toList();

  @override
  void initState() {
    super.initState();
    botViewModel.loadBots();
  }

  @override
  Widget build(BuildContext context) {
    //final bot = botViewModel.bots.isNotEmpty ? botViewModel.bots[0] : null;
    final vm = context.read<ChatViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    final conversations = vm.conversations;

    IconData iconForModel(String name) {
      final key = name.toLowerCase();
      if (key.contains('gpt')) return Icons.smart_toy;
      if (key.contains('dall') || key.contains('image')) return Icons.image;
      if (key.contains('audio') || key.contains('whisper')) return Icons.mic;
      return Icons.auto_awesome;
    }

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

                  // List of base models
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 8.0),
                    child: Text(
                      'Base models',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  
                  ...models.map((model) {
                    return ListTile(
                      title: Row(
                        children: [
                          Icon(
                            iconForModel(model["name"] as String),
                            size: 16,
                            color: colorScheme.onSurface,
                          ),
                          const SizedBox(width: 10),
                          Text(model["name"] as String),
                        ],
                      ),
                      onTap: () {
                        // TODO: Handle selection of base model
                      },
                    );
                  }),

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
                            // await vm.deleteConversation(conversation.id);
                          }
                        },
                        ),
                      onTap: () {
                        // Open chat with this conversation
                        Navigator.pop(context); // Close drawer
                        vm.conversationId = conversation.id;
                        vm.messages.clear();
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
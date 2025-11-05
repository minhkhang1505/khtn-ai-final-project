import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot_view_model.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  final BotViewModel botViewModel = BotViewModel();

  @override
  void initState() {
    super.initState();
    botViewModel.loadBots();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 60,
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: const Text(
              'AI Bots',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create New Bot'),
            onTap: () {
              // TODO: Handle create new bot
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'Chats',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: botViewModel.bots.length,
              itemBuilder: (context, index) {
                final bot = botViewModel.bots[index];
                return ListTile(
                  title: Text(bot.name),
                  subtitle: Text(bot.description),
                  trailing: PopupMenuButton<int>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    offset: const Offset(0, 40),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: Row(
                          children: const [
                            Icon(Icons.share_outlined, size: 20),
                            SizedBox(width: 12),
                            Text('Share'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: const [
                            Icon(Icons.edit_outlined, size: 20),
                            SizedBox(width: 12),
                            Text('Rename'),
                          ],
                        ),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: const [
                            Icon(Icons.archive_outlined, size: 20),
                            SizedBox(width: 12),
                            Text('Archive'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          debugPrint('Share tapped');
                          break;
                        case 1:
                          debugPrint('Rename tapped');
                          break;
                        case 2:
                          debugPrint('Archive tapped');
                          break;
                        case 3:
                          debugPrint('Delete tapped');
                          break;
                      }
                    },
                    icon: const Icon(Icons.more_horiz),
                  ),
                  onTap: () {
                    // TODO: Handle bot selection
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
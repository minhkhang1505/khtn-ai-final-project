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
    final bot = botViewModel.bots.isNotEmpty ? botViewModel.bots[0] : null;
    final colorScheme = Theme.of(context).colorScheme;
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
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create Bot'),
              onTap: () {
                Navigator.pushNamed(context, '/bots/new');
                // TODO: Create new chat page with bot
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Bot'),
              onTap: () {
                Navigator.pushNamed(context, '/bots/edit', arguments: bot);
              },
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Base models',
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
                    trailing: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),

                    onTap: () {
                      // TODO: Handle delete chat
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Base models',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[600],
                ),
              ),
            ),

            // List of existing chats
            Expanded(
              child: ListView.builder(
                itemCount: botViewModel.bots.length,
                itemBuilder: (context, index) {
                  final bot = botViewModel.bots[index];
                  return ListTile(
                    title: Text(bot.name),
                    subtitle: Text(bot.description),
                    trailing: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),

                    onTap: () {
                      // TODO: Handle delete chat
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

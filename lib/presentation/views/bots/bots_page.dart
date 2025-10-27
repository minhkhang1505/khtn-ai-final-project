import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart' show AppSpacing, AppBarInfo;
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_search_bar.dart' show BotSearch;
import 'create_bot_page.dart' show CreateBotPage;
import 'bots_card.dart' show BotCard;

/// Bots page - Manage AI bots
class BotsPage extends StatefulWidget {
  const BotsPage({super.key});

  @override
  State<BotsPage> createState() => _BotsPageState();
}

class _BotsPageState extends State<BotsPage> with SingleTickerProviderStateMixin {

  // Example bot cards
  final bots = <Widget>[
    BotCard(
      botName: 'Chat Assistant',
      botDescription: 'Helps with customer inquiries.',
      category: 'Customer Support',
      model: 'GPT-4',
      state: 'Active',
      prompt: 'Assist customers with their questions.',
    ),
    BotCard(
      botName: 'Sales Bot',
      botDescription: 'Automates sales follow-ups.',
      category: 'Sales',
      model: 'GPT-3.5',
      state: 'Inactive',
      prompt: 'Follow up with potential leads.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppBarInfo.height,
        titleSpacing: AppSpacing.horizontal,
        backgroundColor: AppBarInfo.backgroundColor,
        shadowColor: AppBarInfo.shadowColor,
        elevation: AppBarInfo.elevation,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'AI Bots',
                  style: AppBarInfo.titleTextStyle,
                ),
                SizedBox(height: 4),
                Text(
                  'Automate tasks with AI-powered workflows',
                  style: AppBarInfo.subtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: () {
                // Navigate to Create bot page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateBotPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'Create Bot',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.vertical, left: AppSpacing.horizontal, right: AppSpacing.horizontal),
            child: const BotSearch(),
          ),
          SizedBox(height: AppSpacing.cardSpacing),

          Container(
            padding: const EdgeInsets.only(top: AppSpacing.vertical, left: AppSpacing.horizontal, right: AppSpacing.horizontal),
            child: bots[0],
          ),
          SizedBox(height: AppSpacing.cardSpacing),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.horizontal),
            child: bots[1],
          ),
        ],
      ),
    );
  }
}
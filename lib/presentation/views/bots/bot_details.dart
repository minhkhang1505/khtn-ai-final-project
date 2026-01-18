import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'widgets/edit_bot_app_bar.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';

class BotDetails extends StatelessWidget {
  final BotModel bot;
  const BotDetails({super.key, required this.bot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditBotAppBar(bot: bot),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.chatContentWidth(context),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    // Title
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded, size: 24),
                          SizedBox(width: 8),
                          Text(
                            "Preview",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      )
                    ],

                    // Preview a small chat interface with the bot

                  ),
                ),
              ),
            ),
          ),
        ),
      );  
  }
}
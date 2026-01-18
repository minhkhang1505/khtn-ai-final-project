import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class AgentChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AgentModel agent;

  const AgentChatAppBar({
    super.key,
    required this.agent,
  });

  void _showInstructionsDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How to Use'),
          content: SingleChildScrollView(
            child: Text(
              'Instructions:\n\n'
              '1. Type your request or task description in the message input box.\n\n'
              '2. Press Enter or click the send button to submit your request.\n\n'
              '3. The agent will process your request and generate a plan with:\n'
              '   • Plan title\n'
              '   • Description\n'
              '   • List of tasks with estimated hours\n'
              '   • Total hours required\n\n'
              '4. You can copy any message by hovering over it and clicking the copy button.\n\n'
              'Tips:\n'
              '• Be clear and specific in your requests\n'
              '• You can ask follow-up questions to refine the plan\n'
              '• Use Shift+Enter to create new lines in your message\n\n'
              'Note: The agent only generates plans 5 times per day. Please use them wisely!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colorScheme.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            agent.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            agent.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _showInstructionsDialog(context),
          tooltip: 'Instructions',
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: agent.status == 'Active'
                  ? Colors.green.withAlpha(30)
                  : Colors.grey.withAlpha(30),
              borderRadius: AppBorderRadius.small,
            ),
            child: Center(
              child: Text(
                agent.status,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: agent.status == 'Active'
                          ? Colors.green
                          : Colors.grey,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

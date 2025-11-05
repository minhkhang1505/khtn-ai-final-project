import 'package:flutter/material.dart' hide SearchBar;
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/bot_model.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'widgets/edit_bot_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/action_button_row.dart';
import 'widgets/system_prompts_card.dart';
import 'widgets/knowledge_base_card.dart';
import 'widgets/bot_information_card.dart';

/// Edit Bot Page - Configure AI bot settings
class EditBotPage extends StatefulWidget {
  final BotModel bot;
  const EditBotPage({super.key, required this.bot});

  @override
  State<EditBotPage> createState() => _EditBotPageState();
}

class _EditBotPageState extends State<EditBotPage> {
  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: EditBotAppBar(bot: widget.bot),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.contentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Status & Actions Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withAlpha(100),
                      width: 1.5,
                    ),
                  ),
                  color: colorScheme.surfaceContainerLow.withAlpha(10),
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status & Actions',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Active toggle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.bot.status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Enable or disable this bot',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: widget.bot.status == 'Active',
                              onChanged: (value) {
                                setState(() {
                                  widget.bot.status = value ? 'Active' : 'Inactive';
                                });
                                // TODO: update bot status here (e.g. call API)
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Basic Information Section
                const BotInformationCard(),
                const SizedBox(height: AppSpacing.cardSpacing),

                // System Prompts Section
                const SystemPromptsCard(),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Knowledge Base Section
                const KnowledgeBaseCard(),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Action Buttons
                ActionButtonRow(
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onSave: () {
                    // TODO: Handle save action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

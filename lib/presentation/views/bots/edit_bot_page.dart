import 'package:flutter/material.dart' hide SearchBar;
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/data/models/bot_model.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'widgets/edit_bot_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/save_action_button_row.dart';
import 'widgets/system_prompts_card.dart';
import 'widgets/knowledge_base_card.dart';
import 'widgets/bot_information_card.dart';
import 'widgets/bot_status_card.dart';
import 'widgets/visibility_card.dart';

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
                BotStatusCard(
                  bot: widget.bot,
                  onStatusChanged: () {
                    setState(() {});
                  },
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

                // Visibility Section
                VisibilityCard(onStatusChanged: () {
                  // TODO: Handle visibility status change
                  setState(() {});
                },),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Action Buttons
                SaveActionButtonRow(
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

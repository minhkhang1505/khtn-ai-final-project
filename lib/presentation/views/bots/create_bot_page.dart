import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/create_action_button_row.dart';
import 'widgets/create_bot_app_bar.dart';
import 'widgets/system_prompts_card.dart';
import 'widgets/knowledge_base_card.dart';
import 'widgets/bot_information_card.dart';
import 'widgets/visibility_card.dart';

/// Create Bot Page - Configure new AI bot settings
class CreateBotPage extends StatefulWidget {
  const CreateBotPage({super.key});

  @override
  State<CreateBotPage> createState() => _CreateBotPageState();
}

class _CreateBotPageState extends State<CreateBotPage> {
  final Set<int> selectedIndices = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CreateBotAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.contentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Basic Information Section
                const BotInformationCard(),
                const SizedBox(height: AppSpacing.cardSpacing),

                const SizedBox(height: 12),
                // System Prompts Section
                SystemPromptsCard(),
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
                const SizedBox(height: 12),
                CreateActionButtonRow(
                  onCreate: () {
                    // Handle create bot action
                  },
                  onCancel: () {
                    Navigator.pop(context);
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

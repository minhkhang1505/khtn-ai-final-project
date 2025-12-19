import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';

import 'package:khtn_ai_final_project/data/models/agent_model.dart';

import 'package:khtn_ai_final_project/presentation/viewmodels/bot/create_bot_view_model.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/create_action_button_row.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/message_popup.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';

import 'widgets/create_bot_app_bar.dart';
import 'widgets/knowledge_base_card.dart';
import 'widgets/bot_information_card.dart';
import 'widgets/ai_model_card.dart';

/// Create Bot Page - Configure new AI bot settings
class CreateBotPage extends StatefulWidget {
  const CreateBotPage({super.key});

  @override
  State<CreateBotPage> createState() => _CreateBotPageState();
}

class _CreateBotPageState extends State<CreateBotPage> {
  final Set<int> selectedIndices = {};
  final List<AgentModel> subagents = [];

  @override
  Widget build(BuildContext context) {
    final createBotViewModel = context.read<CreateBotViewModel>();
    return Scaffold(
      appBar: const CreateBotAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.chatContentWidth(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Loading Indicator
                  if (createBotViewModel.isLoading)
                    const LoadingIndicatorWidget(),

                  // Basic Information Section
                  const BotInformationCard(),
                  const SizedBox(height: AppSpacing.cardSpacing),

                  // Knowledge Base Section
                  const KnowledgeBaseCard(),
                  const SizedBox(height: AppSpacing.cardSpacing),

                  // AI model Section
                  AiModelCard(
                    onChanged: (modelId) {
                      createBotViewModel.setSelectedModel(modelId);
                    },
                  ),
                  const SizedBox(height: AppSpacing.cardSpacing),

                  // Action Buttons
                  const SizedBox(height: 12),
                  CreateActionButtonRow(
                    onCreate: () async {
                      final isSuccess = await createBotViewModel.createBot();
                      if (isSuccess) {
                        Navigator.pop(context);
                      } else {
                        // Show error message
                        MessagePopup.show(
                          context,
                          title: 'Error',
                          message: createBotViewModel.errorMessage ?? 'Unknown error occurred',
                        );
                      }
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';

import 'package:khtn_ai_final_project/data/models/agent_model.dart';

import 'package:khtn_ai_final_project/presentation/viewmodels/bot/create_bot_view_model.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/create_action_button_row.dart';
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
    final createBotViewModel = context.watch<CreateBotViewModel>();
    return Scaffold(
      appBar: CreateBotAppBar(
        onBackPressed: () {
          Navigator.of(context).pop();
          createBotViewModel.clearForm();
        },
      ),
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
                  BotInformationCard(
                    assistantNameController: createBotViewModel.assistantNameController,
                    assistantNameError: createBotViewModel.assistantNameError,
                    instructionsController: createBotViewModel.instructionsController,
                    descriptionController: createBotViewModel.descriptionController,
                  ),
                  const SizedBox(height: AppSpacing.cardSpacing),

                  // Knowledge Base Section
                  const KnowledgeBaseCard(),
                  const SizedBox(height: AppSpacing.cardSpacing),

                  // AI model Section
                  AiModelCard(
                    onChanged: (modelId) {
                      createBotViewModel.setSelectedModel(modelId);
                    },
                    errorText: createBotViewModel.modelError,
                  ),
                  const SizedBox(height: AppSpacing.cardSpacing),

                  // Action Buttons
                  const SizedBox(height: 12),
                  CreateActionButtonRow(
                    onCreate: () async {
                      final pageContext = context;
                      await showDialog<void>(
                        context: pageContext,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          bool? success;
                          String? resultMessage;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              Widget content;
                              List<Widget> actions;

                              if (createBotViewModel.isLoading) {
                                content = Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                                    SizedBox(width: 12),
                                    Text('Creating bot...'),
                                  ],
                                );
                                actions = [
                                  TextButton(onPressed: null, child: const Text('Cancel')),
                                ];
                              } else if (success != null) {
                                content = Text(resultMessage ?? (success == true ? 'Bot created successfully' : 'Failed to create bot'));
                                actions = [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                      if (success == true) {
                                        Navigator.pop(pageContext);
                                      }
                                    },
                                    child: const Text('Close'),
                                  ),
                                ];
                              } else {
                                // Start creating
                                Future.microtask(() async {
                                  final ok = await createBotViewModel.createBot();
                                  setState(() {
                                    success = ok;
                                    resultMessage = ok ? 'Bot created successfully' : (createBotViewModel.errorMessage ?? 'Failed to create bot');
                                  });
                                });
                                content = Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                                    SizedBox(width: 12),
                                    Text('Creating bot...'),
                                  ],
                                );
                                actions = [
                                  TextButton(onPressed: null, child: const Text('Cancel')),
                                ];
                              }

                              return AlertDialog(
                                title: const Text('Create Bot'),
                                content: content,
                                actions: actions,
                              );
                            },
                          );
                        },
                      );
                    },
                    onCancel: () {
                      createBotViewModel.clearForm();
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

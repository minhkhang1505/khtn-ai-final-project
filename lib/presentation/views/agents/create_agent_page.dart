import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/create_action_button_row.dart';
import 'widgets/create_agent_app_bar.dart';
import 'widgets/agent_information_card.dart';
import 'widgets/workflow_selector.dart';

class CreateAgentPage extends StatefulWidget {
  const CreateAgentPage({super.key});

  @override
  State<CreateAgentPage> createState() => _CreateAgentPageState();
}

class _CreateAgentPageState extends State<CreateAgentPage> {
  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: const CreateAgentAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.chatContentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Basic Information Section
                AgentInformationCard(),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Workflows Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withAlpha(100),
                    ),
                  ),
                  margin: const EdgeInsets.all(0),
                  color: colorScheme.surfaceContainerLow.withAlpha(10),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Select Workflows *',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Choose at least one workflow for this agent',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 20),

                        // Workflows list
                        WorkflowSelector(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Action Buttons
                CreateActionButtonRow(
                  onCreate: () {
                    // Handle create agent action
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

import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'widgets/workflow_card.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart';
import 'widgets/edit_agent_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/action_button_row.dart';
import 'widgets/workflow_selector_sheet.dart';
import 'widgets/agent_status_card.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';
import 'widgets/agent_information_card.dart';

/// Edit Agent Page - Configure AI agent settings
class EditAgentPage extends StatefulWidget {
  final AgentModel agent;

  const EditAgentPage({super.key, required this.agent});

  @override
  State<EditAgentPage> createState() => _EditAgentPageState();
}

class _EditAgentPageState extends State<EditAgentPage> {
  List<Workflow> _selectedWorkflows = [];

  void _openWorkflowSelector() async {
    final selected = await showModalBottomSheet<List<Workflow>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => WorkflowSelectorSheet(
        initialSelected: _selectedWorkflows,
        onSave: (selected) {
          setState(() {
            _selectedWorkflows = selected;
          });
        },
      ),
    );

    if (selected != null) {
      setState(() {
        _selectedWorkflows = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: EditAgentAppBar(agent: widget.agent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.contentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status & Actions Card
                AgentStatusCard(
                  agent: widget.agent,
                  onStatusChanged: () {
                    setState(() {});
                  },
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Basic Information Card
                AgentInformationCard(
                  // TODO: Implement pre-fill functionality later
                  // Pass existing agent data to pre-fill fields
                  // agent: widget.agent,
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Workflows Card
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLow.withAlpha(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withAlpha(100),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Workflows',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            // Add workflows button
                            OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                              ),
                              onPressed: () {
                                _openWorkflowSelector();
                              },
                              icon: const Icon(Icons.add, size: 18),
                              label: Text(
                                'Add',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.agent.workflows.length} workflow(s) configured',
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 16),

                        // Workflow
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final workflow = widget.agent.workflows[index];
                            return WorkflowsCard(
                              workflowType: workflow,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemCount: widget.agent.workflows.length,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Delete button
                ActionButtonRow(
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onSave: () {
                    // TODO: Implement save functionality
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

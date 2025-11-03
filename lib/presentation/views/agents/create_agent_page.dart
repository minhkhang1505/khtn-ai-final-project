import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'workflows/workflow_card.dart' show WorkflowsCart;
import 'package:khtn_ai_final_project/data/models/workflow_model.dart'
    show Workflow;
import 'package:khtn_ai_final_project/core/constants/constant.dart'
    show AppBarInfo, AppSpacing;
import 'package:khtn_ai_final_project/core/utils/responsive_helper.dart'
    show ResponsiveHelper;

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
      appBar: AppBar(
        toolbarHeight: AppBarInfo.height,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create New Agent', style: AppBarInfo.titleTextStyle),

                SizedBox(height: 4),

                Text(
                  'Set up a new agent with workflows',
                  style: AppBarInfo.subtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Chip(
              label: Text('Active', style: TextStyle(color: Colors.green)),
              backgroundColor: Color(0xFFE8F5E9),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.contentWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Basic Information Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.extraLarge,
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withAlpha(100),
                      width: 1.5,
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
                          'Basic Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Name and describe your agent',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 20),

                        // Agent Name label
                        const Text(
                          'Agent Name *',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Agent Name input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'e.g., Email Assistant',
                            hintStyle: TextStyle(
                              color: colorScheme.onSurface.withAlpha(140),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHigh
                                .withAlpha(120),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description label
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description input
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'What does this agent do?',
                            hintStyle: TextStyle(
                              color: colorScheme.onSurface.withAlpha(140),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceContainerHigh
                                .withAlpha(120),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: AppBorderRadius.medium,
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Workflows Section
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.extraLarge,
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

                        // Workflows Selection
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Workflow.values.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final workflow = Workflow.values[index];
                            final isSelected = selectedIndices.contains(index);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedIndices.remove(index);
                                  } else {
                                    selectedIndices.add(index);
                                  }
                                });
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      borderRadius: AppBorderRadius.medium,
                                      border: Border.all(
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: WorkflowsCart(
                                      workflowType: workflow as dynamic,
                                    ),
                                  ),

                                  if (isSelected)
                                    Positioned.fill(
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor
                                              .withAlpha((0.08 * 255).round()),
                                          borderRadius: AppBorderRadius.medium,
                                        ),
                                      ),
                                    ),

                                  if (isSelected)
                                    Positioned(
                                      right: 12,
                                      top: 12,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.cardSpacing),

                // Create Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.medium,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                        child: Text(
                          'Create Agent',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'workflow_card.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';

class WorkflowSelector extends StatefulWidget {
  const WorkflowSelector({super.key});

  @override
  State<WorkflowSelector> createState() => _WorkflowSelectorState();
}

class _WorkflowSelectorState extends State<WorkflowSelector> {
  final Set<int> selectedIndices = {};
  Set<int> get selections => selectedIndices;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
                  borderRadius: AppBorderRadius.extraLarge,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: WorkflowsCard(
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
                      borderRadius: AppBorderRadius.extraLarge,
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
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'workflow_selector.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/workflow_model.dart';

class WorkflowSelectorSheet extends StatefulWidget {
  final List<Workflow> initialSelected;
  final ValueChanged<List<Workflow>> onSave;

  const WorkflowSelectorSheet({
    super.key,
    required this.initialSelected,
    required this.onSave,
  });

  @override
  State<WorkflowSelectorSheet> createState() => _WorkflowSelectorSheetState();
}

class _WorkflowSelectorSheetState extends State<WorkflowSelectorSheet> {
  final GlobalKey selectorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Workflows',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Flexible(
                child: WorkflowSelector(
                  key: selectorKey,
                  initialSelected: widget.initialSelected,
                ),
              ),

              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save Selections"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.extraLarge,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  final selectedIndices =
                      (selectorKey.currentState as dynamic)?.selections ?? <int>{};
                  final selectedWorkflows = selectedIndices
                      .map((i) => Workflow.values[i])
                      .toList()
                      .cast<Workflow>();
                  widget.onSave(selectedWorkflows);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

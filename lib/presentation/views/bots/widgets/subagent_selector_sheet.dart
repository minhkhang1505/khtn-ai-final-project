import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'agent_selector.dart';

class SubagentSelectorSheet extends StatefulWidget {
  final List<AgentModel> subagents;
  final ValueChanged<List<AgentModel>> onSave;
  const SubagentSelectorSheet({
    super.key,
    required this.subagents,
    required this.onSave,
  });

  @override
  State<SubagentSelectorSheet> createState() => _SubagentSelectorSheetState();
}

class _SubagentSelectorSheetState extends State<SubagentSelectorSheet> {
  List<AgentModel> _selectedAgentsFromSelector = [];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Subagents',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Agent selector list
                  AgentSelector(
                    subagents: widget.subagents,
                    onSelected: (selected) {
                      _selectedAgentsFromSelector = selected;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Save button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton.icon(
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
                        widget.onSave(_selectedAgentsFromSelector);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
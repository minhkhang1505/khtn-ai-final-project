import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';
import 'subagent_selector_sheet.dart';

class SubagentCard extends StatefulWidget {
  /// Accept a nullable list to be defensive; widget will normalize to an empty list.
  final List<AgentModel>? subagents;
  const SubagentCard({
    super.key,
    this.subagents,
  });

  @override
  State<SubagentCard> createState() => _SubagentCardState();
}

class _SubagentCardState extends State<SubagentCard> {
  // Initialize to empty list to guarantee a valid list before initState runs.
  List<AgentModel> _subagents = [];

  @override
  void initState() {
    super.initState();
    // Normalize incoming value to a non-null list
    _subagents = List<AgentModel>.from(widget.subagents ?? []);
  }

  @override
  void didUpdateWidget(covariant SubagentCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If parent provided a different list instance, update internal list
    if (widget.subagents != oldWidget.subagents) {
      _subagents = List<AgentModel>.from(widget.subagents ?? []);
    }
  }

  void _openSubagentSelector() async {
    final selected = await showModalBottomSheet<List<AgentModel>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SubagentSelectorSheet(
        subagents: _subagents,
        onSave: (selected) {
          setState(() {
            _subagents.addAll(selected);
          });
        },
      ),
    );
    if (selected != null) {
      setState(() {
        // selection handled in onSave; this block is kept for safety
      });
    }
  }

  void _removeSubagent(AgentModel agent) {
    setState(() {
      _subagents.remove(agent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
  List<AgentModel> subagents = _subagents; // use normalized internal list
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.medium,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Subagent',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            // Select subagents
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${subagents.length} subagent(s)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                OutlinedButton.icon(
                  onPressed: () {
                    _openSubagentSelector();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: AppBorderRadius.large,
                    ),
                    side: BorderSide(color: colorScheme.primary),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Subagent'),
                ),
              ],
            ),

            // List of subagents
            if (subagents.isNotEmpty) ...[
              const SizedBox(height: 16),
              Column(
                children: subagents.map((agent) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                    color: colorScheme.surfaceContainer,
                    child: ListTile(
                      title: Text(agent.name, style: const TextStyle(overflow: TextOverflow.ellipsis),),
                      subtitle: Text(agent.description, style: const TextStyle(overflow: TextOverflow.ellipsis),),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _removeSubagent(agent);
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
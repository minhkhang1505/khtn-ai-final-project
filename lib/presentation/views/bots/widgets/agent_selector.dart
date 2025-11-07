import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/agent_model.dart';

class AgentSelector extends StatefulWidget {
  final List<AgentModel> subagents;
  final ValueChanged<List<AgentModel>> onSelected;

  const AgentSelector({
    super.key,
    required this.subagents,
    required this.onSelected,
  });

  @override
  State<AgentSelector> createState() => _AgentSelectorState();
}

class _AgentSelectorState extends State<AgentSelector> {
  final List<AgentModel> _selected = [];

  void _toggleAgent(AgentModel agent, bool? checked) {
    setState(() {
      if (checked == true) {
        _selected.add(agent);
      } else {
        _selected.remove(agent);
      }
    });

    widget.onSelected(List<AgentModel>.from(_selected));
  }

  @override
  Widget build(BuildContext context) {
    final agents = AgentModel.createSampleAgents()
        .where((agent) => !widget.subagents.contains(agent))
        .toList();

    if (agents.isEmpty) {
      return const Center(
        child: Text('No more agents available to select.'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: agents.length,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (context, index) {
        final agent = agents[index];
        final isSelected = _selected.contains(agent);

        return CheckboxListTile(
          value: isSelected,
          onChanged: (value) => _toggleAgent(agent, value),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Theme.of(context).colorScheme.primary,
          title: Text(agent.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(agent.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        );
      },
    );
  }
}
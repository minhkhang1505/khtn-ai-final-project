import 'package:flutter/material.dart';
import 'agents_card.dart' show AgentCard;

/// Agents page - Manage AI agents
class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final agents = <Widget>[
    AgentCard(
      agentName: 'Email Assistant',
      agentDescription: 'Handles email workflows automatically.',
      workflows: 'Email Triage',
      state: 'Active',
    ),
    AgentCard(
      agentName: 'Document Processor',
      agentDescription: 'Processes documents efficiently.',
      workflows: 'Data Extraction',
      state: 'Inactive',
    ),
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Agents'),
        actions: [
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text(
              'Create Agent',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(children: agents),
          //const Center(child: Text('Workflows Tab')),
        ],
      ),
    );
  }
}

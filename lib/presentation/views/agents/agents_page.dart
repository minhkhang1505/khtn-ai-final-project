import 'package:flutter/material.dart';
import 'agents_card.dart' show AgentCard;
import 'package:khtn_ai_final_project/constants/constant.dart' show AppSpacing, AppBarInfo;

/// Agents page - Manage AI agents
class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Example agent cards
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
        toolbarHeight: AppBarInfo.height,
        titleSpacing: AppSpacing.horizontal,
        backgroundColor: AppBarInfo.backgroundColor,
        shadowColor: AppBarInfo.shadowColor,
        elevation: AppBarInfo.elevation,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'AI Agents',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Automate tasks with AI-powered workflows',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
          
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'Create Agent',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: const [
              Tab(text: 'Active Agents'),
              Tab(text: 'All Agents'),
              Tab(text: 'Workflows'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ActiveAgentsTab(),
                AllAgentsTab(),
                WorkflowsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActiveAgentsTab extends StatelessWidget {
  const ActiveAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
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
      ],
    );
  }
}

class AllAgentsTab extends StatelessWidget {
  const AllAgentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
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
      ],
    );
  }
}

class WorkflowsTab extends StatelessWidget {
  const WorkflowsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Workflows will be displayed here.',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/agent_viewmodel.dart'
    show AgentViewModel;
import 'package:khtn_ai_final_project/core/constants/constant.dart'
    show AppSpacing, AppBarInfo;
import 'workflows/workflows_tab.dart' show WorkflowsTab;
import 'all_agents_tab.dart' show AllAgentsTab;
import 'active_agents_tab.dart' show ActiveAgentsTab;
import 'create_agent_page.dart' show CreateAgentPage;

/// Agents page - Manage AI agents
class AgentsPage extends StatefulWidget {
  const AgentsPage({super.key});

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage>
    with SingleTickerProviderStateMixin {
  final AgentViewModel _viewModel = AgentViewModel();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _viewModel.loadAgents();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('AI Agents', style: AppBarInfo.titleTextStyle),
                SizedBox(height: 4),
                Text(
                  'Automate tasks with AI-powered workflows',
                  style: AppBarInfo.subtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: () {
                // Navigate to Create Agent page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateAgentPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text(
                'Create Agent',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 1200 : double.infinity,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: AppBorderRadius.extraExtraLarge,
                      child: Container(
                        height: 40,
                        color: colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: colorScheme.onPrimary,
                            indicator: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: AppBorderRadius.extraExtraLarge,
                            ),
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            unselectedLabelColor: colorScheme.primary,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            tabs: const [
                              Tab(text: 'Active Agents'),
                              Tab(text: 'All Agents'),
                              Tab(text: 'Workflows'),
                            ],
                          ),
                        ),
                      ),
                    ),
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
            ),
          );
        },
      ),
    );
  }
}

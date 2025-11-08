import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/agent_view_model.dart';
import 'widgets/agent_app_bar.dart';
import 'tabs/workflows_tab.dart';
import 'tabs/all_agents_tab.dart';
import 'tabs/active_agents_tab.dart';

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

  void _onAddAgent() {
    Navigator.pushNamed(context, '/agents/new');
  }

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
      appBar: CustomAppBar(
        title: "Bots",
        subtitle: "Set up your AI assistant bot",
        onCreatePressed: _onAddAgent,
        createButtonLabel: 'Add Bot',
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

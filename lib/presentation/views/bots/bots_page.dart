import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_search_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/bot_view_model.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_filter_option_menu.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/loading_widget.dart';
import 'widgets/bots_app_bar.dart';
import 'widgets/bot_list.dart';
import 'package:khtn_ai_final_project/presentation/routes/route_observer.dart';


/// Bots page - Manage AI bots
class BotsPage extends StatefulWidget {
  const BotsPage({super.key});

  @override
  State<BotsPage> createState() => _BotsPageState();
}

class _BotsPageState extends State<BotsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    // Fetch bots after the first frame to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BotViewModel>().fetchBots();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Called when the route has been pushed onto the navigator.
    context.read<BotViewModel>().fetchBots();
  }

  @override
  void didPopNext() {
    // Called when a covered route is popped back to this route.
    context.read<BotViewModel>().fetchBots();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final botViewModel = context.watch<BotViewModel>();

    return Scaffold(
      appBar: BotAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 1200 : double.infinity,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.horizontal),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BotSearch(),
                          const SizedBox(height: 12),
                          // Row with filter dropdown (left) and create bot button (right)
                          Row(
                            children: [
                              // Filter dropdown
                              BotFilterOptionMenu(
                                onChanged: (v) async {
                                  await botViewModel.fetchBots();
                                },
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/bots/new');
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Create Bot'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.small),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content based on loading state and bots list
                  if (botViewModel.isLoading) ...[
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: LoadingIndicatorWidget(),
                      ),
                    ),
                  ] else if (botViewModel.bots.isEmpty) ...[
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No bots found.',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    BotList(
                      bots: botViewModel.bots,
                      onTap: (bot) async {
                        Navigator.pushNamed(
                          context,
                          '/bots/edit',
                          arguments: bot,
                        );
                      },
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
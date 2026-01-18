import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/bot_search_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/bot_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/bot_filter_option_menu.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/loading_widget.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch bots after the first frame to avoid calling during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BotViewModel>().fetchBots();
    });
    
    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<BotViewModel>().loadMoreBots();
    }
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
    _scrollController.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Called when the route has been pushed onto the navigator.
    //context.read<BotViewModel>().fetchBots();
  }

  @override
  void didPopNext() {
    // Called when a covered route is popped back to this route.
    // Intentionally no fetch here to avoid duplicate calls from popup routes
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
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.horizontal),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search bar
                          BotSearch(
                            onChanged: (value) {
                              botViewModel.onSearchChanged(value);
                            },
                          ),
                          const SizedBox(height: 12),
                          // Row with filter dropdown (left) and create bot button (right)
                          Row(
                            children: [
                              // Filter dropdown
                              BotFilterOptionMenu(
                                initialValue: botViewModel.filter,
                                onChanged: (v) {
                                  botViewModel.setFilter(v);
                                },
                              ),
                              const Spacer(),
                              // Create Bot button
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await Navigator.pushNamed(context, '/bots/new');
                                  if (mounted) {
                                    await botViewModel.fetchBots();
                                  }
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
                        await Navigator.pushNamed(
                          context,
                          '/bots/edit',
                          arguments: bot,
                        );
                        if (mounted) {
                          await botViewModel.fetchBots();
                        }
                      },
                      onEdit: (bot) async {
                        await Navigator.pushNamed(
                          context,
                          '/bots/edit',
                          arguments: bot,
                        );
                        if (mounted) {
                          await botViewModel.fetchBots();
                        }
                      },
                      onFavoriteToggle: (botId) {
                        botViewModel.toggleFavoriteBotInList(botId);
                      },
                    ),                    
                    if (botViewModel.isLoadingMore)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_search_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/bot_view_model.dart';
import 'widgets/bots_app_bar.dart';
import 'widgets/bots_card.dart';
import 'widgets/bot_filter_option_menu.dart';

/// Bots page - Manage AI bots
class BotsPage extends StatefulWidget {
  const BotsPage({super.key});

  @override
  State<BotsPage> createState() => _BotsPageState();
}

class _BotsPageState extends State<BotsPage> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final botViewModel = context.watch<BotViewModel>();
    // Compute displayed bots based on selected filter
    final List displayedBots = (() {
      final all = botViewModel.bots;
      switch (_selectedFilter) {
        case 'favorite':
          return all.where((b) => b.isFavorite).toList();
        case 'date':
          final copy = List.from(all);
          copy.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
          return copy;
        case 'name':
          final copy = List.from(all);
          copy.sort((a, b) => a.assistantName.compareTo(b.assistantName));
          return copy;
        case 'all':
        default:
          return all;
      }
    })();

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
                              // Filter dropdown (extracted widget)
                              BotFilterOptionMenu(
                                value: _selectedFilter,
                                onChanged: (v) {
                                  setState(() {
                                    _selectedFilter = v;
                                  });
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
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final bot = displayedBots[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.horizontal - 4,
                          right: AppSpacing.horizontal - 4,
                          bottom: index == displayedBots.length - 1
                              ? AppSpacing.vertical
                              : AppSpacing.cardSpacing - 8,
                        ),
                        child: InkWell(
                          borderRadius: AppBorderRadius.medium,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/bots/edit',
                              arguments: bot,
                            );
                          },
                          child: BotCard(bot: bot),
                        ),
                      );
                    }, childCount: displayedBots.length),
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

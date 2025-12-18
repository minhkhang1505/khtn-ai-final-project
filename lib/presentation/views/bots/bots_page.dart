import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/app_constants.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_search_bar.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/bot_view_model.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'widgets/bots_app_bar.dart';
import 'widgets/bots_card.dart';

/// Bots page - Manage AI bots
class BotsPage extends StatefulWidget {
  const BotsPage({super.key});

  @override
  State<BotsPage> createState() => _BotsPageState();
}

class _BotsPageState extends State<BotsPage>
    with SingleTickerProviderStateMixin {
  late BotViewModel _botViewModel;

  @override
  void initState() {
    super.initState();
    _botViewModel = BotViewModel();
    //_botViewModel.loadBots();
  }

  void _onAddBot() {
    Navigator.pushNamed(context, '/bots/new');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BotAppBar(onAddBot: _onAddBot),
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
                      child: BotSearch(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final bot = _botViewModel.bots[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: AppSpacing.horizontal - 4,
                          right: AppSpacing.horizontal - 4,
                          bottom: index == _botViewModel.bots.length - 1
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
                    }, childCount: _botViewModel.bots.length),
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

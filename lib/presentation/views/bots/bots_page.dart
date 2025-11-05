import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart'
    show AppSpacing;
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_search_bar.dart'
    show BotSearch;
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot_viewmodel.dart'
    show BotViewModel;
import 'create_bot_page.dart' show CreateBotPage;
import 'bots_card.dart' show BotCard;

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
    _botViewModel.loadBots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI Bots',
        subtitle: 'Automate tasks with AI-powered workflows',
        onCreatePressed: () {
          // Navigate to Create bot page
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CreateBotPage()),
          );
        },
        createButtonLabel: 'Create Bot',
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 1200 : double.infinity,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.vertical,
                        left: AppSpacing.horizontal + 4,
                        right: AppSpacing.horizontal + 4,
                      ),
                      child: const BotSearch(),
                    ),
                    SizedBox(height: AppSpacing.cardSpacing),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _botViewModel.bots.length,
                      itemBuilder: (context, index) {
                        final bot = _botViewModel.bots[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            left: AppSpacing.horizontal,
                            right: AppSpacing.horizontal,
                            bottom: index == _botViewModel.bots.length - 1
                                ? AppSpacing.vertical
                                : AppSpacing.cardSpacing,
                          ),
                          child: BotCard(bot: bot),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

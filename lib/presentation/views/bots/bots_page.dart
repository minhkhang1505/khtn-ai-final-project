import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/core/constants/constants.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/bot_search_bar.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot_view_model.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme.surface,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('AI Bots', style: AppBarInfo.titleTextStyle),
                Text(
                  'Automate tasks with AI-powered workflows',
                  style: AppBarInfo.subtitleTextStyle,
                ),
              ],
            ),
          ],
        ),
        actions: [
          // if (!Platform.isAndroid && !Platform.isIOS)
          //   Padding(
          //     padding: const EdgeInsets.only(right: 16),
          //     child: FilledButton.icon(
          //       onPressed: () {
          //         // Navigate to Create bot page
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => const CreateBotPage(),
          //           ),
          //         );
          //       },
          //       icon: const Icon(Icons.add, size: 18),
          //       label: const Text(
          //         'Create Bot',
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //       style: FilledButton.styleFrom(
          //         backgroundColor: Theme.of(context).colorScheme.primary,
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 16,
          //           vertical: 20,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: AppBorderRadius.medium,
          //         ),
          //       ),
          //     ),
          //   ),
          IconButton(
            onPressed: () {
              // Navigate to Create bot page
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CreateBotPage()),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/ic_add.svg',
              width: 45,
              height: 45,
              colorFilter: ColorFilter.mode(
                colorScheme.primary,
                BlendMode.srcIn,
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

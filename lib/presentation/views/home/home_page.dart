import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/chat_page.dart';
import 'package:khtn_ai_final_project/presentation/views/bots/bots_page.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/agents_page.dart';
import 'package:khtn_ai_final_project/presentation/views/home/widgets/ios_bottom_nav_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/home/widgets/non_ios_bottom_nav_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledge_page.dart';
import 'package:khtn_ai_final_project/presentation/views/account/account_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String? promptContent;

  const HomePage({super.key, this.promptContent});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _navItems = [
    {'icon': 'assets/icons/ic_chat.svg', 'label': 'Chat'},
    {'icon': 'assets/icons/ic_bot.svg', 'label': 'Bots'},
    {'icon': 'assets/icons/ic_agent.svg', 'label': 'Agents'},
    {'icon': 'assets/icons/ic_knowledge.svg', 'label': 'Knowledge'},
    {'icon': 'assets/icons/ic_account.svg', 'label': 'Account'},
  ];

  @override
  void initState() {
    super.initState();
    // Handle prompt content from arguments if navigating fresh (not from pop)
    if (widget.promptContent != null && widget.promptContent!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final chatViewModel = context.read<ChatViewModel>();
        chatViewModel.setInputMessage(widget.promptContent!);
        setState(() {
          _selectedIndex = 0;
        });
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ChatPage(),
          BotsPage(),
          AgentsPage(),
          KnowledgePage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: isIos
          ? IosBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              navItems: _navItems,
            )
          : NonIosBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              navItems: _navItems,
            ),
    );
  }
}

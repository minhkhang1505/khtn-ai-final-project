import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/chat_page.dart';
import 'package:khtn_ai_final_project/presentation/views/bots/bots_page.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/agents_page.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledge_page.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/prompts_page.dart';
import 'package:khtn_ai_final_project/presentation/views/account/account_page.dart';

/// Main page with bottom navigation bar
///
/// Contains 6 tabs: Chat, Bots, Agents, Knowledge, Prompts, Account
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages corresponding to bottom nav items
  final List<Widget> _pages = const <Widget>[
    ChatPage(),
    BotsPage(),
    AgentsPage(),
    KnowledgePage(),
    PromptsPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIcon(String assetPath, bool isSelected) {
    return SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        BlendMode.srcIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fixed type for more than 3 items
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon('assets/icons/ic_chat.svg', false),
            activeIcon: _buildIcon('assets/icons/ic_chat.svg', true),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/icons/ic_bot.svg', false),
            activeIcon: _buildIcon('assets/icons/ic_bot.svg', true),
            label: 'Bots',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/icons/ic_agent.svg', false),
            activeIcon: _buildIcon('assets/icons/ic_agent.svg', true),
            label: 'Agents',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/icons/ic_knowledge.svg', false),
            activeIcon: _buildIcon('assets/icons/ic_knowledge.svg', true),
            label: 'Knowledge',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/icons/ic_prompt.svg', false),
            activeIcon: _buildIcon('assets/icons/ic_prompt.svg', true),
            label: 'Prompts',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('assets/icons/ic_account.svg', false),
            activeIcon: _buildIcon('assets/icons/ic_account.svg', true),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: _onItemTapped,
      ),
    );
  }
}

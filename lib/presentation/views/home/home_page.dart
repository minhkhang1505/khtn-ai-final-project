import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/presentation/views/chat/chat_page.dart';
import 'package:khtn_ai_final_project/presentation/views/bots/bots_page.dart';
import 'package:khtn_ai_final_project/presentation/views/agents/agents_page.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledge_page.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/prompts_page.dart';
import 'package:khtn_ai_final_project/presentation/views/account/account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    // {'icon': 'assets/icons/ic_prompt.svg', 'label': 'Prompts'},
    {'icon': 'assets/icons/ic_account.svg', 'label': 'Account'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          ChatPage(),
          BotsPage(),
          AgentsPage(),
          KnowledgePage(),
          // PromptsPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: Container(
        // Tăng chiều cao lên chút để nút active không bị chật
        height: 64,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 0),
              spreadRadius: 1,
            ),
          ],
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            40,
          ), // Bắt buộc phải khai báo lại radius giống bên trên
          border: Border.all(
            color: colorScheme.outlineVariant.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(
              color: colorScheme.surface.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (index) {
                  final isSelected = _selectedIndex == index;
                  final item = _navItems[index];

                  return GestureDetector(
                    onTap: () => _onItemTapped(index),
                    behavior: HitTestBehavior.opaque,
                    // AnimatedContainer giờ bao trọn cả Column
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      // Padding bên trong nút active
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      width: isSelected
                          ? 100
                          : 61, // Active thì rộng hơn xíu (tuỳ chỉnh)
                      decoration: BoxDecoration(
                        // Nền active bao trọn cả cụm
                        color: isSelected
                            ? colorScheme.onSurfaceVariant.withOpacity(0.1)
                            : Colors.transparent,
                        // Bo góc kiểu viên thuốc
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min giúp Column gọn lại vừa nội dung
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            item['icon']!,
                            width: isSelected ? 25 : 20,
                            height: isSelected ? 25 : 20,
                            colorFilter: ColorFilter.mode(
                              // Khi chọn thì Icon trắng, không chọn thì xám
                              isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                              BlendMode.srcIn,
                            ),
                          ),
                          Text(
                            item['label']!,
                            style: TextStyle(
                              fontSize: isSelected ? 13 : 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// /// Main page with bottom navigation bar
// ///
// /// Contains 6 tabs: Chat, Bots, Agents, Knowledge, Prompts, Account
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Widget _buildIcon(String assetPath, bool isSelected) {
//     return SvgPicture.asset(
//       assetPath,
//       width: 24,
//       height: 24,
//       colorFilter: ColorFilter.mode(
//         isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
//         BlendMode.srcIn,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: const [
//           ChatPage(),
//           BotsPage(),
//           AgentsPage(),
//           KnowledgePage(),
//           PromptsPage(),
//           AccountPage(),
//         ],
//       ),
//       bottomNavigationBar: 
//       BottomNavigationBar(
//         type: BottomNavigationBarType.fixed, // Fixed type for more than 3 items
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: _buildIcon('assets/icons/ic_chat.svg', false),
//             activeIcon: _buildIcon('assets/icons/ic_chat.svg', true),
//             label: 'Chat',
//           ),
//           BottomNavigationBarItem(
//             icon: _buildIcon('assets/icons/ic_bot.svg', false),
//             activeIcon: _buildIcon('assets/icons/ic_bot.svg', true),
//             label: 'Bots',
//           ),
//           BottomNavigationBarItem(
//             icon: _buildIcon('assets/icons/ic_agent.svg', false),
//             activeIcon: _buildIcon('assets/icons/ic_agent.svg', true),
//             label: 'Agents',
//           ),
//           BottomNavigationBarItem(
//             icon: _buildIcon('assets/icons/ic_knowledge.svg', false),
//             activeIcon: _buildIcon('assets/icons/ic_knowledge.svg', true),
//             label: 'Knowledge',
//           ),
//           BottomNavigationBarItem(
//             icon: _buildIcon('assets/icons/ic_prompt.svg', false),
//             activeIcon: _buildIcon('assets/icons/ic_prompt.svg', true),
//             label: 'Prompts',
//           ),
//           BottomNavigationBarItem(
//             icon: _buildIcon('assets/icons/ic_account.svg', false),
//             activeIcon: _buildIcon('assets/icons/ic_account.svg', true),
//             label: 'Account',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Theme.of(context).colorScheme.primary,
//         unselectedItemColor: Colors.grey,
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class CustomFloatingNavBar extends StatefulWidget {
//   const CustomFloatingNavBar({super.key});

//   @override
//   State<CustomFloatingNavBar> createState() => _CustomFloatingNavBarState();
// }

// class _CustomFloatingNavBarState extends State<CustomFloatingNavBar> {
//   int _selectedIndex = 0;

//   // Danh sách các mục menu của bạn
//   final List<Map<String, dynamic>> _navItems = [
//     {'icon': 'assets/icons/ic_chat.svg', 'label': 'Chat'},
//     {'icon': 'assets/icons/ic_bot.svg', 'label': 'Bots'},
//     {'icon': 'assets/icons/ic_agent.svg', 'label': 'Agents'},
//     // {'icon': 'assets/icons/ic_knowledge.svg', 'label': 'Knowledge'}, // 6 items có thể hơi chật cho thiết kế này, cân nhắc số lượng
//     {'icon': 'assets/icons/ic_prompt.svg', 'label': 'Prompts'},
//     {'icon': 'assets/icons/ic_account.svg', 'label': 'Account'},
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200], // Màu nền để thấy rõ thanh nav nổi
//       extendBody: true, // QUAN TRỌNG: Cho phép body tràn xuống dưới thanh nav
//       body: Center(
//         child: Text("Nội dung màn hình $_selectedIndex"),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Container(
//           height: 65, // Chiều cao của thanh
//           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Tạo khoảng cách để "nổi"
//           decoration: BoxDecoration(
//             color: Colors.white, // Màu nền thanh nav
//             borderRadius: BorderRadius.circular(35), // Bo tròn dạng viên thuốc
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.15), // Màu bóng
//                 blurRadius: 20, // Độ mờ của bóng
//                 offset: const Offset(0, 10), // Độ lệch bóng
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Chia đều khoảng cách
//             children: List.generate(_navItems.length, (index) {
//               final isSelected = _selectedIndex == index;
//               return GestureDetector(
//                 onTap: () => _onItemTapped(index),
//                 behavior: HitTestBehavior.opaque,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Container bao quanh Icon để tạo hiệu ứng "Blue Circle" khi chọn
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 200),
//                       padding: EdgeInsets.all(isSelected ? 10 : 8),
//                       decoration: BoxDecoration(
//                         color: isSelected ? Colors.blue : Colors.transparent, // Màu xanh khi chọn
//                         shape: BoxShape.circle,
//                       ),
//                       // Lưu ý: Thay Icon bên dưới bằng SvgPicture.asset của bạn
//                       child: Icon(
//                         Icons.circle, // Thay bằng SvgPicture.asset(_navItems[index]['icon'])
//                         color: isSelected ? Colors.white : Colors.grey,
//                         size: 24,
//                       ),
//                     ),
//                     // Có thể ẩn Label khi chưa chọn để giống hình mẫu hơn
//                     if (isSelected) 
//                       Text(
//                         _navItems[index]['label'],
//                         style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ),
//                       )
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
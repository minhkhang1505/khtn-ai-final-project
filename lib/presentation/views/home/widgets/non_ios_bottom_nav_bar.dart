import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NonIosBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Map<String, String>> navItems;

  const NonIosBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.navItems,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final unselectedColor = Colors.grey;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Fixed type for > 3 items
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: primaryColor,
      unselectedItemColor: unselectedColor,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      // Tạo danh sách items động từ list navItems truyền vào
      items: navItems.map((item) {
        return BottomNavigationBarItem(
          icon: _buildIcon(item['icon']!, unselectedColor),
          activeIcon: _buildIcon(item['icon']!, primaryColor),
          label: item['label'],
        );
      }).toList(),
    );
  }

  // Hàm helper để dựng icon SVG và tô màu
  Widget _buildIcon(String assetPath, Color color) {
    return SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      // Sử dụng colorFilter để đổi màu icon
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
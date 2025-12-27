import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IosBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Map<String, String>> navItems;

  const IosBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.navItems,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy colorScheme từ context để đảm bảo màu sắc đúng theme
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
              children: List.generate(navItems.length, (index) {
                final isSelected = currentIndex == index;
                final item = navItems[index];

                return GestureDetector(
                  onTap: () => onTap(index),
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
    );
  }
}

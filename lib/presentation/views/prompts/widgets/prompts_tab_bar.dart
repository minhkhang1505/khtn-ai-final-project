import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/theme/app_radius.dart';

class PromptsTabBar extends StatelessWidget {
  final TabController controller;

  const PromptsTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: AppBorderRadius.extraExtraLarge,
        child: Container(
          height: 40,
          color: colorScheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: TabBar(
              controller: controller,
              indicator: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: AppBorderRadius.extraExtraLarge,
              ),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              labelColor: colorScheme.onPrimary,
              unselectedLabelColor: colorScheme.primary,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: "All Prompts"),
                Tab(text: "Categories"),
                Tab(text: "Favorite"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

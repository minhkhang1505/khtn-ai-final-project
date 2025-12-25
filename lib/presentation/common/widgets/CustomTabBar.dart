import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class CustomTabbar extends StatelessWidget {
  final TabController controller;
  final List<String> tabLabels;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  const CustomTabbar({
    super.key,
    required this.controller,
    required this.tabLabels,
    this.height,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: AppBorderRadius.extraExtraLarge,
        child: Container(
          height: height ?? 40,
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
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: fontSize ?? 16,
              ),
              tabs: tabLabels.map((label) => Tab(text: label)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/bot_view_model.dart';

class BotFilterOptionMenu extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const BotFilterOptionMenu({super.key, this.onChanged});

  @override
  State<BotFilterOptionMenu> createState() => _BotFilterOptionMenuState();
}

class _BotFilterOptionMenuState extends State<BotFilterOptionMenu> {
  final List<Map<String, String>> options = const [
    {'key': 'all', 'label': 'All Bots'},
    {'key': 'favorite', 'label': 'Favorite'},
    {'key': 'date', 'label': 'Sort by Date'},
    {'key': 'name', 'label': 'Sort by Name'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final botViewModel = context.read<BotViewModel>();

    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      color: colorScheme.surface,
      elevation: 6,
      offset: const Offset(0, 40),
      onSelected: (index) {
        final key = options[index]['key']!;
        botViewModel.filter = key;
        widget.onChanged?.call(key);
      },
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.25,
      ),
      itemBuilder: (context) => List.generate(
        options.length,
        (index) => PopupMenuItem<int>(
          value: index,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(options[index]['label']!),
              if (botViewModel.filter == options[index]['key'])
                Icon(Icons.check, color: colorScheme.primary, size: 18),
            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: colorScheme.outline.withAlpha(100)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.4),
              child: Text(
                options.firstWhere((o) => o['key'] == botViewModel.filter, orElse: () => options[0])['label']!,
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

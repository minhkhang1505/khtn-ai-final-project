import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/bot/bot_view_model.dart';

class BotSearch extends StatefulWidget {
  const BotSearch({super.key});

  @override
  State<BotSearch> createState() => _BotSearchState();
}

class _BotSearchState extends State<BotSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final botViewModel = context.read<BotViewModel>();

    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          botViewModel.setSearchQuery(value);
        },
        decoration: InputDecoration(
          hintText: 'Search bots...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    botViewModel.setSearchQuery('');
                  },
                )
              : null,
          filled: true,
          fillColor: colorScheme.surfaceContainerHigh.withAlpha(200),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.medium,
            borderSide: BorderSide(
              color: colorScheme.primary.withAlpha(150),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppBorderRadius.medium,
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}

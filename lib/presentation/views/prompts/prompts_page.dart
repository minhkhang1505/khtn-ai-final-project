import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/core/constants/sample_prompts.dart';
import 'package:khtn_ai_final_project/domain/entities/category.dart';
import 'package:khtn_ai_final_project/domain/entities/prompt_entity.dart';
import 'package:khtn_ai_final_project/presentation/common/widgets/custom_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/all_prompts_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/categories_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/favorite_prompts_tab.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompts_app_bar.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/prompts_tab_bar.dart';

/// Prompts page - Manage AI prompts
class PromptsPage extends StatefulWidget {
  const PromptsPage({super.key});

  @override
  State<PromptsPage> createState() => _PromptsPageState();
}

class _PromptsPageState extends State<PromptsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late List<PromptEntity> _prompts;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _prompts = List.from(samplePrompts);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleAddPrompt() {
    Navigator.pushNamed(context, '/prompts/new');
    // TODO: Implement add prompt logic
  }

  void _handleFavoriteTap(PromptEntity prompt) {
    setState(() {
      final index = _prompts.indexWhere((p) => p.id == prompt.id);
      if (index != -1) {
        _prompts[index] = prompt.copyWith(isFavorite: !prompt.isFavorite);
      }
    });
  }

  void _handleCategoryTap(Category category) {
    // TODO: Implement category filter logic
    debugPrint('Category tapped: ${category.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'AI Prompts',
        subtitle: 'Browse and manage your AI prompts',
        // toolbarHeight: AppBarInfo.height,
        onCreatePressed: _handleAddPrompt,
        createButtonLabel: 'Add Prompt',
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth > 600;
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isWideScreen ? 1200 : double.infinity,
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    PromptsTabBar(controller: _tabController),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          AllPromptsTab(
                            prompts: _prompts,
                            onFavoriteTap: _handleFavoriteTap,
                          ),
                          CategoriesTab(
                            categories: categories,
                            onCategoryTap: _handleCategoryTap,
                          ),
                          FavoritePromptsTab(
                            prompts: _prompts,
                            onFavoriteTap: _handleFavoriteTap,
                          ),
                        ],
                      ),
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

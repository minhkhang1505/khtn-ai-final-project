import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/category.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/category_item.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/filter_by_category.dart';
import 'package:provider/provider.dart';

class CategoriesTab extends StatelessWidget {
  final List<Category> categories;

  const CategoriesTab({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<PromptViewmodel>(context, listen: false);

    return LayoutBuilder(
      builder: (context, constraints) {
        // You can adjust the width threshold as needed for your design
        final isWide = constraints.maxWidth >= 800;
        final crossAxisCount = isWide ? 4 : 2;
        switch (viewmodel.viewState) {
          case PromptViewState.loading:
            return const Center(child: CircularProgressIndicator());
          case PromptViewState.failure:
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1.7,
              children: [
                for (var category in categories)
                  CategoryItem(
                    categoryName: category.name,
                    iconPath: category.iconPath,
                    onTap: () {
                      viewmodel.getPromptByCategory(category.id);
                      debugPrint('Category tapped: ${category.name}');
                    },
                  ),
              ],
            );
          case PromptViewState.success:
            return FilterByCategory(prompts: viewmodel.prompts ?? []);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/category.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/prompt/prompt_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/category_item.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/filter_by_category.dart';
import 'package:provider/provider.dart';

class CategoriesTab extends StatelessWidget {
  final List<Category> categories;

  const CategoriesTab({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;
        final crossAxisCount = isWide ? 4 : 2;

        return GridView.count(
          primary: false,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1.7,
          children: [
            for (var category in categories)
              CategoryItem(
                categoryName: category.name,
                iconPath: category.iconPath,
                onTap: () async {
                  final viewModel = context.read<PromptViewmodel>();
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider.value(
                        value: viewModel,
                        child: FilterByCategoryPage(
                          category: category.id,
                          categoryName: category.name,
                        ),
                      ),
                    ),
                  );

                  // If result is prompt content to use, pop PromptsPage with it
                  if (result is String &&
                      result.isNotEmpty &&
                      context.mounted) {
                    Navigator.of(context).pop(result);
                  }
                },
              ),
          ],
        );
      },
    );
  }
}

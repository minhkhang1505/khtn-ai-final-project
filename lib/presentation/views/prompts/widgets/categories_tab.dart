import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/category.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/category_item.dart';

class CategoriesTab extends StatelessWidget {
  final List<Category> categories;
  final Function(Category)? onCategoryTap;

  const CategoriesTab({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 1.7,
      children: [
        for (var category in categories)
          CategoryItem(
            categoryName: category.name,
            iconPath: category.iconPath,
            onTap: () => onCategoryTap?.call(category),
          ),
      ],
    );
  }
}

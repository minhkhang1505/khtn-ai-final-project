import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/constants/categories.dart';
import 'package:khtn_ai_final_project/presentation/views/prompts/widgets/category_item.dart';

class CategoryPickerPage extends StatelessWidget {
  final CategoryType selectedCategory;

  const CategoryPickerPage({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.transparent),
          onPressed: () {},
        ),
        title: const Text('Select Category'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;
          final crossAxisCount = isWide ? 4 : 2;

          return GridView.count(
            primary: false,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1.7,
            children: [
              for (final category in categories)
                CategoryItem(
                  categoryName: category.name,
                  iconPath: category.iconPath,
                  onTap: () => Navigator.pop(context, category.id),
                ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

// class CategoryDropdown extends StatefulWidget {
//   const CategoryDropdown({super.key});

//   @override
//   State<CategoryDropdown> createState() => _CategoryDropdownState();
// }

// class _CategoryDropdownState extends State<CategoryDropdown> {
//   final List<String> categories = [
//     'General',
//     'Customer Support',
//     'Sales',
//     'HR',
//     'Development',
//     'Marketing',
//   ];

//   String selectedCategory = 'General';

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       initialValue: selectedCategory,
//       items: categories
//           .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//           .toList(),
//       onChanged: (value) {
//         if (value != null) {
//           setState(() => selectedCategory = value);
//         }
//       },
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 14,
//           horizontal: 16,
//         ),
//         filled: true,
//         fillColor: Colors.grey.shade200,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       icon: const Icon(Icons.keyboard_arrow_down_rounded),
//       dropdownColor: Colors.white,
//       style: const TextStyle(fontSize: 15, color: Colors.black87),
//     );
//   }
// }

class CategoryOptionMenu extends StatefulWidget {
  final Function(String)? onChanged;
  const CategoryOptionMenu({super.key, this.onChanged});

  @override
  State<CategoryOptionMenu> createState() => _CategoryOptionMenuState();
}

class _CategoryOptionMenuState extends State<CategoryOptionMenu> {
  final List<String> categories = [
    'General',
    'Customer Support',
    'Sales',
    'HR',
    'Development',
    'Marketing',
  ];

  String? selectedModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.medium),
      color: colorScheme.surface,
      elevation: 6,
      offset: const Offset(0, 40),
      onSelected: (index) {
        final category = categories[index];
        setState(() {
          selectedModel = category;
        });
        widget.onChanged?.call(category);
      },
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.3,
      ),
      itemBuilder: (context) => List.generate(
        categories.length,
        (index) => PopupMenuItem<int>(
          value: index,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(categories[index]),
              if (selectedModel == categories[index])
                const Icon(Icons.check, color: Colors.blue, size: 18),
            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: colorScheme.outline.withAlpha(100)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedModel ?? "Select Category"),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

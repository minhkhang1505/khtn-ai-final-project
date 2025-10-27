import 'package:flutter/material.dart';

class AiModelDropdown extends StatefulWidget {
  const AiModelDropdown({super.key});

  @override
  State<AiModelDropdown> createState() => _AiModelDropdownState();
}

class _AiModelDropdownState extends State<AiModelDropdown> {
  final List<String> categories = [
    'GPT-3.5',
    'GPT-4',
    'Claude',
    'Claude 2',
    'Bard',
    'Llama 3',
  ];

  String selectedCategory = 'GPT-3.5';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedCategory,
      items: categories
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => selectedCategory = value);
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      dropdownColor: Colors.white,
      style: const TextStyle(fontSize: 15, color: Colors.black87),
    );
  }
}

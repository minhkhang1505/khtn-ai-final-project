import 'package:flutter/material.dart';

class PromptsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddPrompt;

  const PromptsAppBar({super.key, required this.onAddPrompt});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prompts'),
              SizedBox(height: 4),
              Text(
                'Browse and manage your AI prompts',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          IconButton(onPressed: onAddPrompt, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

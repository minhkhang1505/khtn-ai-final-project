import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PromptsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddPrompt;

  const PromptsAppBar({super.key, required this.onAddPrompt});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
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
          IconButton(
            onPressed: onAddPrompt,
            icon: SvgPicture.asset(
              'assets/icons/ic_add.svg',
              width: 45,
              height: 45,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

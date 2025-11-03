import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KnowledgeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddKnowledge;

  const KnowledgeAppBar({super.key, required this.onAddKnowledge});

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
              Text('Knowledge'),
              SizedBox(height: 4),
              Text('Connect data sources', style: TextStyle(fontSize: 14)),
            ],
          ),
          IconButton(
            onPressed: onAddKnowledge,
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

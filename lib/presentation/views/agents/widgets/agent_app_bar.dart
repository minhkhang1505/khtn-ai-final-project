import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddAgent;

  const AgentAppBar({super.key, required this.onAddAgent});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Agents'),
          SizedBox(height: 4),
          Text('Manage your AI agents', style: TextStyle(fontSize: 14)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: onAddAgent,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

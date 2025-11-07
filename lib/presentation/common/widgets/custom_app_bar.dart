import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khtn_ai_final_project/core/constants/constant.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final double? toolbarHeight;
  final VoidCallback? onCreatePressed;
  final String? createButtonLabel;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions = const [],
    this.toolbarHeight,
    this.onCreatePressed,
    this.createButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> allActions = [...actions];
    if (onCreatePressed != null) {
      if (kIsWeb) {
        allActions.add(
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: FilledButton.icon(
              onPressed: onCreatePressed,
              icon: const Icon(Icons.add, size: 18),
              label: Text(
                createButtonLabel ?? 'Create',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        );
      } else {
        allActions.add(
          IconButton(
            onPressed: onCreatePressed,
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
        );
      }
    }
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppBarInfo.titleTextStyle),
          Text(subtitle, style: AppBarInfo.subtitleTextStyle),
        ],
      ),
      actions: allActions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}

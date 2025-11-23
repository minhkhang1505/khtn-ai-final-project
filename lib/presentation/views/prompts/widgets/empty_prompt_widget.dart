import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPromptWidget extends StatelessWidget {
  final String message;
  const EmptyPromptWidget({super.key, this.message = "No items available."});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_empty_list.svg',
            width: 120,
            height: 120,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary.withAlpha(140),
              BlendMode.srcIn,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }
}

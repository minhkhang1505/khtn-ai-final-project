import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final TextStyle? messageStyle;
  final VoidCallback? onActionPressed;
  final String? actionButtonLabel;
  final Widget? customIcon;
  final EdgeInsets? padding;
  final Future<void> Function()? onRefresh;

  const EmptyStateWidget({
    super.key,
    this.message = "No items available.",
    this.iconPath = 'assets/icons/ic_empty_list.svg',
    this.iconWidth = 120,
    this.iconHeight = 120,
    this.messageStyle,
    this.onActionPressed,
    this.actionButtonLabel,
    this.customIcon,
    this.padding,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            customIcon ??
                SvgPicture.asset(
                  iconPath!,
                  width: iconWidth,
                  height: iconHeight,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary.withAlpha(140),
                    BlendMode.srcIn,
                  ),
                ),
            const SizedBox(height: 16),
            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style:
                  messageStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(150),
                  ),
            ),
            // Action Button (optional)
            if (onActionPressed != null && actionButtonLabel != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onActionPressed,
                child: Text(actionButtonLabel!),
              ),
            ],
          ],
        ),
      ),
    );

    if (onRefresh != null) {
      // Wrap in a scrollable for RefreshIndicator
      content = RefreshIndicator(
        onRefresh: onRefresh!,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [SizedBox(height: 80), content, SizedBox(height: 80)],
        ),
      );
    }
    return content;
  }
}

/// Backward compatibility - keeping old name as alias
class EmptyPromptWidget extends EmptyStateWidget {
  const EmptyPromptWidget({super.key, super.message = "No items available.", super.onRefresh});
}

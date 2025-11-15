import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class AuthPrimaryButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool? isLoading;

  const AuthPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading,
  });

  @override
  State<AuthPrimaryButton> createState() => _AuthPrimaryButtonState();
}

class _AuthPrimaryButtonState extends State<AuthPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      onPressed: widget.isLoading == true ? null : widget.onPressed,
      label: widget.isLoading == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: colorScheme.onSurface.withAlpha(120),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Processing...',
                  style: TextStyle(color: colorScheme.onSurface.withAlpha(120)),
                ),
              ],
            )
          : Text(
              widget.text,
              style: TextStyle(fontSize: 16, color: colorScheme.onPrimary),
            ),
      icon: widget.isLoading == true
          ? null
          : Icon(Icons.arrow_forward, color: colorScheme.onPrimary),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.large),
      ),
    );
  }
}

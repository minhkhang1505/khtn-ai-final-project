import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/theme/app_radius.dart';

class LogoutDialog extends StatefulWidget {
  final Future<void> Function()? onLogout;
  final String? confirmText;
  final String? loadingText;
  final String? errorText;

  const LogoutDialog({
    super.key,
    this.onLogout,
    this.confirmText,
    this.loadingText,
    this.errorText,
  });

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool _isLoading = false;
  String? _error;

  void _handleLogout() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      if (widget.onLogout != null) {
        await widget.onLogout!();
      }
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _error = widget.errorText ?? 'Logout failed. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.confirmText ?? 'Confirm Logout'),
      content: _isLoading
          ? Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(widget.loadingText ?? 'Logging out...'),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.confirmText ?? 'Are you sure you want to log out?'),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
              ],
            ),
      actions: _isLoading
          ? []
          : [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,

                  shape: RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.medium,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error.withAlpha(100),
                    ),
                  ),
                ),

                onPressed: _handleLogout,
                child: Text(
                  'Logout',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
    );
  }
}

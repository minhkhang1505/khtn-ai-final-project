import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/chat/chat_view_model.dart';

/// Usage button that displays remaining tokens and shows details on tap
class UsageButton extends StatelessWidget {
  const UsageButton({super.key});

  void _showUsageDialog(BuildContext context, ChatViewModel vm) async {
    final colorScheme = Theme.of(context).colorScheme;

    // Fetch latest usage data
    vm.getUsage();

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.analytics_outlined, color: colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Token Usage'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUsageRow(
              'Plan',
              vm.tokenUsage.unlimited ? 'Premium' : 'Free',
              Icons.workspace_premium_outlined,
              colorScheme,
            ),
            const SizedBox(height: 12),
            _buildUsageRow(
              'Total Tokens',
              vm.tokenUsage.totalTokens.toString(),
              Icons.credit_card,
              colorScheme,
            ),
            const SizedBox(height: 12),
            _buildUsageRow(
              'Remaining Usage',
              vm.tokenUsage.availableTokens.toString(),
              Icons.token,
              colorScheme,
            ),
            const SizedBox(height: 12),
            _buildUsageRow(
              'Used Tokens',
              (vm.tokenUsage.totalTokens - vm.tokenUsage.availableTokens)
                  .toString(),
              Icons.trending_up,
              colorScheme,
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: vm.tokenUsage.totalTokens > 0
                  ? vm.tokenUsage.availableTokens / vm.tokenUsage.totalTokens
                  : 0,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(
                  vm.tokenUsage.availableTokens,
                  vm.tokenUsage.totalTokens,
                  colorScheme,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              vm.tokenUsage.totalTokens > 0
                  ? '${((vm.tokenUsage.availableTokens / vm.tokenUsage.totalTokens) * 100).toStringAsFixed(1)}% remaining'
                  : 'No quota information available',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          if (!vm.tokenUsage.unlimited)
            TextButton.icon(
              onPressed: () {
                // Placeholder for upgrade action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Upgrade flow not implemented yet'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.upgrade),
              label: const Text('Upgrade plan'),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageRow(
    String label,
    String value,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(int available, int total, ColorScheme colorScheme) {
    final percentage = available / total;
    if (percentage > 0.5) return Colors.green;
    if (percentage > 0.2) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final vm = context.watch<ChatViewModel>();
    final isPremium = vm.tokenUsage.unlimited;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showUsageDialog(context, vm),
          borderRadius: BorderRadius.circular(20),
          hoverColor: colorScheme.surfaceContainerHighest,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPremium ? Icons.workspace_premium_outlined : Icons.token,
                  size: 16,
                  color: isPremium ? Colors.amber : colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  '${isPremium ? 'Premium' : 'Free'} • ${vm.tokenUsage.availableTokens}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

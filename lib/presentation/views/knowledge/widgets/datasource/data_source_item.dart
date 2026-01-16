import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataSourceItem extends StatelessWidget {
  final DataSourceEntity dataSource;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const DataSourceItem({
    super.key,
    required this.dataSource,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconPath = _resolveIconPath(dataSource.type);
    final updatedAt = (dataSource.updatedAt?.trim().isNotEmpty ?? false)
        ? dataSource.updatedAt!
        : dataSource.createdAt;
    final description = dataSource.description?.trim();
    final hasDescription = description != null && description.isNotEmpty;
    final statusLabel = dataSource.isActive ? 'Active' : 'Inactive';
    final statusColor = dataSource.isActive ? Colors.green : Colors.grey;
    final syncLabel = _syncStatusLabel(dataSource.syncStatus);
    final syncColor = _syncStatusColor(dataSource.syncStatus);
    final syncIcon = _syncStatusIcon(dataSource.syncStatus);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.outline.withAlpha(50),
            width: 1.5,
          ),
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataSource.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _StatusDot(color: statusColor),
                      const SizedBox(width: 6),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(syncIcon, size: 14, color: syncColor),
                      const SizedBox(width: 6),
                      Text(
                        syncLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: syncColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Updated: $updatedAt',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (hasDescription) ...[
                    const SizedBox(height: 6),
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDelete,
              icon: SvgPicture.asset(
                'assets/icons/ic_delete.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  colorScheme.error,
                  BlendMode.srcIn,
                ),
              ),
              color: colorScheme.error,
              tooltip: 'Delete',
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }

  String _syncStatusLabel(String? status) {
    switch (status) {
      case 'syncing':
        return 'Syncing';
      case 'not_synced':
        return 'Not Synced';
      case 'synced':
        return 'Synced';
      default:
        return 'Unknown';
    }
  }

  Color _syncStatusColor(String? status) {
    switch (status) {
      case 'syncing':
        return Colors.orange;
      case 'not_synced':
        return Colors.amber;
      case 'synced':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _syncStatusIcon(String? status) {
    switch (status) {
      case 'syncing':
        return Icons.sync;
      case 'not_synced':
        return Icons.warning_amber_rounded;
      case 'synced':
        return Icons.check_circle_outline;
      default:
        return Icons.help_outline;
    }
  }

  String _resolveIconPath(String? type) {
    switch (type) {
      case 'local_file':
        return 'assets/icons/ic_file.svg';
      case 'web':
        return 'assets/icons/ic_url.svg';
      default:
        return 'assets/icons/ic_knowledge.svg';
    }
  }
}

class _StatusDot extends StatelessWidget {
  final Color color;

  const _StatusDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

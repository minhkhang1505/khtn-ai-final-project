import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/models/datasource.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DataSourceItem extends StatelessWidget {
  final DataSource dataSource;
  final String iconPath;
  final VoidCallback onTap;  

  const DataSourceItem({
    super.key,
    required this.dataSource,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
            SizedBox(width: 6),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataSource.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    softWrap: true,
                  ),
                  Text(
                    dataSource.isActive as String,
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  Text(
                    'Created at: ${dataSource.createdAt}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

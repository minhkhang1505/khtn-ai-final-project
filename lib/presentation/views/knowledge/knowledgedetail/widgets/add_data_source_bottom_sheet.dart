import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_type.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/widgets/add_file_dialog.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/widgets/add_drive_dialog.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/widgets/add_url_dialog.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/widgets/add_confluence_dialog.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/knowledgedetail/widgets/add_slack_dialog.dart';
import 'package:provider/provider.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/datasource_viewmodel.dart';

/// Bottom sheet widget for adding data source
class AddDataSourceBottomSheet extends StatelessWidget {
  final DatasourceViewmodel datasourceViewModel;

  const AddDataSourceBottomSheet({
    super.key,
    required this.datasourceViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceBright,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add Data Source',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            'Select a data source to add:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // Data source options from DataSourceTypes
          ...DataSourceTypes.all.map(
            (dataSource) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildDataSourceOption(
                context,
                iconAssetPath: dataSource.iconAssetPath,
                title: dataSource.name,
                subtitle: 'Add from ${dataSource.name}',
                onTap: () => _handleDataSourceSelection(context, dataSource),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _handleDataSourceSelection(
    BuildContext context,
    DataSourceType dataSource,
  ) async {
    // Close the bottom sheet first
    Navigator.pop(context);

    // Handle different data source types
    if (dataSource == DataSourceTypes.file) {
      // Show file dialog
      final result = await showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
          value: datasourceViewModel,
          child: const AddFileDialog(),
        ),
      );

      if (result != null) {
        // TODO: Handle file upload with result['file'] and result['prompt']
      }
    } else if (dataSource == DataSourceTypes.drive) {
      // Show Google Drive dialog
      final result = await showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
          value: datasourceViewModel,
          child: const AddDriveDialog(),
        ),
      );

      if (result != null) {
        // TODO: Handle Google Drive file with result['name'], result['fileId'], result['fileName'], and result['prompt']
      }
    } else if (dataSource == DataSourceTypes.url) {
      // Show URL dialog
      final result = await showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
          value: datasourceViewModel,
          child: const AddUrlDialog(),
        ),
      );

      if (result != null) {
        // TODO: Handle URL with result['name'] and result['url']
      }
    } else if (dataSource == DataSourceTypes.confluence) {
      // Show Confluence dialog
      final result = await showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
          value: datasourceViewModel,
          child: const AddConfluenceDialog(),
        ),
      );

      if (result != null) {
        // TODO: Handle Confluence with result['name'], result['url'], result['username'], and result['apiToken']
      }
    } else if (dataSource == DataSourceTypes.slack) {
      // Show Slack dialog
      final result = await showDialog(
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
          value: datasourceViewModel,
          child: const AddSlackDialog(),
        ),
      );

      if (result != null) {
        // TODO: Handle Slack with result['name'] and result['botToken']
      }
    }
  }

  Widget _buildDataSourceOption(
    BuildContext context, {
    required String iconAssetPath,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outline.withAlpha(30),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withAlpha(50),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                iconAssetPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

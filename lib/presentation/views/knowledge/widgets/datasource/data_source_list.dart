import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';
import 'package:khtn_ai_final_project/presentation/views/common/widgets/error_dialog_widget.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/datasource_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/datasource/data_source_item.dart';
import 'package:provider/provider.dart';

class DataSourceList extends StatefulWidget {
  final String knowledgeId;

  const DataSourceList({super.key, required this.knowledgeId});

  @override
  State<DataSourceList> createState() => _DataSourceListState();
}

class _DataSourceListState extends State<DataSourceList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatasourceViewmodel>(
      builder: (context, vm, child) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: vm.dataSource.length,
          itemBuilder: (context, index) {
            if (index == vm.dataSource.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return DataSourceItem(
              dataSource: vm.dataSource[index],
              onTap: () => _onItemTap(vm.dataSource[index]),
              onDelete: () => _confirmDelete(vm.dataSource[index]),
            );
          },
        );
      },
    );
  }

  void _onItemTap(DataSourceEntity dataSource) {
    //TODO: Show model bottom sheet with data source details: title + description
  }

  Future<void> _confirmDelete(DataSourceEntity dataSource) async {
    final vm = context.read<DatasourceViewmodel>();
    final shouldDelete = await ErrorDialogWidget.show(
      context,
      title: 'Delete Data Source',
      errorMessage:
          'Delete "${dataSource.name}"? This action cannot be undone.',
      showConfirmButton: true,
      confirmText: 'Delete',
      closeText: 'Cancel',
    );

    if (shouldDelete != true || !mounted) return;

    final success = await vm.deleteDataSource(
      widget.knowledgeId,
      dataSource.id,
    );
    if (!mounted) return;

    if (success) {
      await vm.getDataSourceFromKnowledge(
        widget.knowledgeId,
        limit: 20,
        offset: 0,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data source deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(vm.errorMessage ?? 'Failed to delete data source'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

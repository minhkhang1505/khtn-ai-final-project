import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/models/datasource.dart';
import 'package:khtn_ai_final_project/presentation/viewmodels/knowledge/datasource_viewmodel.dart';
import 'package:khtn_ai_final_project/presentation/views/knowledge/widgets/datasource/data_source_item.dart';
import 'package:provider/provider.dart';

class DataSourceList extends StatefulWidget {
  const DataSourceList({super.key});

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
              iconPath: 'assets/icons/ic_knowledge.svg',
              dataSource: vm.dataSource[index],
              onTap: () => _onItemTap(vm.dataSource[index]),
            );
          },
        );
      },
    );
  }

  void _onItemTap(DataSource dataSource) {
    //TODO: Show model bottom sheet with data source details: title + description
  }
}

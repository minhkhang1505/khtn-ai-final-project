import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_response_model.dart';
import 'package:khtn_ai_final_project/domain/models/datasource.dart';
import 'package:injectable/injectable.dart';

@injectable
class DatasourceViewmodel extends ChangeNotifier {

  List<DataSource> _dataSource = [];
  List<DataSource> get dataSource => _dataSource;


}
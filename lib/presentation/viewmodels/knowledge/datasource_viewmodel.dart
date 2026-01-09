import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/usecases/datasource/upload_multiple_file_usecase.dart';

@injectable
class DatasourceViewmodel extends ChangeNotifier {
  final UploadMultipleFileUsecase uploadMultipleFileUsecase;

  DatasourceViewmodel({required this.uploadMultipleFileUsecase});

  List<DataSourceEntity> _dataSource = [];
  List<DataSourceEntity> get dataSource => _dataSource;

  void setDataSource(List<DataSourceEntity> sources) {
    _dataSource = sources;
    notifyListeners();
  }

  Future<String> uploadFiles(List<PlatformFile> files) async {
    try {
      final result = await uploadMultipleFileUsecase.call(files);
      debugPrint("Khang: Uploaded files result: $result");
      return UploadedFile.fromJson(result.toJson()).url;
    } catch (e) {
      debugPrint("Khang: Error uploading files: $e");
      return '';
    }
  }
}

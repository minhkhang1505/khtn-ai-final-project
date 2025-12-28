import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/domain/models/datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/usecases/datasource/upload_multiple_file_usecase.dart';

@injectable
class DatasourceViewmodel extends ChangeNotifier {

  final UploadMultipleFileUsecase uploadMultipleFileUsecase;

  DatasourceViewmodel({required this.uploadMultipleFileUsecase});

  List<DataSource> _dataSource = [];
  List<DataSource> get dataSource => _dataSource;

  void setDataSource(List<DataSource> sources) {
    _dataSource = sources;
    notifyListeners();
  }

  Future<bool> uploadFiles(List<PlatformFile> files) async {
    try {
      final result = await uploadMultipleFileUsecase.call(files);
      debugPrint("Khang: Uploaded files result: $result");
      return result;
    } catch (e) {
      debugPrint("Khang: Error uploading files: $e");
      return false;
    }
  }
}
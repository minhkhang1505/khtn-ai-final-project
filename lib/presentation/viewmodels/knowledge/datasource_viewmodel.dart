import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';
import 'package:khtn_ai_final_project/domain/usecases/datasource/get_datasource_from_knowledge_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/usecases/datasource/upload_multiple_file_usecase.dart';

enum DataSourceState { initial, loading, success, failure }

@injectable
class DatasourceViewmodel extends ChangeNotifier {
  final UploadMultipleFileUsecase uploadMultipleFileUsecase;
  final GetDataSourceFromKnowledgeUsecase getDataSourceFromKnowledgeUsecase;

  DatasourceViewmodel({
    required this.uploadMultipleFileUsecase,
    required this.getDataSourceFromKnowledgeUsecase,
  });

  DataSourceState _state = DataSourceState.initial;
  DataSourceState get state => _state;

  List<DataSourceEntity> _dataSource = [];
  List<DataSourceEntity> get dataSource => _dataSource;

  int _totalDataSources = 0;
  int get totalDataSources => _totalDataSources;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setState(DataSourceState newState) {
    _state = newState;
    notifyListeners();
  }

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

  /// Get data sources from a knowledge base with optional filters
  Future<bool> getDataSourceFromKnowledge(
    String knowledgeId, {
    bool? isFavorite,
    bool? isPublished,
    double? limit,
    double? offset,
    String? order,
    String? orderField,
    String? searchQuery,
  }) async {
    if (_state == DataSourceState.loading) return false;

    try {
      _setState(DataSourceState.loading);

      final query = DataSourceQuery(
        isFavorite: isFavorite,
        isPublished: isPublished,
        limit: limit,
        offset: offset,
        order: order,
        orderField: orderField,
        q: searchQuery,
      );

      final result = await getDataSourceFromKnowledgeUsecase.call(
        knowledgeId,
        query,
      );

      _dataSource = result.data;
      _totalDataSources = result.total;
      _errorMessage = null;
      _setState(DataSourceState.success);

      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _dataSource = [];
      _totalDataSources = 0;
      _setState(DataSourceState.failure);

      debugPrint("Error fetching datasources: $e");
      return false;
    }
  }

  /// Reset viewmodel state
  void resetState() {
    _state = DataSourceState.initial;
    _dataSource = [];
    _totalDataSources = 0;
    _errorMessage = null;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

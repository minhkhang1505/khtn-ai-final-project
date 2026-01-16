import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/network/knowledge_base_api_client.dart';
import 'package:khtn_ai_final_project/data/models/Knowledge/knowledge_query.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_request.dart';
import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/data/models/datasource/multi_file_response.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:injectable/injectable.dart';

abstract class KnowledgeBaseRemoteDataSource {
  Future<KnowledgeBasePaggingResponse> getKnowledgeBases(KnowledgeQuery query);
  Future<KnowledgeModel> createKnowledgeBase(
    KnowledgeBaseCreationAndUpdateRequest request,
  );
  Future<bool> deleteKnowledgeBase(String knowledgeBaseId);
  // Future<bool> addKnowledgeBaseFromFile(String knowledgeBaseId);
  // Future<bool> addKnowledgeBaseFromUrl(String knowledgeBaseId);
  // Future<bool> addKnowledgeBaseFromGDrive(String knowledgeBaseId);
  // Future<bool> addKnowledgeBaseFromSlack(String knowledgeBaseId);
  // Future<bool> addKnowledgeBaseFromConfluence(String knowledgeBaseId);
  Future<KnowledgeModel> updateKnowledgeBase(
    String id,
    KnowledgeBaseCreationAndUpdateRequest request,
  );

  Future<UploadResponse> uploadMultipleFiles(List<PlatformFile> files);

  Future<bool> uploadFilesToKnowledgeBase(
    String knowledgeBaseId,
    DataSourceRequest request,
  );

  Future<DataSourcePagingResponse> getDataSourcesFromKnowledge(
    String knowledgeId,
    DataSourceQuery query,
  );

  Future<bool> deleteDataSourceFromKnowledge(
    String knowledgeId,
    String datasourceId,
  );

  Future<bool> updateDataSourceFromKnowledge(
    String knowledgeId,
    String datasourceId,
  );
}

@LazySingleton(as: KnowledgeBaseRemoteDataSource)
class KnowledgeBaseRemoteDataSourceImpl
    implements KnowledgeBaseRemoteDataSource {
  final KnowledgeBaseApiClient client;
  KnowledgeBaseRemoteDataSourceImpl(this.client);

  @override
  Future<KnowledgeBasePaggingResponse> getKnowledgeBases(
    KnowledgeQuery query,
  ) async {
    final queryJson = query.toJson();
    final response = await client.get(
      '/kb-core/v1/knowledge',
      queryParameters: queryJson,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load knowledge bases');
    }
    return KnowledgeBasePaggingResponse.fromJson(response.data);
  }

  @override
  Future<KnowledgeModel> createKnowledgeBase(
    KnowledgeBaseCreationAndUpdateRequest request,
  ) async {
    final response = await client.post(
      '/kb-core/v1/knowledge',
      data: request.toJson(),
    );
    final data = response.data;

    if (data is Map<String, dynamic>) {
      // Some APIs wrap payload as { "data": { ... } }
      final payload = (data['data'] is Map<String, dynamic>)
          ? (data['data'] as Map<String, dynamic>)
          : data;
      return KnowledgeModel.fromJson(payload);
    }

    throw Exception(
      'Unexpected response format when creating knowledge base: ${data.runtimeType}',
    );
  }

  @override
  Future<bool> deleteKnowledgeBase(String knowledgeBaseId) async {
    final response = await client.delete(
      '/kb-core/v1/knowledge/$knowledgeBaseId',
      queryParameters: {'knowledgeBaseId': knowledgeBaseId},
    );

    final isSuccess = response.statusCode == 204 || response.statusCode == 200;

    return isSuccess;
  }

  // @override
  // Future<bool> addKnowledgeBaseFromFile(String knowledgeBaseId) {}

  // @override
  // Future<bool> addKnowledgeBaseFromUrl(String knowledgeBaseId) {}

  // @override
  // Future<bool> addKnowledgeBaseFromGDrive(String knowledgeBaseId) {}

  // @override
  // Future<bool> addKnowledgeBaseFromSlack(String knowledgeBaseId) {}

  // @override
  // Future<bool> addKnowledgeBaseFromConfluence(String knowledgeBaseId) {}

  @override
  Future<KnowledgeModel> updateKnowledgeBase(
    String id,
    KnowledgeBaseCreationAndUpdateRequest request,
  ) async {
    final response = await client.patch(
      '/kb-core/v1/knowledge/$id',
      data: request.toJson(),
      queryParameters: {'id': id},
    );

    final data = response.data;

    if (data is Map<String, dynamic>) {
      // Some APIs wrap payload as { "data": { ... } }
      final payload = (data['data'] is Map<String, dynamic>)
          ? (data['data'] as Map<String, dynamic>)
          : data;
      return KnowledgeModel.fromJson(payload);
    }

    throw Exception(
      'Unexpected response format when updating knowledge base: ${data.runtimeType}',
    );
  }

  @override
  Future<UploadResponse> uploadMultipleFiles(List<PlatformFile> files) async {
    final formData = FormData.fromMap({
      'files': [
        for (var file in files)
          if (file.path != null)
            await MultipartFile.fromFile(file.path!, filename: file.name),
      ],
    });

    try {
      final response = await client.post(
        '/kb-core/v1/knowledge/files',
        data: formData,
      );

      return response.data;
    } catch (e) {
      debugPrint("Lỗi upload: $e");
      return UploadResponse(files: []);
    }
  }

  @override
  Future<bool> uploadFilesToKnowledgeBase(
    String knowledgeBaseId,
    DataSourceRequest request,
  ) async {
    final response = await client.post(
      '/kb-core/v1/knowledge/$knowledgeBaseId/datasources',
      data: request,
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  @override
  Future<DataSourcePagingResponse> getDataSourcesFromKnowledge(
    String knowledgeId,
    DataSourceQuery query,
  ) async {
    final response = await client.get(
      '/kb-core/v1/knowledge/$knowledgeId/datasources',
      queryParameters: query.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load datasources from knowledge base');
    }

    return DataSourcePagingResponse.fromJson(response.data);
  }

  @override
  Future<bool> deleteDataSourceFromKnowledge(
    String knowledgeId,
    String datasourceId,
  ) async {
    final response = await client.delete(
      '/kb-core/v1/knowledge/$knowledgeId/datasources/$datasourceId',
    );

    return response.statusCode == 204 || response.statusCode == 200;
  }

  @override
  Future<bool> updateDataSourceFromKnowledge(
    String knowledgeId,
    String datasourceId,
  ) async {
    final response = await client.patch(
      '/kb-core/v1/knowledge/$knowledgeId/datasources/$datasourceId',
    );

    return response.statusCode == 200;
  }
}

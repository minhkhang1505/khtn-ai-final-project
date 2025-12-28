import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/core/network/knowledge_base_api_client.dart';
import 'package:khtn_ai_final_project/data/models/knowledge_model.dart';
import 'package:injectable/injectable.dart';

class KnowledgeQuery {
  double? limit;
  double? offset;
  KnowledgeOrder? order;
  String? orderField;
  String? q;

  KnowledgeQuery({
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });

  factory KnowledgeQuery.fromJson(Map<String, dynamic> json) {
    return KnowledgeQuery(
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
      order: json['order'] != null
          ? KnowledgeOrder.values.firstWhere(
              (e) => e.toString() == 'Order.' + (json['order'] as String),
            )
          : null,
      orderField: json['orderField'] as String?,
      q: json['q'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (order != null) 'order': order.toString().split('.').last,
      if (orderField != null) 'orderField': orderField,
      if (q != null) 'q': q,
    };
  }
}

enum KnowledgeOrder { ASC, DESC }

class KnowledgeBaseCreationAndUpdateRequest {
  String? description;
  String knowledgeName;

  KnowledgeBaseCreationAndUpdateRequest({
    this.description,
    required this.knowledgeName,
  });

  factory KnowledgeBaseCreationAndUpdateRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return KnowledgeBaseCreationAndUpdateRequest(
      description: json['description'] as String?,
      knowledgeName: json['knowledgeName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (description != null) {
      data['description'] = description;
    }
    data['knowledgeName'] = knowledgeName;
    return data;
  }
}

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
  Future<KnowledgeBasePaggingResponse> updateKnowledgeBase(
    String id,
    KnowledgeBaseCreationAndUpdateRequest request,
  );

  Future<bool> uploadMultipleFiles(
    List<PlatformFile> files,
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
    return response.statusCode == 200;
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
  Future<KnowledgeBasePaggingResponse> updateKnowledgeBase(
    String id,
    KnowledgeBaseCreationAndUpdateRequest request,
  ) async {
    final response = await client.patch(
      '/kb-core/v1/knowledge/$id',
      data: request.toJson(),
      queryParameters: {'id': id},
    );
    return KnowledgeBasePaggingResponse.fromJson(response.data);
  }

  @override
  Future<bool> uploadMultipleFiles(
    List<PlatformFile> files,
  ) async {
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

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint("Lỗi upload: $e");
      return false;
    }
  }
}

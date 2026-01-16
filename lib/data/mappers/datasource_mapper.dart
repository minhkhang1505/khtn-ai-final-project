import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';

/// Mapper để chuyển đổi từ DataSourceResponse (data layer)
/// sang DataSourceEntity (domain layer)
extension DataSourceResponseMapper on DataSourceResponse {
  DataSourceEntity toDomain() {
    final metadataMap = metadata;
    final metaCreatedAt = metadataMap?['created_at'] as String?;
    final metaUpdatedAt = metadataMap?['updated_at'] as String?;
    final metaDescription = metadataMap?['description'] as String?;
    return DataSourceEntity(
      id: id ?? "",
      name: name ?? "Unnamed Source",
      knowledgeId: knowledgeId ?? "",
      isActive: status ?? false,
      createdAt: metaCreatedAt ?? createdAt ?? "",
      updatedAt: metaUpdatedAt ?? updatedAt,
      description: metaDescription ?? description,
      type: type,
      size: size,
      syncStatus: syncStatus,
      createdBy: createdBy ?? "Unknown User",
    );
  }
}

/// Mapper cho danh sách DataSourceResponse
extension DataSourceResponseListMapper on List<DataSourceResponse> {
  List<DataSourceEntity> toDomainList() {
    return map((response) => response.toDomain()).toList();
  }
}

/// Mapper cho DataSourcePagingResponse
extension DataSourcePagingResponseMapper on DataSourcePagingResponse {
  DataSourcePagingEntity toDomain() {
    return DataSourcePagingEntity(
      data: data.map((e) => e.toDomain()).toList(),
      total: total,
    );
  }
}

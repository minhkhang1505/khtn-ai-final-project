import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';
import 'package:khtn_ai_final_project/domain/entities/datasource_entity.dart';

/// Mapper để chuyển đổi từ DataSourceResponse (data layer)
/// sang DataSourceEntity (domain layer)
extension DataSourceResponseMapper on DataSourceResponse {
  DataSourceEntity toDomain() {
    return DataSourceEntity(
      id: id ?? "",
      name: name ?? "Unnamed Source",
      knowledgeId: knowledgeId ?? "",
      isActive: status ?? false,
      createdAt: createdAt ?? "",
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

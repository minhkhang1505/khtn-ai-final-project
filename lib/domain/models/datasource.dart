import 'package:khtn_ai_final_project/data/models/datasource/data_source_response.dart';

class DataSource {
  final String id;
  final String name;
  final String knowledgeId;
  final bool isActive; 
  final String createdAt;
  final String createdBy;

  DataSource({
    required this.id,
    required this.name,
    required this.knowledgeId,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
  });
  
  bool get isValid => id.isNotEmpty && name.isNotEmpty;
}

extension DataSourceResponseMapper on DataSourceResponse {
  
  DataSource toDomain() {
    return DataSource(
      
      id: id ?? "", 
      name: name ?? "Unnamed Source",
      knowledgeId: knowledgeId ?? "",
      
      isActive: status ?? false, 
      
      createdAt: createdAt ?? "",
      createdBy: createdBy ?? "Unknown User",
    );
  }
}
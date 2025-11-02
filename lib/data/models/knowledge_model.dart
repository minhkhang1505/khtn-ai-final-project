class KnowledgeModel {
  final String id;
  final String userId;
  final String knowledgeName;
  final String description;
  final DateTime createdAt;

  // this attribute is optional
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;

  KnowledgeModel({
    required this.id,
    required this.userId,
    required this.knowledgeName,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });
}

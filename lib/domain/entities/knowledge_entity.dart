class KnowledgeEntity {
  final String id;
  final String userId;
  final String knowledgeName;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? updatedBy;

  const KnowledgeEntity({
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
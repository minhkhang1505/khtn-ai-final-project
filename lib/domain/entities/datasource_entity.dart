/// Entity đại diện cho Data Source trong domain layer
/// Không chứa logic liên quan đến API/Database
class DataSourceEntity {
  final String id;
  final String name;
  final String knowledgeId;
  final bool isActive;
  final String createdAt;
  final String createdBy;

  const DataSourceEntity({
    required this.id,
    required this.name,
    required this.knowledgeId,
    required this.isActive,
    required this.createdAt,
    required this.createdBy,
  });

  bool get isValid => id.isNotEmpty && name.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataSourceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DataSourceEntity {
  final String id;
  final String name;
  final String knowledgeId;
  final bool isActive;
  final String createdAt;
  final String? updatedAt;
  final String? description;
  final String? type;
  final int? size;
  final String? syncStatus;
  final String createdBy;

  const DataSourceEntity({
    required this.id,
    required this.name,
    required this.knowledgeId,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    this.description,
    this.type,
    this.size,
    this.syncStatus,
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

class DataSourcePagingEntity {
  final List<DataSourceEntity> data;
  final int total;

  const DataSourcePagingEntity({required this.data, required this.total});

  bool get hasData => data.isNotEmpty;
  bool get isEmpty => data.isEmpty;
}

class DataSourceResponse {
  String? createdAt;
  String? createdBy;
  String? description;
  String? id;
  String? knowledgeId;
  String? name;
  int? size;
  bool? status;
  String? type;
  String? updatedAt;
  String? updatedBy;
  String? userId;
  Map<String, dynamic>? metadata;
  String? syncStatus;

  DataSourceResponse({
    this.createdAt,
    this.createdBy,
    this.description,
    this.id,
    this.knowledgeId,
    this.name,
    this.size,
    this.status,
    this.type,
    this.updatedAt,
    this.updatedBy,
    this.userId,
    this.metadata,
    this.syncStatus,
  });

  factory DataSourceResponse.fromJson(Map<String, dynamic> json) {
    return DataSourceResponse(
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      knowledgeId: json['knowledgeId'] as String?,
      name: json['name'] as String?,
      size: json['size'] as int?,
      status: json['status'] as bool?,
      type: json['type'] as String?,
      updatedAt: json['updatedAt'] as String?,
      updatedBy: json['updatedBy'] as String?,
      userId: json['userId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      syncStatus: json['syncStatus'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'createdBy': createdBy,
      'description': description,
      'id': id,
      'knowledgeId': knowledgeId,
      'name': name,
      'size': size,
      'status': status,
      'type': type,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'userId': userId,
      'metadata': metadata,
      'syncStatus': syncStatus,
    };
  }

  DataSourceResponse copyWith({
    String? createdAt,
    String? createdBy,
    String? description,
    String? id,
    String? knowledgeId,
    String? name,
    int? size,
    bool? status,
    String? type,
    String? updatedAt,
    String? updatedBy,
    String? userId,
    Map<String, dynamic>? metadata,
    String? syncStatus,
  }) => DataSourceResponse(
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    description: description ?? this.description,
    id: id ?? this.id,
    knowledgeId: knowledgeId ?? this.knowledgeId,
    name: name ?? this.name,
    size: size ?? this.size,
    status: status ?? this.status,
    type: type ?? this.type,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy ?? this.updatedBy,
    userId: userId ?? this.userId,
    metadata: metadata ?? this.metadata,
    syncStatus: syncStatus ?? this.syncStatus,
  );
}

/// Query parameters for getting datasources from knowledge base
class DataSourceQuery {
  bool? isFavorite;
  bool? isPublished;
  double? limit;
  double? offset;
  String? order;
  String? orderField;
  String? q;

  DataSourceQuery({
    this.isFavorite,
    this.isPublished,
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });

  Map<String, dynamic> toJson() {
    return {
      if (isFavorite != null) 'isFavorite': isFavorite,
      if (isPublished != null) 'isPublished': isPublished,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (order != null) 'order': order,
      if (orderField != null) 'orderField': orderField,
      if (q != null) 'q': q,
    };
  }
}

/// Paginated response for datasources
class DataSourcePagingResponse {
  final List<DataSourceResponse> data;
  final int total;

  DataSourcePagingResponse({required this.data, required this.total});

  factory DataSourcePagingResponse.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>?;
    return DataSourcePagingResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => DataSourceResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      total:
          (meta?['total'] as num?)?.toInt() ??
          (json['total'] as num?)?.toInt() ??
          0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((e) => e.toJson()).toList(), 'total': total};
  }
}

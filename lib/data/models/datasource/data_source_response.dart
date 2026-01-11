class DataSourceResponse {
  String? createdAt;
  String? createdBy;
  String? id;
  String? knowledgeId;
  String? name;
  bool? status;
  String? updatedAt;
  String? updatedBy;
  String? userId;

  DataSourceResponse({
    this.createdAt,
    this.createdBy,
    this.id,
    this.knowledgeId,
    this.name,
    this.status,
    this.updatedAt,
    this.updatedBy,
    this.userId,
  });

  factory DataSourceResponse.fromJson(Map<String, dynamic> json) {
    return DataSourceResponse(
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] as String?,
      id: json['id'] as String?,
      knowledgeId: json['knowledgeId'] as String?,
      name: json['name'] as String?,
      status: json['status'] as bool?,
      updatedAt: json['updatedAt'] as String?,
      updatedBy: json['updatedBy'] as String?,
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'createdBy': createdBy,
      'id': id,
      'knowledgeId': knowledgeId,
      'name': name,
      'status': status,
      'updatedAt': updatedAt,
      'updatedBy': updatedBy,
      'userId': userId,
    };
  }

  DataSourceResponse copyWith({
    String? createdAt,
    String? createdBy,
    String? id,
    String? knowledgeId,
    String? name,
    bool? status,
    String? updatedAt,
    String? updatedBy,
    String? userId,
  }) => DataSourceResponse(
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    id: id ?? this.id,
    knowledgeId: knowledgeId ?? this.knowledgeId,
    name: name ?? this.name,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy ?? this.updatedBy,
    userId: userId ?? this.userId,
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
    return DataSourcePagingResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) => DataSourceResponse.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.map((e) => e.toJson()).toList(), 'total': total};
  }
}

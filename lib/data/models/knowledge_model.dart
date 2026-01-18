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

  static DateTime? _tryParseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  factory KnowledgeModel.fromJson(Map<String, dynamic> json) {
    final createdAt = _tryParseDate(json['createdAt']) ?? DateTime.now();
    return KnowledgeModel(
      id: (json['id'] ?? '').toString(),
      userId: (json['userId'] ?? '').toString(),
      knowledgeName:
          (json['knowledgeName'] ?? json['name'] ?? json['title'] ?? '')
              .toString(),
      description: (json['description'] ?? '').toString(),
      createdAt: createdAt,
      updatedAt: _tryParseDate(json['updatedAt']),
      createdBy: json['createdBy']?.toString(),
      updatedBy: json['updatedBy']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'knowledgeName': knowledgeName,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (createdBy != null) 'createdBy': createdBy,
      if (updatedBy != null) 'updatedBy': updatedBy,
    };
  }
}

class KnowledgeRequest {
  String? description;
  String knowledgeName;

  KnowledgeRequest({this.description, required this.knowledgeName});

  KnowledgeRequest copyWith({String? description, String? knowledgeName}) =>
      KnowledgeRequest(
        description: description ?? this.description,
        knowledgeName: knowledgeName ?? this.knowledgeName,
      );
}

///PageDto
class KnowledgeBasePaggingResponse {
  List<KnowledgeResDto> data;
  PageMetaDto meta;

  KnowledgeBasePaggingResponse({required this.data, required this.meta});

  KnowledgeBasePaggingResponse copyWith({
    List<KnowledgeResDto>? data,
    PageMetaDto? meta,
  }) => KnowledgeBasePaggingResponse(
    data: data ?? this.data,
    meta: meta ?? this.meta,
  );

  factory KnowledgeBasePaggingResponse.fromJson(Map<String, dynamic> json) {
    return KnowledgeBasePaggingResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => KnowledgeResDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: PageMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

class KnowledgeResDto {
  String id;
  DateTime createdAt;
  String? createdBy;
  String description;
  String knowledgeName;
  DateTime? updatedAt;
  String? updatedBy;
  String userId;

  KnowledgeResDto({
    required this.id,
    required this.createdAt,
    this.createdBy,
    required this.description,
    required this.knowledgeName,
    this.updatedAt,
    this.updatedBy,
    required this.userId,
  });

  KnowledgeResDto copyWith({
    String? id,
    DateTime? createdAt,
    String? createdBy,
    String? description,
    String? knowledgeName,
    DateTime? updatedAt,
    String? updatedBy,
    String? userId,
  }) => KnowledgeResDto(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    createdBy: createdBy ?? this.createdBy,
    description: description ?? this.description,
    knowledgeName: knowledgeName ?? this.knowledgeName,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedBy: updatedBy ?? this.updatedBy,
    userId: userId ?? this.userId,
  );

  factory KnowledgeResDto.fromJson(Map<String, dynamic> json) {
    return KnowledgeResDto(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
      description: json['description'] as String,
      knowledgeName: json['knowledgeName'] as String,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      updatedBy: json['updatedBy'] as String?,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      if (createdBy != null) 'createdBy': createdBy,
      'description': description,
      'knowledgeName': knowledgeName,
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
      if (updatedBy != null) 'updatedBy': updatedBy,
      'userId': userId,
    };
  }
}

class PageMetaDto {
  bool hasNext;
  double limit;
  double offset;
  double total;

  PageMetaDto({
    required this.hasNext,
    required this.limit,
    required this.offset,
    required this.total,
  });

  PageMetaDto copyWith({
    bool? hasNext,
    double? limit,
    double? offset,
    double? total,
  }) => PageMetaDto(
    hasNext: hasNext ?? this.hasNext,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    total: total ?? this.total,
  );

  factory PageMetaDto.fromJson(Map<String, dynamic> json) {
    return PageMetaDto(
      hasNext: json['hasNext'] as bool,
      limit: (json['limit'] as num).toDouble(),
      offset: (json['offset'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hasNext': hasNext,
      'limit': limit,
      'offset': offset,
      'total': total,
    };
  }
}

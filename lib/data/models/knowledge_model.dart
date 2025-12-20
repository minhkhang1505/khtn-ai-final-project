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


class KnowledgeRequest {
    String? description;
    String knowledgeName;

    KnowledgeRequest({
        this.description,
        required this.knowledgeName,
    });

    KnowledgeRequest copyWith({
        String? description,
        String? knowledgeName,
    }) => 
        KnowledgeRequest(
            description: description ?? this.description,
            knowledgeName: knowledgeName ?? this.knowledgeName,
        );
}


///PageDto
class KnowledgeBasePaggingResponse {
    List<KnowledgeResDto> data;
    PageMetaDto meta;

    KnowledgeBasePaggingResponse({
        required this.data,
        required this.meta,
    });

    KnowledgeBasePaggingResponse copyWith({
        List<KnowledgeResDto>? data,
        PageMetaDto? meta,
    }) => 
        KnowledgeBasePaggingResponse(
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
    DateTime createdAt;
    String? createdBy;
    String description;
    String knowledgeName;
    DateTime? updatedAt;
    String? updatedBy;
    String userId;

    KnowledgeResDto({
        required this.createdAt,
        this.createdBy,
        required this.description,
        required this.knowledgeName,
        this.updatedAt,
        this.updatedBy,
        required this.userId,
    });

    KnowledgeResDto copyWith({
        DateTime? createdAt,
        String? createdBy,
        String? description,
        String? knowledgeName,
        DateTime? updatedAt,
        String? updatedBy,
        String? userId,
    }) => 
        KnowledgeResDto(
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
    }) => 
        PageMetaDto(
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
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
    }) => 
        DataSourceResponse(
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
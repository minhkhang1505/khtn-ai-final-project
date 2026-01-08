class UploadedFile {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String extension;
  final String mimeType;
  final int size;
  final String owner;
  final String url;

  UploadedFile({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.extension,
    required this.mimeType,
    required this.size,
    required this.owner,
    required this.url,
  });

  factory UploadedFile.fromJson(Map<String, dynamic> json) {
    return UploadedFile(
      id: json['id'] ?? '',
      // Parse string ISO 8601 sang DateTime
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at']) 
          : null,
      name: json['name'] ?? '',
      extension: json['extension'] ?? '',
      mimeType: json['mime_type'] ?? '',
      size: json['size'] ?? 0,
      owner: json['owner'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'name': name,
      'extension': extension,
      'mime_type': mimeType,
      'size': size,
      'owner': owner,
      'url': url,
    };
  }
}
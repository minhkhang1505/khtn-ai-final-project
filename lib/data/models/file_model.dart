import 'package:khtn_ai_final_project/domain/entities/file_entity.dart';

/// Model cho File từ API (data layer)
/// Chứa logic fromJson/toJson
class FileModel {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String extension;
  final String mimeType;
  final int size;
  final String owner;
  final String url;

  const FileModel({
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

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] ?? '',
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

  /// Chuyển đổi sang domain entity
  FileEntity toDomain() {
    return FileEntity(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      name: name,
      extension: extension,
      mimeType: mimeType,
      size: size,
      owner: owner,
      url: url,
    );
  }
}

/// Mapper cho FileModel
extension FileModelMapper on FileModel {
  FileEntity toEntity() => toDomain();
}

/// Mapper cho danh sách FileModel
extension FileModelListMapper on List<FileModel> {
  List<FileEntity> toDomainList() {
    return map((model) => model.toDomain()).toList();
  }
}

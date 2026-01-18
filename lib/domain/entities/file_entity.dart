/// Entity đại diện cho File đã upload trong domain layer
/// Không chứa logic fromJson/toJson (sẽ ở data layer)
class FileEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final String extension;
  final String mimeType;
  final int size;
  final String owner;
  final String url;

  const FileEntity({
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

  bool get isValid => id.isNotEmpty && name.isNotEmpty && url.isNotEmpty;

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(2)} KB';
    if (size < 1024 * 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

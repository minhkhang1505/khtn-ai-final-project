import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/domain/repositories/knowledge_base_repository.dart';

@lazySingleton
class UploadMultipleFileUsecase {
  final KnowledgeBaseRepository repository;

  UploadMultipleFileUsecase({required this.repository});

  Future<bool> call(List<PlatformFile> files) async {
    final response = await repository.uploadMultipleFiles(files);
    return response;
  }
}

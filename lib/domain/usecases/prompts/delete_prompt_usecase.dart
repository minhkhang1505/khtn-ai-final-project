import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeletePromptUsecase {
  final PromptRepository repository;

  DeletePromptUsecase(this.repository);

  Future<bool> call(String promptId) async {
    final result = await repository.deletePrompt(promptId);
    return result;
  }
}

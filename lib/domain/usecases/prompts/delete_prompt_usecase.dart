import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class DeletePromptUsecase {
  final PromptRepository repository;

  DeletePromptUsecase(this.repository);

  Future<bool> call(String promptId) async {
    final result = await repository.deletePrompt(promptId);
    return result;
  }
}

import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class UpdatePromptUsecase {
  final PromptRepository repository;

  UpdatePromptUsecase({required this.repository});

  Future<bool> call(String promptId, PromptCreationAndUpdateRequest request) {
    return repository.updatePrompt(promptId, request);
  }
}

import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CreatePromptUsecase {
  final PromptRepository repository;
  CreatePromptUsecase(this.repository);

  Future<bool> call(PromptCreationAndUpdateRequest request) async {
    final result = await repository.createPrompt(request);
    return result;
  }
}

import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class GetPromptUseCase {
  final PromptRepository repository;
  GetPromptUseCase(this.repository);

  Future<PromptResponse> call(PromptRequest request) async {
    final response = await repository.getPrompts(request);
    return response;
  }
}

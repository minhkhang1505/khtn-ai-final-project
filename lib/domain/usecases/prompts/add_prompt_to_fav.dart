import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class AddPromptToFavorite {
  final PromptRepository repository;

  AddPromptToFavorite(this.repository);

  Future<bool> call(String promptId) async {
    final result = await repository.addPromptToFavorites(promptId);
    return result;
  }
}

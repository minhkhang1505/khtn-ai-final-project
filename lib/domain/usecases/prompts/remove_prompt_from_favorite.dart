import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class RemovePromptFromFavorite {
  final PromptRepository repository;

  RemovePromptFromFavorite(this.repository);

  Future<bool> call(String promptId) async {
    final result = await repository.removeFromFavorites(promptId);
    return result;
  }
}

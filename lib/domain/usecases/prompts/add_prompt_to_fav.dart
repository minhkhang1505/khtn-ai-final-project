import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddPromptToFavoriteUsecase {
  final PromptRepository repository;

  AddPromptToFavoriteUsecase(this.repository);

  Future<bool> call(String promptId) async {
    final result = await repository.addPromptToFavorites(promptId);
    return result;
  }
}

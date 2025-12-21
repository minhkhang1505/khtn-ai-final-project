import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RemovePromptFromFavoriteUsecase {
  final PromptRepository repository;

  RemovePromptFromFavoriteUsecase(this.repository);

  Future<bool> call(String promptId) async {
    final result = await repository.removeFromFavorites(promptId);
    return result;
  }
}

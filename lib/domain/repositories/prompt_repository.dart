import 'package:khtn_ai_final_project/data/models/prompt_model.dart';

abstract class PromptRepository {
  Future<PromptPaggingResponse> getPrompts(PromptRequest request);
  Future<bool> createPrompt(PromptCreationAndUpdateRequest request);
  Future<bool> deletePrompt(String promptId);
  Future<bool> addPromptToFavorites(String promptId);
  Future<bool> removeFromFavorites(String promptId);
  Future<bool> updatePrompt(String id, PromptCreationAndUpdateRequest request);
}

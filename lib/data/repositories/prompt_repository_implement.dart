import 'package:khtn_ai_final_project/data/datasources/remote/prompt_remote_data_source.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:khtn_ai_final_project/domain/repositories/prompt_repository.dart';

class PromptRepositoryImpl implements PromptRepository {
  final PromptRemoteDataSource remoteDataSource;
  PromptRepositoryImpl(this.remoteDataSource);

  @override
  Future<PromptResponse> getPrompts(PromptRequest request) async {
    final response = await remoteDataSource.getPrompts(request);
    return response;
  }

  @override
  Future<bool> createPrompt(PromptCreationAndUpdateRequest request) async {
    final response = await remoteDataSource.createPrompt(request);
    return response;
  }

  @override
  Future<bool> deletePrompt(String promptId) async {
    final response = await remoteDataSource.deletePrompt(promptId);
    return response;
  }

  @override
  Future<bool> addPromptToFavorites(String promptId) async {
    final response = await remoteDataSource.addPromptToFavorites(promptId);
    return response;
  }

  @override
  Future<bool> removeFromFavorites(String promptId) async {
    final response = await remoteDataSource.removeFromFavorites(promptId);
    return response;
  }

  @override
  Future<bool> updatePrompt(
    String promtId,
    PromptCreationAndUpdateRequest request,
  ) async {
    final response = await remoteDataSource.updatePrompt(promtId, request);

    return response;
  }
}

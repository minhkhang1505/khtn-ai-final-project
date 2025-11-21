import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';

abstract class PromptRemoteDataSource {
  Future<PromptResponse> getPrompts(PromptRequest request);
  Future<bool> createPrompt(PromptCreationAndUpdateRequest request);
  Future<bool> deletePrompt(String promptId);
  Future<bool> addPromptToFavorites(String promptId);
  Future<bool> removeFromFavorites(String promptId);
  Future<bool> updatePrompt(String id, PromptCreationAndUpdateRequest request);
}

class PromptRemoteDataSourceImpl implements PromptRemoteDataSource {
  final JarvisApiClient client;

  PromptRemoteDataSourceImpl(this.client);

  @override
  Future<PromptResponse> getPrompts(PromptRequest request) async {
    final response = await client.get('/prompts', data: request.toJson());

    if (response.statusCode != 200) {
      throw Exception('Failed to load prompts');
    }

    return PromptResponse.fromJson(response.data);
  }

  @override
  Future<bool> createPrompt(PromptCreationAndUpdateRequest request) async {
    final response = await client.post('/prompts', data: request.toJson());

    return response.statusCode == 201;
  }

  @override
  Future<bool> deletePrompt(String promptId) async {
    final response = await client.delete('/prompts/$promptId');

    return response.statusCode == 200;
  }

  @override
  Future<bool> addPromptToFavorites(String promptId) async {
    final response = await client.post('/prompts/$promptId/favorite');
    return response.statusCode == 201;
  }

  @override
  Future<bool> removeFromFavorites(String promptId) async {
    final response = await client.delete('/prompts/$promptId/favorite');
    return response.statusCode == 200;
  }

  @override
  Future<bool> updatePrompt(
    String id,
    PromptCreationAndUpdateRequest request,
  ) async {
    final response = await client.patch('/prompts/$id', data: request.toJson());
    return response.statusCode == 200;
  }
}

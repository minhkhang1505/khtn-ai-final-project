import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';
import 'package:injectable/injectable.dart';

abstract class PromptRemoteDataSource {
  Future<PromptPaggingResponse> getPrompts(PromptRequest request);
  Future<bool> createPrompt(PromptCreationAndUpdateRequest request);
  Future<bool> deletePrompt(String promptId);
  Future<bool> addPromptToFavorites(String promptId);
  Future<bool> removeFromFavorites(String promptId);
  Future<bool> updatePrompt(String id, PromptCreationAndUpdateRequest request);
}

@LazySingleton(as: PromptRemoteDataSource)
class PromptRemoteDataSourceImpl implements PromptRemoteDataSource {
  final JarvisApiClient client;

  PromptRemoteDataSourceImpl(this.client);

  @override
  Future<PromptPaggingResponse> getPrompts(PromptRequest request) async {
    final query = request.toJson();
    // Debug: show the query we'll send
    // Example: {isFavorite: true, isPublic: true, limit: 10, offset: 0}
    // This helps verify isFavorite=true is actually requested
    // (LogInterceptor will also print the full URL)
    // ignore: avoid_print
    print(
      '[PromptRemoteDataSource] GET /prompts with query: ' + query.toString(),
    );
    // Use authorized GET to ensure favorites/private filters work
    final response = await client.getWithQuery(
      '/prompts',
      queryParameters: query,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load prompts');
    }

    return PromptPaggingResponse.fromJson(response.data);
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

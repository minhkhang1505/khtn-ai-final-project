import 'package:khtn_ai_final_project/core/network/jarvis_api_client.dart';
import 'package:khtn_ai_final_project/data/models/prompt_model.dart';

abstract class PromptRemoteDataSource {
  Future<PromptResponse> getPrompts(PromptRequest request);
}

class PromptRemoteDataSourceImpl implements PromptRemoteDataSource {
  final JarvisApiClient client;

  PromptRemoteDataSourceImpl(this.client);

  @override
  Future<PromptResponse> getPrompts(PromptRequest request) async {
    final response = await client.get(
      '/prompts',
      data: request.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load prompts');
    }

    return PromptResponse.fromJson(
      response.data,
    );
  }
}

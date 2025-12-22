import 'package:khtn_ai_final_project/core/network/bot_api_client.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_response_model.dart';

abstract class BotRemoteDataSource {
  Future<BotModel> createBot(BotRequestModel createBotRequest);
  Future<GetBotsResponseModel> getBots(GetBotsRequestModel getBotsRequest);
  Future<BotModel> updateBot(String assistantId, BotRequestModel botRequest);
  Future<void> deleteBot(String assistantId);
  Future<BotModel> getBot(String assistantId);
  Future<BotModel> toggleFavorite(String assistantId);
}

class BotRemoteDataSourceImpl implements BotRemoteDataSource {
  final BotApiClient client;

  BotRemoteDataSourceImpl(this.client);

  //for create bot
  @override
  Future<BotModel> createBot(BotRequestModel botRequest) async {
    final response = await client.post(
      '/kb-core/v1/ai-assistant',
      data: botRequest.toJson(),
    );
    return BotModel.fromJson(response.data);
  }

  //for get all bots
  @override
  Future<GetBotsResponseModel> getBots(GetBotsRequestModel getBotsRequest) async {
    final response = await client.get(
      '/kb-core/v1/ai-assistant',
      queryParameters: getBotsRequest.toJson(),
    );
    return GetBotsResponseModel.fromJson(response.data);
  }

  // for update bot
  @override
  Future<BotModel> updateBot(String assistantId, BotRequestModel botRequest) async {
    final response = await client.patch(
      '/kb-core/v1/ai-assistant/$assistantId',
      data: botRequest.toJson(),
    );
    return BotModel.fromJson(response.data);
  }

  // for delete bot
  @override
  Future<void> deleteBot(String assistantId) async {
    await client.delete(
      '/kb-core/v1/ai-assistant/$assistantId',
    );
    return;
  }

  // for get bot
  @override
  Future<BotModel> getBot(String assistantId) async {
    final response = await client.get(
      '/kb-core/v1/ai-assistant/$assistantId',
    );
    return BotModel.fromJson(response.data);
  }

  // for update favorite
  @override
  Future<BotModel> toggleFavorite(String assistantId) async {
    final response = await client.post(
      '/kb-core/v1/ai-assistant/$assistantId/favorite',
    );
    return BotModel.fromJson(response.data);
  }
}

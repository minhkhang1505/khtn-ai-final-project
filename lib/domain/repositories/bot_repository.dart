import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_response_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';

abstract class BotRepository {
  Future<GetBotsResponseModel> getBots(GetBotsRequestModel getBotsRequest);
  Future<BotModel> getBot(String id);
  Future<BotModel> createBot(BotRequestModel botRequest);
  Future<BotModel> updateBot(String id, BotRequestModel botRequest);
  Future<void> deleteBot(String id);
}

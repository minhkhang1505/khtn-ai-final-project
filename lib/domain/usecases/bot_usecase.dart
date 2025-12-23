import 'package:khtn_ai_final_project/domain/repositories/bot_repository.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_response_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BotUseCase {
  final BotRepository botRepository;
  BotUseCase({required this.botRepository});

  Future<GetBotsResponseModel> getBots(
    GetBotsRequestModel getBotsRequest,
  ) async {
    return await botRepository.getBots(getBotsRequest);
  }

  Future<BotModel> getBotById(String id) async {
    return await botRepository.getBotById(id);
  }

  Future<BotModel> createBot(BotRequestModel botRequest) async {
    return await botRepository.createBot(botRequest);
  }

  Future<BotModel> updateBot(String id, BotRequestModel botRequest) async {
    return await botRepository.updateBot(id, botRequest);
  }

  Future<void> deleteBot(String id) async {
    return await botRepository.deleteBot(id);
  }

  Future<BotModel> toggleFavorite(String id) async {
    return await botRepository.toggleFavorite(id);
  }
}

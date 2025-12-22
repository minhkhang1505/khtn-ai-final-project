import 'package:khtn_ai_final_project/domain/repositories/bot_repository.dart';
import 'package:khtn_ai_final_project/data/datasources/remote/bot_remote_data_source.dart';

import 'package:khtn_ai_final_project/data/models/bot/bot_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_request_model.dart';
import 'package:khtn_ai_final_project/data/models/bot/bot_response_model.dart';


class BotRepositoryImpl implements BotRepository {
  final BotRemoteDataSource remoteDataSource;

  BotRepositoryImpl(this.remoteDataSource);

  @override
  Future<BotModel> createBot(BotRequestModel botRequest) async {
    final response = await remoteDataSource.createBot(botRequest);
    return response;
  }

  @override
  Future<GetBotsResponseModel> getBots(GetBotsRequestModel getBotsRequest) async {
    final response = await remoteDataSource.getBots(getBotsRequest);
    return response;
  }

  @override
  Future<BotModel> getBotById(String id) async {
    final response = await remoteDataSource.getBot(id);
    return response;
  }

  @override
  Future<void> deleteBot(String id) async {
    final response = await remoteDataSource.deleteBot(id);
    return response;
  }

  @override
  Future<BotModel> updateBot(String id, BotRequestModel botRequest) async {
    final response = await remoteDataSource.updateBot(id, botRequest);
    return response;
  }

  @override
  Future<BotModel> toggleFavorite(String id) async {
    final response = await remoteDataSource.toggleFavorite(id);
    return response;
  }
}

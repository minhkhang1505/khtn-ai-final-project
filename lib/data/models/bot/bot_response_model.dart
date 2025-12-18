import 'bot_model.dart';

// Get Bots Response
// TODO: update model according to API response
class GetBotsResponseModel {
  final List<BotModel> bots;
  final int total;

  GetBotsResponseModel({
    required this.bots,
    required this.total,
  });

  factory GetBotsResponseModel.fromJson(Map<String, dynamic> json) {
    var botsJson = json['bots'] as List;
    List<BotModel> botsList =
        botsJson.map((botJson) => BotModel.fromJson(botJson)).toList();

    return GetBotsResponseModel(
      bots: botsList,
      total: json['total'],
    );
  }
}


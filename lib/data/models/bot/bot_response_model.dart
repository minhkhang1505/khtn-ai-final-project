import 'bot_model.dart';

class Data {
  List<BotModel> bots;
  Data({required this.bots});
}

class Meta {
  int limit;
  int offset;
  int total;
  bool hasNext;
  Meta({
    required this.limit,
    required this.offset,
    required this.total,
    required this.hasNext,
  });
}

// Get Bots Response
class GetBotsResponseModel {
  final Data data;
  final Meta meta;

  GetBotsResponseModel({
    required this.data,
    required this.meta,
  });

  factory GetBotsResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> botsJson = (json['data'] ?? []) as List;
    final List<BotModel> botsList =
        botsJson.map((botJson) => BotModel.fromJson(botJson)).toList();

    final Map<String, dynamic> metaJson =
        (json['meta'] as Map<String, dynamic>? ?? {});

    return GetBotsResponseModel(
      data: Data(bots: botsList),
      meta: Meta(
        limit: metaJson['limit'] ?? 0,
        offset: metaJson['offset'] ?? 0,
        total: metaJson['total'] ?? botsList.length,
        hasNext: metaJson['hasNext'] ?? false,
      ),
    );
  }
}


import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:injectable/injectable.dart';

abstract class TaskPlanningRemoteDataSource {
  Future<String> planTask(String request);
}

@LazySingleton(as: TaskPlanningRemoteDataSource)
class TaskPlanningRemoteDataSourceImpl implements TaskPlanningRemoteDataSource {
  static const String _webhookUrl = 'https://hocdoth.app.n8n.cloud/webhook/task-planning';

  @override
  Future<String> planTask(String request) async {
    try {
      final response = await http.post(
        Uri.parse(_webhookUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'request': request,
        }),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to plan task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error calling task planning API: $e');
    }
  }
}

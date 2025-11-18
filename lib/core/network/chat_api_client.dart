import 'package:dio/dio.dart';
import 'auth_api_client.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';

class ChatApiClient {
  static const String baseUrl = 'https://api.dev.jarvis.cx/api/v1/ai-chat';
  final AuthLocalDataSource localDataSource;
  String endpoint = '/messages';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': 'Bearer YOUR_API_KEY_HERE', // Replace with your actual API key
        'Content-Type': 'application/json',
      },
    ),
  );

  ChatApiClient(this.localDataSource) {
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(AuthInterceptor(localDataSource));  // Reuse AuthInterceptor for token management
  }

  // for chat with bot
  Future<Response> chat(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);

  // for get conversations
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  // for get conversation history
  Future<Response> getConversationHistory(String path,
          {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  // for send message
  Future<Response> post(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);
}
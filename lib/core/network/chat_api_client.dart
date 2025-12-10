import 'package:dio/dio.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';
import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';

class ChatApiClient {
  static const String baseUrl = 'https://api.jarvis.cx/api/v1/ai-chat/messages';
  final AuthLocalDataSource localDataSource;
  String endpoint = '/messages';

  late final Dio _dio;

  ChatApiClient(this.localDataSource) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add token interceptor so Authorization header is injected from local storage
    _dio.interceptors.add(
      TokenInterceptor(
        localDataSource: localDataSource,
        refreshTokenEndpoint: 'auth/sessions/current/refresh',
        baseUrl: AuthApiClient.baseUrl,
        dio: _dio,
      ),
    );

    _dio.interceptors.add(LogInterceptor());
  }

  // for chat with bot
  Future<Response> chat(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);

  // for get conversations
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      _dio.get(path, queryParameters: queryParameters);

  // for get conversation history
  Future<Response> getConversationHistory(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => _dio.get(path, queryParameters: queryParameters);

  // for send message
  Future<Response> post(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);
}

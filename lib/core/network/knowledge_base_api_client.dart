import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/utils/guid_provider.dart';

@preResolve
@lazySingleton
class KnowledgeBaseApiClient {
  final AuthLocalDataSource localDataSource;

  static const String baseUrl = 'https://knowledge-api.jarvis.cx/';
  static const String _refreshTokenEndpoint = 'auth/sessions/current/refresh';

  final String guid;
  late final Dio _dio;

  KnowledgeBaseApiClient._(this.guid, this.localDataSource) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'x-jarvis-guid': guid}));

    _dio.interceptors.add(
      TokenInterceptor(
        localDataSource: localDataSource,
        refreshTokenEndpoint: _refreshTokenEndpoint,
        baseUrl: AuthApiClient.baseUrl,
        dio: _dio,
      ),
    );
    _dio.interceptors.add(LogInterceptor());
  }

  @factoryMethod
  static Future<KnowledgeBaseApiClient> create(
    AuthLocalDataSource localDataSource,
  ) async {
    final guid = await GuidProvider.getGuid();
    return KnowledgeBaseApiClient._(guid, localDataSource);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    final accessToken = await localDataSource.getAccessToken();

    final isFormData = data is FormData;

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        if (!isFormData) 
        'Content-Type': 'application/json',
      },
    );
    return _dio.post(path, data: data, options: options);
  }

  Future<Response> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    return _dio.patch(
      path,
      queryParameters: queryParameters,
      options: options,
      data: data,
    );
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
      },
    );
    return _dio.delete(
      path,
      options: options,
      queryParameters: queryParameters,
    );
  }
}

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';
import 'package:khtn_ai_final_project/core/utils/guid_provider.dart';

@preResolve
@lazySingleton
class JarvisApiClient {
  final AuthLocalDataSource localDataSource;
  static const String baseUrl = 'https://api.jarvis.cx/api/v1/';
  static const String _refreshTokenEndpoint = 'auth/sessions/current/refresh';

  final String guid;
  late final Dio _dio;

  JarvisApiClient._(this.guid, this.localDataSource) {
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
  static Future<JarvisApiClient> create(
    AuthLocalDataSource localDataSource,
  ) async {
    final guid = await GuidProvider.getGuid();
    return JarvisApiClient._(guid, localDataSource);
  }

  /// GET request - Authorization skipped for /prompts endpoint
  Future<Response> get(String path, {Map<String, dynamic>? data}) async {
    return _dio.get(path, queryParameters: data);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    return _dio.post(path, data: data, options: options);
  }

  Future<ResponseBody> postStream(String path, {Map<String, dynamic>? data}) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.stream,
    );
    final response = await _dio.post(path, data: data, options: options);
    return response.data as ResponseBody;
  }

  Future<Response> delete(String path) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
      },
    );
    return _dio.delete(path, options: options);
  }

  Future<Response> patch(String path, {Map<String, dynamic>? data}) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    return _dio.patch(path, data: data, options: options);
  }

  /// Get the current GUID
  String getGuid() => guid;
}

// Extension method to add GET with query parameters
extension JarvisApiClientQueryExt on JarvisApiClient {
  Future<Response> getWithQuery(
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
    return _dio.get(path, options: options, queryParameters: queryParameters);
  }

  Future<Response> deleteWithQuery(
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

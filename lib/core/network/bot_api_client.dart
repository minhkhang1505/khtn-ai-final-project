import 'package:dio/dio.dart';
import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';
import 'package:injectable/injectable.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

@preResolve
@lazySingleton
class BotApiClient {
  final AuthLocalDataSource localDataSource;
  static const String baseUrl = 'https://knowledge-api.jarvis.cx';
  static const String _refreshTokenEndpoint = 'auth/sessions/current/refresh';

  final String guid;
  late final Dio _dio;

  BotApiClient._(this.guid, this.localDataSource) {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));

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

  /// Create a configured client instance
  @factoryMethod
  static Future<BotApiClient> create(
    AuthLocalDataSource localDataSource,
  ) async {
    final guid = await getOrCreateGuid();
    return BotApiClient._(guid, localDataSource);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': guid,
        'Content-Type': 'application/json',
      },
    );
    return _dio.get(path, options: options, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': guid,
        'Content-Type': 'application/json',
      },
    );
    return _dio.post(path, data: data, options: options);
  }

  Future<Response> delete(String path) async {
    final accessToken = await localDataSource.getAccessToken();

    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
        'x-jarvis-guid': guid,
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
        'x-jarvis-guid': guid,
        'Content-Type': 'application/json',
      },
    );
    return _dio.patch(path, data: data, options: options);
  }

  // Future<Response> getWithQuery(String path, {Map<String, dynamic>? queryParameters}) async {
  // 	final accessToken = await localDataSource.getAccessToken();
  // 	final options = Options(
  // 		headers: {
  // 			if (accessToken != null && accessToken.isNotEmpty)
  // 				'Authorization': 'Bearer $accessToken',
  // 		},
  // 	);
  // 	return _dio.get(path, options: options, queryParameters: queryParameters);
  // }

  // Future<Response> deleteWithQuery(String path, {Map<String, dynamic>? queryParameters}) async {
  // 	final accessToken = await localDataSource.getAccessToken();
  // 	final options = Options(
  // 		headers: {
  // 			if (accessToken != null && accessToken.isNotEmpty)
  // 				'Authorization': 'Bearer $accessToken',
  // 		},
  // 	);
  // 	return _dio.delete(path, options: options, queryParameters: queryParameters);
  // }
}

/// Helper: persistent GUID used by Jarvis services. Reuses implementation from Jarvis client.

Future<String> getOrCreateGuid() async {
  final prefs = await SharedPreferences.getInstance();
  var guid = prefs.getString('jarvis_guid');

  if (guid == null || guid.isEmpty) {
    guid = const Uuid().v4();
    await prefs.setString('jarvis_guid', guid);
  }

  return guid;
}

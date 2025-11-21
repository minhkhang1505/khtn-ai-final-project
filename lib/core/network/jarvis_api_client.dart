import 'package:dio/dio.dart';
import 'package:khtn_ai_final_project/core/network/auth_api_client.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class JarvisApiClient {
  final localDataSource = AuthLocalDataSourceImpl();
  static const String baseUrl = 'https://api.dev.jarvis.cx/api/v1/';
  static const String _refreshTokenEndpoint = 'auth/sessions/current/refresh';

  final String guid;
  late final Dio _dio;

  JarvisApiClient._(this.guid) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'x-jarvis-guid': guid, 'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      TokenInterceptor(
        localDataSource: localDataSource,
        refreshTokenEndpoint: _refreshTokenEndpoint,
        baseUrl: AuthApiClient.baseUrl,
      ),
    );
    _dio.interceptors.add(LogInterceptor());
  }

  static Future<JarvisApiClient> create() async {
    final guid = await getOrCreateGuid();
    return JarvisApiClient._(guid);
  }

  /// GET request with Authorization header support
  Future<Response> get(String path, {Map<String, dynamic>? data}) async {
    final accessToken = await localDataSource.getAccessToken();
    final options = Options(
      headers: {
        if (accessToken != null && accessToken.isNotEmpty)
          'Authorization': 'Bearer $accessToken',
      },
    );
    return _dio.get(path, options: options);
  }

  /// Get the current GUID
  String getGuid() => guid;
}

/// Get or create a persistent GUID for this device/app instance
Future<String> getOrCreateGuid() async {
  final prefs = await SharedPreferences.getInstance();
  var guid = prefs.getString('jarvis_guid');

  if (guid == null || guid.isEmpty) {
    guid = const Uuid().v4();
    await prefs.setString('jarvis_guid', guid);
  }

  return guid;
}

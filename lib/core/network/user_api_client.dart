import 'package:dio/dio.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserApiClient {
  final localDataSource = AuthLocalDataSourceImpl();
  static const String baseUrl = 'https://api.dev.jarvis.cx/api/v1/';

  final String guid;
  late final Dio _dio;

  UserApiClient._(this.guid) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'x-jarvis-guid': guid, 'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.add(LogInterceptor());
  }

  static Future<UserApiClient> create() async {
    final guid = await getOrCreateGuid();
    return UserApiClient._(guid);
  }

  /// GET request with Authorization header support
  Future<Response> get(String path, {Map<String, dynamic>? data}) async {
    final refreshToken = await localDataSource.getRefreshToken();
    final options = Options(
      headers: {
        if (refreshToken != null && refreshToken.isNotEmpty)
          'Authorization': 'Bearer $refreshToken',
      },
    );
    return _dio.get(path, options: options);
  }

  /// POST request with Authorization header support
  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    final refreshToken = await localDataSource.getRefreshToken();
    final options = Options(
      headers: {
        if (refreshToken != null && refreshToken.isNotEmpty)
          'Authorization': 'Bearer $refreshToken',
      },
    );
    return _dio.post(path, data: data, options: options);
  }

  /// PUT request with Authorization header support
  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    final refreshToken = await localDataSource.getRefreshToken();
    final options = Options(
      headers: {
        if (refreshToken != null && refreshToken.isNotEmpty)
          'Authorization': 'Bearer $refreshToken',
      },
    );
    return _dio.put(path, data: data, options: options);
  }

  /// DELETE request with Authorization header support
  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    final refreshToken = await localDataSource.getRefreshToken();
    final options = Options(
      headers: {
        if (refreshToken != null && refreshToken.isNotEmpty)
          'Authorization': 'Bearer $refreshToken',
      },
    );
    return _dio.delete(path, options: options);
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

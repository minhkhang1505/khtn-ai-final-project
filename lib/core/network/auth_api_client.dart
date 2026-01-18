import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';
import 'package:khtn_ai_final_project/core/config/app_config.dart';

@lazySingleton
class AuthApiClient {
  static String get baseUrl => AppConfig.authApiUrl;
  static const String _refreshTokenEndpoint = 'auth/sessions/current/refresh';

  final AuthLocalDataSource localDataSource;
  late final Dio _dio;

  AuthApiClient(this.localDataSource) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'X-Stack-Access-Type': 'client',
          'X-Stack-Project-Id': '45a1e2fd-77ee-4872-9fb7-987b8c119633',
          'X-Stack-Publishable-Client-Key':
              'pck_7wjweasxxnfspvr20dvmyd9pjj0p9kp755bxxcm4ae1er',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      TokenInterceptor(
        localDataSource: localDataSource,
        refreshTokenEndpoint: _refreshTokenEndpoint,
        baseUrl: baseUrl,
        dio: _dio,
      ),
    );
    _dio.interceptors.add(LogInterceptor());
  }

  // for sign-up, login, refresh token
  Future<Response> post(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);

  //for logout
  Future<Response> delete(
    String path, {
    bool includeRefreshToken = false,
  }) async {
    final refreshToken = includeRefreshToken
        ? await localDataSource.getRefreshToken()
        : null;
    final options = Options(
      headers: {
        if (refreshToken != null && refreshToken.isNotEmpty)
          'X-Stack-Refresh-Token': refreshToken,
      },
    );
    debugPrint('DELETE request: $path');
    debugPrint('Headers: ${options.headers}');
    return _dio.delete(path, options: options, data: {});
  }
}

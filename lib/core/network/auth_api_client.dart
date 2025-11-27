import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';
import 'package:khtn_ai_final_project/core/network/token_interceptor.dart';

class AuthApiClient {
  static const String baseUrl = 'https://auth-api.dev.jarvis.cx/api/v1/';
  static const String _refreshTokenEndpoint = 'auth/sessions/current/refresh';

  final AuthLocalDataSource localDataSource = AuthLocalDataSourceImpl();
  late final Dio _dio;

  AuthApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'X-Stack-Access-Type': 'client',
          'X-Stack-Project-Id': 'a914f06b-5e46-4966-8693-80e4b9f4f409',
          'X-Stack-Publishable-Client-Key':
              'pck_tqsy29b64a585km2g4wnpc57ypjprzzdch8xzpq0xhayr',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      TokenInterceptor(
        localDataSource: localDataSource,
        refreshTokenEndpoint: _refreshTokenEndpoint,
        baseUrl: baseUrl,
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

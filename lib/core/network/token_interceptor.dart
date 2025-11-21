import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';

/// Generic token interceptor for handling JWT authentication and token refresh
/// Can be reused across multiple API clients
class TokenInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;
  final String refreshTokenEndpoint;
  final String baseUrl;

  TokenInterceptor({
    required this.localDataSource,
    required this.refreshTokenEndpoint,
    required this.baseUrl,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await localDataSource.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      'TokenInterceptor: onError called with statusCode: ${err.response?.statusCode}',
    );

    if (err.response?.statusCode == 400) {
      debugPrint('TokenInterceptor: Bad request (400) - ${err.response?.data}');
      handler.next(err);
      return;
    }

    if (err.response?.statusCode == 401) {
      debugPrint(
        'TokenInterceptor: Unauthorized (401) - Attempting token refresh',
      );
      await _handleTokenRefresh(err, handler);
      return;
    }

    handler.next(err);
  }

  /// Handle 401 error by attempting to refresh the access token
  Future<void> _handleTokenRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final refreshToken = await localDataSource.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      debugPrint('TokenInterceptor: No refresh token available');
      handler.next(err);
      return;
    }

    try {
      debugPrint('TokenInterceptor: Refreshing access token...');
      final dio = Dio();
      final response = await dio.post(
        '$baseUrl$refreshTokenEndpoint',
        data: {},
        options: Options(
          headers: {
            'X-Stack-Refresh-Token': refreshToken,
            'Content-Type': 'application/json',
          },
        ),
      );

      final newAccessToken = response.data['access_token'];
      if (newAccessToken != null) {
        await localDataSource.saveTokens(access: newAccessToken);
        debugPrint('TokenInterceptor: Token refreshed successfully');

        // Retry the original request with new token
        final retryRequest = err.requestOptions;
        final newResponse = await Dio().fetch(retryRequest);
        return handler.resolve(newResponse);
      }
    } catch (e) {
      debugPrint('TokenInterceptor: Token refresh failed - $e');
      await localDataSource.clearTokens();
    }

    handler.next(err);
  }
}

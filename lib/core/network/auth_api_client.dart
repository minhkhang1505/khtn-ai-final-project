import 'package:dio/dio.dart';
import 'package:khtn_ai_final_project/data/datasources/local/auth_local_data_source.dart';

class AuthApiClient {
  static const String baseUrl = 'https://auth-api.dev.jarvis.cx/api/v1/';
  final AuthLocalDataSource localDataSource = AuthLocalDataSourceImpl();
  final Dio _dio = Dio(
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

  AuthApiClient() {
    _dio.interceptors.add(AuthInterceptor(localDataSource));
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
    return _dio.delete(path, options: options);
  }
}

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;
  AuthInterceptor(this.localDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await localDataSource.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await localDataSource.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          final dio = err.requestOptions.extra['dio'] as Dio? ?? Dio();
          final refreshToken = await dio.post(
            '${AuthApiClient.baseUrl}/auth/sessions/current/refresh',
            data: {},
          );

          final newAccessToken = refreshToken.data['access_token'];
          await localDataSource.saveTokens(access: newAccessToken);

          final retryRequest = err.requestOptions;
          final newResponse = await Dio().fetch(retryRequest);
          return handler.resolve(newResponse);
        } catch (_) {
          await localDataSource.clearTokens();
        }
      }
      handler.next(err);
    }
  }
}

import 'package:dio/dio.dart';

class AuthApiClient {
  static const String baseUrl = 'https://auth-api.dev.jarvis.cx/api/v1/';
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
    _dio.interceptors.add(LogInterceptor());
  }

  // for sign-up, login, refresh token
  Future<Response> post(String path, {Map<String, dynamic>? data}) =>
      _dio.post(path, data: data);

  //for logout
  Future<Response> delete(String path, {required String token}) {
    final options = Options(headers: {'Authorization' : 'Bearer $token'});
    return _dio.delete(path, options: options);
  }
}

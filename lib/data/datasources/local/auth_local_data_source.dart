import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({required String access, String? refresh});
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  //final SharedPreferences prefs;
  static const String _accessToken = 'access_token';
  static const String _refreshToken = 'refresh_token';

  // AuthLocalDataSourceImpl(this.prefs);

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> saveTokens({required String access, String? refresh}) async {

    await _storage.write(key: _accessToken, value: access);
    if (refresh != null) {
      await _storage.write(key: _refreshToken, value: refresh);
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshToken);
  }

  @override
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessToken);
    await _storage.delete(key: _refreshToken);
  }
}

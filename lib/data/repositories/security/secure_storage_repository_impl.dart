import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:github_commit_history/domain/repositories/security/secure_storage_repository.dart';

class SecureStorageRepositoryImpl extends SecureStorageRepository {
  final String _accessToken = "access_token";
  final String _refreshToken = "refresh_token";
  final String _username = "user_name";

  final _securePrefs = const FlutterSecureStorage();

  @override
  Future<String?> readAccessToken() async {
    return await _securePrefs.read(key: _accessToken);
  }

  @override
  Future<String?> readRefreshToken({bool remove = true}) async {
    final token = await _securePrefs.read(key: _refreshToken);
    if (token != null && remove) {
      await _securePrefs.delete(key: _refreshToken);
    }
    return token;
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await _securePrefs.write(key: _accessToken, value: token);
  }

  @override
  Future<void> saveToken(String token) async {
    await saveAccessToken(token);
  }

  @override
  Future<void> clearTokens() async {
    await _securePrefs.delete(key: _accessToken);
    await _securePrefs.delete(key: _refreshToken);
  }

  @override
  Future<void> saveUserName(String username) async {
    await _securePrefs.write(key: _username, value: username);
  }

  @override
  Future<String?> readUserName() async {
    return await _securePrefs.read(key: _username);
  }
}

abstract class SecureStorageRepository {
  Future<String?> readAccessToken();
  Future<String?> readUserName();
  Future<String?> readRefreshToken({bool remove = true});
  Future<void> saveAccessToken(String token);
  Future<void> saveUserName(String username);
  Future<void> saveToken(String token);
  Future<void> clearTokens();
}

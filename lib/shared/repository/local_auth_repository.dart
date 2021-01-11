abstract class ILocalAuthRepository {
  Future get(String key);
  Future remove(String key);
  Future insert(String key, dynamic value);
  Future<void> logout();
}
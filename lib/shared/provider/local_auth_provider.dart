import 'dart:async';
import 'package:food_cafe/resource/api.dart';
import 'package:food_cafe/shared/repository/local_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthProvider implements ILocalAuthRepository {
  Completer<SharedPreferences> _instance = Completer<SharedPreferences>();

  _init() async {
    _instance.complete(await SharedPreferences.getInstance());
  }

  LocalAuthProvider() {
    _init();
  }

  @override
  Future get(String key) async {
    var shared = await _instance.future;
    return shared.get(key);
  }

  @override
  Future insert(String key, dynamic value) async {
    var shared = await _instance.future;
    if (value is bool) {
      shared.setBool(key, value);
    } else if (value is String) {
      shared.setString(key, value);
    } else if (value is double) {
      shared.setDouble(key, value);
    } else if (value is int) {
      shared.setInt(key, value);
    } else if (value is List<String>) {
      shared.setStringList(key, value);
    } else if (value is List<dynamic>) {
      shared.setStringList(key, value);
    }
  }

  @override
  Future remove(String key) async {
    var shared = await _instance.future;
    return shared.remove(key);
  }

  @override
  Future logout() async {
    var shared = await _instance.future;
    shared.remove(SECURE_STORAGE_USERNAME);
    shared.remove(SECURE_STORAGE_EMAIL);
    shared.remove(SECURE_STORAGE_PROFILE_URL);
    shared.remove(SECURE_STORAGE_USER_ID);
    shared.remove(SECURE_STORAGE_TOKEN);
    shared.remove(SECURE_STORAGE_MOBILE);
    shared.remove(SECURE_STORAGE_WHERE_LOGIN);
  }
}

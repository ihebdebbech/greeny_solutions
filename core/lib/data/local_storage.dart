import 'package:core/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage(AppConfig appConfig) {
    _init();
  }

  late SharedPreferences _prefs;

  

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  Future<bool> clear() async {
    return _prefs.clear();
  }

  bool containsKey(String key) => _prefs.containsKey(key);
}

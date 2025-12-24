import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
class LocalStorage {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  LocalStorage(this._prefs, this._secureStorage);

  /// Delare key
  static const String accessTokenKey = 'access-token';
  static const String localeKey = 'locale_key';

  /// Function

  Future<void> setAccessToken(String accessToken) async {
    await _secureStorage.write(key: accessTokenKey, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return _secureStorage.read(key: accessTokenKey);
  }

  Future<void> setLocale(String locale) async {
    await _prefs.setString(localeKey, locale);
  }

  String? getLocale() {
    return _prefs.getString(localeKey);
  }
}

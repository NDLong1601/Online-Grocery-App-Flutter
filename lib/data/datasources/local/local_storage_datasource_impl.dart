import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/core/constants/storage_keys.dart';
import 'package:online_groceries_store_app/data/core/guard.dart';
import 'package:online_groceries_store_app/data/datasources/local/local_storage_datasource.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of local storage datasource using SharedPreferences and FlutterSecureStorage
///
/// This class provides a concrete implementation of [ILocalStorageDataSource] that handles
/// both secure and non-secure local storage operations. It uses:
/// - [FlutterSecureStorage] for sensitive data like access tokens
/// - [SharedPreferences] for general application data like locale settings and user preferences
///
/// All operations are wrapped with error handling through the `guardLocalStorage` function
/// to ensure consistent error management across all storage operations.
///
/// The class is registered as a singleton dependency using the `@Singleton` annotation,
/// making it available for dependency injection throughout the application.
///
/// Example usage:
/// ```dart
/// // Store sensitive data
/// await localStorage.storeAccessToken('jwt_token_here');
///
/// // Store user preferences
/// await localStorage.storeLocale('en_US');
/// await localStorage.storeBool('dark_mode', true);
///
/// // Retrieve data
/// final token = await localStorage.retrieveAccessToken();
/// final locale = await localStorage.retrieveLocale();
/// ```
///
/// Security considerations:
/// - Access tokens are stored in secure storage and are encrypted
/// - Other data types use SharedPreferences which may not be encrypted
/// - The `clearAll()` method removes data from both storage mechanisms
@Singleton(as: ILocalStorageDataSource)
class LocalStorageDataSourceImpl implements ILocalStorageDataSource {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;

  LocalStorageDataSourceImpl(this._sharedPreferences, this._secureStorage);

  @override
  ResultFuture<void> storeAccessToken(String accessToken) async {
    return guardLocalStorage(() async {
      await _secureStorage.write(
        key: StorageKeys.accessToken,
        value: accessToken,
      );
    });
  }

  @override
  ResultFuture<String?> retrieveAccessToken() async {
    return guardLocalStorage(() async {
      return await _secureStorage.read(key: StorageKeys.accessToken);
    });
  }

  @override
  ResultFuture<void> removeAccessToken() async {
    return guardLocalStorage(() async {
      await _secureStorage.delete(key: StorageKeys.accessToken);
    });
  }

  @override
  ResultFuture<void> storeLocale(String locale) async {
    return guardLocalStorage(() async {
      await _sharedPreferences.setString(StorageKeys.localeKey, locale);
    });
  }

  @override
  ResultFuture<String?> retrieveLocale() async {
    return guardLocalStorage(() async {
      return _sharedPreferences.getString(StorageKeys.localeKey);
    });
  }

  @override
  ResultFuture<void> storeString(String key, String value) async {
    return guardLocalStorage(() async {
      await _sharedPreferences.setString(key, value);
    });
  }

  @override
  ResultFuture<String?> retrieveString(String key) async {
    return guardLocalStorage(() async {
      return _sharedPreferences.getString(key);
    });
  }

  @override
  ResultFuture<void> storeBool(String key, bool value) async {
    return guardLocalStorage(() async {
      await _sharedPreferences.setBool(key, value);
    });
  }

  @override
  ResultFuture<bool?> retrieveBool(String key) async {
    return guardLocalStorage(() async {
      return _sharedPreferences.getBool(key);
    });
  }

  @override
  ResultFuture<void> storeInt(String key, int value) async {
    return guardLocalStorage(() async {
      await _sharedPreferences.setInt(key, value);
    });
  }

  @override
  ResultFuture<int?> retrieveInt(String key) async {
    return guardLocalStorage(() async {
      return _sharedPreferences.getInt(key);
    });
  }

  @override
  ResultFuture<void> clearAll() async {
    return guardLocalStorage(() async {
      await _sharedPreferences.clear();
      await _secureStorage.deleteAll();
    });
  }

  @override
  ResultFuture<bool> hasKey(String key) async {
    return guardLocalStorage(() async {
      return _sharedPreferences.containsKey(key);
    });
  }
}

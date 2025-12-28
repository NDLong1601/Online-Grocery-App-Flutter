import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/datasources/local/local_storage_datasource.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';

/// Implementation of [ILocalStorage] that provides local data storage functionality
/// for user preferences, authentication tokens, and application settings.
///
/// This class acts as a repository layer that delegates storage operations to
/// [ILocalStorageDataSource] while maintaining consistent storage keys and
/// providing default values for certain preferences.
///
/// Uses dependency injection with [Singleton] annotation to ensure a single
/// instance throughout the application lifecycle.
///
/// Storage categories:
/// - Authentication: Access tokens
/// - User data: User ID, email
/// - App preferences: Theme mode, notifications, locale
/// - App state: First launch flag
///
/// All methods return [ResultFuture] for consistent error handling across
/// the application.

@Singleton(as: ILocalStorage)
class LocalStorageImpl implements ILocalStorage {
  final ILocalStorageDataSource _localStorageDataSource;

  LocalStorageImpl(this._localStorageDataSource);

  /// Storage keys for consistency
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _themeModeKey = 'theme_mode';
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _isFirstLaunchKey = 'is_first_launch';

  @override
  ResultFuture<void> setAccessToken(String accessToken) async {
    return _localStorageDataSource.storeAccessToken(accessToken);
  }

  @override
  ResultFuture<String?> getAccessToken() async {
    return _localStorageDataSource.retrieveAccessToken();
  }

  @override
  ResultFuture<void> removeAccessToken() async {
    return _localStorageDataSource.removeAccessToken();
  }

  @override
  ResultFuture<void> setLocale(String locale) async {
    return _localStorageDataSource.storeLocale(locale);
  }

  @override
  ResultFuture<String?> getLocale() async {
    return _localStorageDataSource.retrieveLocale();
  }

  @override
  ResultFuture<void> setUserId(String userId) async {
    return _localStorageDataSource.storeString(_userIdKey, userId);
  }

  @override
  ResultFuture<String?> getUserId() async {
    return _localStorageDataSource.retrieveString(_userIdKey);
  }

  @override
  ResultFuture<void> setUserEmail(String email) async {
    return _localStorageDataSource.storeString(_userEmailKey, email);
  }

  @override
  ResultFuture<String?> getUserEmail() async {
    return _localStorageDataSource.retrieveString(_userEmailKey);
  }

  @override
  ResultFuture<void> setThemeMode(String themeMode) async {
    return _localStorageDataSource.storeString(_themeModeKey, themeMode);
  }

  @override
  ResultFuture<String?> getThemeMode() async {
    return _localStorageDataSource.retrieveString(_themeModeKey);
  }

  @override
  ResultFuture<void> setNotificationsEnabled(bool enabled) async {
    return _localStorageDataSource.storeBool(_notificationsEnabledKey, enabled);
  }

  @override
  ResultFuture<bool> getNotificationsEnabled() async {
    final result = await _localStorageDataSource.retrieveBool(
      _notificationsEnabledKey,
    );
    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value ?? true), // Default to true if not set
    );
  }

  @override
  ResultFuture<void> setIsFirstLaunch(bool isFirstLaunch) async {
    return _localStorageDataSource.storeBool(_isFirstLaunchKey, isFirstLaunch);
  }

  @override
  ResultFuture<bool> getIsFirstLaunch() async {
    final result = await _localStorageDataSource.retrieveBool(
      _isFirstLaunchKey,
    );
    return result.fold(
      (failure) => Left(failure),
      (value) =>
          Right(value ?? true), // Default to true if not set (first launch)
    );
  }

  @override
  ResultFuture<void> clearAllUserData() async {
    return _localStorageDataSource.clearAll();
  }
}

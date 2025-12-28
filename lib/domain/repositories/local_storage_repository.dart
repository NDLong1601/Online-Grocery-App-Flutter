import 'package:online_groceries_store_app/domain/core/result.dart';

/// Domain repository interface for local storage operations
/// This interface defines the contract for local storage at the domain layer
/// It should remain independent of any external dependencies

/// Domain repository interface for local storage operations.
/// This abstract class defines the contract for local storage operations at the domain layer.
/// It follows the Repository pattern and remains independent of any external dependencies,
/// allowing for easy testing and implementation swapping.
///
/// The interface is organized into several categories:
/// - Authentication: Token management for user sessions
/// - User Preferences: Locale and personalization settings
/// - User Session: User identification and email storage
/// - App Settings: Theme, notifications, and other app configurations
/// - Onboarding: First-time user experience flags
/// - Data Management: Bulk operations for user data cleanup
///
/// All methods return [ResultFuture] to provide consistent error handling
/// and async operation support across the application.
///
/// Example usage:
/// ```dart
/// class AuthService {
///   final ILocalStorage _localStorage;
///
///   AuthService(this._localStorage);
///
///   Future<void> login(String token) async {
///     final result = await _localStorage.setAccessToken(token);
///     // Handle result...
///   }
/// }
/// ```
abstract class ILocalStorage {
  /// Authentication related methods
  ResultFuture<void> setAccessToken(String accessToken);
  ResultFuture<String?> getAccessToken();
  ResultFuture<void> removeAccessToken();

  /// User preferences
  ResultFuture<void> setLocale(String locale);
  ResultFuture<String?> getLocale();

  /// User session management
  ResultFuture<void> setUserId(String userId);
  ResultFuture<String?> getUserId();
  ResultFuture<void> setUserEmail(String email);
  ResultFuture<String?> getUserEmail();

  /// App settings
  ResultFuture<void> setThemeMode(String themeMode);
  ResultFuture<String?> getThemeMode();
  ResultFuture<void> setNotificationsEnabled(bool enabled);
  ResultFuture<bool> getNotificationsEnabled();

  /// Onboarding and first-time user experience
  ResultFuture<void> setIsFirstLaunch(bool isFirstLaunch);
  ResultFuture<bool> getIsFirstLaunch();

  /// Clear all user data (useful for logout)
  ResultFuture<void> clearAllUserData();
}

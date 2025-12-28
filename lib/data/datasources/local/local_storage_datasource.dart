import 'package:online_groceries_store_app/domain/core/result.dart';

/// Local Storage Data Source Interface
///
/// This abstract class defines the contract for local storage operations in the data layer
/// of the application. It provides a standardized interface for storing and retrieving
/// various types of data locally on the device.
///
/// The interface supports:
/// - Secure token storage for authentication
/// - User preference management (locale, settings)
/// - Generic key-value storage for different data types (String, bool, int)
/// - Data management operations (clear, check existence)
///
/// All methods return `ResultFuture<T>` to handle asynchronous operations with
/// proper error handling and result wrapping.
///
/// Implementation classes should handle:
/// - Secure storage for sensitive data (tokens)
/// - Persistent storage across app sessions
/// - Platform-specific storage mechanisms
/// - Error handling for storage failures
///
/// Example usage:
/// ```dart
/// final localStorage = LocalStorageDataSource();
///
/// // Store and retrieve access token
/// await localStorage.storeAccessToken('your_token_here');
/// final token = await localStorage.retrieveAccessToken();
///
/// // Store user preferences
/// await localStorage.storeLocale('en_US');
/// await localStorage.storeBool('dark_mode', true);
/// ```

/// Abstract class for local storage datasource
/// This defines the contract for local storage operations at the data layer
abstract class ILocalStorageDataSource {
  /// Store access token securely
  ResultFuture<void> storeAccessToken(String accessToken);

  /// Retrieve access token
  ResultFuture<String?> retrieveAccessToken();

  /// Remove access token
  ResultFuture<void> removeAccessToken();

  /// Store locale preference
  ResultFuture<void> storeLocale(String locale);

  /// Retrieve locale preference
  ResultFuture<String?> retrieveLocale();

  /// Store user preferences as key-value pairs
  ResultFuture<void> storeString(String key, String value);

  /// Retrieve string value by key
  ResultFuture<String?> retrieveString(String key);

  /// Store boolean value
  ResultFuture<void> storeBool(String key, bool value);

  /// Retrieve boolean value
  ResultFuture<bool?> retrieveBool(String key);

  /// Store integer value
  ResultFuture<void> storeInt(String key, int value);

  /// Retrieve integer value
  ResultFuture<int?> retrieveInt(String key);

  /// Clear all stored data
  ResultFuture<void> clearAll();

  /// Check if key exists
  ResultFuture<bool> hasKey(String key);
}

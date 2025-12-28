/// A utility class that contains constant keys used for local storage operations.
///
/// This class provides centralized access to storage key constants to ensure
/// consistency across the application when storing and retrieving data from
/// local storage mechanisms like SharedPreferences or secure storage.
///
/// All keys are defined as static constants to prevent instantiation and
/// provide compile-time safety for storage operations.
class StorageKeys {
  static const String accessToken = 'access_token';
  static const String userId = 'user_id';
  static const String localeKey = 'locale_key';
  // ...
}

/// Constants used throughout the application.
///
/// This class contains static constant values that are used across
/// different parts of the application to maintain consistency and
/// avoid magic numbers/strings.
class AppConstants {
  /// The default timeout duration in seconds for network requests.
  ///
  /// Used to set timeout limits for HTTP requests to prevent
  /// indefinite waiting periods.
  static const int defaultTimeoutSeconds = 30;

  /// The default locale identifier for the application.
  ///
  /// Used for internationalization (i18n) and localization (l10n)
  /// when no specific locale is set by the user.
  static const String defaultLocale = 'en';

  /// The maximum number of retry attempts for failed operations.
  ///
  /// Used to limit the number of retries for network requests
  /// or other operations that might fail temporarily.
  static const int maxRetryAttempts = 3;
}

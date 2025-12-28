/// Abstract interface for application logging functionality.
///
/// Provides a standardized logging interface with different severity levels
/// and crash reporting capabilities. Implementations should handle the actual
/// logging mechanism (console, file, remote service, etc.).
///
/// All logging methods support optional error information, stack traces,
/// and additional metadata for enhanced debugging and monitoring.
///
/// Example usage:
/// ```dart
/// final logger = MyLoggerImplementation();
/// logger.i('User login successful', metadata: {'userId': 123});
/// logger.e('Database connection failed', error: exception, stackTrace: trace);
/// ```
abstract class AppLogger {
  /// Log a message at level [Level.info]
  void i(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Log a message at level [Level.warning]
  void w(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Log a message at level [Level.error]
  void e(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Log a message at level [Level.fatal]
  void f(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Log a message at level [Level.trace]
  void t(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// Log a message at level [Level.debug]
  void d(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });

  /// crash the app
  void crash({
    String reason = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  });
}

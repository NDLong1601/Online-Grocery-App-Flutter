import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:online_groceries_store_app/domain/core/app_logger.dart';

/// A console-based implementation of the [AppLogger] interface that provides
/// colorful, formatted logging output to the console using the Logger package.
///
/// This class is registered as a lazy singleton and implements comprehensive
/// logging functionality with different log levels (trace, debug, info, warning,
/// error, fatal) and crash reporting capabilities.
///
/// Features:
/// - Colorful console output with emojis for better readability
/// - Configurable stack trace display (2 method calls for normal logs, 8 for errors)
/// - Timestamp formatting showing time and duration since start
/// - Metadata support that gets appended to log messages
/// - Pretty-printed output with 120 character line width
///
/// The logger automatically formats messages by mixing in any provided metadata
/// and supports optional error objects and stack traces for debugging purposes.
///
/// Example usage:
/// ```dart
/// final logger = GetIt.instance<AppLogger>();
/// logger.i('User logged in', metadata: {'userId': '123'});
/// logger.e('Network error', error: exception, stackTrace: stackTrace);
/// ```

@LazySingleton(as: AppLogger)
class ConsoleAppLogger implements AppLogger {
  final Logger _logger;

  ConsoleAppLogger()
    : _logger = Logger(
        level: Level.trace,
        printer: PrettyPrinter(
          methodCount: 2, // Number of method calls to be displayed
          errorMethodCount:
              8, // Number of method calls if stacktrace is provided
          lineLength: 120, // Width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          // Should each log print contain a timestamp
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        ),
      );

  @override
  void crash({
    String reason = '',
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    e(
      'CRASH: $reason',
      error: error,
      stackTrace: stackTrace,
      metadata: metadata,
    );
  }

  @override
  void d(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _logger.d(
      _mixMetadata(message, metadata),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void e(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _logger.e(
      _mixMetadata(message, metadata),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void f(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _logger.f(
      _mixMetadata(message, metadata),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void i(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _logger.i(
      _mixMetadata(message, metadata),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void t(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _logger.t(
      _mixMetadata(message, metadata),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void w(
    Object message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    _logger.w(
      _mixMetadata(message, metadata),
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// mix in metadata to message
  String _mixMetadata(Object message, Map<String, dynamic>? metadata) {
    return metadata == null ? '$message' : '$message | metadata: $metadata';
  }
}

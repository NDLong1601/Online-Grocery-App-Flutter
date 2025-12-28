import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Creates a pretty DIO logger interceptor with predefined configuration.
///
/// Returns a [PrettyDioLogger] interceptor that logs HTTP requests and responses
/// in a formatted, readable way. The logger is configured to:
/// - Log request headers and body
/// - Log response body (but not headers)
/// - Log errors
/// - Use compact formatting with maximum width of 100 characters
///
/// This interceptor is typically used during development to debug network calls
/// and inspect the data being sent and received.
///
/// Returns:
///   An [Interceptor] instance configured for pretty logging.
Interceptor prettyDioLoggerInterceptor() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 100,
  );
}

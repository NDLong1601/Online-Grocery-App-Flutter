import 'package:dio/dio.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';

/// A utility class for mapping Dio exceptions to domain-specific failure objects.
///
/// This mapper handles the conversion of HTTP client exceptions from the data layer
/// to structured failure objects used in the domain layer, following clean architecture principles.
///
/// The mapper categorizes failures into:
/// - Network-related failures (timeouts, connection errors)
/// - Authentication/Authorization failures (401, 403)
/// - Server failures (5xx status codes)
/// - Unknown failures (fallback case)

/// Extracts a human-readable error message from various response data formats.
///
/// Attempts to parse the server response data and extract a meaningful error message
/// that can be displayed to the user or logged for debugging purposes.
///
/// **Parameters:**
/// - `data`: The response data from the server, can be of any type (String, Map, etc.)
///
/// **Returns:**
/// - `String?`: The extracted message if found, null otherwise
///
/// **Supported formats:**
/// - Direct string responses
/// - JSON objects with a 'message' field
/// - Returns null for unsupported formats or parsing errors

/// Maps Dio HTTP exceptions to domain-specific failure objects.
///
/// This function analyzes the DioException and converts it into an appropriate
/// Failure subclass based on the error type and HTTP status code. This abstraction
/// allows the domain layer to handle errors without depending on specific HTTP client implementations.
///
/// **Parameters:**
/// - `e`: The DioException thrown by the HTTP client
///
/// **Returns:**
/// - `Failures`: An appropriate failure object representing the error condition
///
/// **Failure mappings:**
/// - Connection/timeout errors → `NetworkFailure`
/// - Connection errors → `NoInternetConnectionFailure`
/// - HTTP 401 → `UnauthorizedFailure`
/// - HTTP 403 → `ForbiddenFailure`
/// - HTTP 5xx → `ServerFailure` (with status code and message)
/// - All other cases → `UnknownFailure`
///
/// **Note:** All failure objects preserve the original exception and stack trace
/// for debugging purposes.
/// Extracts the server message from the data which is response.data (String/Map/Whatever)
String? extractServerMessage(dynamic data) {
  try {
    if (data == null) return null;
    if (data is String) return data;
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message != null && message is String) return message;
    }
    return null;
  } catch (e) {
    return null;
  }
}

/// Maps the dio exception from data layer to the failure (domain layer)
Failures mapDioExceptionToFailures(DioException e) {
  final code = e.response?.statusCode;
  final message = extractServerMessage(e.response?.data);

  /// Timeout / socket exception
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return NetworkFailure(cause: e, stackTrace: e.stackTrace);
  }

  /// No internet connection
  if (e.type == DioExceptionType.connectionError) {
    return NoInternetConnectionFailure(cause: e, stackTrace: e.stackTrace);
  }

  /// Server returns code
  if (code != null) {
    if (code == 401) {
      return UnauthorizedFailure(cause: e, stackTrace: e.stackTrace);
    }
    if (code == 403) {
      return ForbiddenFailure(cause: e, stackTrace: e.stackTrace);
    }

    /// Server returns code 500 - 599
    if (code >= 500) {
      return ServerFailure(
        stackTrace: e.stackTrace,
        cause: e,
        statusCode: code,
        message: message,
      );
    }
  }

  return UnknownFailure(cause: e, stackTrace: e.stackTrace);
}

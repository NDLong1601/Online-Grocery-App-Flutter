import 'package:dio/dio.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';

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

/// A collection of custom exception classes for handling various error scenarios in the data layer.
///
/// This file defines specific exceptions that can be thrown during data operations,
/// network requests, and other data-related processes. Each exception provides
/// context about the type of error that occurred.
///
/// **Exception Types:**
///
/// - [ServerException]: Thrown when server returns an error response
/// - [NetworkException]: Thrown when network-related errors occur
/// - [CacheException]: Thrown when cache operations fail
/// - [UnauthorizedException]: Thrown when authentication is required or invalid (HTTP 401)
/// - [ForbiddenException]: Thrown when access is forbidden (HTTP 403)
/// - [NoInternetException]: Thrown when internet connection is unavailable
/// - [UnknowException]: Thrown for unexpected or unhandled errors
///
/// **Usage Example:**
/// ```dart
/// try {
///   // Some data operation
/// } catch (e) {
///   if (e is ServerException) {
///     print('Server error: ${e.message} (${e.statusCode})');
///   } else if (e is NetworkException) {
///     print('Network error occurred');
///   }
/// }
/// ```
///
/// These exceptions should be caught and handled appropriately in the
/// repository or use case layers to provide meaningful error messages
/// to the user interface.
/// Defines the exceptions for the data layer
/// Exception for server errors
class ServerException implements Exception {
  final int? statusCode;
  final String? message;
  final dynamic data;

  ServerException({this.statusCode, this.message, this.data});
}

class NetworkException implements Exception {
  final Object? cause;

  NetworkException([this.cause]);
}

class CacheException implements Exception {
  final Object? cause;
  CacheException([this.cause]);
}

class UnauthorizedException implements Exception {
  final Object? cause;
  UnauthorizedException([this.cause]);
}

class ForbiddenException implements Exception {
  final Object? cause;
  ForbiddenException([this.cause]);
}

class NoInternetException implements Exception {
  final Object? cause;
  NoInternetException([this.cause]);
}

class UnknowException implements Exception {
  final Object? cause;
  UnknowException([this.cause]);
}

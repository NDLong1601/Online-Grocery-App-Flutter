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

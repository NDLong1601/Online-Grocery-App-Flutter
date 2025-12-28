/// A comprehensive failure handling system for the domain layer.
///
/// This file defines a hierarchy of failure classes that represent different
/// types of errors that can occur in the application. All failures extend
/// the base [Failures] class and include optional cause and stack trace
/// information for debugging purposes.
///
/// The failure classes include:
/// - [NetworkFailure]: Network-related connectivity issues
/// - [ServerFailure]: Server-side errors with optional status code and message
/// - [CacheFailure]: Local cache or storage related failures
/// - [UnauthorizedFailure]: Authentication failures (401 errors)
/// - [ForbiddenFailure]: Authorization failures (403 errors)
/// - [NoInternetConnectionFailure]: Internet connectivity issues
/// - [UnknownFailure]: Catch-all for unhandled or unexpected errors
///
/// Usage:
/// ```dart
/// // Example of handling different failure types
/// result.fold(
///   (failure) {
///     if (failure is NetworkFailure) {
///       // Handle network issues
///     } else if (failure is ServerFailure) {
///       // Handle server errors using statusCode and message
///     }
///   },
///   (success) => // Handle success
/// );
/// ```
/// Base class for all failures with a cause and stacktrace
/// This is used to handle failures in the domain layer
abstract class Failures {
  final Object? cause;
  final StackTrace? stackTrace;

  Failures({this.cause, this.stackTrace});
}

class NetworkFailure extends Failures {
  NetworkFailure({super.cause, super.stackTrace});
}

class ServerFailure extends Failures {
  final int? statusCode;
  final String? message;

  ServerFailure({super.cause, super.stackTrace, this.statusCode, this.message});
}

class CacheFailure extends Failures {
  CacheFailure({super.cause, super.stackTrace});
}

class UnauthorizedFailure extends Failures {
  UnauthorizedFailure({super.cause, super.stackTrace});
}

class ForbiddenFailure extends Failures {
  ForbiddenFailure({super.cause, super.stackTrace});
}

class NoInternetConnectionFailure extends Failures {
  NoInternetConnectionFailure({super.cause, super.stackTrace});
}

class UnknownFailure extends Failures {
  UnknownFailure({super.cause, super.stackTrace});
}

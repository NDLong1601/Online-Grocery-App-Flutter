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

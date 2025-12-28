import 'package:online_groceries_store_app/domain/core/result.dart';

/// Base class for all use cases
/// Base abstract class for asynchronous use cases in the application.
///
/// This class defines the contract for use cases that execute asynchronously
/// and return a Future result. It follows the Clean Architecture pattern
/// where use cases represent business logic operations that may involve
/// network calls, database operations, or other async operations.
///
/// Type parameters:
/// - [Result]: The type of data returned on successful execution
/// - [Params]: The type of parameters required for the use case execution
///
/// Returns a [ResultFuture<Result>] which represents a Future that resolves
/// to either a success with the result data or a failure with error information.

/// A marker class used when a use case doesn't require any parameters.
///
/// This class serves as a placeholder type for use cases that don't need
/// input parameters. It provides type safety while maintaining the consistent
/// interface of the Usecase and UsecaseAsync abstract classes.
///
/// Usage example:
/// ```dart
/// class GetCurrentUserUsecase extends UsecaseAsync<User, NoParams> {
///   @override
///   ResultFuture<User> call(NoParams params) {
///     // Implementation that doesn't use params
///   }
/// }
/// ```
/// Usecase for sync
abstract class Usecase<Result, Params> {
  ResultEither<Result> call(Params params);
}

/// Usecase for async
abstract class UsecaseAsync<Result, Params> {
  ResultFuture<Result> call(Params params);
}

/// No params for usecase
class NoParams {}

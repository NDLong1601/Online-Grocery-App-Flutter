import 'package:dartz/dartz.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';

/// Defines the type of the result for usecase
/// Either is a type that represents either a successful value or an error which is our Failures
/// [T] is the type of the success value
/// [Failures] is the type of failures value
/// [typedef] is a keyword in Dart that is used to define a new type
/// Type alias for Either monad representing a result that can be either a failure or a success value.
///
/// [T] is the type of the success value.
/// Returns [Either<Failures, T>] where left side contains failures and right side contains the success value.
typedef ResultEither<T> = Either<Failures, T>;

/// Type alias for asynchronous operations that return a [ResultEither].
///
/// Commonly used in use cases and repository patterns for async operations that can fail.
/// [T] is the type of the success value wrapped in a Future.
/// Returns [Future<ResultEither<T>>] representing an async operation that resolves to either a failure or success.
typedef ResultFuture<T> = Future<ResultEither<T>>;

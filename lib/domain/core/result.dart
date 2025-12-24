import 'package:dartz/dartz.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';

/// Defines the type of the result for usecase
/// Either is a type that represents either a successful value or an error which is our Failures
/// [T] is the type of the success value
/// [Failures] is the type of failures value
/// [typedef] is a keyword in Dart that is used to define a new type
typedef ResultEither<T> = Either<Failures, T>;

/// Defines the type of the result for use case async
typedef ResultFuture<T> = Future<ResultEither<T>>;

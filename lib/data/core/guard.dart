import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:online_groceries_store_app/data/core/dio_failure_mapper.dart';
import 'package:online_groceries_store_app/data/core/exceptions.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';

/// A utility class that provides exception handling guards for different types of operations.
///
/// This guard system follows the Either pattern, returning a [ResultFuture] that can contain
/// either a success result (Right) or a failure (Left). It provides consistent error handling
/// across the application by catching various exception types and mapping them to appropriate
/// failure objects.
///
/// Example usage:
/// ```dart
/// final result = await guardDio(() => apiService.getData());
/// result.fold(
///   (failure) => handleError(failure),
///   (data) => handleSuccess(data),
/// );
/// ```

/// Guard the dio exception and return the result
ResultFuture<T> guardDio<T>(Future<T> Function() task) async {
  try {
    final data = await task();
    return Right(data);
  } on DioException catch (e) {
    return Left(mapDioExceptionToFailures(e));
  } on ForbiddenException catch (e, stackTrace) {
    return Left(ForbiddenFailure(cause: e, stackTrace: stackTrace));
  } on UnauthorizedException catch (e, stackTrace) {
    return Left(UnauthorizedFailure(cause: e, stackTrace: stackTrace));
  } on NetworkException catch (e, stackTrace) {
    return Left(NetworkFailure(cause: e, stackTrace: stackTrace));
  } on UnknowException catch (e, stackTrace) {
    return Left(UnknownFailure(cause: e, stackTrace: stackTrace));
  } on NoInternetException catch (e, stackTrace) {
    return Left(NoInternetConnectionFailure(cause: e, stackTrace: stackTrace));
  } on CacheException catch (e, stackTrace) {
    return Left(CacheFailure(cause: e, stackTrace: stackTrace));
  } catch (e, stackTrace) {
    return Left(UnknownFailure(cause: e, stackTrace: stackTrace));
  }
}

/// A guard function that wraps local storage operations and handles exceptions.
///
/// This function executes a given [task] and returns a [ResultFuture] that either
/// contains the successful result or a [CacheFailure] if an exception occurs.
///
/// **Parameters:**
/// - [task]: A function that returns a [Future<T>] representing the local storage operation
///
/// **Returns:**
/// - [ResultFuture<T>]: A [Right] containing the data if successful, or a [Left] containing
///   a [CacheFailure] with the exception details if an error occurs
///
/// **Example:**
/// ```dart
/// final result = await guardLocalStorage(() async {
///   return await localStorage.getData();
/// });
///
/// result.fold(
///   (failure) => print('Cache error: ${failure.cause}'),
///   (data) => print('Success: $data'),
/// );
/// ```
/// Local storage guard
ResultFuture<T> guardLocalStorage<T>(Future<T> Function() task) async {
  try {
    final data = await task();
    return Right(data);
  } catch (e, stackTrace) {
    return Left(CacheFailure(cause: e, stackTrace: stackTrace));
  }
}

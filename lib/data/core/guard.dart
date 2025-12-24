import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:online_groceries_store_app/data/core/dio_failure_mapper.dart';
import 'package:online_groceries_store_app/data/core/exceptions.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';

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

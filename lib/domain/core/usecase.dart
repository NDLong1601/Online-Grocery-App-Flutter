import 'package:online_groceries_store_app/domain/core/result.dart';

/// Base class for all use cases

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

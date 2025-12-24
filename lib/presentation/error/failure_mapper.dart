import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';

class FailureMapper {
  final BuildContext context;

  FailureMapper(this.context);

  String mapFailureToMessage(Failures failure) {
    switch (failure) {
      case NetworkFailure():
        return 'Network Error';
      case ServerFailure():
        return 'Server Error';
      case CacheFailure():
        return 'Cache Error';
      case UnauthorizedFailure():
        return 'Unauthorized Error';
      case ForbiddenFailure():
        return 'Forbidden Error';
      case NoInternetConnectionFailure():
        return 'No Internet Connection Error';
      case UnknownFailure():
        return 'Unknown Error';
      default:
        return 'Unknown Failure';
    }
  }
}

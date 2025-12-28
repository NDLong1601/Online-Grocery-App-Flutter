import 'package:flutter/material.dart';
import 'package:online_groceries_store_app/domain/core/failures.dart';

/// A utility class that maps different types of failures to user-friendly error messages.
///
/// This class provides a centralized way to convert failure objects into localized
/// or contextual error messages that can be displayed to the user.
///
/// Example usage:
/// ```dart
/// final mapper = FailureMapper(context);
/// final errorMessage = mapper.mapFailureToMessage(NetworkFailure());
/// ```
class FailureMapper {
  /// The build context used for potential localization or theme access.
  final BuildContext context;

  /// Creates a new [FailureMapper] with the given [context].
  ///
  /// The [context] parameter is required and may be used for accessing
  /// localization resources or other context-dependent features.
  FailureMapper(this.context);

  /// Maps a [Failures] object to a human-readable error message string.
  ///
  /// Takes a [failure] parameter of type [Failures] and returns an appropriate
  /// error message based on the specific failure type.
  ///
  /// Supported failure types:
  /// - [NetworkFailure] -> "Network Error"
  /// - [ServerFailure] -> "Server Error"
  /// - [CacheFailure] -> "Cache Error"
  /// - [UnauthorizedFailure] -> "Unauthorized Error"
  /// - [ForbiddenFailure] -> "Forbidden Error"
  /// - [NoInternetConnectionFailure] -> "No Internet Connection Error"
  /// - [UnknownFailure] -> "Unknown Error"
  /// - Any other failure type -> "Unknown Failure"
  ///
  /// Returns a [String] containing the error message to display to the user.
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

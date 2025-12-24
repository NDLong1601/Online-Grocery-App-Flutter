import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkInterceptor extends Interceptor {
  NetworkInterceptor();

  /// Implement local storage, app logger

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// get access token from local storage and add to header

    debugPrint('Requesting [${options.method}] => PATH: ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'Response [${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      'Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    handler.next(err);
  }
}

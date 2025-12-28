import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/domain/core/app_logger.dart';
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart';

/// A network interceptor that handles authentication, logging, and error handling
/// for HTTP requests made through the Dio client.
///
/// This interceptor is automatically registered as a lazy singleton and performs
/// the following operations:
/// - Adds Bearer token authentication to outgoing requests
/// - Logs detailed information about requests, responses, and errors
/// - Handles token retrieval failures gracefully
///
/// The interceptor integrates with the local storage system to retrieve
/// access tokens and uses the application logger for comprehensive
/// request/response tracking.
///
/// **Request Flow:**
/// 1. Retrieves access token from local storage
/// 2. Adds Authorization header if token is available
/// 3. Logs request details (method, URL, headers, query params, body)
///
/// **Response Flow:**
/// 1. Logs response details (status code, URL, response data)
///
/// **Error Flow:**
/// 1. Logs error details (status code, URL, error data)
///
/// Example usage:
/// ```dart
/// final dio = Dio();
/// dio.interceptors.add(NetworkInterceptor(localStorage, logger));
/// ```

@lazySingleton
class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this._localStorage, this._loggger);

  final ILocalStorage _localStorage;
  final AppLogger _loggger;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _localStorage.getAccessToken();
    token.fold(
      (failure) => {_loggger.e('ERROR [${failure.cause?.toString()}]')},
      (data) => {options.headers['Authorization'] = 'Bearer $data'},
    );
    _loggger.t(
      'REQUEST ${options.method} ${options.uri}',
      metadata: {
        'headers': options.headers,
        'query': options.queryParameters,
        'data': options.data,
      },
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _loggger.t(
      'RESPONSE [${response.statusCode}] ${response.requestOptions.uri}',
      metadata: {'data': response.data},
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _loggger.e(
      'ERROR [${err.response?.statusCode}] ${err.requestOptions.uri}',
      metadata: {'data': err.response?.data},
    );
    super.onError(err, handler);
  }
}

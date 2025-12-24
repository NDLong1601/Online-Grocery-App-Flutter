import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/core/logging/app_logger.dart';
import 'package:online_groceries_store_app/data/datasources/local/local_storage.dart';

@lazySingleton
class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this._localStorage, this._loggger);

  final LocalStorage _localStorage;
  final AppLogger _loggger;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _localStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
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

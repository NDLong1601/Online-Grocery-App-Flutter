import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/core/env/app_config.dart';
import 'package:online_groceries_store_app/data/core/dio_logger.dart';
import 'package:online_groceries_store_app/data/core/interceptors.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A dependency injection module that provides third-party dependencies for the application.
///
/// This module is responsible for configuring and providing instances of external
/// libraries and services that are commonly used throughout the application.
///
/// Dependencies provided:
/// - [Dio] HTTP client with pre-configured settings and interceptors
/// - [SharedPreferences] for local data persistence
/// - [FlutterSecureStorage] for secure local storage
///
/// The module uses the injectable package annotations to define how dependencies
/// should be created and managed by the dependency injection container.
@module
abstract class ThirdPartyModule {
  Dio dio(
    AppConfig appConfig,
    @Named('baseUrl') String baseUrl,
    NetworkInterceptor networkInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // dio.interceptors.add(networkInterceptor);
    // dio.interceptors.add(prettyDioLoggerInterceptor());
    dio.interceptors.addAll([networkInterceptor, prettyDioLoggerInterceptor()]);

    return dio;
  }

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  FlutterSecureStorage secureStorage() => const FlutterSecureStorage();
}

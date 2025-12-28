import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/core/env/app_config.dart';
import 'package:online_groceries_store_app/core/env/flavor.dart';

/// Environment module for dependency injection configuration.
///
/// This module defines different configurations for development, staging, and production
/// environments using the injectable package. Each environment has its own AppConfig
/// and base URL configuration.
///
/// The module provides:
/// - Environment-specific AppConfig singletons with appropriate flavor and base URL
/// - Named base URL strings for injection into HTTP clients like Dio/Retrofit
///
/// Environments:
/// - `dev`: Development environment using 'https://dummyjson.com'
/// - `staging`: Staging environment using 'https://dummyjson.staging.com'
/// - `prod`: Production environment using 'https://dummyjson.prod.com'
///
/// Usage:
/// The configurations are automatically injected based on the current environment
/// setting when the app is built or run with the appropriate environment flag.
const dev = Environment('dev');
const staging = Environment('staging');
const prod = Environment('prod');

@module
abstract class EnvModule {
  /// App config for each environment

  @dev
  @singleton
  AppConfig devConfig() =>
      AppConfig(flavor: Flavor.dev, baseUrl: 'https://dummyjson.com');

  @staging
  @singleton
  AppConfig stagingConfig() => AppConfig(
    flavor: Flavor.staging,
    baseUrl: 'https://dummyjson.staging.com',
  );

  @prod
  @singleton
  AppConfig prodConfig() =>
      AppConfig(flavor: Flavor.prod, baseUrl: 'https://dummyjson.prod.com');

  /// baseUrl for each environment with @Named to inject to Dio/Retrofit
  @dev
  @Named('baseUrl')
  String devBaseUrl(AppConfig config) => config.baseUrl;

  @staging
  @Named('baseUrl')
  String stagingBaseUrl(AppConfig config) => config.baseUrl;

  @prod
  @Named('baseUrl')
  String prodBaseUrl(AppConfig config) => config.baseUrl;
}

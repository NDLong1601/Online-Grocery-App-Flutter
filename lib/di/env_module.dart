import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/core/env/app_config.dart';
import 'package:online_groceries_store_app/core/env/flavor.dart';

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

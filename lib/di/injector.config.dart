// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:online_groceries_store_app/core/env/app_config.dart' as _i428;
import 'package:online_groceries_store_app/core/logging/console_app_logger.dart'
    as _i787;
import 'package:online_groceries_store_app/data/core/interceptors.dart'
    as _i492;
import 'package:online_groceries_store_app/data/datasources/local/local_storage_datasource.dart'
    as _i321;
import 'package:online_groceries_store_app/data/datasources/local/local_storage_datasource_impl.dart'
    as _i871;
import 'package:online_groceries_store_app/data/datasources/remote/api_service.dart'
    as _i960;
import 'package:online_groceries_store_app/data/repositories/auth_repository_impl.dart'
    as _i810;
import 'package:online_groceries_store_app/data/repositories/local_storage_impl.dart'
    as _i646;
import 'package:online_groceries_store_app/di/domain_module.dart' as _i449;
import 'package:online_groceries_store_app/di/env_module.dart' as _i528;
import 'package:online_groceries_store_app/di/third_party_module.dart' as _i686;
import 'package:online_groceries_store_app/domain/core/app_logger.dart'
    as _i556;
import 'package:online_groceries_store_app/domain/repositories/auth_repository.dart'
    as _i564;
import 'package:online_groceries_store_app/domain/repositories/local_storage_repository.dart'
    as _i188;
import 'package:online_groceries_store_app/domain/usecase/login_user_usecase.dart'
    as _i478;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _dev = 'dev';
const String _staging = 'staging';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    final envModule = _$EnvModule();
    final domainModule = _$DomainModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => thirdPartyModule.prefs,
      preResolve: true,
    );
    gh.factory<_i558.FlutterSecureStorage>(
      () => thirdPartyModule.secureStorage(),
    );
    gh.lazySingleton<_i556.AppLogger>(() => _i787.ConsoleAppLogger());
    gh.singleton<_i428.AppConfig>(
      () => envModule.devConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i428.AppConfig>(
      () => envModule.stagingConfig(),
      registerFor: {_staging},
    );
    gh.factory<String>(
      () => envModule.devBaseUrl(gh<_i428.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_dev},
    );
    gh.factory<String>(
      () => envModule.stagingBaseUrl(gh<_i428.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_staging},
    );
    gh.singleton<_i321.ILocalStorageDataSource>(
      () => _i871.LocalStorageDataSourceImpl(
        gh<_i460.SharedPreferences>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.singleton<_i428.AppConfig>(
      () => envModule.prodConfig(),
      registerFor: {_prod},
    );
    gh.factory<String>(
      () => envModule.prodBaseUrl(gh<_i428.AppConfig>()),
      instanceName: 'baseUrl',
      registerFor: {_prod},
    );
    gh.singleton<_i188.ILocalStorage>(
      () => _i646.LocalStorageImpl(gh<_i321.ILocalStorageDataSource>()),
    );
    gh.lazySingleton<_i492.NetworkInterceptor>(
      () => _i492.NetworkInterceptor(
        gh<_i188.ILocalStorage>(),
        gh<_i556.AppLogger>(),
      ),
    );
    gh.factory<_i361.Dio>(
      () => thirdPartyModule.dio(
        gh<_i428.AppConfig>(),
        gh<String>(instanceName: 'baseUrl'),
        gh<_i492.NetworkInterceptor>(),
      ),
    );
    gh.lazySingleton<_i960.ApiService>(() => _i960.ApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i564.IAuthRepository>(
      () => _i810.AuthRepositoryImpl(gh<_i960.ApiService>()),
    );
    gh.factory<_i478.LoginUserUsecase>(
      () => domainModule.loginUserUsecase(gh<_i564.IAuthRepository>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i686.ThirdPartyModule {}

class _$EnvModule extends _i528.EnvModule {}

class _$DomainModule extends _i449.DomainModule {}

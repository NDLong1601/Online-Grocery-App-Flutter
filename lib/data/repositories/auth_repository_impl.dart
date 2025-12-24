import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/core/guard.dart';
import 'package:online_groceries_store_app/data/datasources/remote/api_service.dart';
import 'package:online_groceries_store_app/data/mappers/login_mapper.dart';
import 'package:online_groceries_store_app/data/models/request/login_request.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/login_credentials.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl extends IAuthRepository {
  final ApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  ResultFuture<LoginEntity> login(LoginCredentials credentials) {
    return guardDio<LoginEntity>(() async {
      final request = LoginRequest(
        username: credentials.username,
        password: credentials.password,
      );
      final dto = await _apiService.login(request);
      return dto.toEntity();
    });
  }
}

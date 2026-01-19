import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/value_object/login_credentials.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/auth_repository.dart';

/// A use case for authenticating users with their login credentials.
///
/// This use case handles the login process by delegating to the authentication
/// repository. It takes [LoginCredentials] as input and returns a [LoginEntity]
/// wrapped in a [ResultFuture].
///
/// Responsibility: Authenticate user with username and password
///
/// Example usage:
/// ```dart
/// final loginUsecase = LoginUserUsecase(authRepository);
/// final result = await loginUsecase(LoginCredentials(email: 'user@example.com', password: 'password'));
/// ```
///
/// See also:
/// * [LoginEntity] - The entity returned upon successful login
/// * [LoginCredentials] - The credentials required for login
/// * [IAuthRepository] - The repository interface for authentication operations
final class LoginUserUsecase
    extends UsecaseAsync<LoginEntity, LoginCredentials> {
  final IAuthRepository _authRepository;

  LoginUserUsecase(this._authRepository);

  @override
  ResultFuture<LoginEntity> call(LoginCredentials params) {
    return _authRepository.login(params);
  }
}

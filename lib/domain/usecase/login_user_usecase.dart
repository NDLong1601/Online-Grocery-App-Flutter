import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/login_credentials.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/auth_repository.dart';

@Injectable()
final class LoginUserUsecase
    extends UsecaseAsync<LoginEntity, LoginCredentials> {
  final IAuthRepository _authRepository;

  LoginUserUsecase(this._authRepository);

  @override
  ResultFuture<LoginEntity> call(LoginCredentials params) {
    return _authRepository.login(params);
  }
}

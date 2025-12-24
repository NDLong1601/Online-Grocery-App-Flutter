import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/entities/login_credentials.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';

abstract class IAuthRepository {
  ResultFuture<LoginEntity> login(LoginCredentials credentials);
}

import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/value_object/login_credentials.dart';
import 'package:online_groceries_store_app/domain/entities/login_entity.dart';

/// Repository interface for authentication operations.
///
/// This abstract class defines the contract for authentication-related
/// data operations, providing a clean separation between the domain
/// layer and data layer.
abstract class IAuthRepository {
  /// Authenticates a user with the provided credentials.
  ///
  /// Takes [credentials] containing user login information and attempts
  /// to authenticate the user against the authentication service.
  ///
  /// Returns a [ResultFuture<LoginEntity>] which represents the
  /// asynchronous result of the login operation. The result will contain
  /// either a successful [LoginEntity] with user information or an error
  /// if authentication fails.
  ///
  /// Throws authentication-related exceptions if the login process
  /// encounters any issues.
  ResultFuture<LoginEntity> login(LoginCredentials credentials);
}

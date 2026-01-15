import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/domain/repositories/auth_repository.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_single_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/login_user_usecase.dart';

/// Domain module that provides dependency injection for use cases.
///
/// This module defines how to create and inject domain layer use cases
/// with their required repository dependencies. It uses the @module
/// annotation to mark this class as a dependency injection module.
///
/// Each method in this module is responsible for creating a specific
/// use case instance with its required dependencies injected.
@module
abstract class DomainModule {
  @Injectable()
  LoginUserUsecase loginUserUsecase(IAuthRepository repo) {
    return LoginUserUsecase(repo);
  }

  @Injectable()
  GetMyCartUsecase getMyCartUsecase(ICartRepository repo) {
    return GetMyCartUsecase(repo);
  }

  @Injectable()
  GetSingleCartUsecase getSingleCartUsecase(ICartRepository repo) {
    return GetSingleCartUsecase(repo);
  }
}

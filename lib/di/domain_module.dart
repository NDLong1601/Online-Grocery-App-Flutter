import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/domain/repositories/auth_repository.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/repositories/category_repository.dart';
import 'package:online_groceries_store_app/domain/repositories/product_repository.dart';
import 'package:online_groceries_store_app/domain/usecase/add_to_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/create_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_categories_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_my_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_product_by_id_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_products_by_category_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_single_cart_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/login_user_usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/update_cart_usecase.dart';

/// Domain module that provides dependency injection for use cases.
///
/// This module defines how to create and inject domain layer use cases
/// with their required repository dependencies. It uses the @module
/// annotation to mark this class as a dependency injection module.
///
/// Each method in this module is responsible for creating a specific
/// use case instance with its required dependencies injected.
///
/// Note: The domain layer itself does not depend on injectable.
/// Only this DI module (which is infrastructure) uses injectable annotations.
@module
abstract class DomainModule {
  // Auth Use Cases
  @Injectable()
  LoginUserUsecase loginUserUsecase(IAuthRepository repo) {
    return LoginUserUsecase(repo);
  }

  // Cart Use Cases
  @Injectable()
  GetMyCartUsecase getMyCartUsecase(ICartRepository repo) {
    return GetMyCartUsecase(repo);
  }

  @Injectable()
  GetSingleCartUsecase getSingleCartUsecase(ICartRepository repo) {
    return GetSingleCartUsecase(repo);
  }

  @Injectable()
  AddToCartUsecase addToCartUsecase(ICartRepository repo) {
    return AddToCartUsecase(repo);
  }

  @Injectable()
  CreateCartUsecase createCartUsecase(ICartRepository repo) {
    return CreateCartUsecase(repo);
  }

  @Injectable()
  UpdateCartUsecase updateCartUsecase(ICartRepository repo) {
    return UpdateCartUsecase(repo);
  }

  // Category Use Cases
  @Injectable()
  GetCategoriesUsecase getCategoriesUsecase(ICategoryRepository repo) {
    return GetCategoriesUsecase(repo);
  }

  // Product Use Cases
  @Injectable()
  GetProductsByCategoryUsecase getProductsByCategoryUsecase(
    IProductRepository repo,
  ) {
    return GetProductsByCategoryUsecase(repo);
  }

  @Injectable()
  GetProductByIdUsecase getProductByIdUsecase(IProductRepository repo) {
    return GetProductByIdUsecase(repo);
  }
}

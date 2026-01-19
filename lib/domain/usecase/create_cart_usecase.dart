import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/create_cart_params.dart';

/// UseCase for creating a new cart with a product
///
/// This use case is used when user doesn't have any existing cart
/// and wants to add a product to cart for the first time.
class CreateCartUsecase extends UsecaseAsync<CartEntity, CreateCartParams> {
  final ICartRepository _cartRepository;

  CreateCartUsecase(this._cartRepository);

  @override
  ResultFuture<CartEntity> call(CreateCartParams params) {
    return _cartRepository.createCart(
      userId: params.userId,
      productId: params.productId,
      quantity: params.quantity,
    );
  }
}

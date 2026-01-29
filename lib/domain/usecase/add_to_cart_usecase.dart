import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/add_to_cart_params.dart';

/// UseCase for adding a product to cart
///
/// This use case handles the business logic for adding products to the cart,
/// including validation and calling the repository.
///
/// Responsibility: Add a product to an existing cart
final class AddToCartUsecase extends UsecaseAsync<CartEntity, AddToCartParams> {
  final ICartRepository _cartRepository;

  AddToCartUsecase(this._cartRepository);

  @override
  ResultFuture<CartEntity> call(AddToCartParams params) {
    return _cartRepository.addToCart(
      cartId: params.cartId,
      productId: params.productId,
      quantity: params.quantity,
    );
  }
}

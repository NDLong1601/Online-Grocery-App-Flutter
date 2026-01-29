import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/update_cart_params.dart';

/// UseCase for updating cart products
///
/// This use case handles the business logic for updating product quantities
/// in the cart, including removing products when quantity is 0.
///
/// Responsibility: Update quantities of products in an existing cart
final class UpdateCartUsecase
    extends UsecaseAsync<CartEntity, UpdateCartParams> {
  final ICartRepository _cartRepository;

  UpdateCartUsecase(this._cartRepository);

  @override
  ResultFuture<CartEntity> call(UpdateCartParams params) {
    return _cartRepository.updateCart(
      cartId: params.cartId,
      products: params.products
          .map((p) => (productId: p.productId, quantity: p.quantity))
          .toList(),
    );
  }
}

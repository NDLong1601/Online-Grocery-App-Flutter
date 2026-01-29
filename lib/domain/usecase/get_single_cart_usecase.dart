import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/get_single_cart_params.dart';

/// Use case for getting a specific cart by its ID
///
/// This use case retrieves detailed information about a single cart.
///
/// Responsibility: Fetch a single cart by cart ID
final class GetSingleCartUsecase
    extends UsecaseAsync<CartEntity, GetSingleCartParams> {
  final ICartRepository _cartRepository;

  GetSingleCartUsecase(this._cartRepository);

  @override
  ResultFuture<CartEntity> call(GetSingleCartParams params) {
    return _cartRepository.getSingleCart(cartId: params.cartId);
  }
}

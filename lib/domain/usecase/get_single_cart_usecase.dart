import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/cart_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/get_single_cart_params.dart';

class GetSingleCartUsecase
    extends UsecaseAsync<CartEntity, GetSingleCartParams> {
  final ICartRepository _cartRepository;

  GetSingleCartUsecase(this._cartRepository);

  @override
  ResultFuture<CartEntity> call(GetSingleCartParams params) {
    return _cartRepository.getSingleCart(cartId: params.cartId);
  }
}

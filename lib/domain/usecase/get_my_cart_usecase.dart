import 'package:online_groceries_store_app/domain/core/result.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/entities/carts_by_user_entity.dart';
import 'package:online_groceries_store_app/domain/repositories/cart_repository.dart';
import 'package:online_groceries_store_app/domain/value_object/get_my_cart_params.dart';

class GetMyCartUsecase extends UsecaseAsync<CartsByUserEntity, GetMyCartParams> {
  final ICartRepository _cartRepository;
  GetMyCartUsecase(this._cartRepository);

  @override
  ResultFuture<CartsByUserEntity> call(GetMyCartParams params) {
    return _cartRepository.getMyCart(userId: params.userId);
  }
}
